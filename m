Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFzoV-0002WH-3m
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 23:08:07 +0000
Subject: AMD Family 10H machine check on vmcore read
From: Bob Montgomery <bob.montgomery@hp.com>
Date: Mon, 07 Jul 2008 17:08:06 -0600
Message-Id: <1215472086.3361.297.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

We maintain a 2.6.18 derived kernel.  
When testing kdump on a new AMD Family 10h (16) processor, once in the
kdump kernel, a read from either /proc/vmcore or /dev/oldmem that
corresponds to the area of memory identified in the original (crashing)
kernel by these boot messages:

Mapping aperture over 65536 KB of RAM @ 1c000000
...
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 1c000000 size 65536 KB
PCI-DMA: using GART IOMMU.

causes a machine check.

On a Family 15 AMD64 processor running this kernel and kdump kernel, I
can read the areas identified as being in the aperture from the kdump
kernel and get values, but on the new processor, reads from the kdump
kernel that are within that address range result in the machine check:

HARDWARE ERROR
CPU 0: Machine Check Exception:                4 Bank 4: be0000010005001b
TSC 141bd974323de ADDR 1c000000 MISC e00c0ffe01000000

While up on the original kernel, attempts to read those locations
from /dev/mem result in EFAULTs on both the old and new processors.
It's just the reads from the kdump kernel's /proc/vmcore or /dev/oldmem
that work ok on the old processor and machine check on the new one.

The output of /proc/iomem does not specifically identify the area.  It's
just within the range of: 

00100000-cfe4ffff : System RAM

I found code in arch/x86_64/kernel/mce.c:mce_cpu_quirks() that disables
GART TBL walk errors to prevent machine checks.  The code checked for
family 15 and so I added family 16 as well.  Here is a patch that fixes
my version of the kernel:

--- linux-source-2.6.18-kdump/arch/x86_64/kernel/mce.c.orig	2008-07-02 09:27:39.000000000 -0600
+++ linux-source-2.6.18-kdump/arch/x86_64/kernel/mce.c	2008-07-02 09:28:45.000000000 -0600
@@ -354,7 +354,8 @@ static void mce_init(void *dummy)
 static void __cpuinit mce_cpu_quirks(struct cpuinfo_x86 *c)
 { 
 	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 15) {
+	if (c->x86_vendor == X86_VENDOR_AMD && 
+			((c->x86 == 15) || (c->x86 == 16))) {
 		/* disable GART TBL walk error reporting, which trips off 
 		   incorrectly with the IOMMU & 3ware & Cerberus. */
 		clear_bit(10, &bank[4]);


But I don't see this fix upstream in the kernel.  So I'm wondering if
some other patch protects other kdump kernels from this problem.  In
particular, a recent patch that informed the e820 map about the gart
aperture to prevent a normal kernel and a kexec kernel from putting it
at different addresses.  It didn't mention machine checks from kdump
kernels, but I wonder if it would have prevented access to that memory
area by having it be excluded from the /proc/vmcore list of areas??

Thanks for any insights,
Bob Montgomery




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
