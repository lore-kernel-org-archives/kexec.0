Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TliO2-0002ut-E7
 for kexec@lists.infradead.org; Thu, 20 Dec 2012 15:50:19 +0000
Date: Thu, 20 Dec 2012 09:51:47 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH] makedumpfile: request the kernel do page scans
Message-ID: <20121220155147.GA2048@sgi.com>
References: <20121119180710.GA16448@sgi.com>
 <20121210.095929.249234826.d.hatayama@jp.fujitsu.com>
 <20121210153614.GA9037@sgi.com>
 <20121220.122214.503837449.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121220.122214.503837449.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: ptesarik@suse.cz, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Thu, Dec 20, 2012 at 12:22:14PM +0900, HATAYAMA Daisuke wrote:
> From: Cliff Wickman <cpw@sgi.com>
> Subject: Re: [PATCH] makedumpfile: request the kernel do page scans
> Date: Mon, 10 Dec 2012 09:36:14 -0600
> > On Mon, Dec 10, 2012 at 09:59:29AM +0900, HATAYAMA Daisuke wrote:
> >> From: Cliff Wickman <cpw@sgi.com>
> >> Subject: Re: [PATCH] makedumpfile: request the kernel do page scans
> >> Date: Mon, 19 Nov 2012 12:07:10 -0600
> >> 
> >> > On Fri, Nov 16, 2012 at 03:39:44PM -0500, Vivek Goyal wrote:
> >> >> On Thu, Nov 15, 2012 at 04:52:40PM -0600, Cliff Wickman wrote:
> > 
> > Hi Hatayama,
> > 
> > If ioremap/iounmap is the bottleneck then perhaps you could do what
> > my patch does: it consolidates all the ranges of physical addresses
> > where the boot kernel's page structures reside (see make_kernel_mmap())
> > and passes them to the kernel, which then does a handfull of ioremaps's to
> > cover all of them.  Then /proc/vmcore could look up the already-mapped
> > virtual address.
> > (also note a kludge in get_mm_sparsemem() that verifies that each section
> > of the mem_map spans contiguous ranges of page structures.  I had
> > trouble with some sections when I made that assumption)
> > 
> > I'm attaching 3 patches that might be useful in your testing:
> > - 121210.proc_vmcore2  my current patch that applies to the released
> >   makedumpfile 1.5.1
> > - 121207.vmcore_pagescans.sles applies to a 3.0.13 kernel
> > - 121207.vmcore_pagescans.rhel applies to a 2.6.32 kernel
> > 
> 
> I used the same patch set on the benchmark.
> 
> BTW, I have continuously reservation issue, so I think I cannot use
> terabyte memory machine at least in this year.
> 
> Also, your patch set is doing ioremap per a chunk of memory map,
> i.e. a number of consequtive pages at the same time. On your terabyte
> machines, how large they are? We have memory consumption issue on the
> 2nd kernel so we must decrease amount of memory used. But looking into
> ioremap code quickly, it looks not using 2MB or 1GB pages to
> remap. This means more than tera bytes page table is generated. Or
> have you probably already investigated this?
> 
> BTW, my idea to solve this issue are two:
> 
> 1) make linear direct mapping for old memory, and acess the old memory
> via the linear direct mapping, not by ioremap.
> 
>   - adding remap code in vmcore, or passing the regions that need to
>     be remapped using memmap= kernel option to tell the 2nd kenrel to
>     map them in addition.

Good point.  It would take over 30G of memory to map 16TB with 4k pages.
I recently tried to dump such a memory and ran out of kernel memory --
no wonder!

Do you have a patch for doing a linear direct mapping?  Or can you name
existing kernel infrastructure to do such mapping?  I'm just looking for
a jumpstart to enhance the patch.

-Cliff
> 
> Or,
> 
> 2) Support 2MB or 1GB pages in ioremap.
> 
> Thanks.
> HATAYAMA, Daisuke

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
