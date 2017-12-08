/*
Fast Artificial Neural Network Library (fann)
Copyright (C) 2003-2012 Steffen Nissen (sn@leenissen.dk)

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <stdio.h>

#include "fann.h"
float err_test(struct fann *ann, struct fann_train_data *test_data);

int main()
{
	const unsigned int num_layers = 4;
	const unsigned int num_neurons_hidden0 = 19;
	const unsigned int num_neurons_hidden1 = 15;
	const float desired_error = (const float) 0.1;
	const int max_epochs = 3000;
	const int epochs_between_reports = 10;
	int total_connection;
	struct fann *ann;
	struct fann_train_data *train_data, *test_data;

	unsigned int i = 0;
	unsigned int j = 0;
	struct fann_connection *con_it;
	struct fann_connection *weights;

	float error;
	printf("Creating network.\n");
	printf("num_layers:%d\n",num_layers);
	printf("num_neurons_hidden0:%d\n",num_neurons_hidden0);
	printf("num_neurons_hidden1:%d\n",num_neurons_hidden1);

	train_data = fann_read_train_from_file("../datasets/nr.train");

	printf("num_input:%d\n", train_data->num_input);
	printf("num_output:%d\n", train_data->num_output);
	ann = fann_create_standard(num_layers,
					  train_data->num_input, num_neurons_hidden0, num_neurons_hidden1, train_data->num_output);

	printf("Training network.\n");
	fann_set_activation_function_hidden(ann, FANN_SIGMOID_SYMMETRIC);
	fann_set_activation_function_output(ann, FANN_SIGMOID_SYMMETRIC);
	printf("steepness:%f\n",fann_get_activation_steepness(ann,1,1));
	fann_set_activation_steepness_hidden(ann, 0.5);
	fann_set_activation_steepness_output(ann, 0.5);
	fann_set_training_algorithm(ann, FANN_TRAIN_INCREMENTAL);
	fann_set_learning_momentum(ann, 0.4f);
	fann_set_learning_rate(ann, 1e-2f);
	total_connection = fann_get_total_connections(ann);
	printf("total_connection: %d",total_connection);
	weights = (struct fann_connection *)malloc(sizeof(struct fann_connection) * total_connection);
	


	for(i = 0; i < max_epochs; i++)
	{
		fann_train_epoch(ann, train_data);
		fann_get_connection_array(ann,weights);
		con_it = weights;
		for(j = 0;j < total_connection; j++)
		{
			//printf("weight: %f\n",con_it->weight);
			if(con_it->weight>1)
				con_it->weight=1;
			else if(con_it->weight<-1)
				con_it->weight=-1;
			con_it++;
		}
		fann_set_weight_array(ann,weights,total_connection);
		error = err_test(ann, train_data);
		if(i % epochs_between_reports == 0)
			printf("Epochs  %8d. Current error: %.10f. Bit fail %d.\n", i, error, ann->num_bit_fail);
		if(error <= desired_error)
			break;
	}
	//fann_train_on_data(ann, train_data, 300, 10, desired_error);

	printf("Testing network.\n");

	test_data = fann_read_train_from_file("../datasets/nr.test");

	//fann_reset_MSE(ann);
	error = err_test(ann, test_data);
	printf("err ratio on test data: %f\n", error);
	printf("Saving network.\n");

	fann_save(ann, "nr.net");

	printf("Cleaning up.\n");
	fann_destroy_train(train_data);
	fann_destroy_train(test_data);
	fann_destroy(ann);

	return 0;
}

float err_test(struct fann *ann, struct fann_train_data *test_data)
{
	fann_type *calc_out;
	float num_r;
	float max_r;
	float num_d;
	float max_d;
	float right_c = 0;
	float err_ratio;
	unsigned int i,j;
	for(i = 0; i < fann_length_train_data(test_data); i++)
	{
		calc_out = fann_run(ann, test_data->input[i]);
		max_r = 0;
		num_r = 0;
		max_d = 0;
		num_d = 0;
		for(j = 0; j < 10; j++)
		{
			//printf("calc_out: %f\n", calc_out[j]);
			//printf("output: %f\n", test_data->output[i][j]);
			if(max_r < calc_out[j]){
				max_r = calc_out[j];
				num_r = j;
			}
			if(max_d < test_data->output[i][j]){
				max_d = test_data->output[i][j];
				num_d = j;
			}
		}
		//printf("num_r: %f\n", num_r);
		//printf("num_d: %f\n", num_d);
		if(num_r == num_d)
			right_c++;
	}
	//printf("right_c: %f\n", right_c);
	err_ratio = 1 - right_c / fann_length_train_data(test_data);
	return err_ratio;
}
