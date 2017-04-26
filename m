Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3BFl-0001WI-0E
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 00:56:22 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] memmap: Parse "Reserved" together with "reserved"
Date: Tue, 25 Apr 2017 17:55:26 -0700
Message-Id: <20170426005526.27313-1-yinghai@kernel.org>
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
To: Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

For x86 with recent kernel after
 commit 640e1b38b0 ("x86/boot/e820: Basic cleanup of e820.c")
change "reserved" to "Reserved" in /sys firmware memmap and /proc/iomem.

So here, we add handling for that too.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 kexec/arch/i386/crashdump-x86.c |    2 ++
 kexec/arch/ia64/kexec-ia64.c    |    2 ++
 kexec/arch/mips/kexec-mips.c    |    2 ++
 kexec/firmware_memmap.c         |    2 ++
 4 files changed, 8 insertions(+)

Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -323,6 +323,8 @@ static int get_crash_memory_ranges(struc
 			type = RANGE_PMEM;
 		} else if(memcmp(str,"reserved\n",9) == 0 ) {
 			type = RANGE_RESERVED;
+		} else if(memcmp(str,"Reserved\n",9) == 0 ) {
+			type = RANGE_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c
@@ -117,6 +117,8 @@ int get_memory_ranges(struct memory_rang
 		}
 		else if (memcmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
+		else if (memcmp(str, "Reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
 		}
 		else if (memcmp(str, "Crash kernel\n", 13) == 0) {
 			/* Redefine the memory region boundaries if kernel
Index: kexec-tools/kexec/arch/mips/kexec-mips.c
===================================================================
--- kexec-tools.orig/kexec/arch/mips/kexec-mips.c
+++ kexec-tools/kexec/arch/mips/kexec-mips.c
@@ -57,6 +57,8 @@ int get_memory_ranges(struct memory_rang
 			type = RANGE_RAM;
 		} else if (memcmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
+		} else if (memcmp(str, "Reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
 		} else {
 			continue;
 		}
Index: kexec-tools/kexec/firmware_memmap.c
===================================================================
--- kexec-tools.orig/kexec/firmware_memmap.c
+++ kexec-tools/kexec/firmware_memmap.c
@@ -164,6 +164,8 @@ static int parse_memmap_entry(const char
 		range->type = RANGE_RESERVED;
 	else if (strcmp(type, "reserved") == 0)
 		range->type = RANGE_RESERVED;
+	else if (strcmp(type, "Reserved") == 0)
+		range->type = RANGE_RESERVED;
 	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
 		range->type = RANGE_ACPI_NVS;
 	else if (strcmp(type, "Uncached RAM") == 0)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
