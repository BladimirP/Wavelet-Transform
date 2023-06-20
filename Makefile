CC=nvcc
CFLAGS= -O3
BINS=prog

prog:
	$(CC) $(CFLAGS) -o prog main.cu

clean:
	@echo " [CLN] Removing binary files"
	@rm -f $(BINS)