Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U2DIi-0004MF-GV
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 04:05:01 +0000
Subject: [PATCH] kdump: do not drop entire e820 in crash kernel
Message-Id: <E1U2DId-0001E4-Df@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Sun, 03 Feb 2013 22:04:55 -0600
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
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, venkatesh.pallipadi@intel.com, kexec@lists.infradead.org, hpa@zytor.com

From: Cliff Wickman <cpw@sgi.com>

The crash kernel is not able to find its root device if that device is not
on PCI 0.

This is because it is booted with the command line option memmap=exactmap
which currently clears the e820 table.  So ACPI processing does not
find reserved i/o spaces. 

This works for a device on PCI 0 because ACPI falls back to a legacy mode.
But the error message " [Firmware Bug]: PCI: MMCONFIG at
 [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources"
is written to the log even in this functioning case.

It fails for some devices on UV2, and only for UV2, because SGI seems to
be the only manufacturer currently using the extended PCI(>0).

The fix is to not drop the entire e820 table on a memmap=exactmap, but
to preserve all the non-E820_RAM reservations that the BIOS has made.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 arch/x86/kernel/e820.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: linus.current/arch/x86/kernel/e820.c
===================================================================
--- linus.current.orig/arch/x86/kernel/e820.c
+++ linus.current/arch/x86/kernel/e820.c
@@ -839,6 +839,8 @@ static int __init parse_memmap_opt(char
 {
 	char *oldp;
 	u64 start_at, mem_size;
+	int i;
+	struct e820entry *curp, *availp;
 
 	if (!p)
 		return -EINVAL;
@@ -852,7 +854,17 @@ static int __init parse_memmap_opt(char
 		 */
 		saved_max_pfn = e820_end_of_ram_pfn();
 #endif
-		e820.nr_map = 0;
+		/* keep everything that was reserved by the BIOS */
+		for (i = 0, curp = &e820.map[0], availp = &e820.map[0];
+						i < e820.nr_map; i++, curp++) {
+			if (curp->type != E820_RAM) {
+				if (curp != availp) {
+					*availp = *curp;
+					availp++;
+				}
+			}
+		}
+		e820.nr_map = availp - &e820.map[0];
 		userdef = 1;
 		return 0;
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
