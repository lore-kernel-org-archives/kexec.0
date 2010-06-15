Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OOc7H-0001TY-5C
	for kexec@lists.infradead.org; Tue, 15 Jun 2010 19:48:12 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay2.corp.sgi.com (Postfix) with ESMTP id 4F49830407B
	for <kexec@lists.infradead.org>; Tue, 15 Jun 2010 12:48:10 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id 38D917001ADC
	for <kexec@lists.infradead.org>; Tue, 15 Jun 2010 14:48:10 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OOc8T-0005Va-Fb
	for kexec@lists.infradead.org; Tue, 15 Jun 2010 14:49:25 -0500
Subject: [PATCH] makedumpfile: output files filling ramdisk
Message-Id: <E1OOc8T-0005Va-Fb@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Tue, 15 Jun 2010 14:49:25 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


makedumpfile's path FILENAME_BITMAP "/tmp/..." causes it to try to write
bitmap files to the ramdisk.  These can be very large if the machine has
lots of memory, and so writing the file can fail.

makedumpfile is exec'd by kdumptool. And kdumptool should chroot to
its --root directory.  But if the intent is to avoid this problem it
doesn't seem to work.  That may be the proper fix, rather than the below.

A TMPDIR environment variable is set in the script
/lib/mkinitrd/scripts/boot-kdump.sh. So this patch assumes that
the FILENAME_BITMAP path should be based at TMPDIR.

Also below, LATEST_VERSION is updated to KERNEL_VERSION(2, 6, 32), as this
seems to work on 2.6.32 and prevents a makedumpfile grumbling.

Diffed against makedumpfile-1.3.5

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   13 ++++++++++---
 makedumpfile.h |    4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

Index: makedumpfile-1.3.5/makedumpfile.c
===================================================================
--- makedumpfile-1.3.5.orig/makedumpfile.c
+++ makedumpfile-1.3.5/makedumpfile.c
@@ -933,14 +933,21 @@ int
 open_dump_bitmap(void)
 {
 	int i, fd;
+	char *tmpname;
 
-	if ((info->name_bitmap
-	    = (char *)malloc(sizeof(FILENAME_BITMAP))) == NULL) {
+	tmpname = getenv("TMPDIR");
+	if (!tmpname)
+		tmpname = "/tmp";
+
+	if ((info->name_bitmap = (char *)malloc(sizeof(FILENAME_BITMAP) +
+						strlen(tmpname) + 1)) == NULL) {
 		ERRMSG("Can't allocate memory for the filename. %s\n",
 		    strerror(errno));
 		return FALSE;
 	}
-	strcpy(info->name_bitmap, FILENAME_BITMAP);
+	strcpy(info->name_bitmap, tmpname);
+	strcat(info->name_bitmap, "/");
+	strcat(info->name_bitmap, FILENAME_BITMAP);
 	if ((fd = mkstemp(info->name_bitmap)) < 0) {
 		ERRMSG("Can't open the bitmap file(%s). %s\n",
 		    info->name_bitmap, strerror(errno));
Index: makedumpfile-1.3.5/makedumpfile.h
===================================================================
--- makedumpfile-1.3.5.orig/makedumpfile.h
+++ makedumpfile-1.3.5/makedumpfile.h
@@ -230,7 +230,7 @@ do { \
 #define BUFSIZE_FGETS		(1500)
 #define BUFSIZE_BITMAP		(4096)
 #define PFN_BUFBITMAP		(BITPERBYTE*BUFSIZE_BITMAP)
-#define FILENAME_BITMAP		"/tmp/kdump_bitmapXXXXXX"
+#define FILENAME_BITMAP		"kdump_bitmapXXXXXX"
 #define FILENAME_STDOUT		"STDOUT"
 
 /*
@@ -449,7 +449,7 @@ do { \
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION		KERNEL_VERSION(2, 6, 31)/* linux-2.6.31 */
+#define LATEST_VERSION		KERNEL_VERSION(2, 6, 32)/* linux-2.6.32 */
 
 /*
  * vmcoreinfo in /proc/vmcore

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
