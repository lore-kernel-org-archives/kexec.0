Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WeftD-0002Ta-TL
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 07:22:13 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] kdump: pass e820 reserved region to 2nd kernel via e820 table
 or setup_data
Date: Mon, 28 Apr 2014 15:21:44 +0800
Message-Id: <1398669704-31851-1-git-send-email-chaowang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, cpw@sgi.com

e820 reserved region could be useful in 2nd kernel.

For example, PCI mmconf (extended mode) requires reserved region
otherwise it falls back to legacy mode. The following log is from Cliff
Wickman <cpw@sgi.com>:

 PCI: MMCONFIG for domain 1003 [bus 3f-3f] at [mem 0xff0ff00000-0xff0fffffff] (base 0xff0c000000)
 [Firmware Bug]: PCI: MMCONFIG at [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources
 PCI: not using MMCONFIG

PCI devices on segment 1 (>0) can't fall back to legacy mode, thus
kernel probing fails and device can't be found.

We don't pass reserved region because these regions could be too much
and eat up our very limited kernel command line resource in
memmap=exactmap case.

However now we use e820 map and setup_data to pass memory map to 2nd
kernel and the number of reserved regions should not be a problem any
more.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 4a1491b..321ed3d 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -300,6 +300,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_ACPI;
 		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
 			type = RANGE_ACPI_NVS;
+		} else if(memcmp(str,"reserved\n",9) == 0 ) {
+			type = RANGE_RANGE;
+		} else if (memcmp(str, "GART\n", 5) == 0) {
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
@@ -989,14 +992,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
 		unsigned long start, end, size, type;
 		if ( !( mem_range[i].type == RANGE_ACPI
-			|| mem_range[i].type == RANGE_ACPI_NVS) )
+			|| mem_range[i].type == RANGE_ACPI_NVS
+			|| mem_range[i].type == RANGE_RESERVED))
 			continue;
 		start = mem_range[i].start;
 		end = mem_range[i].end;
 		type = mem_range[i].type;
 		size = end - start + 1;
 		add_memmap(memmap_p, &nr_memmap, start, size, type);
-		if (arch_options.pass_memmap_cmdline)
+		if (arch_options.pass_memmap_cmdline || type != RANGE_RESERVED)
 			cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
