Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L4xLz-0006bx-Tw
	for kexec@lists.infradead.org; Tue, 25 Nov 2008 12:49:20 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3BF4341976
	for <kexec@lists.infradead.org>; Tue, 25 Nov 2008 13:49:18 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Don't use /sys/firmware/memmap for Xen
Date: Tue, 25 Nov 2008 13:49:18 +0100
Message-Id: <1227617358-20560-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Bernhard Walle <bwalle@suse.de>

On Xen, we have to use /proc/iomem to retrieve the memory area for the kexec'd
kernel, not /sys/firmware/memmap. Dom0 kernel gets a E820 map that contains
only one region:

    0000000000000000-0000000018e5e000 (System RAM)

Compared to the /proc/iomem:

    00000000-0009cbff : System RAM
    0009cc00-0009ffff : reserved
    000ce000-000d3fff : reserved
    000e0000-000fffff : reserved
    00100000-1fd6ffff : System RAM
      01000000-04ffffff : Crash kernel
      1ec00000-1fbfffff : Hypervisor code and data
        1f0b4680-1f0b4873 : Crash note
        1f0b4900-1f0b4a93 : Crash note
        1f0b4b80-1f0b4d13 : Crash note
        1f0b4e00-1f0b4f93 : Crash note
    ...

Without that patch, /proc/vmcore is empty in the kexec'd kernel and I'm unable
to copy the crashdump.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/kexec-x86-common.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 00c2be3..2112bd5 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -147,7 +147,14 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 {
 	int ret, i;
 
-	if (have_sys_firmware_memmap())
+	/*
+	 * When using Xen, /sys/firmware/memmap (i.e., the E820 map) is
+	 * wrong, it just provides one large memory are and that cannot
+	 * be used for Kdump. Use always the /proc/iomem interface there
+	 * even if we have /sys/firmware/memmap. Without that, /proc/vmcore
+	 * is empty in the kdump kernel.
+	 */
+	if (!xen_present() && have_sys_firmware_memmap())
 		ret = get_memory_ranges_sysfs(range, ranges);
 	else
 		ret = get_memory_ranges_proc_iomem(range, ranges);
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
