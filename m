Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wnrnr-0005oO-J7
 for kexec@lists.infradead.org; Fri, 23 May 2014 15:54:40 +0000
Date: Fri, 23 May 2014 17:54:11 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86: do not enable efi boot for sgi uv machine
Message-ID: <20140523155411.GC28727@pd.tnic>
References: <20140523101454.GA8608@darkstar.nay.redhat.com>
 <20140523132834.GB2126@redhat.com>
 <640284398.17653158.1400852828081.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <640284398.17653158.1400852828081.JavaMail.zimbra@redhat.com>
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
Cc: Russ Anderson <rja@sgi.com>, matt.fleming@intel.com, kexec@lists.infradead.org, horms@verge.net.au, Alex Thorlton <athorlton@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, May 23, 2014 at 09:47:08AM -0400, Dave Young wrote:
> Hi,
> 
> Vivek, replying with webmail, sorry for the formatting issue.
> 
> Another way is export the mapping scheme in sysfs. So if kernel boot
> with efi=old_map we can detect it as well. OTOH in future there's probably
> other quirk system.
> 
> So kexec-tools can switch to use old way if kernel use ioremap.
> 
> Adding Matt and Boris to cc, to see if they have idea.
> 
> Thanks
> Dave
> 
> ----- Original Message -----
> From: "Vivek Goyal" <vgoyal@redhat.com>
> To: "Dave Young" <dyoung@redhat.com>
> Cc: horms@verge.net.au, kexec@lists.infradead.org
> Sent: Friday, May 23, 2014 9:28:34 PM
> Subject: Re: [PATCH] x86: do not enable efi boot for sgi uv machine
> 
> On Fri, May 23, 2014 at 06:14:55PM +0800, Dave Young wrote:
> > 
> > kexec/kdump uefi support depends on the 1:1 mapping scheme
> > in 3.14 kernel but SGI reported that 1:1 mapping does not work on
> > their UV system. thus there's below commit to switch back to
> > old ioremap way for sgi uv machines.
> > 
> > So for kexec-tools before we got the 1:1 mapping support on those
> > machines we should also use old way that means boot 2nd kernel
> > without uefi.

Well, we did find the bug in a combined debug session and SGI will be
issuing a fix soon. I don't know whether any quirk will be needed for
systems which don't have the fix - I guess that's something for SGI
people to decide. CCed and leaving in the rest for reference.

@Alex, Russ: this is about using kexec on UEFI boxes.

> > 
> > Tested on a uv1 machine.
> > 
> > Here is the kernel commit to quirk out SGI UV:
> > commit a5d90c923bcfb9632d998ed06e9569216ad695f3
> > Author: Borislav Petkov <bp@suse.de>
> > Date:   Tue Mar 4 17:02:17 2014 +0100
> > 
> >     x86/efi: Quirk out SGI UV
> >     
> >     Alex reported hitting the following BUG after the EFI 1:1 virtual
> >     mapping work was merged,
> >     
> >      kernel BUG at arch/x86/mm/init_64.c:351!
> >      invalid opcode: 0000 [#1] SMP
> >      Call Trace:
> >       [<ffffffff818aa71d>] init_extra_mapping_uc+0x13/0x15
> >       [<ffffffff818a5e20>] uv_system_init+0x22b/0x124b
> >       [<ffffffff8108b886>] ? clockevents_register_device+0x138/0x13d
> >       [<ffffffff81028dbb>] ? setup_APIC_timer+0xc5/0xc7
> >       [<ffffffff8108b620>] ? clockevent_delta2ns+0xb/0xd
> >       [<ffffffff818a3a92>] ? setup_boot_APIC_clock+0x4a8/0x4b7
> >       [<ffffffff8153d955>] ? printk+0x72/0x74
> >       [<ffffffff818a1757>] native_smp_prepare_cpus+0x389/0x3d6
> >       [<ffffffff818957bc>] kernel_init_freeable+0xb7/0x1fb
> >       [<ffffffff81535530>] ? rest_init+0x74/0x74
> >       [<ffffffff81535539>] kernel_init+0x9/0xff
> >       [<ffffffff81541dfc>] ret_from_fork+0x7c/0xb0
> >       [<ffffffff81535530>] ? rest_init+0x74/0x74
> >     
> >     Getting this thing to work with the new mapping scheme would need more
> >     work, so automatically switch to the old memmap layout for SGI UV.
> > 
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  kexec/arch/i386/x86-linux-setup.c |   15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > --- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
> > +++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
> > @@ -817,12 +817,25 @@ out:
> >  	return;
> >  }
> >  
> > +static int is_sgi_uv_machine(void)
> > +{
> > +	DIR *sgi_dir;
> > +
> > +	sgi_dir = opendir("/sys/firmware/sgi_uv");
> > +	if (sgi_dir) {
> > +		closedir(sgi_dir);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  void setup_linux_system_parameters(struct kexec_info *info,
> >  				   struct x86_linux_param_header *real_mode)
> >  {
> >  	/* get subarch from running kernel */
> >  	setup_subarch(real_mode);
> > -	if (bzImage_support_efi_boot)
> > +	if (bzImage_support_efi_boot && !is_sgi_uv_machine())
> >  		setup_efi_info(info, real_mode);
> 
> Hi Dave,
> 
> I think instead of always falling back to old "noefi" method for SGI UV
> machines, we should probably provide a config option to override default
> behavior. Something like "--nouefi". And let user/distributions decide
> in what cases to use that parameter.
> 
> Reason being, that at some point of time this limitation will be fixed.
> And at that point of time if we modify kexec-tools, then it will stop
> working with older kernels. And then same issue will arise that
> kexec-tools is not working with older kernels.
> 
> If we just provide a way to override default, then distributions in their
> scripts should know what kernels work what way and automatically use or
> not use option accordingly.
> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
