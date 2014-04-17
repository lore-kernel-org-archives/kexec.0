Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Waey2-0006vH-Tr
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 05:34:35 +0000
Date: Thu, 17 Apr 2014 13:35:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 9/9] x86: Pass memory range via E820 for kdump
Message-ID: <20140417053541.GC4889@dhcp-16-126.nay.redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
 <1397487341-17287-10-git-send-email-chaowang@redhat.com>
 <20140417052913.GB4889@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417052913.GB4889@dhcp-16-126.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/17/14 at 01:29pm, Dave Young wrote:
> On 04/14/14 at 10:55pm, WANG Chao wrote:
> > command line size is restricted by kernel, sometimes memmap=exactmap has
> > too many memory ranges to pass to cmdline. And also memmap=exactmap and
> > kASLR doesn't work together.
> > 
> > A better approach, to pass the memory ranges for crash kernel to boot
> > into, is filling the memory ranges into E820.
> > 
> > boot_params only got 128 slots for E820 map to fit in, when the number of
> > memory map exceeds 128, use setup_data to pass the rest as extended E820
> > memory map.
> > 
> > kexec boot could also benefit from setup_data in case E820 memory map
> > exceeds 128.
> > 
> > Now this new approach becomes default instead of memmap=exactmap.
> > saved_max_pfn users can specify --pass-memmap-cmdline to use the
> > exactmap approach.
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > Tested-by: Linn Crosetto <linn@hp.com>
> > Reviewed-by: Linn Crosetto <linn@hp.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c   |   6 +-
> >  kexec/arch/i386/x86-linux-setup.c | 149 +++++++++++++++++++++++++-------------
> >  kexec/arch/i386/x86-linux-setup.h |   1 +
> >  3 files changed, 103 insertions(+), 53 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 7b618a6..4a1491b 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -979,7 +979,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> >  	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
> >  		return -1;
> > -	cmdline_add_memmap(mod_cmdline, memmap_p);
> > +	if (arch_options.pass_memmap_cmdline)
> > +		cmdline_add_memmap(mod_cmdline, memmap_p);
> >  	if (!bzImage_support_efi_boot)
> >  		cmdline_add_efi(mod_cmdline);
> >  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> > @@ -995,7 +996,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  		type = mem_range[i].type;
> >  		size = end - start + 1;
> >  		add_memmap(memmap_p, &nr_memmap, start, size, type);
> > -		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> > +		if (arch_options.pass_memmap_cmdline)
> > +			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> 
> Seems memmap_p contains the acpi ranges as well, so cmdline_add_memmap_acpi is
> not necessary anymore, just improve cmdline_add_memmap to add both RAM and ACPI
> ranges is enough.

CRASH_MAX_MEMMAP_NR is used in cmdline_add_memmap, it does not include the acpi
ranges, it looks strange, but anyway there's checking about cmdline overflow, tos
I think maybe this CRASH_MAX_MEMMAP_NR can be dropped.

> 
> Thanks
> Dave
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
