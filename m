Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rn1QV-0002g3-N3
 for kexec@lists.infradead.org; Tue, 17 Jan 2012 05:17:47 +0000
Date: Tue, 17 Jan 2012 13:40:04 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Auto-detect the correct
 MAX_PHYSMEM_BITSusedin vmcore being analyzed.
Message-Id: <20120117134004.25264f9f.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111221214809tachibana@mail.jp.nec.com>
References: <4EF1B019.3030201@linux.vnet.ibm.com>
 <20111221214809tachibana@mail.jp.nec.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: tachibana@mxm.nes.nec.co.jp, holzheu@linux.vnet.ibm.com, kexec@lists.infradead.org, ananth@in.ibm.com, BUENDGEN@de.ibm.com

Hi Mahesh,

On Wed, 21 Dec 2011 21:48:09 +0900
tachibana@mxm.nes.nec.co.jp wrote:

> Hi Mahesh,
> 
> On 2011/12/21 15:38:25 +0530, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > On 12/21/2011 11:41 AM, tachibana@mxm.nes.nec.co.jp wrote:
> > > Hi Mahesh,
> > > 
> > > Thank you for the patch.
> > > I will review it.
> > > However I have never dumped 1 terabyte or more data using makedumpfile.
> > > Has anyone ever dumped it successfully?
> > > 
> > 
> > I have seen makedumpfile successfully compressing vmcore generated on
> > system with 1TB memory.
> 
> Thank you for your information.

I will merge your patch with renaming macros as:

  _MAX_PHYSMEM_BITS_OLD  ->  _MAX_PHYSMEM_BITS_ORIG 
  _MAX_PHYSMEM_BITS_NEW	 ->  _MAX_PHYSMEM_BITS_3_3

So, attached patch queued for makedumpfile-1.4.2.

Thanks
Atsushi Kumagai


From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

So far s390x kernel was using 42 bits for MAX_PHYSMEM_BITS that use to
support maximum of 4TB of memory. In order to support bigger systems,
the newer s390x kernel will now use 46 bits for MAX_PHYSMEM_BITS to support
maximum of 64TB of memory.

This patch auto-detects the correct value to use for MAX_PHYSMEM_BITS by
examining the mem_section array size from the vmcore being analyzed.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Rename _MAX_PHYSMEM_BITS_OLD to _MAX_PHYSMEM_BITS_ORIG
and _MAX_PHYSMEM_BITS_NEW to _MAX_PHYSMEM_BITS_3_3.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 arch/s390x.c   |   27 ++++++++++++++++++++++++++-
 makedumpfile.h |    3 ++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index 9237eaa..02b9e63 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -60,6 +60,28 @@
 #define pte_offset(x)		(pte_index(x) * sizeof(unsigned long))
 
 int
+set_s390x_max_physmem_bits(void)
+{
+	long array_len = ARRAY_LENGTH(mem_section);
+	/*
+	 * The older s390x kernels uses _MAX_PHYSMEM_BITS as 42 and the
+	 * newer kernels uses 46 bits.
+	 */
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_3;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	return FALSE;
+}
+
+int
 get_machdep_info_s390x(void)
 {
 	unsigned long vmalloc_start;
@@ -70,7 +92,10 @@ get_machdep_info_s390x(void)
 		flag_ignore_r_char = 1;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+	if (!set_s390x_max_physmem_bits()) {
+		ERRMSG("Can't detect max_physmem_bits.\n");
+		return FALSE;
+	}
 	info->page_offset = __PAGE_OFFSET;
 
 	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 4b4a58b..ebb8929 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -535,7 +535,8 @@ do { \
 #define KERNELBASE		(0)
 #define KVBASE			KERNELBASE
 #define _SECTION_SIZE_BITS	(28)
-#define _MAX_PHYSMEM_BITS	(42)
+#define _MAX_PHYSMEM_BITS_ORIG          (42)
+#define _MAX_PHYSMEM_BITS_3_3           (46)
 
 /* Bits in the segment/region table address-space-control-element */
 #define _ASCE_TYPE_MASK		0x0c
-- 
1.6.5.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
