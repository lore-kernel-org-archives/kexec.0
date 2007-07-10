Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I8EWr-0000UM-Kk
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 08:09:19 -0400
Date: Tue, 10 Jul 2007 08:09:04 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710120904.GB10121@hmsendeavour.rdu.redhat.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070710064817.GC5471@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710064817.GC5471@in.ibm.com>
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
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Dan Aloni <da-x@monatomic.org>, linux-kernel@vger.kernel.org

On Tue, Jul 10, 2007 at 12:18:17PM +0530, Vivek Goyal wrote:
> On Fri, Jul 06, 2007 at 05:58:04PM +0300, Dan Aloni wrote:
> > On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> > > Hello,
> > > 
> > > does anybody know a _reliable_ way to determine the version the kernel
> > > that produced a vmcore file? This means not scanning for a specific
> > > string or something like that which can fail on random memory.
> > > 
> > > Would it make sense to add a ELF PT_NOTE section in the vmcore?
> > > 
> > > Thanks for input!
> > 
> > (I'm sorry if this E-Mail needlessly turned into a long RFC 
> > but I had to bring this up when I bumped into this question on 
> > LKML)
> > 
> > Actually, instead of another ELF PT_NOTE section for this 
> > information and other things, kdump is currently going into 
> > another direction, described below.
> > 
> > Redhat has a makedumpinfo util which they intend to use as slim
> > kernel-version-independent utility on kdump rootfs in order to
> > save /proc/vmcore in a compact manner.
> > 
> > Normally makedumpinfo would require access to the vmlinux file 
> > that the crashed kernel was originated from. However instead of 
> > depending on vmlinux, it is possible to generate a small textual
> > "CONFIGFILE" that looks like this, for example (generated using
> > makedumpinfo -g):
> > 
> > OSRELEASE=2.6.20.3
> > PAGESIZE=4096
> > SYMBOL(mem_map)=ffffffff806cf5d8
> > SYMBOL(init_uts_ns)=ffffffff805f8be0
> > SYMBOL(_stext)=ffffffff80200f20
> > SYMBOL(node_online_map)=ffffffff80651bc0
> > SYMBOL(contig_page_data)=ffffffff80600e80
> > SIZE(page)=56
> > SIZE(pglist_data)=3712
> > SIZE(zone)=1152
> > SIZE(free_area)=24
> > SIZE(list_head)=16
> > OFFSET(page.flags)=0
> > OFFSET(page._count)=8
> > OFFSET(page.mapping)=24
> > OFFSET(page.lru)=40
> > OFFSET(pglist_data.node_zones)=0
> > OFFSET(pglist_data.nr_zones)=3576
> > OFFSET(pglist_data.node_mem_map)=3584
> > OFFSET(pglist_data.node_start_pfn)=3600
> > OFFSET(pglist_data.node_spanned_pages)=3616
> > OFFSET(zone.free_pages)=0
> > OFFSET(zone.free_area)=408
> > OFFSET(zone.vm_stat)=872
> > OFFSET(zone.spanned_pages)=1064
> > OFFSET(free_area.free_list)=0
> > OFFSET(list_head.next)=0
> > OFFSET(list_head.prev)=8
> > LENGTH(zone.free_area)=11
> > SRCFILE(pud_t)=include/asm/page.h
> > 
> > It contains enough information in order to make a compact kernel
> > dump (makedumpinfo needs to go over the struct page arrays). As
> > you see, it also contains the kernel version.
> > 
> 
> But this will not solve Bernhard's problem where looking at a vmcore
> he wants to know which vmlinux (kernel version with time stamp) has
> generated this vmcore. So adding a ELF NOTE should help.
> 
I think an ELF note would be a fine idea.

> > However, this file needs to be passed somehow to the rootfs
> > of the kdump kernel. This poses a chicken-and-egg problem on 
> > my setup where the initramfs of the first kernel contains 
> > a staticlu linked version of the kexec executable along with a
> > kdump kernel to be loaded before mount rootfs and running 
> > init. 
> > 
> 
> Why are you loading kdump kernel from first kernel's initramfs?
> I guess to enable the dump capture as soon as possible so if some
> driver panics() you can capture the dump?
> 
> Can't we modify the initramfs generation process (mkinitrd) to take
> care of this situation?. By the way, how is second kernel's initramfs
> is generated currently? The moment we start packing a file which contains
We use a modified version of mkinitrd, called mkdumprd to generate the kdump
initramfs.

> the debuginfo for first kernel, initramfs of second kernel becomes dependent
> on first kernel and to me its not a good approach.
> 
> A dump kernel and its initrd should be independent of the crashing kernel.
> 
They are, even if you manually pack them into the first kernels initramfs.  Not
sure where you see a dependency here.

> Neil/Keni'chi, how is this taken care in current RHEL5 build? Is second
> kernel's initramfs dependent on first kernel if one is doing filtering
> in second kernel from initramfs?
> 
No not at all.  Well, not really.  If you configure kdump to use makedumpfile,
the mkdumprd script runs makedumpfile -g to generate a config file that gets
packed into the kdump initramfs for use during the dump process, which is all
makedumpfile needs to successfully filter the crashing kernel.  So we are
dependent on the first kernel during kdump service startup, since we need to
generate that config file, but after that, we're completely independent.

Thanks
Neil

> Thanks
> Vivek

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
