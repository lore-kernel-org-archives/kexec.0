Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WahuI-0004yq-5n
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 08:42:54 +0000
Date: Thu, 17 Apr 2014 16:42:25 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v6 9/9] x86: Pass memory range via E820 for kdump
Message-ID: <20140417084225.GF1849@dhcp-17-89.nay.redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
 <1397487341-17287-10-git-send-email-chaowang@redhat.com>
 <20140417052913.GB4889@dhcp-16-126.nay.redhat.com>
 <20140417053541.GC4889@dhcp-16-126.nay.redhat.com>
 <20140417061736.GA1849@dhcp-17-89.nay.redhat.com>
 <20140417063244.GF4889@dhcp-16-126.nay.redhat.com>
 <20140417065749.GC1849@dhcp-17-89.nay.redhat.com>
 <20140417070713.GA11676@dhcp-16-126.nay.redhat.com>
 <20140417071726.GE1849@dhcp-17-89.nay.redhat.com>
 <20140417073045.GB11676@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417073045.GB11676@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/17/14 at 03:30pm, Dave Young wrote:
> On 04/17/14 at 03:17pm, WANG Chao wrote:
> > On 04/17/14 at 03:07pm, Dave Young wrote:
> > > On 04/17/14 at 02:57pm, WANG Chao wrote:
> > > > On 04/17/14 at 02:32pm, Dave Young wrote:
> > > > > On 04/17/14 at 02:17pm, WANG Chao wrote:
> > > > > > On 04/17/14 at 01:35pm, Dave Young wrote:
> > > > > > > On 04/17/14 at 01:29pm, Dave Young wrote:
> > > > > > > > On 04/14/14 at 10:55pm, WANG Chao wrote:
> > > > > > > > > command line size is restricted by kernel, sometimes memmap=exactmap has
> > > > > > > > > too many memory ranges to pass to cmdline. And also memmap=exactmap and
> > > > > > > > > kASLR doesn't work together.
> > > > > > > > > 
> > > > > > > > > A better approach, to pass the memory ranges for crash kernel to boot
> > > > > > > > > into, is filling the memory ranges into E820.
> > > > > > > > > 
> > > > > > > > > boot_params only got 128 slots for E820 map to fit in, when the number of
> > > > > > > > > memory map exceeds 128, use setup_data to pass the rest as extended E820
> > > > > > > > > memory map.
> > > > > > > > > 
> > > > > > > > > kexec boot could also benefit from setup_data in case E820 memory map
> > > > > > > > > exceeds 128.
> > > > > > > > > 
> > > > > > > > > Now this new approach becomes default instead of memmap=exactmap.
> > > > > > > > > saved_max_pfn users can specify --pass-memmap-cmdline to use the
> > > > > > > > > exactmap approach.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > > > > > > > > Tested-by: Linn Crosetto <linn@hp.com>
> > > > > > > > > Reviewed-by: Linn Crosetto <linn@hp.com>
> > > > > > > > > ---
> > > > > > > > >  kexec/arch/i386/crashdump-x86.c   |   6 +-
> > > > > > > > >  kexec/arch/i386/x86-linux-setup.c | 149 +++++++++++++++++++++++++-------------
> > > > > > > > >  kexec/arch/i386/x86-linux-setup.h |   1 +
> > > > > > > > >  3 files changed, 103 insertions(+), 53 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > > > > > > > index 7b618a6..4a1491b 100644
> > > > > > > > > --- a/kexec/arch/i386/crashdump-x86.c
> > > > > > > > > +++ b/kexec/arch/i386/crashdump-x86.c
> > > > > > > > > @@ -979,7 +979,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > > > > > > > >  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> > > > > > > > >  	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
> > > > > > > > >  		return -1;
> > > > > > > > > -	cmdline_add_memmap(mod_cmdline, memmap_p);
> > > > > > > > > +	if (arch_options.pass_memmap_cmdline)
> > > > > > > > > +		cmdline_add_memmap(mod_cmdline, memmap_p);
> > > > > > > > >  	if (!bzImage_support_efi_boot)
> > > > > > > > >  		cmdline_add_efi(mod_cmdline);
> > > > > > > > >  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> > > > > > > > > @@ -995,7 +996,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > > > > > > > >  		type = mem_range[i].type;
> > > > > > > > >  		size = end - start + 1;
> > > > > > > > >  		add_memmap(memmap_p, &nr_memmap, start, size, type);
> > > > > > > > > -		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> > > > > > > > > +		if (arch_options.pass_memmap_cmdline)
> > > > > > > > > +			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> > > > > > > > 
> > > > > > > > Seems memmap_p contains the acpi ranges as well, so cmdline_add_memmap_acpi is
> > > > > > > > not necessary anymore, just improve cmdline_add_memmap to add both RAM and ACPI
> > > > > > > > ranges is enough.
> > > > > > > 
> > > > > > > CRASH_MAX_MEMMAP_NR is used in cmdline_add_memmap, it does not include the acpi
> > > > > > > ranges, it looks strange, but anyway there's checking about cmdline overflow, tos
> > > > > > > I think maybe this CRASH_MAX_MEMMAP_NR can be dropped.
> > > > > > 
> > > > > > First, naming cmdline_add_memmap is not accurate regarding what the
> > > > > > function does (adding RAM only). But it's historical naming issue,
> > > > > > nothing to do with this patch :(
> > > > > > 
> > > > > > I'm sure that could be improved later.
> > > > > > 
> > > > > > Second, about dropping CRASH_MAX_MEMMAP_NR, I'm not sure if it's a good
> > > > > > idea.
> > > > > > 
> > > > > > CRASH_MAX_MEMMAP_NR is used to allocate memmap_p memory:
> > > > > > 
> > > > > > load_crash_segments(){
> > > > > > 	[..]
> > > > > > 	sz = (sizeof(struct memory_range) * CRASH_MAX_MEMMAP_NR);
> > > > > > 	memmap_p = xmalloc(sz);
> > > > > > 	memset(memmap_p, 0, sz);
> > > > > > 	[..]
> > > > > > }
> > > > > > 
> > > > > > And so that every time when we walk through memmap_p,
> > > > > > CRASH_MAX_MEMMAP_NR can be used as a upper boundary.
> > > > > > 
> > > > > > I think maintain CRASH_MAX_MEMMAP_NR is reasonable and necessary based
> > > > > > on the current code base.
> > > > > 
> > > > > Hmm, if it's used for allocate mem range array then how about directly use
> > > > > CRASH_MAX_MEMORY_RANGES which is same in your 5/9.
> > > > 
> > > > I did that on purpose for two reasons:
> > > > 
> > > > - I tend to make the changes as minimal as possible to make reviewer's
> > > >   life easier. So that I choose the same value for CRASH_MAX_MEMMAP_NR
> > > >   as CRASH_MAX_MEMORY_RANGES.
> > > 
> > > As long as the patches are logically clear, it does not matter to me :)
> > 
> > Maybe I should have set CRASH_MAX_MEMMAP_NR to 1024 directly.
> 
> Rethinking about it the hard limit is not good I remember there's report from
> SGI there's a lot of memory ranges so in the patch they increased the max ranges
> to 2048, but the patch was reverted.

Probally you mean this:

commit 8274916
Author: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Date:   Wed Mar 27 20:42:28 2013 +0800

    Revert: "kexec: lengthen the kernel command line image"

Cliff increased kernel cmdline size restriction in kexec-tools from 2048
to 64K and this patch got reverted since kernel has its restriction.

They wanted to increase kernel cmdline size in order to pass more memmap
to 2nd kernel. Now I have increased the memmap limitation to 1024. It
would be definitely enough.

> 
> Since there's several possible improvements I'm fine with current way in
> your patch, let keep it as is for now.

It comes to me that in the future there are two places that can be
improved or cleaned up. I summarize them as the followings:

- clean up cmdline_add_memmap and cmdline_add_memmap_acpi
- Dropping hard limitation memory maps, like CRASH_MAX_MEMMAP_NR

Do you have additional issues needed to be addressed?

> 
> I will ack the whole series from my point of view. 

And I really appreciate it. Thanks for review.

> 
> > 
> > > 
> > > > 
> > > > - CRASH_MAX_MEMORY_RANGES and CRASH_MAX_MEMMAP_NR are used for
> > > >   allocating different memory_range structures, crash_memory_range vs.
> > > >   memmap_p. Those two different variables are used in different places
> > > >   and serve for different purpose (1st kernel's memmap vs. 2nd kernel's
> > > >   memmap). In long term, I think keeping both macros separately is a
> > > >   better choice because one of them could change for whatever reason.
> > > 
> > > It's unlikely at least now IMO, I think we should even drop the limit
> > > because we have e820 + setup_data.
> > 
> > Do you know if kernel has limitation for setup_data?
> 
> I do not think there's limitation for setup_data as it's a link list..

It's not limited how many memory maps can be passed via setup_data. But
there does have a limitation of how many *sanitized maps* can be stored in kernel.

All e820 maps in e820 and setup_data will be appended to a global
(struct e820map e820).  And that struct e820map has 128 slots.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
