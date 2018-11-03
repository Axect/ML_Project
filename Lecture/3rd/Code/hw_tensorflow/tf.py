#!/usr/bin/env python3

# -*- coding: utf-8 -*-

"""

Created on Tue May 23 14:56:53 2017


@author: crazyj

"""



import numpy as np

import tensorflow as tf


# trainint set

X_train = np.array( [[0,0], [0,1], [1,0], [1,1]])

T_train = np.array( [[0], [1], [1], [0]] )



# placeholder

X = tf.placeholder(tf.float32, [None, 2])

T = tf.placeholder(tf.float32, [None, 1])


# variable

W1 = tf.Variable(tf.truncated_normal([2,4]))

b1 = tf.Variable(tf.zeros([4]))

W2 = tf.Variable(tf.truncated_normal([4,1]))

b2 = tf.Variable(tf.zeros([1]), dtype=tf.float32)


# model

A1 = tf.matmul(X, W1)+b1

Z1 = tf.sigmoid(A1)

A2 = tf.matmul(Z1, W2)+b2

Z2 = tf.sigmoid(A2)


learn_rate = 0.25

Cost = tf.reduce_mean(tf.reduce_sum(tf.square(Z2-T), 1))

train = tf.train.GradientDescentOptimizer(learn_rate).minimize(Cost)


predict = Z2


sess = tf.Session()

sess.run(tf.global_variables_initializer())

for i in range(5000):

    _train, _Cost = sess.run([train, Cost], feed_dict={X:X_train, T:T_train})

    #print( "cost=", _Cost)

    

_predict = sess.run([predict], feed_dict={X:X_train})

print("predict=", _predict)

print("result=", np.array(np.array(_predict)>0.5, np.int))


