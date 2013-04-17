Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USPWH-0001Dy-2E
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 10:23:18 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 17 Apr 2013 15:48:27 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DCD8A3940059
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 15:52:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3HAMkjS48234592
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 15:52:46 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3HAMpnn032260
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 20:22:51 +1000
Subject: [PATCH] kexec/uImage: probe to identify a corrupted image
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 17 Apr 2013 15:52:44 +0530
Message-ID: <20130417102022.6919.82083.stgit@suzukikp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: msm@freescale.com, bigeasy@linutronix.de, kexec@lists.infradead.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Teach uImage_probe_xxx() to return the information about
a corrupted image. This is required to prevent the loading
of a corrupted ramdisk, where we don't have strict checking
for the other formats, unlike the kernel. So, we should abort
the operation than causing a problem with the new kernel.

Without this patch, a corrupted uImage ramdisk is treated as
a plain ramdisk where there is no format check involved.

# kexec -l uImage --initrd romfs-initrd.corrupt
The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
# echo $?
0
# kexec -e
Starting new kernel
Bye!
Reserving 55MB of memory at 70MB for crashkernel (System RAM: 256MB)
Using Xilinx Virtex440 machine description
Linux version 3.6.0-rc3 (root@suzukikp) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (GCC) ) #66 Tue Apr 16 06:36:56 UTC 2013
Found initrd at 0xcf5f8000:0xcfff8040
...

NET: Registered protocol family 17
RAMDISK: Couldn't find valid RAM disk image starting at 0.
List of all partitions:
No filesystem could mount root, tried:  ext2 cramfs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)


With this patch :

# kexec -l uImage --initrd romfs-initrd.corrupt
uImage: The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
uImage: Corrupted ramdisk file romfs-initrd

With a corrupted kernel image(the behaviour remains the same) :
# kexec -l uImage.corrupt --initrd romfs-initrd
uImage: The data CRC does not match. Computed: 285787b7 expected e37f65ad
Cannot determine the file type of uImage.corrupt

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |    9 +++++++--
 kexec/kexec-uImage.c              |   29 ++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 008463b..83a7a5f 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -56,10 +56,15 @@ char *slurp_ramdisk_ppc(const char *filename, off_t *r_size)
 	struct Image_info img;
 	off_t size;
 	const unsigned char *buf = slurp_file(filename, &size);
+	int rc;
 
 	/* Check if this is a uImage RAMDisk */
-	if (buf &&
-	    uImage_probe_ramdisk(buf, size, IH_ARCH_PPC) == 0) {
+	if (!buf)
+		return buf;
+	rc = uImage_probe_ramdisk(buf, size, IH_ARCH_PPC); 
+	if (rc < 0)
+		die("uImage: Corrupted ramdisk file %s\n", filename);
+	else if (rc == 0) {
 		if (uImage_load(buf, size, &img) != 0)
 			die("uImage: Reading %ld bytes from %s failed\n",
 				size, filename);
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 1ad02f4..00bc064 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -19,6 +19,10 @@
 /*
  * Returns the image type if everything goes well. This would
  * allow the user to decide if the image is of their interest.
+ *
+ * Returns -1 on a corrupted image
+ *
+ * Returns 0 if this is not a uImage
  */
 int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 {
@@ -33,7 +37,7 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 
 	memcpy(&header, buf, sizeof(header));
 	if (be32_to_cpu(header.ih_magic) != IH_MAGIC)
-		return -1;
+		return 0;
 #ifdef HAVE_LIBZ
 	hcrc = be32_to_cpu(header.ih_hcrc);
 	header.ih_hcrc = 0;
@@ -84,7 +88,7 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 #ifdef HAVE_LIBZ
 	crc = crc32(0, (void *)buf + sizeof(header), be32_to_cpu(header.ih_size));
 	if (crc != be32_to_cpu(header.ih_dcrc)) {
-		printf("The data CRC does not match. Computed: %08x "
+		printf("uImage: The data CRC does not match. Computed: %08x "
 				"expected %08x\n", crc,
 				be32_to_cpu(header.ih_dcrc));
 		return -1;
@@ -93,18 +97,33 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 	return (int)header.ih_type;
 }
 
+/* 
+ * To conform to the 'probe' routine in file_type struct,
+ * we return :
+ *  0		- If the image is valid 'type' image.
+ *
+ *  Now, we have to pass on the 'errors' in the image. So,
+ *
+ * -1		- If the image is corrupted.
+ *  1		- If the image is not a uImage.
+ */
+
 int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch)
 {
 	int type = uImage_probe(buf, len, arch);
+	if (type < 0)
+		return -1;
 
-	return (type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD) ? 
-			0 : -1;
+	return !(type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD);
 }
 
 int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch)
 {
 	int type = uImage_probe(buf, len, arch);
-	return (type == IH_TYPE_RAMDISK) ? 0 : -1;
+
+	if (type < 0)
+		return -1;
+	return !(type == IH_TYPE_RAMDISK);
 }
 
 #ifdef HAVE_LIBZ


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
