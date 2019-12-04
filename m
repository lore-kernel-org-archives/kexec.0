Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from heinz.dinsnail.net ([81.169.187.250])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icT66-0003wM-T3
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 11:45:36 +0000
Date: Wed, 4 Dec 2019 12:31:40 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191204113140.GA3081@weiser.dinsnail.net>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Hello Dave,

On Wed, Dec 04, 2019 at 03:59:17PM +0800, Dave Young wrote:
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/quirks.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> >  		return;
> >  	}
> >  
> > -	/* No need to reserve regions that will never be freed. */
> > -	if (md.attribute & EFI_MEMORY_RUNTIME)
> > -		return;
> > -
> >  	size += addr % EFI_PAGE_SIZE;
> >  	size = round_up(size, EFI_PAGE_SIZE);
> >  	addr = round_down(addr, EFI_PAGE_SIZE);
> > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> >  	early_memunmap(new, new_size);
> >  
> >  	efi_memmap_install(new_phys, num_entries);
> > +	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > +	e820__update_table(e820_table);
> >  }
> >  
> >  /*
> Michael, could you a one more test and provide a tested-by if it works
> for you?

Did three successful kexecs in sequence of mainline 5.4.0 plus the patch
(had problems getting recent -next to boot on my machine). ESRT region
stayed reserved and intact so that the "Invalid version" error message   
is gone.

Tested-by: Michael Weiser <michael.weiser@gmx.de>
--
Thanks!
Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
