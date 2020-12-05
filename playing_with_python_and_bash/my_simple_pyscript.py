#!/usr/bin/python3
import argparse
import sys

def add(args):
	return args.x + args.y

def main():

	parser = argparse.ArgumentParser()

	parser.add_argument('--x', type=float, default=0.0,
						help='Please type in the first number.')

	parser.add_argument('--y', type=float, default=0.0,
						help='Please type in the second number.')

	args = parser.parse_args()
	print(add(args))   # This output is captured by the bash script
	#sys.stdout.write(str(add(args)))

if __name__ == '__main__':
	main()
