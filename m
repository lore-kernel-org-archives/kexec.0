Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp05.uk.ibm.com ([195.75.94.101])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zr3eU-0000Fl-9C
 for kexec@lists.infradead.org; Tue, 27 Oct 2015 12:46:59 +0000
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 12:46:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7126B17D8059
 for <kexec@lists.infradead.org>; Tue, 27 Oct 2015 12:35:34 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RCZMZw53542970
 for <kexec@lists.infradead.org>; Tue, 27 Oct 2015 12:35:22 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RCZM8s028515
 for <kexec@lists.infradead.org>; Tue, 27 Oct 2015 06:35:22 -0600
Date: Tue, 27 Oct 2015 13:35:20 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v2] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151027133520.30653ba3@holzheu>
In-Reply-To: <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
 <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org

On Mon, 26 Oct 2015 15:31:39 +0800
Dave Young <dyoung@redhat.com> wrote:

[snip]

> IMHO adding a slurp_file_mmap for s390x use is a better way since the
> huge initramfs is not a general case.

Ok, what about the following patch:
---
[PATCH] kexec/s390x: use mmap instead of read for slurp_file()

The slurp_fd() function allocates memory and uses the read() system call.
This results in double memory consumption for image and initrd:

 1) Memory allocated in user space by the kexec tool
 2) Memory allocated in kernel by the kexec() system call

Therefore use mmap() to reduce the runtime memory consumption of the kexec tool.

The following use case illustrates the usefulness of this patch a bit more:

 1) Boot a 4 GB Linux system
 2) Read kernel and 1,5 GB ramdisk from external source into local
    tmpfs (ram)
 3) kexec the kernel and ramdisk

 Without this patch for the kexec runtime we need:

 1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/arch/s390/kexec-image.c |    2 +-
 kexec/kexec.c                 |   40 ++++++++++++++++++++++++++++++++++------
 kexec/kexec.h                 |    1 +
 3 files changed, 36 insertions(+), 7 deletions(-)

--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -101,7 +101,7 @@ image_s390_load(int argc, char **argv, c
 	 * we load the ramdisk directly behind the image with 1 MiB alignment.
 	 */
 	if (ramdisk) {
-		rd_buffer = slurp_file(ramdisk, &ramdisk_len);
+		rd_buffer = slurp_file_mmap(ramdisk, &ramdisk_len);
 		if (rd_buffer == NULL) {
 			fprintf(stderr, "Could not read ramdisk.\n");
 			return -1;
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -29,6 +29,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/reboot.h>
+#include <sys/mman.h>
 #include <unistd.h>
 #include <fcntl.h>
 #ifndef _O_BINARY
@@ -481,13 +482,19 @@ static int add_backup_segments(struct ke
 	return 0;
 }
 
-static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
+static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread,
+		      int use_mmap)
 {
 	char *buf;
 	off_t progress;
 	ssize_t result;
 
-	buf = xmalloc(size);
+	if (use_mmap) {
+		buf = mmap(NULL, size, PROT_READ|PROT_WRITE,
+			   MAP_ANON|MAP_PRIVATE, -1, 0);
+	} else {
+		buf = xmalloc(size);
+	}
 	progress = 0;
 	while (progress < size) {
 		result = read(fd, buf + progress, size - progress);
@@ -496,7 +503,10 @@ static char *slurp_fd(int fd, const char
 				continue;
 			fprintf(stderr, "Read on %s failed: %s\n", filename,
 				strerror(errno));
-			free(buf);
+			if (use_mmap)
+				munmap(buf, size);
+			else
+				free(buf);
 			close(fd);
 			return NULL;
 		}
@@ -514,7 +524,8 @@ static char *slurp_fd(int fd, const char
 	return buf;
 }
 
-char *slurp_file(const char *filename, off_t *r_size)
+static char *slurp_file_generic(const char *filename, off_t *r_size,
+				int use_mmap)
 {
 	int fd;
 	char *buf;
@@ -552,11 +563,18 @@ char *slurp_file(const char *filename, o
 		if (err < 0)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
+		buf = slurp_fd(fd, filename, size, &nread, use_mmap);
 	} else {
 		size = stats.st_size;
+		if (use_mmap) {
+			buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE, fd, 0);
+			nread = stats.st_size;
+		} else {
+			buf = slurp_fd(fd, filename, size, &nread, 0);
+		}
 	}
 
-	buf = slurp_fd(fd, filename, size, &nread);
 	if (!buf)
 		die("Cannot read %s", filename);
 
@@ -567,6 +585,16 @@ char *slurp_file(const char *filename, o
 	return buf;
 }
 
+char *slurp_file(const char *filename, off_t *r_size)
+{
+	return slurp_file_generic(filename, r_size, 0);
+}
+
+char *slurp_file_mmap(const char *filename, off_t *r_size)
+{
+	return slurp_file_generic(filename, r_size, 1);
+}
+
 /* This functions reads either specified number of bytes from the file or
    lesser if EOF is met. */
 
@@ -583,7 +611,7 @@ char *slurp_file_len(const char *filenam
 		return 0;
 	}
 
-	return slurp_fd(fd, filename, size, nread);
+	return slurp_fd(fd, filename, size, nread, 0);
 }
 
 char *slurp_decompress_file(const char *filename, off_t *r_size)
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -253,6 +253,7 @@ extern void die(const char *fmt, ...)
 extern void *xmalloc(size_t size);
 extern void *xrealloc(void *ptr, size_t size);
 extern char *slurp_file(const char *filename, off_t *r_size);
+extern char *slurp_file_mmap(const char *filename, off_t *r_size);
 extern char *slurp_file_len(const char *filename, off_t size, off_t *nread);
 extern char *slurp_decompress_file(const char *filename, off_t *r_size);
 extern unsigned long virt_to_phys(unsigned long addr);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
