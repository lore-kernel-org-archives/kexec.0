Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hupPX-0004d1-Ou
 for kexec@lists.infradead.org; Tue, 06 Aug 2019 02:41:17 +0000
Date: Tue, 6 Aug 2019 10:41:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190806024108.GA6956@dhcp-128-65.nay.redhat.com>
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matthew Garrett <matthewgarrett@google.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-efi <linux-efi@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08/05/19 at 06:55pm, Ard Biesheuvel wrote:
> On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung@redhat.com> wrote:
> >
> > kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> > just reset while calling efi_delete_dummy_variable();  Unfortunately
> > I don't know how to debug the firmware, it is also possible a potential
> > problem on real hardware as well although nobody reproduced it.
> >
> > The intention of efi_delete_dummy_variable is to trigger garbage collection
> > when entering virtual mode.  But SetVirtualAddressMap can only run once
> > for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> > a good place to clean dummy object.
> >
> 
> I would argue that this means it is not a good place to *create* the
> dummy variable, and if we don't create it, we don't have to delete it
> either.
> 
> > Drop efi_delete_dummy_variable so that kexec reboot can work.
> >
> 
> Creating it and not deleting it is bad, so please try and see if we
> can omit the creation on this code path instead.

I'm not sure in this case the var is created or not, the logic seems
tricky to me.  It seems to me it is intend to force delete a non-exist
var here.

Matthew, can you comment here about Ard's question?

> 
> 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/efi.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > --- linux-x86.orig/arch/x86/platform/efi/efi.c
> > +++ linux-x86/arch/x86/platform/efi/efi.c
> > @@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
> >
> >         if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
> >                 runtime_code_page_mkexec();
> > -
> > -       /* clean DUMMY object */
> > -       efi_delete_dummy_variable();
> >  #endif
> >  }
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
