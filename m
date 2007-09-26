Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IaRNX-0001Oz-4q
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 03:32:20 -0400
Subject: crash by normal: crashdump without reserving memory during system boot
From: "Huang, Ying" <ying.huang@intel.com>
Date: Wed, 26 Sep 2007 15:34:10 +0800
Message-Id: <1190792050.21818.284.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Hi,

I have a proposal to do crashdump without reserving memory during system
boot. The method is as follow:

1. Do not reserve memory during system boot, that is
crashkernel=<XX>@<YY> is not used in kernel command line.

2. A new kexec flag named KEXEC_CRASH_BY_NORMAL is defined for
sys_kexec_load system call. When this flag is specified, the
sys_kexec_load works as normal kexec (not crash kexec), except the
destination image is kexec_crash_image instead of kexec_image.

3. In kexec-tools (/sbin/kexec), --mem-min=<addr1> and --mem-max=<addr2>
is used to specify the memory area used by crashdump kernel. That is,
the image, elf core header, available memory of crashdump kernel is
within <addr1> ~ <addr2>.

4. In kexec-tools, in addition to kernel image, elf core header, etc are
loaded, the available memory of crashdump kernel is loaded too. For
example, the segments for sys_kexec_load for crashdump kernel can be:

--mem-min=0x100000
--mem-max=0xffffff

No.	buf		bufsz		mem		memsz
0	NULL		0		0x1000		0x9e000
1	0x881fe88	0x289b		0x100000	0x3000
2	NULL		0		0x103000	0xfd000
3	0xb7bfa808	0xb7c00		0x200000	0xb8000
4	NULL		0		0x2b8000	0xd39000
5	0x8818d38	0x7120		0xff1000	0x9000
6	NULL		0		0xffa000	0x1000
7	0x8818268	0x400		0xffb000	0x4000
8	NULL		0		0xfff000	0x1000

5. In relocate_kernel of Linux kernel, instead of copy the source page
to destination page, the contents of source page and the destination
page are swapped. (The destination page -> source page map is in
kexec_crash_image->head) The memory area used by crashdump kernel is
backupped to source page.


In original crashdump implementation, the crashdump kernel run in
reserved memory area. The reserved memory pages are reserved memory
pages in primary (original) kernel.

In this proposed implementation, the crashdump kernel run in specified
memory area, the contents of destination memory area is backupped before
crashdump kernel running. The backup pages are allocated memory pages in
primary (original) kernel.


The pros and cons of proposed implementation:

Pros:
- The memory used by crashdump kernel need not to be reserved during
boot time.
- The memory used by crashdump kernel can be specified during
sys_kexec_load
- The memory used by crashdump kernel can be freed after unloading.

Cons:
- The memory used by crashdump kernel can be the DMA destination, their
contents may be ruined by devices during the boot of crashdump kernel.
(Is it possible to turn off DMA for some memory area other than
reserving it?)


In fact, almost all mechanism for this proposal has been implemented by
my previous patch: "kexec jump" in "kexec based hibernation".


Any comment is welcome.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
