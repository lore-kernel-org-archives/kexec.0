Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R4Xo2-0007kD-N2
	for kexec@lists.infradead.org; Fri, 16 Sep 2011 12:46:11 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8GCk5qS026566
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 12:46:05 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8GCk5wu1962062
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 13:46:05 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8GCk5di024779
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 06:46:05 -0600
Subject: [PATCH]  kexec-tools: s390: Find correct address for ramdisk
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 16 Sep 2011 14:46:04 +0200
Message-ID: <1316177164.3507.10.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hello Simon,

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

When the kernel image size is larger than 8 MiB on s390, we currently
can't load the ramdisk, because it is loaded to the fix address 8 MiB
(RAMDISK_ORIGIN_ADDR) per default.

With this patch the ramdisk is loaded behind the image with an 1 MiB
alignment. To be compatible with older kernels we still load
the ramdisk to 8 MiB, if the kernel is smaller than 8 MiB.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/arch/s390/kexec-image.c |   10 +++++++---
 kexec/arch/s390/kexec-s390.h  |    3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -101,16 +101,20 @@ image_s390_load(int argc, char **argv, c
 	/* We do want to change the kernel image */
 	krnl_buffer = (void *) kernel_buf + IMAGE_READ_OFFSET;
 
-	/* Load ramdisk if present */
+	/*
+	 * Load ramdisk if present: If image is larger than RAMDISK_ORIGIN_ADDR,
+	 * we load the ramdisk directly behind the image with 1 MiB alignment.
+	 */
 	if (ramdisk) {
 		rd_buffer = slurp_file(ramdisk, &ramdisk_len);
 		if (rd_buffer == NULL) {
 			fprintf(stderr, "Could not read ramdisk.\n");
 			return -1;
 		}
-		ramdisk_origin = RAMDISK_ORIGIN_ADDR;
+		ramdisk_origin = MAX(RAMDISK_ORIGIN_ADDR, kernel_size);
+		ramdisk_origin = ALIGN_UP(ramdisk_origin, 0x100000);
 		add_segment_check(info, rd_buffer, ramdisk_len,
-				  RAMDISK_ORIGIN_ADDR, ramdisk_len);
+				  ramdisk_origin, ramdisk_len);
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -21,6 +21,9 @@
 #define COMMAND_LINESIZE      896
 #define MAX_MEMORY_RANGES     64
 
+#define ALIGN_UP(addr, size) (((addr) + ((size)-1)) & (~((size)-1)))
+#define MAX(x, y) ((x) > (y) ? (x) : (y))
+
 extern int image_s390_load(int, char **, const char *, off_t, struct kexec_info *);
 extern int image_s390_probe(const char *, off_t);
 extern void image_s390_usage(void);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
