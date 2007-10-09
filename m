Return-path: <kexec-bounces@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IfF7G-0000Dm-Qh
	for kexec@lists.infradead.org; Tue, 09 Oct 2007 14:27:24 +0100
Subject: Re: crash by normal: crashdump without reserving memory during
	system boot
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20071001084024.GF4933@in.ibm.com>
References: <1190792050.21818.284.camel@caritas-dev.intel.com>
	<20071001084024.GF4933@in.ibm.com>
Date: Tue, 09 Oct 2007 21:28:18 +0800
Message-Id: <1191936498.9719.91.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Mon, 2007-10-01 at 14:10 +0530, Vivek Goyal wrote:
On Wed, Sep 26, 2007 at 03:34:10PM +0800, Huang, Ying wrote:
> > Hi,
> > 
> > I have a proposal to do crashdump without reserving memory during
system
> > boot. The method is as follow:
> > 
> > 1. Do not reserve memory during system boot, that is
> > crashkernel=<XX>@<YY> is not used in kernel command line.
> > 
> > 2. A new kexec flag named KEXEC_CRASH_BY_NORMAL is defined for
> > sys_kexec_load system call. When this flag is specified, the
> > sys_kexec_load works as normal kexec (not crash kexec), except the
> > destination image is kexec_crash_image instead of kexec_image.
> > 
> > 3. In kexec-tools (/sbin/kexec), --mem-min=<addr1> and
--mem-max=<addr2>
> > is used to specify the memory area used by crashdump kernel. That
is,
> > the image, elf core header, available memory of crashdump kernel is
> > within <addr1> ~ <addr2>.
> > 
> 
> Probably this can be an optional thing. Anyway if destination pages
are
> going to be backed up in source pages, a user does not have to specify
> --mem-min and --mem-max.
> 
The --mem-min and --mem-max is used to specify the destination memory
range. I think they are necessary. One source page corresponds to one
destination page (except some source page allocated at the same position
of corresponding destination page). The --mem-min and --mem-max has
similar function as crashkernel=YM@XM in kernel parameters.
 
> 4. In kexec-tools, in addition to kernel image, elf core header, etc
are
> > loaded, the available memory of crashdump kernel is loaded too. For
> > example, the segments for sys_kexec_load for crashdump kernel can
be:
> > 
> > --mem-min=0x100000
> > --mem-max=0xffffff
> > 
> > No.	buf		bufsz		mem		memsz
> > 0	NULL		0		0x1000		0x9e000
> > 1	0x881fe88	0x289b		0x100000	0x3000
> > 2	NULL		0		0x103000	0xfd000
> > 3	0xb7bfa808	0xb7c00		0x200000	0xb8000
> > 4	NULL		0		0x2b8000	0xd39000
> > 5	0x8818d38	0x7120		0xff1000	0x9000
> > 6	NULL		0		0xffa000	0x1000
> > 7	0x8818268	0x400		0xffb000	0x4000
> > 8	NULL		0		0xfff000	0x1000
> > 
> 
> May be user also need to specify how much memory to allocate for
second
> kernel execution.
> 
The memory for second kernel execution is specified through --mem-min
and --mem-max.

> 5. In relocate_kernel of Linux kernel, instead of copy the source page
> > to destination page, the contents of source page and the destination
> > page are swapped. (The destination page -> source page map is in
> > kexec_crash_image->head) The memory area used by crashdump kernel is
> > backupped to source page.
> > 
> > 
> 
> Interesting. Just that it introduces more code in crash path.
> 
> 

The source/destination page swap code is very simple and executed after
turning off paging. So I think the added code has no big problem.

> In original crashdump implementation, the crashdump kernel run in
> > reserved memory area. The reserved memory pages are reserved memory
> > pages in primary (original) kernel.
> > 
> > In this proposed implementation, the crashdump kernel run in
specified
> > memory area, the contents of destination memory area is backupped
before
> > crashdump kernel running. The backup pages are allocated memory
pages in
> > primary (original) kernel.
> > 
> 
> How would you prepare ELF headers for backed up memory. ELF headers
are
> created in user space and before sys_kexec_load is executed,
kexec-tools
> need to know the address of physical memory where the actual data is.
But
> in this scheme, source pages will be allocated only after
sys_kexec_load
> has been called.
> 
> These source page addresses will have to be exported to user space so
> that kexec tools can fill up ELF headers accordingly.
> 

Now, the memory region used by the second kernel is excluded from the
ELF headers. The map of destination page -> source page can be passed to
the second kernel. So the contents of destination page can be restored
from source page in a user space tool (such as a modified version of
makedumpfile). It is much harder to embed the map of destination page ->
source into ELF headers.

> 
> > The pros and cons of proposed implementation:
> > 
> > Pros:
> > - The memory used by crashdump kernel need not to be reserved during
> > boot time.
> > - The memory used by crashdump kernel can be specified during
> > sys_kexec_load
> > - The memory used by crashdump kernel can be freed after unloading.
> > 
> > Cons:
> > - The memory used by crashdump kernel can be the DMA destination,
their
> > contents may be ruined by devices during the boot of crashdump
kernel.
> > (Is it possible to turn off DMA for some memory area other than
> > reserving it?)
> 
> Potential corruption because of DMA was a big issue and that's why the
> exclusive reserved area and relocatable kernel came into the picture.
> 
> Eric in the past had tried disabling DMA at PCI level, but I think it
> did not work for him.
> 
> - There is no gurantee that one will get sufficient memory allocated
>   when needed. so loading kdump kernel might fail.
> 
> - More code in crash path and potentially reduces the relibaility of
>   the mechanism.

A possible solution for DMA issue is as follow:

- Specify the memory region used by the second kernel in kernel boot
command line.
- Create a zone for this memory region. This zone can not be used for
DMA.
- Use this memory region for the second kernel.
 
> > 
> > 
> > In fact, almost all mechanism for this proposal has been implemented
by
> > my previous patch: "kexec jump" in "kexec based hibernation".
> > 
> > 
> > Any comment is welcome.
> > 
> 
> Idea is interesting. But at the same time it reduces the reliability
of
> kdump. I am especially concerned about DMA issue more code in crash
path.

It is less reliable than the original method. But I think if the DMA
issue can be solved, it may be acceptable.

> I will rather try to find out if I can create some mechanisms to do
large
> contiguous memory area allocation from user space at run time instead
of
> doing it at boot time.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
