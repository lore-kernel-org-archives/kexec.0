Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icRpH-00033G-IV
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 10:24:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id y17so7863920wrh.5
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 02:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
 <20191204101412.GD114697@gmail.com>
In-Reply-To: <20191204101412.GD114697@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 4 Dec 2019 10:24:01 +0000
Message-ID: <CAKv+Gu8TcF69QNhqRJGh+A8AJ=91dfTJhRmV=J4V3ML9vQWoXA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
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
To: Ingo Molnar <mingo@kernel.org>
Cc: Michael Weiser <michael@weiser.dinsnail.net>, linux-efi <linux-efi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Wed, 4 Dec 2019 at 10:14, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dave Young <dyoung@redhat.com> wrote:
>
> > On 12/04/19 at 03:52pm, Dave Young wrote:
> > > Michael Weiser reported he got below error during a kexec rebooting:
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > is to reuse the EFI boot services data across kexec reboot. For example
> > > the BGRT image data and some ESRT memory like Michael reported.
> > >
> > > But although the memory is reserved it is not updated in X86 e820 table.
> > > And kexec_file_load iterate system ram in io resource list to find places
> > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > initramfs overwritten the ESRT memory and then the failure happened.
> >
> > s/overwritten/overwrote :)  If need a repost please let me know..
> >
> > >
> > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > by updating the reserved EFI boot services memory as reserved type in e820.
> > >
> > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > bypassed in the reservation code path because they are assumed as reserved.
> > > But the reservation is still needed for multiple kexec reboot.
> > > And it is the only possible case we come here thus just drop the code
> > > chunk then everything works without side effects.
> > >
> > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > not trigger the problem, but I successfully tested with BGRT instead.
> > > both kexec_load and kexec_file_load work and kdump works as well.
> > >
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
>
>
> So I edited this to:
>
>  From: Dave Young <dyoung@redhat.com>
>
>  Michael Weiser reported he got this error during a kexec rebooting:
>
>    esrt: Unsupported ESRT version 2904149718861218184.
>
>  The ESRT memory stays in EFI boot services data, and it was reserved
>  in kernel via efi_mem_reserve().  The initial purpose of the reservation
>  is to reuse the EFI boot services data across kexec reboot. For example
>  the BGRT image data and some ESRT memory like Michael reported.
>
>  But although the memory is reserved it is not updated in the X86 E820 table,
>  and kexec_file_load() iterates system RAM in the IO resource list to find places
>  for kernel, initramfs and other stuff. In Michael's case the kexec loaded
>  initramfs overwrote the ESRT memory and then the failure happened.
>
>  Since kexec_file_load() depends on the E820 table being updated, just fix this
>  by updating the reserved EFI boot services memory as reserved type in E820.
>
>  Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
>  bypassed in the reservation code path because they are assumed as reserved.
>
>  But the reservation is still needed for multiple kexec reboots,
>  and it is the only possible case we come here thus just drop the code
>  chunk, then everything works without side effects.
>
>  On my machine the ESRT memory sits in an EFI runtime data range, it does
>  not trigger the problem, but I successfully tested with BGRT instead.
>  both kexec_load() and kexec_file_load() work and kdump works as well.
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
