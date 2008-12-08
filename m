Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L9iTA-0005Lq-QJ
	for kexec@lists.infradead.org; Mon, 08 Dec 2008 15:56:26 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id mB8FuFXM018138
	for <kexec@lists.infradead.org>; Mon, 8 Dec 2008 21:26:15 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB8FtKC91941600
	for <kexec@lists.infradead.org>; Mon, 8 Dec 2008 21:25:20 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id mB8FuFZF024807
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 02:56:15 +1100
From: Chandru <chandru@in.ibm.com>
Subject: Re: kdump: quad core Opteron
Date: Mon, 8 Dec 2008 21:26:16 +0530
References: <48EB5B68.8010401@in.ibm.com> <20081007132401.GA4007@redhat.com>
	<1223395191.2215.179.camel@amd.troyhebe>
In-Reply-To: <1223395191.2215.179.camel@amd.troyhebe>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200812082126.16680.chandru@in.ibm.com>
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
To: kexec@lists.infradead.org, bob.montgomery@hp.com
Cc: Vivek Goyal <vgoyal@redhat.com>

On Tuesday 07 October 2008 21:29:51 Bob Montgomery wrote:
> On Tue, 2008-10-07 at 13:24 +0000, Vivek Goyal wrote:
> > On Tue, Oct 07, 2008 at 06:21:52PM +0530, Chandru wrote:
> > > kdump on a quad core Opteron blade machine doesn't give a complete
> > > vmcore on the system.   All works well until we attempt to copy
> > > /proc/vmcore to some target place ( disk , n/w ). The system
> > > immediately resets without any OS messages after having copied few mb's
> > > of vmcore file.  Problem also occurs with 2.6.27-rc8 and latest
> > > kexec-tools.  If we pass 'mem=4G' as boot parameter to the first
> > > kernel, then kdump succeeds in copying a readable vmcore to /var/crash.
> >
> > Hi Chandru,
> >
> > How much memory this system has got. Can you also paste the output of
> > /proc/iomem of first kernel.
> >
> > Does this system has GART? So looks like we are accessing some memory
> > area which platform does not like. (We saw issues with GART in the past.)
> >
> > Can you also provide /proc/vmcore ELF header (readelf output), in both
> > the cases (mem=4G and without that).
> >
> > You can try putting some printk in /proc/vmcore code and see which
> > physical memory area you are accessing when system goes bust. If in all
> > the failure cases it is same physical memory area, then we can try to
> > find what's so special about it.
>
> Or you can assume this is pretty much exactly the problem I ran into in
> August.  I've attached the patch that I'm using with our 2.6.18 kernel
> to disable CPU-side access by the GART, which prevents the problem on
> our Family 10H systems.  You'll need to fix the directory name for
> kernels newer than the arch/x86_64 merge.
>
> Now that someone else has seen the problem, if this fixes it, I'll
> submit the patch upstream.
>
> Here's the README for the patch:
>
> This patch changes the initialization of the GART (in
> pci-gart.c:init_k8_gatt) to set the DisGartCpu bit in the GART Aperture
> Control Register.  Setting the bit Disables requests from the CPUs from
> accessing the GART.  In other words, CPU memory accesses within the
> range of addresses in the aperture will not cause the GART to perform an
> address translation.  The aperture area was already being unmapped at
> the kernel level with clear_kernel_mapping() to prevent accesses from
> the CPU, but that kernel level unmapping is not in effect in the kexec'd
> kdump kernel.  By disabling the CPU-side accesses within the GART, which
> does persist through the kexec of the kdump kernel, the kdump kernel is
> prevented from interacting with the GART during accesses to the dump
> memory areas which include the address range of the GART aperture.
> Although the patch can be applied to the kdump kernel, it is not
> exercised there because the kdump kernel doesn't attempt to initialize
> the GART.
>
> Bob Montgomery
> working at HP

Hi Bob, 

This problem was recently reported on a LS42 blade and the patch given by you 
also resolved the issue here too.  However I made couple of changes to 
kexec-tools to ignore GART memory region and not have elf headers created to 
it.  This patch also seemed to work on a LS21.

Thanks,
Chandru

Signed-off-by: Chandru S <chandru@in.ibm.com>
---

--- kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c.orig	2008-12-08 
01:50:41.000000000 -0600
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2008-12-08 
03:02:45.000000000 -0600
@@ -47,7 +47,7 @@ static struct crash_elf_info elf_info =
 };
 
 /* Forward Declaration. */
-static int exclude_crash_reserve_region(int *nr_ranges);
+static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
 
 #define KERN_VADDR_ALIGN	0x100000	/* 1MB */
 
@@ -164,10 +164,11 @@ static struct memory_range crash_reserve
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 	const char *iomem= proc_iomem();
-	int memory_ranges = 0;
+	int memory_ranges = 0, gart = 0;
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long long start, end;
+	uint64_t gart_start = 0, gart_end = 0;
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
@@ -219,6 +220,10 @@ static int get_crash_memory_ranges(struc
 			type = RANGE_ACPI;
 		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
 			type = RANGE_ACPI_NVS;
+		} else if (memcmp(str, "GART\n", 5) == 0) {
+			gart_start = start;
+			gart_end = end;
+			gart = 1;
 		} else {
 			continue;
 		}
@@ -233,8 +238,14 @@ static int get_crash_memory_ranges(struc
 		memory_ranges++;
 	}
 	fclose(fp);
-	if (exclude_crash_reserve_region(&memory_ranges) < 0)
+	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
+				crash_reserved_mem.end) < 0)
 		return -1;
+	if (gart) {
+		/* exclude GART region if the system has one */
+		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
+			return -1;
+	}
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 #ifdef DEBUG
@@ -252,32 +263,27 @@ static int get_crash_memory_ranges(struc
 /* Removes crash reserve region from list of memory chunks for whom elf 
program
  * headers have to be created. Assuming crash reserve region to be a single
  * continuous area fully contained inside one of the memory chunks */
-static int exclude_crash_reserve_region(int *nr_ranges)
+static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 {
 	int i, j, tidx = -1;
-	unsigned long long cstart, cend;
 	struct memory_range temp_region;
 
-	/* Crash reserved region. */
-	cstart = crash_reserved_mem.start;
-	cend = crash_reserved_mem.end;
-
 	for (i = 0; i < (*nr_ranges); i++) {
 		unsigned long long mstart, mend;
 		mstart = crash_memory_range[i].start;
 		mend = crash_memory_range[i].end;
-		if (cstart < mend && cend > mstart) {
-			if (cstart != mstart && cend != mend) {
+		if (start < mend && end > mstart) {
+			if (start != mstart && end != mend) {
 				/* Split memory region */
-				crash_memory_range[i].end = cstart - 1;
-				temp_region.start = cend + 1;
+				crash_memory_range[i].end = start - 1;
+				temp_region.start = end + 1;
 				temp_region.end = mend;
 				temp_region.type = RANGE_RAM;
 				tidx = i+1;
-			} else if (cstart != mstart)
-				crash_memory_range[i].end = cstart - 1;
+			} else if (start != mstart)
+				crash_memory_range[i].end = start - 1;
 			else
-				crash_memory_range[i].start = cend + 1;
+				crash_memory_range[i].start = end + 1;
 		}
 	}
 	/* Insert split memory region, if any. */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
