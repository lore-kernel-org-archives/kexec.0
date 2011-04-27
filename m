Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail29.messagelabs.com ([216.82.249.147])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QF4Gq-0003Jp-HY
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 12:55:15 +0000
Subject: [PATCH 2.0.2] use /proc/iomem for map with "add_efi_memmap" kernel
	option
From: Ben Romer <benjamin.romer@unisys.com>
Date: Wed, 27 Apr 2011 08:56:09 -0400
Message-ID: <1303908969.20180.8.camel@ustr-romerbm>
MIME-Version: 1.0
Reply-To: benjamin.romer@unisys.com
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
To: kexec <kexec@lists.infradead.org>
Cc: horms <horms@verge.net.au>

This patch changes the behavior of the kexec loader when the
"add_efi_memmap" option is present on the currently running kernel's
command line, to read the kernel memory map from /proc/iomem instead
of /sys/firmware/memmap. 

On EFI systems, sometimes the e820 table is missing or incomplete.
Systems like these use the "add_efi_memmap" option to add EFI's memory
table entries to the kernel's memory table to build a complete picture
of the system's memory; however, using the option does not add these
entries to the table used to populate /sys/firmware/memmap, which is
meant to be a pristine original copy. 

The kexec loader uses the pristine memory map by default, which causes
problems when the loader doesn't have a complete picture of the system
and incorrectly loads the kernel or ramdisk in places that aren't
actually usable. This change makes the kexec loader check the running
kernel's command line for the "add_efi_memmap" option and if it finds
it, will use the modified map instead of the original map.

signed-off-by: Benjamin Romer <benjamin.romer@unisys.com>
---

diff --git a/kexec/arch/i386/kexec-x86-common.c
b/kexec/arch/i386/kexec-x86-common.c
index ba54973..474e680 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -202,6 +202,28 @@ again:
 }
 
 /**
+ * Detect the add_efi_memmap kernel parameter.
+ *
+ * On some EFI-based systems, the e820 map is empty, or does not
contain a
+ * complete memory map. The add_efi_memmap parameter adds these entries
to
+ * the kernel's memory map, but does not add them under sysfs, which
causes
+ * kexec to fail in a way similar to how it does not work on Xen.
+ *
+ * @return 1 if parameter is present, 0 if not or if an error occurs.
+ */
+int efi_map_added( void ) {
+	char buf[512], *res;
+	FILE *fp = fopen( "/proc/cmdline", "r" );
+	if( fp ) {
+		res = fgets( buf, 512, fp );
+		fclose( fp );
+		return strstr( buf, "add_efi_memmap" ) != NULL;
+	} else {
+		return 0;
+	}
+}
+
+/**
  * Return a sorted list of memory ranges.
  *
  * If we have the /sys/firmware/memmap interface, then use that. If
not,
@@ -227,7 +249,7 @@ int get_memory_ranges(struct memory_range **range,
int *ranges,
 	 * even if we have /sys/firmware/memmap. Without that, /proc/vmcore
 	 * is empty in the kdump kernel.
 	 */
-	if (!xen_present() && have_sys_firmware_memmap()) {
+	if (!efi_map_added() && !xen_present() && have_sys_firmware_memmap())
{
 		ret = get_memory_ranges_sysfs(range, ranges);
 		if (!ret)
 			ret = fixup_memory_ranges_sysfs(range, ranges);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
