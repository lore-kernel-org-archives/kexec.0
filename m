Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTZtS-0004jt-JZ
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 16:44:35 +0000
Date: Fri, 28 Mar 2014 09:44:04 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: PATCH: kexec/i386: fix erroneous memory descriptor message
Message-ID: <20140328164404.GB3745@verge.net.au>
References: <5333AEEB.4090100@suse.de>
 <20140327054715.GA20847@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140327054715.GA20847@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Tony Jones <tonyj@suse.de>

On Thu, Mar 27, 2014 at 01:47:15PM +0800, Dave Young wrote:
> On 03/26/14 at 09:54pm, Tony Jones wrote:
> > On non-EFI systems, efi_info section of boot_params is zero filled resulting 
> > in an erroneous message from kexec regarding "efi memory descriptor" version.
> > 
> > Caused by commit: e1ffc9e9a0769e1f54185003102e9bec428b84e8 "Passing efi related 
> > data via setup_data"
> > 
> > # od -j 448 -N 32 -v -x /sys/kernel/boot_params/data 
> > 0000700 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000720 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000740
> > 
> > # kexec -l --reuse-cmdline --initrd=/boot/initrd-`uname -r` /boot/vmlinuz-`uname -r`
> > efi memory descriptor version 0 is not supported!
> > 
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> > 
> > ---
> >  kexec/arch/i386/x86-linux-setup.c |   14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > --- a/kexec/arch/i386/x86-linux-setup.c
> > +++ b/kexec/arch/i386/x86-linux-setup.c
> > @@ -687,17 +687,25 @@ static void setup_efi_info(struct kexec_
> >  	ret = get_bootparam(&real_mode->efi_info, offset, 32);
> >  	if (ret)
> >  		return;
> > +	if (((struct efi_info *)real_mode->efi_info)->efi_memmap_size == 0)
> > +		/* zero filled efi_info */
> > +		goto out;
> >  	desc_version = get_efi_mem_desc_version(real_mode);
> >  	if (desc_version != 1) {
> >  		fprintf(stderr,
> >  			"efi memory descriptor version %d is not supported!\n",
> >  			desc_version);
> > -		memset(&real_mode->efi_info, 0, 32);
> > -		return;
> > +		goto out;
> >  	}
> >  	ret = setup_efi_data(info, real_mode);
> >  	if (ret)
> > -		memset(&real_mode->efi_info, 0, 32);
> > +		goto out;
> > +
> > +	return;
> > +
> > +out:
> > +	memset(&real_mode->efi_info, 0, 32);
> > +	return;
> >  }
> >  
> >  void setup_linux_system_parameters(struct kexec_info *info,
> 
> Good catch, thanks.
> 
> Acked-by: Dave Young <dyoung@redhat.com>

Thanks, Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
