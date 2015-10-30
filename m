Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZsBCJ-0002Wt-0u
 for kexec@lists.infradead.org; Fri, 30 Oct 2015 15:02:32 +0000
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 15:02:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7192E17D8062
 for <kexec@lists.infradead.org>; Fri, 30 Oct 2015 15:02:19 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9UF267m52625568
 for <kexec@lists.infradead.org>; Fri, 30 Oct 2015 15:02:06 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9UF250P031525
 for <kexec@lists.infradead.org>; Fri, 30 Oct 2015 09:02:06 -0600
Date: Fri, 30 Oct 2015 16:02:04 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v3] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151030160204.6cf76607@holzheu>
In-Reply-To: <20151030133904.GA18134@localhost.localdomain>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
 <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
 <20151027133520.30653ba3@holzheu>
 <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
 <20151028105721.4ada142d@holzheu>
 <20151029063710.GE21927@dhcp-129-115.nay.redhat.com>
 <20151029162612.14e68bdc@holzheu>
 <20151030020322.GA18800@dhcp-128-73.nay.redhat.com>
 <20151030111353.7fdf3762@holzheu>
 <20151030133904.GA18134@localhost.localdomain>
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
To: Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

The slurp_fd() function allocates memory and uses the read() system call.
This results in double memory consumption for image and initrd:

 1) Memory allocated in user space by the kexec tool
 2) Memory allocated in kernel by the kexec() system call

The following illustrates the use case that we have on s390x:

 1) Boot a 4 GB Linux system
 2) Copy kernel and 1,5 GB ramdisk from external source into tmpfs (ram)
 3) Use kexec to boot kernel with ramdisk

 Therefore for kexec runtime we need:

 1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB

This patch introduces slurp_file_mmap() which for "normal" files uses
mmap() instead of malloc()/read(). This reduces the runtime memory
consumption of the kexec tool as follows:

 1,5 GB (tmpfs) + 1,5 GB (kernel memory) = 3 GB

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/s390/kexec-image.c |    2 +-
 kexec/kexec.c                 |   31 ++++++++++++++++++++++++++++---
 kexec/kexec.h                 |    1 +
 3 files changed, 30 insertions(+), 4 deletions(-)

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
@@ -514,7 +515,8 @@ static char *slurp_fd(int fd, const char
 	return buf;
 }
 
-char *slurp_file(const char *filename, off_t *r_size)
+static char *slurp_file_generic(const char *filename, off_t *r_size,
+				int use_mmap)
 {
 	int fd;
 	char *buf;
@@ -552,11 +554,17 @@ char *slurp_file(const char *filename, o
 		if (err < 0)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
+		buf = slurp_fd(fd, filename, size, &nread);
 	} else {
 		size = stats.st_size;
+		if (use_mmap) {
+			buf = mmap(NULL, size, PROT_READ|PROT_WRITE,
+				   MAP_PRIVATE, fd, 0);
+			nread = size;
+		} else {
+			buf = slurp_fd(fd, filename, size, &nread);
+		}
 	}
-
-	buf = slurp_fd(fd, filename, size, &nread);
 	if (!buf)
 		die("Cannot read %s", filename);
 
@@ -567,6 +575,23 @@ char *slurp_file(const char *filename, o
 	return buf;
 }
 
+/*
+ * Read file into malloced buffer.
+ */
+char *slurp_file(const char *filename, off_t *r_size)
+{
+	return slurp_file_generic(filename, r_size, 0);
+}
+
+/*
+ * Map "normal" file or read "character device" into malloced buffer.
+ * You must not use free, realloc, etc. for the returned buffer.
+ */
+char *slurp_file_mmap(const char *filename, off_t *r_size)
+{
+	return slurp_file_generic(filename, r_size, 1);
+}
+
 /* This functions reads either specified number of bytes from the file or
    lesser if EOF is met. */
 
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
