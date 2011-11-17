Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RR0wk-0004z8-Rx
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 12:20:05 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B84273EE0AE
 for <kexec@lists.infradead.org>; Thu, 17 Nov 2011 21:19:55 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D16145DE59
 for <kexec@lists.infradead.org>; Thu, 17 Nov 2011 21:19:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7392D45DE55
 for <kexec@lists.infradead.org>; Thu, 17 Nov 2011 21:19:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 619421DB8051
 for <kexec@lists.infradead.org>; Thu, 17 Nov 2011 21:19:55 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0487C1DB804C
 for <kexec@lists.infradead.org>; Thu, 17 Nov 2011 21:19:55 +0900 (JST)
Date: Thu, 17 Nov 2011 21:19:46 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC] makedumpfile, crash: LZO compression support
Message-Id: <20111117211946.3e27b840.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk"
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
To: crash-utility@redhat.com, kexec@lists.infradead.org

This is a multi-part message in MIME format.

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

This is a RFC patch set that adds LZO compression support to
makedumpfile and crash utility. LZO is as good as in size but by far
better in speed than ZLIB, leading to reducing down time during
generation of crash dump and refiltering.

How to build:

  1. Get LZO library, which is provided as lzo-devel package on recent
  linux distributions, and is also available on author's website:
  http://www.oberhumer.com/opensource/lzo/.

  2. Apply the patch set to makedumpfile v1.4.0 and crash v6.0.0.

  3. Build both using make. But for crash, do the following now:

    $ make CFLAGS="-llzo2"

How to use:

  I've newly used -l option for lzo compression in this patch. So for
  example, do as follows:

  $ makedumpfile -l vmcore dumpfile
  $ crash vmlinux dumpfile

Request of configure-like feature for crash utility:

  I would like configure-like feature on crash utility for users to
  select wheather to add LZO feature actually or not in build-time,
  that is: ./configure --enable-lzo or ./configure --disable-lzo.

  The reason is that support staff often downloads and installs the
  latest version of crash utility on machines where lzo library is not
  provided.

  Looking at the source code, it looks to me that crash does some kind
  of configuration processing in a local manner, around configure.c,
  and I guess it's difficult to use autoconf tools directly.

  Or is there another better way?

Performance Comparison:

  Sample Data

    Ideally, I must have measured the performance for many enough
    vmcores generated from machines that was actually running, but now
    I don't have enough sample vmcores, I couldn't do so. So this
    comparison doesn't answer question on I/O time improvement. This
    is TODO for now.

    Instead, I choosed worst and best cases regarding compression
    ratio and speed only. Specifically, the former is /dev/urandom and
    the latter is /dev/zero.

    I get the sample data of 10MB, 100MB and 1GB by doing like this:

      $ dd bs=4096 count=$((1024*1024*1024/4096)) if=/dev/urandom of=urandom.1GB

  How to measure

    Then I performed compression for each block, 4096 bytes, and
    measured total compression time and output size. See attached
    mycompress.c.

  Result

    See attached file result.txt.

  Discussion

    For both kinds of data, lzo's compression was considerably quicker
    than zlib's. Compression ratio is about 37% for urandom data, and
    about 8.5% for zero data. Actual situation of physical memory
    would be in between the two cases, and so I guess average
    compression time ratio is between 37% and 8.5%.

    Although beyond the topic of this patch set, we can estimate worst
    compression time on more data size since compression is performed
    block size wise and the compression time increases
    linearly. Estimated worst time on 2TB memory is about 15 hours for
    lzo and about 40 hours for zlib. In this case, compressed data
    size is larger than the original, so they are really not used,
    compression time is fully meaningless. I think compression must be
    done in parallel, and I'll post such patch later.

Diffstat

  * makedumpfile

 diskdump_mod.h |    3 +-
 makedumpfile.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.h |   12 +++++++
 3 files changed, 101 insertions(+), 12 deletions(-)

  * crash

 defs.h     |    1 +
 diskdump.c |   20 +++++++++++++++++++-
 diskdump.h |    3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

TODO

  * evaluation including I/O time using actual vmcores

Thanks.
HATAYAMA, Daisuke

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: text/x-csrc;
 name="mycompress.c"
Content-Disposition: attachment;
 filename="mycompress.c"
Content-Transfer-Encoding: 7bit

/*
 * How to build:
 *
 *   $ gcc -lz -llzo2 ./mycompress.c -o mycompress
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <zlib.h>
#include <lzo/lzo1x.h>

enum
{
	BLOCK_SIZE = 4096
};

enum compression
{
	GLIB = 0,
	LZO
};

static inline size_t max(size_t a, size_t b)
{
	return a >= b ? a : b;
}

static inline size_t compressBoundLZO(size_t size)
{
	return size + size / 16 + 64 + 3;
}

static inline double getdtime(void)
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (double)tv.tv_sec + (double)tv.tv_usec * 0.001 * 0.001;
}

static void print_usage(void)
{
	printf("usage: mycompress [glib|lzo] <input file> <output file>\n");
}

int main(int argc, char **argv)
{
	enum compression flag_compress;
	FILE *fi = NULL, *fo = NULL;
	char *bufout = NULL;
	lzo_bytep wrkmem = NULL;
	unsigned long size_out, len_bufout;
	double t_compress_start, t_compress_end, t_compress_total;
	double t_io_start, t_io_end, t_io_total;
	size_t total_input_bytes, total_output_bytes;

	if (argc != 4) {
		print_usage();
		return EXIT_FAILURE;
	}

	if (strncmp(argv[1], "glib", 4) == 0) {
		flag_compress = GLIB;
	}

	else if (strncmp(argv[1], "lzo", 3) == 0) {
		if (lzo_init() != LZO_E_OK) {
			fprintf(stderr, "lzo_init() failed\n");
			return EXIT_FAILURE;
		}
		flag_compress = LZO;
	}

	else {
		return EXIT_FAILURE;
	}

	fi = fopen(argv[2], "r");
	if (!fi) {
		perror("fopen");
		goto error;
	}
	fo = fopen(argv[3], "w");
	if (!fo) {
		perror("fopen");
		goto error;
	}
	switch (flag_compress) {
	case GLIB:
		len_bufout = compressBound(BLOCK_SIZE);

		break;
	case LZO:
		len_bufout = compressBoundLZO(BLOCK_SIZE);
		break;
	}
	bufout = malloc(len_bufout);
	if (!bufout) {
		perror("malloc");
		goto error;
	}
	wrkmem = malloc(LZO1X_1_MEM_COMPRESS);
	if (!wrkmem) {
		perror("malloc");
		goto error;
	}

	t_compress_start = t_compress_end = t_compress_total = 0;
	t_io_start = t_io_end = t_io_total = 0;
	total_input_bytes = total_output_bytes = 0;

	while (!ferror(fi)) {
		char buf[BLOCK_SIZE];
		unsigned long size_out;

		total_input_bytes += BLOCK_SIZE;

		if (fread(buf, sizeof(buf), 1, fi) != 1) {
			if (feof(fi))
				break;
			perror("fread");
			goto error;
		}

		/*
		 * For size_out, GLIB needs output buffer size, while
		 * LZO original data size.
		 */
		switch (flag_compress) {
		case GLIB: size_out = len_bufout; break;
		case LZO: size_out = BLOCK_SIZE; break;
		}

		t_compress_start = getdtime();
		switch (flag_compress) {
		case GLIB:
			if (compress2(bufout, &size_out, buf, BLOCK_SIZE,
				      Z_BEST_SPEED) != Z_OK) {
				fprintf(stderr, "glib compression failed\n");
				goto error;
			}
			break;
		case LZO:
			if (lzo1x_1_compress(buf, BLOCK_SIZE, bufout,
					     &size_out, wrkmem) != LZO_E_OK) {
				fprintf(stderr, "lzo compression failed\n");
				goto error;
			}
			break;
		}

		t_compress_end = getdtime();
		t_compress_total += t_compress_end - t_compress_start;

		t_io_start = getdtime();
		if (fwrite(bufout, size_out, 1, fo) != 1) {
			perror("fwrite");
			goto error;
		}
		t_io_end = getdtime();
		t_io_total += t_io_end - t_io_start;

		total_output_bytes += size_out;
	}

	printf("Input size: %d bytes\n", total_input_bytes);
	printf("Compression Time: %lf seconds\n", t_compress_total);
	printf("Output size: %d bytes\n", total_output_bytes);
	printf("IO Time: %lf seconds\n", t_io_total);

error:
	if (fi)
		fclose(fi);
	if (fo)
		fclose(fo);
	free(wrkmem);
	return 0;
}

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: text/plain;
 name="result.txt"
Content-Disposition: attachment;
 filename="result.txt"
Content-Transfer-Encoding: 7bit

  * /dev/urandom
				lzo		zlib		compression time ratio(%)
     10MBytes
compression time(sec)		0.271553	0.721236	37.65106012
output size(bytes)		10537086	10513920	
compression size ratio(%)	100.4502445	100.2294026	

     100MBytes
compression time(sec)		2.671278	7.229928	36.94750487
output size(bytes)		105370774	105139200	
compression size ratio(%)	100.4854756	100.2646381	

     1GBytes
compression time(sec)		27.627126	74.94164	36.86485377
output size(bytes)		1078997064	1076625408	
compression size ratio(%)	100.489049	100.2681722	

  * /dev/zero
				lzo		zlib		compression time ratio(%)
     10MBytes
compression time(sec)		0.020834	0.238794	8.724674824
output size(bytes)		71680		104960		
compression size ratio(%)	0.683326825	1.000585709	

     100MBytes
compression time(sec)		0.208346	2.441701	8.532821996
output size(bytes)		716800		1049600		
compression size ratio(%)	0.683567048	1.000937463	

     1GBytes
compression time(sec)		2.123407	26.047801	8.151962617
output size(bytes)		7340032		10747904	
compression size ratio(%)	0.683591142	1.000972744

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: application/octet-stream;
 name="0001-Add-LZO-Support.patch"
Content-Disposition: attachment;
 filename="0001-Add-LZO-Support.patch"
Content-Transfer-Encoding: base64

RnJvbSA1ZTlmYjlhZTJhNjI1MzFiM2Y0NTEzNmZkMzU1YjYzYTBlN2FlOThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpwLmZ1aml0
c3UuY29tPgpEYXRlOiBXZWQsIDE2IE5vdiAyMDExIDEwOjQ5OjI3ICswOTAwClN1YmplY3Q6IFtS
RkMgUEFUQ0ggMS8yXSBtYWtlZHVtcGZpbGU6IEFkZCBMWk8gU3VwcG9ydAoKVGhpcyBpcyB0aGUg
bWFrZWR1bXBmaWxlIHNpZGUgb2YgdGhlIExaTyBzdXBwb3J0IHBhdGNoc3MuCi0tLQogZGlza2R1
bXBfbW9kLmggfCAgICAzICstCiBtYWtlZHVtcGZpbGUuYyB8ICAgNTkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogbWFrZWR1bXBmaWxlLmgg
fCAgICAyICsKIDMgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZGlza2R1bXBfbW9kLmggYi9kaXNrZHVtcF9tb2QuaAppbmRleCA3
NWVjZDE4Li5lYTIyOWFlIDEwMDY0NAotLS0gYS9kaXNrZHVtcF9tb2QuaAorKysgYi9kaXNrZHVt
cF9tb2QuaApAQCAtNzgsNyArNzgsOCBAQCBzdHJ1Y3Qga2R1bXBfc3ViX2hlYWRlciB7CiB9Owog
CiAvKiBwYWdlIGZsYWdzICovCi0jZGVmaW5lIERVTVBfREhfQ09NUFJFU1NFRAkweDEJLyogcGFn
ZSBpcyBjb21wcmVzc2VkICAgICAgICAgICAgICAgKi8KKyNkZWZpbmUgRFVNUF9ESF9DT01QUkVT
U0VEX1pMSUIJMHgxCS8qIHBhZ2UgaXMgY29tcHJlc3NlZCB3aXRoIHpsaWIgKi8KKyNkZWZpbmUg
RFVNUF9ESF9DT01QUkVTU0VEX0xaTwkweDIJLyogcGFnZSBpcyBjb21wcmVzc2VkIHdpdGggbHpv
ICovCiAKIC8qIGRlc2NyaXB0b3Igb2YgZWFjaCBwYWdlIGZvciB2bWNvcmUgKi8KIHR5cGVkZWYg
c3RydWN0IHBhZ2VfZGVzYyB7CmRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1w
ZmlsZS5jCmluZGV4IDQxNDNmMTIuLjJmODEwYjEgMTAwNjQ0Ci0tLSBhL21ha2VkdW1wZmlsZS5j
CisrKyBiL21ha2VkdW1wZmlsZS5jCkBAIC0yNTcsNyArMjU3LDcgQEAgcmVhZHBtZW1fa2R1bXBf
Y29tcHJlc3NlZCh1bnNpZ25lZCBsb25nIGxvbmcgcGFkZHIsIHZvaWQgKmJ1ZnB0ciwgc2l6ZV90
IHNpemUpCiAJCWdvdG8gZXJyb3I7CiAJfQogCi0JaWYgKHBkLmZsYWdzICYgRFVNUF9ESF9DT01Q
UkVTU0VEKSB7CisJaWYgKHBkLmZsYWdzICYgRFVNUF9ESF9DT01QUkVTU0VEX1pMSUIpIHsKIAkJ
cmV0bGVuID0gaW5mby0+cGFnZV9zaXplOwogCQlyZXQgPSB1bmNvbXByZXNzKCh1bnNpZ25lZCBj
aGFyICopYnVmMiwgJnJldGxlbiwKIAkJCQkJKHVuc2lnbmVkIGNoYXIgKilidWYsIHBkLnNpemUp
OwpAQCAtMjY2LDYgKzI2NiwxNyBAQCByZWFkcG1lbV9rZHVtcF9jb21wcmVzc2VkKHVuc2lnbmVk
IGxvbmcgbG9uZyBwYWRkciwgdm9pZCAqYnVmcHRyLCBzaXplX3Qgc2l6ZSkKIAkJCWdvdG8gZXJy
b3I7CiAJCX0KIAkJbWVtY3B5KGJ1ZnB0ciwgYnVmMiArIHBhZ2Vfb2Zmc2V0LCBzaXplKTsKKwl9
IGVsc2UgaWYgKGluZm8tPmZsYWdfbHpvX3N1cHBvcnQKKwkJICAgJiYgKHBkLmZsYWdzICYgRFVN
UF9ESF9DT01QUkVTU0VEX0xaTykpIHsKKwkJcmV0bGVuID0gaW5mby0+cGFnZV9zaXplOworCQly
ZXQgPSBsem8xeF9kZWNvbXByZXNzX3NhZmUoKHVuc2lnbmVkIGNoYXIgKilidWYsIHBkLnNpemUs
CisJCQkJCSAgICAodW5zaWduZWQgY2hhciAqKWJ1ZjIsICZyZXRsZW4sCisJCQkJCSAgICBMWk8x
WF9NRU1fREVDT01QUkVTUyk7CisJCWlmICgocmV0ICE9IExaT19FX09LKSB8fCAocmV0bGVuICE9
IGluZm8tPnBhZ2Vfc2l6ZSkpIHsKKwkJCUVSUk1TRygiVW5jb21wcmVzcyBmYWlsZWQ6ICVkXG4i
LCByZXQpOworCQkJZ290byBlcnJvcjsKKwkJfQorCQltZW1jcHkoYnVmcHRyLCBidWYyICsgcGFn
ZV9vZmZzZXQsIHNpemUpOwogCX0gZWxzZQogCQltZW1jcHkoYnVmcHRyLCBidWYgKyBwYWdlX29m
ZnNldCwgc2l6ZSk7CiAKQEAgLTI0OTUsNiArMjUwNiw5IEBAIGluaXRpYWwodm9pZCkKIAl1bnNp
Z25lZCBsb25nIHNpemU7CiAJaW50IGRlYnVnX2luZm8gPSBGQUxTRTsKIAorCWlmIChsem9faW5p
dCgpID09IExaT19FX09LKQorCQlpbmZvLT5mbGFnX2x6b19zdXBwb3J0ID0gVFJVRTsKKwogCWlm
ICghaXNfeGVuX21lbW9yeSgpICYmIGluZm8tPmZsYWdfZXhjbHVkZV94ZW5fZG9tKSB7CiAJCU1T
RygiJy1YJyBvcHRpb24gaXMgZGlzYWJsZSwiKTsKIAkJTVNHKCJiZWNhdXNlICVzIGlzIG5vdCBY
ZW4ncyBtZW1vcnkgY29yZSBpbWFnZS5cbiIsIGluZm8tPm5hbWVfbWVtb3J5KTsKQEAgLTQ2NjIs
MTAgKzQ2NzYsMTEgQEAgd3JpdGVfa2R1bXBfcGFnZXMoc3RydWN0IGNhY2hlX2RhdGEgKmNkX2hl
YWRlciwgc3RydWN0IGNhY2hlX2RhdGEgKmNkX3BhZ2UpCiAJb2ZmX3Qgb2Zmc2V0X2RhdGEgPSAw
OwogCXN0cnVjdCBkaXNrX2R1bXBfaGVhZGVyICpkaCA9IGluZm8tPmR1bXBfaGVhZGVyOwogCXVu
c2lnbmVkIGNoYXIgYnVmW2luZm8tPnBhZ2Vfc2l6ZV0sICpidWZfb3V0ID0gTlVMTDsKLQl1bnNp
Z25lZCBsb25nIGxlbl9idWZfb3V0OworCXVuc2lnbmVkIGxvbmcgbGVuX2J1Zl9vdXQsIGxlbl9i
dWZfb3V0X3psaWIsIGxlbl9idWZfb3V0X2x6bzsKIAlzdHJ1Y3QgZHVtcF9iaXRtYXAgYml0bWFw
MjsKIAlzdHJ1Y3QgdGltZXZhbCB0dl9zdGFydDsKIAljb25zdCBvZmZfdCBmYWlsZWQgPSAob2Zm
X3QpLTE7CisJbHpvX2J5dGVwIHdya21lbSA9IE5VTEw7CiAKIAlpbnQgcmV0ID0gRkFMU0U7CiAK
QEAgLTQ2NzQsNyArNDY4OSwxNSBAQCB3cml0ZV9rZHVtcF9wYWdlcyhzdHJ1Y3QgY2FjaGVfZGF0
YSAqY2RfaGVhZGVyLCBzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfcGFnZSkKIAogCWluaXRpYWxpemVf
Mm5kX2JpdG1hcCgmYml0bWFwMik7CiAKLQlsZW5fYnVmX291dCA9IGNvbXByZXNzQm91bmQoaW5m
by0+cGFnZV9zaXplKTsKKwlpZiAoKHdya21lbSA9IG1hbGxvYyhMWk8xWF8xX01FTV9DT01QUkVT
UykpID09IE5VTEwpIHsKKwkJRVJSTVNHKCJDYW4ndCBhbGxvY2F0ZSBtZW1vcnkgZm9yIHRoZSB3
b3JraW5nIG1lbW9yeS4gJXNcbiIsCisJCSAgICAgICBzdHJlcnJvcihlcnJubykpOworCQlnb3Rv
IG91dDsKKwl9CisKKwlsZW5fYnVmX291dF96bGliID0gY29tcHJlc3NCb3VuZChpbmZvLT5wYWdl
X3NpemUpOworCWxlbl9idWZfb3V0X2x6byA9IGluZm8tPnBhZ2Vfc2l6ZSArIGluZm8tPnBhZ2Vf
c2l6ZSAvIDE2ICsgNjQgKyAzOworCWxlbl9idWZfb3V0ID0gTUFYKGxlbl9idWZfb3V0X3psaWIs
IGxlbl9idWZfb3V0X2x6byk7CiAJaWYgKChidWZfb3V0ID0gbWFsbG9jKGxlbl9idWZfb3V0KSkg
PT0gTlVMTCkgewogCQlFUlJNU0coIkNhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3IgdGhlIGNvbXBy
ZXNzaW9uIGJ1ZmZlci4gJXNcbiIsCiAJCSAgICBzdHJlcnJvcihlcnJubykpOwpAQCAtNDc1NSwx
MyArNDc3OCwyMiBAQCB3cml0ZV9rZHVtcF9wYWdlcyhzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfaGVh
ZGVyLCBzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfcGFnZSkKIAkJLyoKIAkJICogQ29tcHJlc3MgdGhl
IHBhZ2UgZGF0YS4KIAkJICovCi0JCXNpemVfb3V0ID0gbGVuX2J1Zl9vdXQ7Ci0JCWlmIChpbmZv
LT5mbGFnX2NvbXByZXNzCi0JCSAgICAmJiAoY29tcHJlc3MyKGJ1Zl9vdXQsICZzaXplX291dCwg
YnVmLAotCQkgICAgaW5mby0+cGFnZV9zaXplLCBaX0JFU1RfU1BFRUQpID09IFpfT0spCisJCWlm
ICgoaW5mby0+ZmxhZ19jb21wcmVzcyAmIERVTVBfREhfQ09NUFJFU1NFRF9aTElCKQorCQkgICAg
JiYgKChzaXplX291dCA9IGxlbl9idWZfb3V0KSwKKwkJCWNvbXByZXNzMihidWZfb3V0LCAmc2l6
ZV9vdXQsIGJ1ZiwgaW5mby0+cGFnZV9zaXplLAorCQkJCSAgWl9CRVNUX1NQRUVEKSA9PSBaX09L
KQogCQkgICAgJiYgKHNpemVfb3V0IDwgaW5mby0+cGFnZV9zaXplKSkgewotCQkJcGQuZmxhZ3Mg
PSAxOwotCQkJcGQuc2l6ZSAgPSBzaXplX291dDsKKwkJCXBkLmZsYWdzID0gRFVNUF9ESF9DT01Q
UkVTU0VEX1pMSUI7CisJCQlwZC5zaXplID0gc2l6ZV9vdXQ7CisJCQltZW1jcHkoYnVmLCBidWZf
b3V0LCBwZC5zaXplKTsKKwkJfSBlbHNlIGlmIChpbmZvLT5mbGFnX2x6b19zdXBwb3J0CisJCQkg
ICAmJiAoaW5mby0+ZmxhZ19jb21wcmVzcyAmIERVTVBfREhfQ09NUFJFU1NFRF9MWk8pCisJCQkg
ICAmJiAoKHNpemVfb3V0ID0gaW5mby0+cGFnZV9zaXplKSwKKwkJCSAgICAgICBsem8xeF8xX2Nv
bXByZXNzKGJ1ZiwgaW5mby0+cGFnZV9zaXplLCBidWZfb3V0LAorCQkJCQkJJnNpemVfb3V0LCB3
cmttZW0pID09IExaT19FX09LKQorCQkJICAgJiYgKHNpemVfb3V0IDwgaW5mby0+cGFnZV9zaXpl
KSkgeworCQkJcGQuZmxhZ3MgPSBEVU1QX0RIX0NPTVBSRVNTRURfTFpPOworCQkJcGQuc2l6ZSA9
IHNpemVfb3V0OwogCQkJbWVtY3B5KGJ1ZiwgYnVmX291dCwgcGQuc2l6ZSk7CiAJCX0gZWxzZSB7
CiAJCQlwZC5mbGFncyA9IDA7CkBAIC00ODAzLDYgKzQ4MzUsOCBAQCB3cml0ZV9rZHVtcF9wYWdl
cyhzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfaGVhZGVyLCBzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfcGFn
ZSkKIG91dDoKIAlpZiAoYnVmX291dCAhPSBOVUxMKQogCQlmcmVlKGJ1Zl9vdXQpOworCWlmICh3
cmttZW0gIT0gTlVMTCkKKwkJZnJlZSh3cmttZW0pOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTY4
OTMsNyArNjkyNyw3IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAogCWluZm8tPmJs
b2NrX29yZGVyID0gREVGQVVMVF9PUkRFUjsKIAltZXNzYWdlX2xldmVsID0gREVGQVVMVF9NU0df
TEVWRUw7Ci0Jd2hpbGUgKChvcHQgPSBnZXRvcHRfbG9uZyhhcmdjLCBhcmd2LCAiYjpjRGQ6RUZm
ZzpoaTpNUnJzdlh4OiIsIGxvbmdvcHRzLAorCXdoaWxlICgob3B0ID0gZ2V0b3B0X2xvbmcoYXJn
YywgYXJndiwgImI6Y0RkOkVGZmc6aGk6bE1ScnN2WHg6IiwgbG9uZ29wdHMsCiAJICAgIE5VTEwp
KSAhPSAtMSkgewogCQlzd2l0Y2ggKG9wdCkgewogCQljYXNlICdiJzoKQEAgLTY5MDMsNyArNjkz
Nyw3IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJCWluZm8tPm5hbWVfZmlsdGVy
Y29uZmlnID0gb3B0YXJnOwogCQkJYnJlYWs7CiAJCWNhc2UgJ2MnOgotCQkJaW5mby0+ZmxhZ19j
b21wcmVzcyA9IDE7CisJCQlpbmZvLT5mbGFnX2NvbXByZXNzID0gRFVNUF9ESF9DT01QUkVTU0VE
X1pMSUI7CiAJCQlicmVhazsKIAkJY2FzZSAnRCc6CiAJCQlmbGFnX2RlYnVnID0gVFJVRTsKQEAg
LTY5NDIsNiArNjk3Niw5IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJCQlnb3Rv
IG91dDsKIAkJCWluZm8tPmZsYWdfc2FkdW1wX2Rpc2tzZXQgPSAxOwogCQkJYnJlYWs7CisJCWNh
c2UgJ2wnOgorCQkJaW5mby0+ZmxhZ19jb21wcmVzcyA9IERVTVBfREhfQ09NUFJFU1NFRF9MWk87
CisJCQlicmVhazsKIAkJY2FzZSAnbSc6CiAJCQltZXNzYWdlX2xldmVsID0gYXRvaShvcHRhcmcp
OwogCQkJYnJlYWs7CmRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuaCBiL21ha2VkdW1wZmlsZS5o
CmluZGV4IDFlMTMwMDguLjdhYzhjMGUgMTAwNjQ0Ci0tLSBhL21ha2VkdW1wZmlsZS5oCisrKyBi
L21ha2VkdW1wZmlsZS5oCkBAIC0zMiw2ICszMiw3IEBACiAjaW5jbHVkZSA8Ynl0ZXN3YXAuaD4K
ICNpbmNsdWRlIDxnZXRvcHQuaD4KICNpbmNsdWRlIDxsaW1pdHMuaD4KKyNpbmNsdWRlIDxsem8v
bHpvMXguaD4KICNpbmNsdWRlICJjb21tb24uaCIKICNpbmNsdWRlICJkd2FyZl9pbmZvLmgiCiAj
aW5jbHVkZSAiZGlza2R1bXBfbW9kLmgiCkBAIC03NjcsNiArNzY4LDcgQEAgc3RydWN0IER1bXBJ
bmZvIHsKIAlpbnQJCW51bV9kdW1wX2xldmVsOyAgICAgIC8qIG51bWJlciBvZiBkdW1wIGxldmVs
ICovCiAJaW50CQlhcnJheV9kdW1wX2xldmVsW05VTV9BUlJBWV9EVU1QX0xFVkVMXTsKIAlpbnQJ
CWZsYWdfY29tcHJlc3M7ICAgICAgIC8qIGZsYWcgb2YgY29tcHJlc3Npb24gKi8KKwlpbnQJCWZs
YWdfbHpvX3N1cHBvcnQ7ICAgIC8qIGZsYWcgb2YgTFpPIGNvbXByZXNzaW9uIHN1cHBvcnQgKi8K
IAlpbnQJCWZsYWdfZWxmX2R1bXBmaWxlOyAgIC8qIGZsYWcgb2YgY3JlYXRpbmcgRUxGIGR1bXBm
aWxlICovCiAJaW50CQlmbGFnX2dlbmVyYXRlX3ZtY29yZWluZm87LyogZmxhZyBvZiBnZW5lcmF0
aW5nIHZtY29yZWluZm8gZmlsZSAqLwogCWludAkJZmxhZ19yZWFkX3ZtY29yZWluZm87ICAgIC8q
IGZsYWcgb2YgcmVhZGluZyB2bWNvcmVpbmZvIGZpbGUgKi8KLS0gCjEuNy40LjQKCg==

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: application/octet-stream;
 name="0001-Support-LZO-compression-format.patch"
Content-Disposition: attachment;
 filename="0001-Support-LZO-compression-format.patch"
Content-Transfer-Encoding: base64

RnJvbSBjNDdlZDgyODU2MGNiYmZjMDZjMGRlZGNlOWZkOGEwYTdkNTY3MWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpwLmZ1aml0
c3UuY29tPgpEYXRlOiBXZWQsIDIgTm92IDIwMTEgMTU6MTI6MjggKzA5MDAKU3ViamVjdDogW1JG
QyBQQVRDSF0gY3Jhc2g6IFN1cHBvcnQgTFpPIGNvbXByZXNzaW9uIGZvcm1hdAoKLS0tCiBkZWZz
LmggICAgIHwgICAgMSArCiBkaXNrZHVtcC5jIHwgICAyMCArKysrKysrKysrKysrKysrKysrLQog
ZGlza2R1bXAuaCB8ICAgIDMgKystCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGVmcy5oIGIvZGVmcy5oCmluZGV4IDY2ZDg0
NGIuLmEwNTM5MWIgMTAwNzU1Ci0tLSBhL2RlZnMuaAorKysgYi9kZWZzLmgKQEAgLTQ3LDYgKzQ3
LDcgQEAKICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUgPHN5cy90aW1lLmg+CiAjaW5j
bHVkZSA8ZXhlY2luZm8uaD4gLyogYmFja3RyYWNlKCkgKi8KKyNpbmNsdWRlIDxsem8vbHpvMXgu
aD4KIAogI2lmbmRlZiBBVFRSSUJVVEVfVU5VU0VECiAjZGVmaW5lIEFUVFJJQlVURV9VTlVTRUQg
X19hdHRyaWJ1dGVfXyAoKF9fdW51c2VkX18pKQpkaWZmIC0tZ2l0IGEvZGlza2R1bXAuYyBiL2Rp
c2tkdW1wLmMKaW5kZXggNTUxOWFmNy4uNjIwZDNmMSAxMDA2NDQKLS0tIGEvZGlza2R1bXAuYwor
KysgYi9kaXNrZHVtcC5jCkBAIC02Niw2ICs2Niw3IEBAIHN0cnVjdCBkaXNrZHVtcF9kYXRhIHsK
IAl1bG9uZwljYWNoZWRfcmVhZHM7CiAJdWxvbmcgICp2YWxpZF9wYWdlczsKIAl1bG9uZyAgIGFj
Y2Vzc2VzOworCWludAlsem9fc3VwcG9ydGVkOwogfTsKIAogc3RhdGljIHN0cnVjdCBkaXNrZHVt
cF9kYXRhIGRpc2tkdW1wX2RhdGEgPSB7IDAgfTsKQEAgLTY0MSw2ICs2NDIsOCBAQCBpc19kaXNr
ZHVtcChjaGFyICpmaWxlKQogCWlmIChwYy0+ZmxhZ3MyICYgR0VUX09TUkVMRUFTRSkgCiAJCWRp
c2tkdW1wX2dldF9vc3JlbGVhc2UoKTsKIAorCWRkLT5sem9fc3VwcG9ydGVkID0gbHpvX2luaXQo
KSA9PSBMWk9fRV9PSzsKKwogCXJldHVybiBUUlVFOwogfQogCkBAIC03OTUsMTMgKzc5OCwyOCBA
QCBjYWNoZV9wYWdlKHBoeXNhZGRyX3QgcGFkZHIpCiAJCQlyZXR1cm4gUkVBRF9FUlJPUjsKIAl9
CiAKLQlpZiAocGQuZmxhZ3MgJiBEVU1QX0RIX0NPTVBSRVNTRUQpIHsKKwlpZiAocGQuZmxhZ3Mg
JiBEVU1QX0RIX0NPTVBSRVNTRURfWkxJQikgewogCQlyZXRsZW4gPSBibG9ja19zaXplOwogCQly
ZXQgPSB1bmNvbXByZXNzKCh1bnNpZ25lZCBjaGFyICopZGQtPnBhZ2VfY2FjaGVfaGRyW2ldLnBn
X2J1ZnB0ciwKIAkJICAgICAgICAgICAgICAgICAmcmV0bGVuLAogCQkgICAgICAgICAgICAgICAg
ICh1bnNpZ25lZCBjaGFyICopZGQtPmNvbXByZXNzZWRfcGFnZSwKIAkJICAgICAgICAgICAgICAg
ICBwZC5zaXplKTsKIAkJaWYgKChyZXQgIT0gWl9PSykgfHwgKHJldGxlbiAhPSBibG9ja19zaXpl
KSkgeworCQkJZXJyb3IoSU5GTywgIiVzOiB1bmNvbXByZXNzIGZhaWxlZDogJWRcbiIsCisJCQkJ
RElTS0RVTVBfVkFMSUQoKSA/ICJkaXNrZHVtcCIgOiAiY29tcHJlc3NlZCBrZHVtcCIsCisJCQkJ
cmV0KTsKKwkJCXJldHVybiBSRUFEX0VSUk9SOworCQl9CisJfSBlbHNlIGlmIChwZC5mbGFncyAm
IERVTVBfREhfQ09NUFJFU1NFRF9MWk8pIHsKKworCQlpZiAoIWRkLT5sem9fc3VwcG9ydGVkKQor
CQkJcmV0dXJuIFJFQURfRVJST1I7CisKKwkJcmV0bGVuID0gYmxvY2tfc2l6ZTsKKwkJcmV0ID0g
bHpvMXhfZGVjb21wcmVzc19zYWZlKGRkLT5jb21wcmVzc2VkX3BhZ2UsIHBkLnNpemUsCisJCQkJ
CSAgICBkZC0+cGFnZV9jYWNoZV9oZHJbaV0ucGdfYnVmcHRyLAorCQkJCQkgICAgJnJldGxlbiwg
TFpPMVhfTUVNX0RFQ09NUFJFU1MpOworCQlpZiAoKHJldCAhPSBMWk9fRV9PSykgfHwgKHJldGxl
biAhPSBibG9ja19zaXplKSkgewogCQkJZXJyb3IoSU5GTywgIiVzOiB1bmNvbXByZXNzIGZhaWxl
ZDogJWRcbiIsIAogCQkJCURJU0tEVU1QX1ZBTElEKCkgPyAiZGlza2R1bXAiIDogImNvbXByZXNz
ZWQga2R1bXAiLAogCQkJCXJldCk7CmRpZmYgLS1naXQgYS9kaXNrZHVtcC5oIGIvZGlza2R1bXAu
aAppbmRleCBjN2NjNGZjLi5iZDk5ZmJkIDEwMDY0NAotLS0gYS9kaXNrZHVtcC5oCisrKyBiL2Rp
c2tkdW1wLmgKQEAgLTcyLDcgKzcyLDggQEAgc3RydWN0IGtkdW1wX3N1Yl9oZWFkZXIgewogfTsK
IAogLyogcGFnZSBmbGFncyAqLwotI2RlZmluZSBEVU1QX0RIX0NPTVBSRVNTRUQJMHgxCS8qIHBh
Z2UgaXMgY29tcHJlc3NlZCAgICAgICAgICAgICAgICovCisjZGVmaW5lIERVTVBfREhfQ09NUFJF
U1NFRF9aTElCCTB4MQkvKiBwYWdlIGlzIGNvbXByZXNzZWQgd2l0aCB6bGliICovCisjZGVmaW5l
IERVTVBfREhfQ09NUFJFU1NFRF9MWk8JMHgyCS8qIHBhZ2UgaXMgY29tcHJlc3NlZCB3aXRoIGx6
byAqLwogCiAvKiBkZXNjcmlwdG9yIG9mIGVhY2ggcGFnZSBmb3Igdm1jb3JlICovCiB0eXBlZGVm
IHN0cnVjdCBwYWdlX2Rlc2MgewotLSAKMS43LjQuNAoK

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: application/octet-stream;
 name="0002-Add-Compression-and-IO-time-report.patch"
Content-Disposition: attachment;
 filename="0002-Add-Compression-and-IO-time-report.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMWUzZDU2MTQ3MmNlOTYyZjc2ZGNiNDg2ZjhkZDk0ODk3NDljMzlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpwLmZ1aml0
c3UuY29tPgpEYXRlOiBXZWQsIDE2IE5vdiAyMDExIDE2OjE2OjU0ICswOTAwClN1YmplY3Q6IFtS
RkMgUEFUQ0ggMi8yXSBtYWtlZHVtcGZpbGU6IEFkZCBDb21wcmVzc2lvbiBhbmQgSU8gdGltZSBy
ZXBvcnQKCkFkZCBjb21wcmVzc2lvbiBhbmQgSU8gdGltZSByZXBvcnQgaW4gaW5mb3JtYXRpb24g
Z2l2ZW4gd2hlbgotLW1lc3NhZ2UtbGV2ZWwgMTYgaXMgc3BlY2lmaWVkIGluIGNvbW1hbmQtbGlu
ZS4KClRoZSBleGFtcGxlIGlzIGxpa2UgdGhpczoKCiQgLi9tYWtlZHVtcGZpbGUgLS1tZXNzYWdl
LWxldmVsIDE2IC1jIC1kMCB2bWNvcmUgZHVtcGZpbGUKCmJpdG1hcCBjcmVhdGlvbiB0aW1lOiAw
LjAwMTM3NiBzZWNvbmRzCgpJL08gdGltZTogMy4xNTI5OTUgc2Vjb25kcwpDb21wcmVzc2lvbiB0
aW1lOiAyMTYuMjY3Njk0IHNlY29uZHMKU1RFUCBbQ29weWluZyBkYXRhICAgICAgICAgICAgICAg
XSA6IDMxOS4zNTI2NzAgc2Vjb25kcwoKT3JpZ2luYWwgcGFnZXMgIDogMHgwMDAwMDAwMDAwMTQw
MDAwCiAgRXhjbHVkZWQgcGFnZXMgICA6IDB4MDAwMDAwMDAwMDAxMjU0ZAogICAgUGFnZXMgZmls
bGVkIHdpdGggemVybyAgOiAweDAwMDAwMDAwMDAwMTI1NGQKICAgIENhY2hlIHBhZ2VzICAgICAg
ICAgICAgIDogMHgwMDAwMDAwMDAwMDAwMDAwCiAgICBDYWNoZSBwYWdlcyArIHByaXZhdGUgICA6
IDB4MDAwMDAwMDAwMDAwMDAwMAogICAgVXNlciBwcm9jZXNzIGRhdGEgcGFnZXMgOiAweDAwMDAw
MDAwMDAwMDAwMDAKICAgIEZyZWUgcGFnZXMgICAgICAgICAgICAgIDogMHgwMDAwMDAwMDAwMDAw
MDAwCiAgUmVtYWluaW5nIHBhZ2VzICA6IDB4MDAwMDAwMDAwMDEyZGFiMwogIChUaGUgbnVtYmVy
IG9mIHBhZ2VzIGlzIHJlZHVjZWQgdG8gOTQlLikKTWVtb3J5IEhvbGUgICAgIDogMHgwMDAwMDAw
MDAwMDAwMDAwCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tClRvdGFsIHBhZ2VzICAgICA6IDB4MDAwMDAwMDAwMDE0MDAwMAotLS0KIG1ha2VkdW1wZmls
ZS5jIHwgICA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiBt
YWtlZHVtcGZpbGUuaCB8ICAgMTAgKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIv
bWFrZWR1bXBmaWxlLmMKaW5kZXggMmY4MTBiMS4uN2E2MDBlNyAxMDA2NDQKLS0tIGEvbWFrZWR1
bXBmaWxlLmMKKysrIGIvbWFrZWR1bXBmaWxlLmMKQEAgLTQ2NzksNiArNDY3OSw3IEBAIHdyaXRl
X2tkdW1wX3BhZ2VzKHN0cnVjdCBjYWNoZV9kYXRhICpjZF9oZWFkZXIsIHN0cnVjdCBjYWNoZV9k
YXRhICpjZF9wYWdlKQogCXVuc2lnbmVkIGxvbmcgbGVuX2J1Zl9vdXQsIGxlbl9idWZfb3V0X3ps
aWIsIGxlbl9idWZfb3V0X2x6bzsKIAlzdHJ1Y3QgZHVtcF9iaXRtYXAgYml0bWFwMjsKIAlzdHJ1
Y3QgdGltZXZhbCB0dl9zdGFydDsKKwlkb3VibGUgZF9zdGFydCwgZF9lbmQsIGRfY29tcHJlc3Ms
IGRfaW87CiAJY29uc3Qgb2ZmX3QgZmFpbGVkID0gKG9mZl90KS0xOwogCWx6b19ieXRlcCB3cmtt
ZW0gPSBOVUxMOwogCkBAIC00NzQ5LDYgKzQ3NTAsOCBAQCB3cml0ZV9rZHVtcF9wYWdlcyhzdHJ1
Y3QgY2FjaGVfZGF0YSAqY2RfaGVhZGVyLCBzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfcGFnZSkKIAkJ
ZW5kX3BmbiAgID0gaW5mby0+bWF4X21hcG5yOwogCX0KIAorCWRfY29tcHJlc3MgPSBkX2lvID0g
MC4wOworCiAJZm9yIChwZm4gPSBzdGFydF9wZm47IHBmbiA8IGVuZF9wZm47IHBmbisrKSB7CiAK
IAkJaWYgKChudW1fZHVtcGVkICUgcGVyKSA9PSAwKQpAQCAtNDc3OSwxOSArNDc4MiwyOSBAQCB3
cml0ZV9rZHVtcF9wYWdlcyhzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfaGVhZGVyLCBzdHJ1Y3QgY2Fj
aGVfZGF0YSAqY2RfcGFnZSkKIAkJICogQ29tcHJlc3MgdGhlIHBhZ2UgZGF0YS4KIAkJICovCiAJ
CWlmICgoaW5mby0+ZmxhZ19jb21wcmVzcyAmIERVTVBfREhfQ09NUFJFU1NFRF9aTElCKQotCQkg
ICAgJiYgKChzaXplX291dCA9IGxlbl9idWZfb3V0KSwKKwkJICAgICYmICgoZF9zdGFydCA9IGdl
dGR0aW1lKCkpLAorCQkJKHNpemVfb3V0ID0gbGVuX2J1Zl9vdXQpLAogCQkJY29tcHJlc3MyKGJ1
Zl9vdXQsICZzaXplX291dCwgYnVmLCBpbmZvLT5wYWdlX3NpemUsCiAJCQkJICBaX0JFU1RfU1BF
RUQpID09IFpfT0spCisJCSAgICAmJiAoKGRfZW5kID0gZ2V0ZHRpbWUoKSksIFRSVUUpCiAJCSAg
ICAmJiAoc2l6ZV9vdXQgPCBpbmZvLT5wYWdlX3NpemUpKSB7CisKKwkJCWRfY29tcHJlc3MgKz0g
ZF9lbmQgLSBkX3N0YXJ0OworCiAJCQlwZC5mbGFncyA9IERVTVBfREhfQ09NUFJFU1NFRF9aTElC
OwogCQkJcGQuc2l6ZSA9IHNpemVfb3V0OwogCQkJbWVtY3B5KGJ1ZiwgYnVmX291dCwgcGQuc2l6
ZSk7CiAJCX0gZWxzZSBpZiAoaW5mby0+ZmxhZ19sem9fc3VwcG9ydAogCQkJICAgJiYgKGluZm8t
PmZsYWdfY29tcHJlc3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfTFpPKQotCQkJICAgJiYgKChzaXpl
X291dCA9IGluZm8tPnBhZ2Vfc2l6ZSksCisJCQkgICAmJiAoKGRfc3RhcnQgPSBnZXRkdGltZSgp
KSwKKwkJCSAgICAgICAoc2l6ZV9vdXQgPSBpbmZvLT5wYWdlX3NpemUpLAogCQkJICAgICAgIGx6
bzF4XzFfY29tcHJlc3MoYnVmLCBpbmZvLT5wYWdlX3NpemUsIGJ1Zl9vdXQsCiAJCQkJCQkmc2l6
ZV9vdXQsIHdya21lbSkgPT0gTFpPX0VfT0spCisJCQkgICAmJiAoKGRfZW5kID0gZ2V0ZHRpbWUo
KSksIFRSVUUpCiAJCQkgICAmJiAoc2l6ZV9vdXQgPCBpbmZvLT5wYWdlX3NpemUpKSB7CisKKwkJ
CWRfY29tcHJlc3MgKz0gZF9lbmQgLSBkX3N0YXJ0OworCiAJCQlwZC5mbGFncyA9IERVTVBfREhf
Q09NUFJFU1NFRF9MWk87CiAJCQlwZC5zaXplID0gc2l6ZV9vdXQ7CiAJCQltZW1jcHkoYnVmLCBi
dWZfb3V0LCBwZC5zaXplKTsKQEAgLTQ4MDMsNiArNDgxNiw4IEBAIHdyaXRlX2tkdW1wX3BhZ2Vz
KHN0cnVjdCBjYWNoZV9kYXRhICpjZF9oZWFkZXIsIHN0cnVjdCBjYWNoZV9kYXRhICpjZF9wYWdl
KQogCQlwZC5vZmZzZXQgICAgID0gb2Zmc2V0X2RhdGE7CiAJCW9mZnNldF9kYXRhICArPSBwZC5z
aXplOwogCisJCWRfc3RhcnQgPSBnZXRkdGltZSgpOworCiAJCS8qCiAJCSAqIFdyaXRlIHRoZSBw
YWdlIGhlYWRlci4KIAkJICovCkBAIC00ODE0LDggKzQ4MjksMTQgQEAgd3JpdGVfa2R1bXBfcGFn
ZXMoc3RydWN0IGNhY2hlX2RhdGEgKmNkX2hlYWRlciwgc3RydWN0IGNhY2hlX2RhdGEgKmNkX3Bh
Z2UpCiAJCSAqLwogCQlpZiAoIXdyaXRlX2NhY2hlKGNkX3BhZ2UsIGJ1ZiwgcGQuc2l6ZSkpCiAJ
CQlnb3RvIG91dDsKKworCQlkX2VuZCA9IGdldGR0aW1lKCk7CisKKwkJZF9pbyArPSBkX2VuZCAt
IGRfc3RhcnQ7CiAJfQogCisJZF9zdGFydCA9IGdldGR0aW1lKCk7CisKIAkvKgogCSAqIFdyaXRl
IHRoZSByZW1haW5kZXIuCiAJICovCkBAIC00ODI0LDYgKzQ4NDUsMTQgQEAgd3JpdGVfa2R1bXBf
cGFnZXMoc3RydWN0IGNhY2hlX2RhdGEgKmNkX2hlYWRlciwgc3RydWN0IGNhY2hlX2RhdGEgKmNk
X3BhZ2UpCiAJaWYgKCF3cml0ZV9jYWNoZV9idWZzeihjZF9oZWFkZXIpKQogCQlnb3RvIG91dDsK
IAorCWRfZW5kID0gZ2V0ZHRpbWUoKTsKKworCWRfaW8gKz0gZF9lbmQgLSBkX3N0YXJ0OworCisJ
UkVQT1JUX01TRygiXG4iKTsKKwlSRVBPUlRfTVNHKCJJL08gdGltZTogJWxmIHNlY29uZHNcbiIs
IGRfaW8pOworCVJFUE9SVF9NU0coIkNvbXByZXNzaW9uIHRpbWU6ICVsZiBzZWNvbmRzXG4iLCBk
X2NvbXByZXNzKTsKKwogCS8qCiAJICogcHJpbnQgWzEwMCAlXQogCSAqLwpAQCAtNjAzOSw2ICs2
MDY4LDcgQEAgaW50CiBjcmVhdGVfZHVtcGZpbGUodm9pZCkKIHsKIAlpbnQgbnVtX3JldHJ5LCBz
dGF0dXMsIG5ld19sZXZlbDsKKwlkb3VibGUgZF9zdGFydCwgZF9lbmQsIGRfYml0bWFwOwogCiAJ
aWYgKCFvcGVuX2ZpbGVzX2Zvcl9jcmVhdGluZ19kdW1wZmlsZSgpKQogCQlyZXR1cm4gRkFMU0U7
CkBAIC02MDczLDkgKzYxMDMsMTggQEAgcmV0cnk6CiAJaWYgKGluZm8tPm5hbWVfZmlsdGVyY29u
ZmlnICYmICFnYXRoZXJfZmlsdGVyX2luZm8oKSkKIAkJcmV0dXJuIEZBTFNFOwogCisJZF9zdGFy
dCA9IGdldGR0aW1lKCk7CisKIAlpZiAoIWNyZWF0ZV9kdW1wX2JpdG1hcCgpKQogCQlyZXR1cm4g
RkFMU0U7CiAKKwlkX2VuZCA9IGdldGR0aW1lKCk7CisKKwlkX2JpdG1hcCA9IGRfZW5kIC0gZF9z
dGFydDsKKworCVJFUE9SVF9NU0coIlxuIik7CisJUkVQT1JUX01TRygiYml0bWFwIGNyZWF0aW9u
IHRpbWU6ICVsZiBzZWNvbmRzXG4iLCBkX2JpdG1hcCk7CisKIAlpZiAoaW5mby0+ZmxhZ19zcGxp
dCkgewogCQlpZiAoKHN0YXR1cyA9IHdyaXRlb3V0X211bHRpcGxlX2R1bXBmaWxlcygpKSA9PSBG
QUxTRSkKIAkJCXJldHVybiBGQUxTRTsKZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5oIGIvbWFr
ZWR1bXBmaWxlLmgKaW5kZXggN2FjOGMwZS4uN2VjOGNjNiAxMDA2NDQKLS0tIGEvbWFrZWR1bXBm
aWxlLmgKKysrIGIvbWFrZWR1bXBmaWxlLmgKQEAgLTMzLDYgKzMzLDcgQEAKICNpbmNsdWRlIDxn
ZXRvcHQuaD4KICNpbmNsdWRlIDxsaW1pdHMuaD4KICNpbmNsdWRlIDxsem8vbHpvMXguaD4KKyNp
bmNsdWRlIDxzeXMvdGltZS5oPgogI2luY2x1ZGUgImNvbW1vbi5oIgogI2luY2x1ZGUgImR3YXJm
X2luZm8uaCIKICNpbmNsdWRlICJkaXNrZHVtcF9tb2QuaCIKQEAgLTE0NDcsNCArMTQ0OCwxMyBA
QCBzdHJ1Y3QgZWxmX3Byc3RhdHVzIHsKIAogI2VuZGlmCiAKK3N0YXRpYyBpbmxpbmUgZG91Ymxl
IGdldGR0aW1lKHZvaWQpCit7CisJc3RydWN0IHRpbWV2YWwgdHY7CisKKwlnZXR0aW1lb2ZkYXko
JnR2LCBOVUxMKTsKKworCXJldHVybiAoZG91YmxlKXR2LnR2X3NlYyArIChkb3VibGUpdHYudHZf
dXNlYyAqIDAuMDAxICogMC4wMDE7Cit9CisKICNlbmRpZiAvKiBNQUtFRFVNUEZJTEVfSCAqLwot
LSAKMS43LjQuNAoK

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--Multipart=_Thu__17_Nov_2011_21_19_46_+0900_W/fa6vRrLTUk41Gk--


