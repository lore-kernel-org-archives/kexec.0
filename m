Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMuYf-0004nh-Up
 for kexec@lists.infradead.org; Fri, 10 Apr 2020 14:23:03 +0000
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
 [209.85.166.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7917120CC7
 for <kexec@lists.infradead.org>; Fri, 10 Apr 2020 14:23:00 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id n20so1888932ioa.4
 for <kexec@lists.infradead.org>; Fri, 10 Apr 2020 07:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Apr 2020 16:22:49 +0200
Message-ID: <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
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
Cc: linux-efi <linux-efi@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>

On Fri, 10 Apr 2020 at 16:02, Dave Young <dyoung@redhat.com> wrote:
>
> On 04/10/20 at 09:56pm, Dave Young wrote:
> > On 04/10/20 at 09:43am, Ard Biesheuvel wrote:
> > > Commit
> > >
> > >   0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")
> > >
> > > removed the code that retrieves the non-remapped UEFI runtime services
> > > pointer from the data structure provided by kexec, as it was never really
> > > needed on the kexec boot path: mapping the runtime services table at its
> > > non-remapped address is only needed when calling SetVirtualAddressMap(),
> > > which never happens during a kexec boot in the first place.
> > >
> > > However, dropping the 'runtime' member from struct efi_setup_data was a
> > > mistake. That struct is shared ABI between the kernel and the kexec tooling
> > > for x86, and so we cannot simply change its layout. So let's put back the
> > > removed field, but call it 'unused' to reflect the fact that we never look
> > > at its contents. While at it, add a comment to remind our future selves
> > > that the layout is external ABI.
> > >
> > > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > > Tested-by: Theodore Ts'o <tytso@mit.edu>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >
> > > Ingo, Thomas, Boris: I sent out my efi-urgent pull request just yesterday,
> > > so please take this directly into tip:efi/urgent - no need to wait for the
> > > next batch.
> > >
> > >  arch/x86/include/asm/efi.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index 781170d36f50..96044c8d8600 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
> > >  extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
> > >  extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> > >
> > > +/* kexec external ABI */
> > >  struct efi_setup_data {
> > >     u64 fw_vendor;
> > > +   u64 unused;
> > >     u64 tables;
> > >     u64 smbios;
> > >     u64 reserved[8];
> > > --
> > > 2.17.1
> > >
> >
> > Ah, replied too quick in another mail.  I just cced kexec list again.
> >
> > Thanks for the fix:
> >
> > Reviewed-by: Dave Young <dyoung@redhat.com>
> >
>

Thanks Dave

> BTW, a fixes tag is good to have..
>

I usually omit those for patches that fix bugs that were introduced in
the current cycle.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
