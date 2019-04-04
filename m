Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBw4A-0008JB-Ud
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 06:41:41 +0000
Date: Thu, 4 Apr 2019 14:41:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
References: <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
 <20190404030037.GT7627@MiWiFi-R3L-srv>
 <20190404031030.GU7627@MiWiFi-R3L-srv>
 <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/04/19 at 11:22am, Dave Young wrote:
> On 04/04/19 at 11:10am, Baoquan He wrote:
> > On 04/04/19 at 11:00am, Baoquan He wrote:
> > > On 04/04/19 at 10:52am, Dave Young wrote:
> > > > On 04/04/19 at 01:23am, Junichi Nomura wrote:
> > > > > Hi Dave and Chao,
> > > > > 
> > > > > On 4/3/19 6:02 PM, Chao Fan wrote:
> > > > > > On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
> > > > > >> On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
> > > > > >>> Fix 3.  need more debugging, have you or Junichi run tests on more real
> > > > > >>> hardware, maybe it is easier to reproduce on real hardware, I'm glad to
> > > > > >>> help to try test patch or provide any help. 
> > > > > >>
> > > > > >> I am still testing in real hardware.
> > > > > > 
> > > > > > Hi Dave,
> > > > > > 
> > > > > > I find a Fujitsu Desktop PC to test it.
> > > > > > Without this PATCH, it failed to kexec and kdump.
> > > > > > With this PATCH, it succeed to kexec.
> > > > > > But failed to kdump. From the log, I think it didn't jump to the second
> > > > > > kernel, just reboot after panic. I have not figured out what's the
> > > > > > problem, but it seems not caused by this PATCH.
> > > > > > So I still think this PATCH works for the Fujitsu Desktop PC.
> > > > > > 
> > > > > > As for your issue, I think there may be some problems related to specified
> > > > > > hardware. Are you using a Lenovo laptop?
> > > > > > 
> > > > > > And I am not sure how Nomura tested it.
> > > > > 
> > > > > I've tested 3 different models of EFI-booted baremetal servers with both
> > > > > normal kexec and panic kexec.  So far as I've tried Linus's v5.1-rc3,
> > > > > the problem always reproduced without the patch and disappears with the patch.
> > > > 
> > > > Hmm, both of my two laptops (Thinkpad T480s and T420) failed to boot with kexec.
> > > > 
> > > > I will see if I can find something, but it may need more time because
> > > > early console does not work especially after kexec.
> > > 
> > > Dave, can you try below patch to print debugging message and hang kernel
> > > to check the outputting? The hang is necessary, otherwise later printk
> > > printking will overwrite it.
> > > 
> > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > > index c0d6c560df69..68119547c4aa 100644
> > > --- a/arch/x86/boot/compressed/misc.c
> > > +++ b/arch/x86/boot/compressed/misc.c
> > > @@ -351,9 +351,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> > >  	/* Clear flags intended for solely in-kernel use. */
> > >  	boot_params->hdr.loadflags &= ~KASLR_FLAG;
> > >  
> > > -	/* Save RSDP address for later use. */
> > > -	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> > > -
> > >  	sanitize_boot_params(boot_params);
> > >  
> > >  	if (boot_params->screen_info.orig_video_mode == 7) {
> > > @@ -370,6 +367,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> > >  	console_init();
> > >  	debug_putstr("early console in extract_kernel\n");
> > >  
> >  +	/* Save RSDP address for later use. */
> >  +	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> >  +
> >  +	error("Hang kernel for kexec debugging");
> > 
> > Sorry, here I means calling error() to hang kernel after calling
> > get_rsdp_addr().
> 
> Thanks, it did not hang, it always reset to firmware/grub boot menu.
> I'm pretty sure now the bug exists in get_rsdp_addr().

static acpi_physical_address kexec_get_rsdp_addr(void)
{
...
        /* Get systab from boot params. */
        systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
        if (!systab)
              error("EFI system table not found in kexec boot_params.");
 
...
  -> add error("hang me") here will have a hang
...
        return __efi_get_rsdp_addr((unsigned long)esd->tables,
                                   systab->nr_tables, true);
 
But add error("hang me") in __efi_get_rsdp_addr it did not hang.
 
It seems reference the systab pointer cause a system reset.
 
A question is does the identity mapping covered the memory address of
systab?
 
In my case it is 0xdad9ef18
 
If the memory is mapped on demand, then there will be problems, it
should cover setup_data and efi table space.
 
Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
