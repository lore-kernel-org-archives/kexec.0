Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail51.messagelabs.com ([216.82.241.99])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QEmvg-0003y5-M7
	for kexec@lists.infradead.org; Tue, 26 Apr 2011 18:24:09 +0000
Subject: kexec-tools support for add_efi_memmap
From: Ben Romer <benjamin.romer@unisys.com>
Date: Tue, 26 Apr 2011 14:24:50 -0400
Message-ID: <1303842290.20829.57.camel@ustr-romerbm>
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
To: horms@verge.net.au, kexec@lists.infradead.org

Hi Simon! 

I'm working on supporting linux on a Unisys virtualization platform
called s-Par, and I've put together a patch for kexec-tools that I'd
like to submit. s-Par is an EFI-based virtualization system that splits
up a machine in a way similar to the way Xen does, using a hypervisor,
and we have a virtual EFI environment that runs for each guest
partition. This is a "pure" EFI environment, so it doesn't have a
fully-defined e820 table. To boot linux on our platform, we have to use
the "add_efi_memmap" parameter to fill out the kernel's memory map with
the additional entries from EFI.

This causes problems when we try to kexec, because the kexec loader is
using the /sys/firmware information which is incomplete. It ends up
causing the kernel and initrd to overlap in memory, which of course
doesn't work. 

I found some discussion of a similar problem on the LKML - a patch from
Mike Travis, specifically, in a thread called "[Patch 1/1] x86 efi:
insert add_efi_memmap entries into both e820 maps" from May 12, 2010 -
the end of which said that the loader needed work rather than the kernel
being modified. 

The patch below checks for the add_efi_memmap option in the kernel
command line, and switches to using /proc/iomem instead of /sys/memmap
when the option is found. I think this might fix the general case and I
know it will allow linux to successfully kexec on our platform.

Would you mind taking a look and letting me know what you think? Thanks
in advance. :) If this looks okay to you I'll type up and send a formal
patch email. Sometimes our email system eats patches so if this doesn't
come through cleanly I'll try again with a different account.

-- Ben

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
