Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from noname.neutralserver.com ([70.84.186.210])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I6pGS-0005Yy-Kn
	for kexec@lists.infradead.org; Fri, 06 Jul 2007 15:58:36 +0100
Date: Fri, 6 Jul 2007 17:58:04 +0300
From: Dan Aloni <da-x@monatomic.org>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070706145804.GA31409@localdomain>
References: <20070706132814.GA7079@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070706132814.GA7079@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> Hello,
> 
> does anybody know a _reliable_ way to determine the version the kernel
> that produced a vmcore file? This means not scanning for a specific
> string or something like that which can fail on random memory.
> 
> Would it make sense to add a ELF PT_NOTE section in the vmcore?
> 
> Thanks for input!

(I'm sorry if this E-Mail needlessly turned into a long RFC 
but I had to bring this up when I bumped into this question on 
LKML)

Actually, instead of another ELF PT_NOTE section for this 
information and other things, kdump is currently going into 
another direction, described below.

Redhat has a makedumpinfo util which they intend to use as slim
kernel-version-independent utility on kdump rootfs in order to
save /proc/vmcore in a compact manner.

Normally makedumpinfo would require access to the vmlinux file 
that the crashed kernel was originated from. However instead of 
depending on vmlinux, it is possible to generate a small textual
"CONFIGFILE" that looks like this, for example (generated using
makedumpinfo -g):

OSRELEASE=2.6.20.3
PAGESIZE=4096
SYMBOL(mem_map)=ffffffff806cf5d8
SYMBOL(init_uts_ns)=ffffffff805f8be0
SYMBOL(_stext)=ffffffff80200f20
SYMBOL(node_online_map)=ffffffff80651bc0
SYMBOL(contig_page_data)=ffffffff80600e80
SIZE(page)=56
SIZE(pglist_data)=3712
SIZE(zone)=1152
SIZE(free_area)=24
SIZE(list_head)=16
OFFSET(page.flags)=0
OFFSET(page._count)=8
OFFSET(page.mapping)=24
OFFSET(page.lru)=40
OFFSET(pglist_data.node_zones)=0
OFFSET(pglist_data.nr_zones)=3576
OFFSET(pglist_data.node_mem_map)=3584
OFFSET(pglist_data.node_start_pfn)=3600
OFFSET(pglist_data.node_spanned_pages)=3616
OFFSET(zone.free_pages)=0
OFFSET(zone.free_area)=408
OFFSET(zone.vm_stat)=872
OFFSET(zone.spanned_pages)=1064
OFFSET(free_area.free_list)=0
OFFSET(list_head.next)=0
OFFSET(list_head.prev)=8
LENGTH(zone.free_area)=11
SRCFILE(pud_t)=include/asm/page.h

It contains enough information in order to make a compact kernel
dump (makedumpinfo needs to go over the struct page arrays). As
you see, it also contains the kernel version.

However, this file needs to be passed somehow to the rootfs
of the kdump kernel. This poses a chicken-and-egg problem on 
my setup where the initramfs of the first kernel contains 
a staticlu linked version of the kexec executable along with a
kdump kernel to be loaded before mount rootfs and running 
init. 

I used this 'crazy' kernel-packed-within-a-kernel method so 
that I wouldn't need to manage the other kernel file in the
embedded distribution I'm working on. I described this method 
to Neil Horman back in OLS last week.

A patch that I am working on will make it possible to integrate
the output of 'makedumpinfo -g' into vmlinux as the final build
stage of the kernel. This information will be presented itself
as /proc/kcore.info for the first kernel throughout its entire
execution. Then inside initramfs of the first kernel, a small 
util will modify the vmlinux file of the kdump kernel before it
gets loaded so that another special file appearing as 
/proc/vmcore.info under the kdump kernel will present the same
info. 

This way, distributions will not have to manage the packaging
of that extra file, and this is also similar to the way it was 
done with /proc/config.gz.

Originally I thought perhaps makedumpinfo can be hinted in a
way of being able to access the kallsyms info of the _crashed_
kernel and from there be able to access everything else it 
needs in a version-indepedent manner. For example, SIZE(page)
could have been presented as a simple global varible somewhere
inside the kernel:

    unsigned int kdump_size_of_pglist_data = sizeof(struct pglist_data);

If you could access the kallsyms information of the crashed
kernel from within the rootfs of the kdump kernel you can have
easily reached this variable. I think all information from
the CONFIGFILE can be 'exported' in this manner. The major
downside I can think of this approach, although it would
be quite rare - certain memory corruption bugs (especially
where kallsyms data gets squashed) can make it fail. Also,
kallsyms wastes memory on memory-limited embedded setups,
so you might not want to depend on it. Perhaps EXPORT_SYMBOL
can be used instead..

Any comments?

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
