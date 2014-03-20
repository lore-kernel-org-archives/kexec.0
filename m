Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQVoI-0003XC-QF
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 05:46:35 +0000
Date: Thu, 20 Mar 2014 13:46:08 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v2] x86, kaslr: Kernel base can be randomized at 0-1G
 offset.
Message-ID: <20140320054608.GA25772@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140319133331.GB21530@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: dyoung@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ebiederm@xmission.com

[CC Simon]

On 03/19/14 at 09:33am, Vivek Goyal wrote:
> On Wed, Mar 19, 2014 at 03:05:51PM +0800, WANG Chao wrote:
> > On 03/17/14 at 08:56am, Vivek Goyal wrote:
> > > On Fri, Mar 14, 2014 at 04:20:18PM +0800, WANG Chao wrote:
> > > > With kASLR enabled (CONFIG_RANDOMIZED_BASE=y), kernel virtual address
> > > > base is PAGE_OFFSET plus a randomized offset from 0 to 1G.
> > > > 
> > > > Current kexec-tools gets kernel vaddr and size from /proc/kcore. It
> > > > assumes kernel vaddr start/end is within the range [0,512M). If kaslr
> > > > enabled, kernel vaddr start/end will stay at [0+offset, 512M+offset).
> > 
> > NACK this patch myself.
> > 
> > There are several mistakes I made. I misunderstood some concepts. Then I
> > realize this kASLR issue is not trivial to fix.
> > 
> > I think if kexec-tools needs to get kernel text mapping from kcore in
> > kALSR case, the max base offset (CONFIG_RANDOMIZE_MAX_BASE_OFFSET) of
> > the kernel text area must be exposed to userspace some where. We can use
> > that value to determine which area is for kernel text mapping and which
> > is for modules text mapping.
> 
> How about looking at /proc/kallsyms and look at address of one of the
> symbols say _text. And search for the ELF header in kcore which contains
> _text address and that's ELF header representing kernel text mapping.

Cool. I'd like to go with _stext. _text presents in /proc/kallsyms only
when CONFIG_KALLSYMS_ALL=y. What do you think?

> 
> That way you don't have to worry about the value of
> CONFIG_RANDOMIZE_MAX_BASE_OFFSET.
> 
> > 
> > > 
> > > Hi Chao,
> > > 
> > > Documentation/x86/x86_64/mm.txt still says that kernel text mapping area
> > > is 512MB.
> > > 
> > > ffffffff80000000 - ffffffffa0000000 (=512 MB)  kernel text mapping, from
> > > phys 0
> > > 
> > > So has that changed now due to kASLR.
> > 
> > Yes, with kASLR enabled, kernel text mapping is as following
> > 
> > ffffffff80000000 - (ffffffff80000000+CONFIG_RANDOMIZE_BASE_MAX_OFFSET)
> > 
> > That said, if using CONFIG_RANDOMIZE_BASE_MAX_OFFSET=0x40000000 by
> > default, the kernel text mapping is as following:
> > 
> > ffffffff80000000 - ffffffffc0000000
> > 
> 
> Agreed. help text for CONFIG_RANDOMIZE_BASE_MAX_OFFSET says following.
> 
> On 64-bit this is limited by how the kernel fixmap page table is
> positioned, so this cannot be larger than 1GiB currently.  Without
> RANDOMIZE_BASE, there is a 512MiB to 1.5GiB split between kernel
> and modules. When RANDOMIZE_BASE_MAX_OFFSET is above 512MiB, the
> modules area will shrink to compensate, up to the current maximum
> 1GiB to 1GiB split. The default is 1GiB.
> 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
