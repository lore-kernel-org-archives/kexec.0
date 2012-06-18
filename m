Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SgU6o-00030C-DR
 for kexec@lists.infradead.org; Mon, 18 Jun 2012 05:02:40 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 472553EE0B5
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 22D162C69C2
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 927DA2E7BAE
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8712C1DB804A
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:31 +0900 (JST)
Received: from m022.s.css.fujitsu.com (m022.s.css.fujitsu.com [10.0.81.62])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 425521DB8045
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:31 +0900 (JST)
Received: from m022.css.fujitsu.com (m022 [127.0.0.1])
 by m022.s.css.fujitsu.com (Postfix) with ESMTP id 23269490008
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:30 +0900 (JST)
Received: from localhost (unknown [10.124.101.95])
 by m022.s.css.fujitsu.com (Postfix) with ESMTP id E8C0148000D
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 14:02:29 +0900 (JST)
Date: Mon, 18 Jun 2012 14:02:21 +0900 (JST)
Message-Id: <20120618.140221.379738059.d.hatayama@jp.fujitsu.com>
Subject: [RESEND] Benchmark of I/O multiplexing with LZO/snappy compression
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_Jun_18_14_02_21_2012_148)--"
Content-Transfer-Encoding: 7bit
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

----Next_Part(Mon_Jun_18_14_02_21_2012_148)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I evaluated I/O multiplexing together with paralell compression in two
kinds of formats: lzo and snappy.

In summary:
- By 8-dimentional I/O multiplexing, thoughtput is 5 times as quick as
  the 1-dimentional: For snappy, 1TB copy takes 25min.
- For randomized data, snappy is as quick as raw, e.g. no compression
  case.
- lzo consumes more CPU time than snappy, but it could probably be
  better for quicker CPUs and more sparse data; another kind of bench
  is required.

In advance, any comments are appreciated.

* Environments

- PRIMEQUEST 1800E2
  - CPU: Intel Xeon E7-8870 (10core/2.4GHz) x 2 sockets
  - RAM: 32GB
- DISKS
  - MBD2147RC (10025rpm) x 4
  - ETERNUS DX440: Emulex 8Gb/s fiber adapters x 4

(*) To get 8-dimentional I/O multiplexing, I used 4 disks and 4 LUNV
    of SAN simply because I didn't have enough disks available (^^;

* How to measure what?

  This bench measured the real time consumed for copying 10GB
  on-memory data, simulating /proc/vmcore, into multiple different
  disks with no compression or with LZO and snappy compressions.

  The data is randomized enough so the time for compression is
  meaningless; no I/O workload changes during compression; this bench
  is only for worst case.

  - Parameters
    - number of writing/compressing threads (and so number of I/O
      multiplexing)
      - 1 ~ 8
    - compression format
      - raw
      - lzo
      - snappy
    - kernel versions
      - v3.4
      - RHEL6.2 (2.6.32.220)
      - RHEL5.8 (2.6.18-238)

  example)
    - Let fakevmcore of 10GB and its block size 4kB.
    - split I/O into two different disks: /mnt/disk{0,1}
    - Block size for compression is 4kB.
    - compress data in LZO: -c is LZO and -s is snappy.
    - flush page cache after nsplit.

  $ insmod ./fakevmcore.ko fakevmcore_size=$((10*1024*1024*1024)) fakevmcore_block_size=4096
  $ time { nsplit -c --blocksize=4096 /proc/fakevmcore /mnt/disk0/a /mnt/disk1/a ; \
           echo 3 > /proc/sys/vm/drop_caches; }

  To build nsplit.c on fc16, the following compression libraries are required:
    - lzo-devel, lzo-minilzo, lzo
    - snappy-devel, snappy

* Results

n: number of writing and compressing threads

- upstream v3.4 kernel

n    raw       lzo      snappy
1 1m29.617s 2m41.979s 1m9.592s
2 1m8.519s  1m26.555s 1m26.902s
3 0m48.653s 1m0.462s  0m35.172s
4 0m28.039s 0m47.248s 0m28.430s
5 0m23.491s 0m37.181s 0m23.435s
6 0m18.202s 0m28.428s 0m18.580s
7 0m15.897s 0m29.873s 0m16.678s
8 0m13.659s 0m23.180s 0m13.922s

- RHEL6.2 (2.6.32.220)

n    raw       lzo     snappy
1 0m53.119s 2m36.603s 1m33.061s
2 1m31.578s 1m28.808s 0m49.492s
3 0m31.675s 0m57.540s 0m33.795s
4 0m37.714s 0m45.035s 0m32.871s
5 0m20.363s 0m34.988s 0m21.894s
6 0m22.602s 0m31.216s 0m19.195s
7 0m18.837s 0m25.204s 0m15.906s
8 0m13.715s 0m22.228s 0m13.884s

- RHEL5.8 (2.6.18-238)

n    raw       lzo     snappy
1 0m55.144s 1m20.771s 1m4.140s
2 0m52.157s 1m8.336s  1m1.089s
3 0m50.172s 0m41.329s 0m47.859s
4 0m35.409s 0m28.764s 0m43.286s
5 0m22.974s 0m20.501s 0m20.197s
6 0m17.430s 0m18.072s 0m19.524s
7 0m14.222s 0m14.936s 0m15.603s
8 0m13.071s 0m14.755s 0m13.313s

- By 8-dimentional I/O multiplexing, throughput is improved as quick
  as 4~5 times in raw, 5-6 times in lzo, and 6-8 times in snappy.

  - 10GB per 15sec corresponds to 1TB per 25min 36sec.

- snappy is as quick as raw. I think snappy can be used with a very
  low risk even at the worst case.

- lzo is slower than raw and snappy. But paralell compression works
  well. Although lzo is worse than other two in this bench, I expect
  lzo could be better than the other two if using better CPU and data
  consists of more sparse data.

- On LZO, RHEL5.8's is better than those of v3.4 and RHEL6.2. Due to
  I/O workloads situation? But I don't know that precisely.

* TODO
- Retry benchmark using disks only.
- Evaluate btrfs's transparent compression for large data; for very
  large data, compression in kernel-space has advantage compared to
  that in user-space.

Thanks.
HATAYAMA, Daisuke

----Next_Part(Mon_Jun_18_14_02_21_2012_148)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=Makefile

CC = gcc
OPTIONS = -g -O0 -W -Wall -pthread -llzo2 -lsnappy

obj-m := fakevmcore.o

fakevmcore.ko:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

all: build

build: nsplit fakevmcore.ko

nsplit: nsplit.o
	$(CC) $(OPTIONS) -o $@ $^

nsplit.o: nsplit.c
	$(CC) $(OPTIONS) -c $^

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -f ./nsplit
	rm -rf *.o
	rm -rf *~

----Next_Part(Mon_Jun_18_14_02_21_2012_148)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fakevmcore.c"

#include <linux/init.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/random.h>
#include <asm/io.h>
#include <asm/uaccess.h>

static void *fakevmcore_data;
static unsigned long fakevmcore_size;
static unsigned long fakevmcore_block_size;
static struct proc_dir_entry *proc_fakevmcore;

module_param(fakevmcore_size, ulong, 0444);
module_param(fakevmcore_block_size, ulong, 0444);

static ssize_t read_fakevmcore(struct file *file, char __user *buffer,
			       size_t buflen, loff_t *fpos)
{
	ssize_t acc = 0;

	if (buflen == 0 || *fpos >= fakevmcore_size)
		return 0;

	if (buflen > fakevmcore_size - *fpos)
		buflen = fakevmcore_size - *fpos;

	while (buflen > 0) {
		size_t tsz, offset;

		offset = *fpos % fakevmcore_block_size;
		tsz = min(fakevmcore_block_size - offset, buflen);
		if (copy_to_user(buffer, fakevmcore_data + offset, tsz))
			return -EFAULT;
		buflen -= tsz;
		*fpos += tsz;
		buffer += tsz;
		acc += tsz;
	}

	return acc;
}

static const struct file_operations proc_fakevmcore_operations = {
	.read = read_fakevmcore,
	.llseek = default_llseek,
};

static int fakevmcore_init(void)
{
	if (!fakevmcore_size) {
		fakevmcore_size = PAGE_SIZE;
		printk("fakevmcore_size defaults to PAGE_SIZE\n");
	}

	if (!fakevmcore_block_size) {
		fakevmcore_block_size = PAGE_SIZE;
		printk("fakevmcore_block_size defaults to PAGE_SIZE\n");
	}

	fakevmcore_data = (void *)__get_free_pages(GFP_KERNEL,
					   get_order(fakevmcore_block_size));
	if (!fakevmcore_data) {
		printk("__get_free_page failed\n");
		goto out;
	}

	get_random_bytes(fakevmcore_data, fakevmcore_block_size);

	proc_fakevmcore = proc_create("fakevmcore", S_IRUGO, NULL, &proc_fakevmcore_operations);
	if (proc_fakevmcore)
		proc_fakevmcore->size = fakevmcore_size;

out:
	return 0;
}

static void fakevmcore_exit(void)
{
	if (fakevmcore_data) {
		free_pages((unsigned long)fakevmcore_data,
			   get_order(fakevmcore_block_size));
		fakevmcore_data = NULL;
	}

	if (proc_fakevmcore) {
		remove_proc_entry(proc_fakevmcore->name, proc_fakevmcore->parent);
		proc_fakevmcore = NULL;
	}

	fakevmcore_size = 0;
	fakevmcore_block_size = 0;
}

module_init(fakevmcore_init);
module_exit(fakevmcore_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>");

----Next_Part(Mon_Jun_18_14_02_21_2012_148)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="nsplit.c"

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <getopt.h>
#include <lzo/lzo1x.h>
#include <snappy-c.h>

enum nsplit_constants
{
	FALSE = 0,
	TRUE = 1,
	ARGV_OUTFILE_START_POS = 2,
	BLOCK_SIZE = 4096,
	PAGE_SIZE = 4096,
};

enum nsplit_compress
{
	NS_COMPRESS_LZO = 1,
	NS_COMPRESS_SNAPPY = 2,
};

struct nsplit_data
{
	char *infile;
	int infd;
	int nr_threads;
	unsigned long nr_blocks;
	struct stat st;
	int debug;
	enum nsplit_compress compress;
	size_t blocksize;
};
struct nsplit_data nsplit_data;
struct nsplit_data *nd = &nsplit_data;

static int
nsplit_data_init(char *infile, int nr_threads)
{
	int ret = FALSE;

	if (!nd->blocksize)
		nd->blocksize = BLOCK_SIZE;

	nd->infile = infile;
	nd->nr_threads = nr_threads;

	if (nd->nr_threads < 1) {
		fprintf(stderr, "invalid number of threads: %d\n", nd->nr_threads);
		goto out;
	}

	if (stat(nd->infile, &nd->st) < 0) {
		perror("stat");
		goto out;
	}

	nd->nr_blocks = nd->st.st_size / nd->nr_threads / nd->blocksize;

	if ((nd->infd = open(nd->infile, O_RDONLY)) < 0) {
		perror("open");
		goto out;
	}

	if (nd->debug) {
		printf("infile size: %lu\n", nd->st.st_size);
		printf("number of threads: %d\n", nd->nr_threads);
		printf("block size: %lu\n", nd->blocksize);
		printf("number of blocks: %lu\n", nd->nr_blocks);
	}

	ret = TRUE;
out:
	return ret;
}

static void
nsplit_data_free(void)
{
	if (nd->infd)
		close(nd->infd);
}

struct nsplit_thread_data
{
	char *outfile;
	int thread_index;
	loff_t block_start;
	loff_t block_end;
};

static struct nsplit_thread_data *
nsplit_create_thread_data(char *outfile, int thread_index)
{
	struct nsplit_thread_data *ntd;

	if (posix_memalign((void *)&ntd, PAGE_SIZE, sizeof(struct nsplit_thread_data))) {
		perror("posix_memalign");
		goto out;
	}

	ntd->outfile = outfile;
	ntd->thread_index = thread_index;
	ntd->block_start = nd->nr_blocks * nd->blocksize * ntd->thread_index;
	ntd->block_end = nd->nr_blocks * nd->blocksize * (ntd->thread_index + 1);

	/* last thread needs to care the round. */
	if (thread_index == nd->nr_threads - 1
	    && nd->st.st_size > ntd->block_end)
		ntd->block_end += nd->st.st_size - ntd->block_end;

	if (nd->debug) {
		printf("thread: %d\n", thread_index);
		printf("  outfile: %s\n", ntd->outfile);
		printf("  start: %lu\n", ntd->block_start);
		printf("  end: %lu\n", ntd->block_end);
	}

out:
	return ntd;
}

/*
 * Care for the case where only part of a whole requests succeeds.
 */
static inline int preadout(int fd, unsigned char *buf, size_t size, loff_t off)
{
	ssize_t readbytes, bytes, rest;

	readbytes = 0;
	rest = size;
	while (rest > 0) {
		if ((bytes = pread(fd, buf + readbytes, rest, off)) < 0) {
			perror("pread");

			if (nd->debug) {
				fprintf(stderr, "fd: %d\n", fd);
				fprintf(stderr, "readbytes: %ld\n", readbytes);
				fprintf(stderr, "rest: %ld\n", rest);
				fprintf(stderr, "offset: %lu\n", off);
			}

			return FALSE;
		}
		readbytes += bytes;
		rest -= bytes;
		off += bytes;
	}
	return TRUE;
}

static inline unsigned long compress_bound_lzo(unsigned long size)
{
	return size + size / 16 + 64 + 3;
}

static void *f(void *arg)
{
	struct nsplit_thread_data *ntd = arg;
	FILE *fp = NULL;
	loff_t block;
	unsigned char *buffer = NULL, *wrkmem = NULL, *bufout = NULL;
	size_t iobytes = nd->blocksize;

	fp = fopen(ntd->outfile, "w");
	if (!fp) {
		perror("fopen");
		goto out;
	}

	if (posix_memalign((void *)&buffer, PAGE_SIZE, iobytes)) {
		perror("posix_memalign");
		goto out;
	}

	if (nd->compress == NS_COMPRESS_LZO) {
		if (posix_memalign((void *)&wrkmem, PAGE_SIZE,
				   LZO1X_1_MEM_COMPRESS)) {
			perror("posix_memalign");
			goto out;
		}
		if (posix_memalign((void *)&bufout, PAGE_SIZE,
				   compress_bound_lzo(iobytes))) {
			perror("posix_memalign");
			goto out;
		}
	} else if (nd->compress == NS_COMPRESS_SNAPPY) {
		if (posix_memalign((void *)&bufout, PAGE_SIZE,
				   snappy_max_compressed_length(iobytes))) {
			perror("posix_memalign");
			goto out;
		}
	}

	for (block = ntd->block_start; block < ntd->block_end;
	     block += iobytes) {
		unsigned long sizeout;
		int retval;

		if (ntd->block_end - block < (loff_t)nd->blocksize)
			iobytes = ntd->block_end - block;
		if (!preadout(nd->infd, buffer, iobytes, block))
			goto out;
		switch (nd->compress) {
		case NS_COMPRESS_LZO:
			sizeout = iobytes;
			retval = lzo1x_1_compress(buffer, iobytes, bufout,
						  &sizeout, wrkmem);
			if (retval == LZO_E_OK && sizeout < iobytes) {
				if (fwrite(bufout, sizeout, 1, fp) != 1) {
					perror("fwrite");
					goto out;
				}
			} else
				goto writebufout;
			break;
		case NS_COMPRESS_SNAPPY:
			sizeout = snappy_max_compressed_length(iobytes);
			retval = snappy_compress((char *)buffer, iobytes,
						 (char *)bufout, &sizeout);
			if (retval == SNAPPY_OK && sizeout < iobytes) {
				if (fwrite(bufout, sizeout, 1, fp) != 1) {
					perror("fwrite");
					goto out;
				}
			} else
				goto writebufout;
			break;
		default:
		writebufout:
			if (fwrite(buffer, iobytes, 1, fp) != 1) {
				perror("fwrite");
				goto out;
			}
			break;
		}
	}

out:
	if (fp)
		fclose(fp);
	free(ntd);
	if (wrkmem)
		free(wrkmem);
	if (bufout)
		free(bufout);
	if (buffer)
		free(buffer);
	return NULL;
}

static void usage(void)
{
	fprintf(stderr, "usage: nsplit [-b size|--block=size] [-d|--debug] <in file> [<out file>]+\n");
	fprintf(stderr, " \n");
	fprintf(stderr, "  [-b size|--block=size]  specify block size for compression\n");
	fprintf(stderr, "  [-d|--debug]  print debug information\n");
}

static struct option longopts[] = {
	{"block", required_argument, NULL, 'b'},
	{"debug", required_argument, NULL, 'd'},
	{0, 0, 0, 0}
};

static int nsplit_main(char *infile, char **outfiles, int nr_threads)
{
	pthread_t *threads = NULL;
	int i, ret = EXIT_FAILURE;

	if (!nsplit_data_init(infile, nr_threads))
		goto out;

	threads = malloc(nd->nr_threads * sizeof(pthread_t));
	if (!threads) {
		perror("malloc");
		goto out;
	}

	for (i = 0; i < nd->nr_threads; ++i) {
		struct nsplit_thread_data *ntd;

		ntd = nsplit_create_thread_data(outfiles[i], i);
		if (!ntd)
			goto out;

		if (pthread_create(&threads[i], NULL, f, (void *)ntd) != 0) {
			perror("pthread_create");
			goto out;
		}
	}

	for (i = 0; i < nd->nr_threads; ++i) {
		if (pthread_join(threads[i], NULL) != 0) {
			perror("pthread_join");
			goto out;
		}
	}

	ret = EXIT_SUCCESS;
out:
	if (threads)
		free(threads);
	nsplit_data_free();
	return ret;
}

int main(int argc, char **argv)
{
	int c, argerrs, option_index;

	argerrs = 0;

	while ((c = getopt_long(argc, argv, "bcds", longopts, &option_index)) != -1) {
		switch (c) {
		case 'b':
			nd->blocksize = strtoul(optarg, NULL, 10);
			break;
		case 'c':
			nd->compress = NS_COMPRESS_LZO;
			break;
		case 'd':
			nd->debug = TRUE;
			break;
		case 's':
			nd->compress = NS_COMPRESS_SNAPPY;
			break;
		case '?':
			argerrs++;
			break;
		}
	}

	/* Infile and a single outfile are given at least? */
	if (!argv[optind] || !argv[optind+1])
		argerrs++;

	if (argerrs > 0) {
		usage();
		exit(EXIT_FAILURE);
	}

	return nsplit_main(argv[optind], &argv[optind+1], argc-optind-1);
}

----Next_Part(Mon_Jun_18_14_02_21_2012_148)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

----Next_Part(Mon_Jun_18_14_02_21_2012_148)----


