Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f66.google.com ([209.85.166.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUS5a-0006Li-B3
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 07:59:24 +0000
Received: by mail-io1-f66.google.com with SMTP id n9so7887362ioo.2
 for <kexec@lists.infradead.org>; Tue, 04 Dec 2018 23:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20181123092801.16411-1-kasong@redhat.com>
 <20181204121024.GA2168@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20181204121024.GA2168@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 5 Dec 2018 15:58:59 +0800
Message-ID: <CACPcB9fWrFmeOiMiNfXkr_FXcDRnk-AgJ=-kwrmnFjuN_tfi2A@mail.gmail.com>
Subject: Re: [PATCH] x86: Clear isVGA flag if current fb driver is mimicking
 VGA
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

Thanks for the feedback!
This didn't happen with my laptop with i915, blindly using previous vga type
is not working for it, so didn't expect it would break some i915 devices.
I tried with my home laptop (also use i915) again and this patch did
break the previous working vga.
Will adopt your suggestion and update the patch.
On Tue, Dec 4, 2018 at 8:10 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 11/23/18 at 05:28pm, Kairui Song wrote:
> > Some device (eg. hyperv_fb) will mimic EFI (or VESA) VGA on first boot
> > up, but after the real driver is loaded, it will switch to new mode
> > and no longer compatible with EFI/VESA VGA. Keep setting
> > orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> > try to manipulate the framebuffer in a wrong way.
> >
> > As we have already take care of "VESA VGA" and "EFI VGA", just set the
> > orig_video_isVGA to 0 for any other driver reports as EFI/VESA VGA but
> > is not EFI/VESA VGA.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  kexec/arch/i386/x86-linux-setup.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> > index dc785a2..a129812 100644
> > --- a/kexec/arch/i386/x86-linux-setup.c
> > +++ b/kexec/arch/i386/x86-linux-setup.c
> > @@ -152,6 +152,11 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
> >               err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
> >               if (err)
> >                       goto out;
> > +
> > +             if (real_mode->orig_video_isVGA == 0x70 || real_mode->orig_video_isVGA == 0x23) {
> > +                     /* Clear isVGA flag for fb drivers that mimic EFI/VESA VGA */
> > +                     real_mode->orig_video_isVGA = 0;
> > +             }
>
> The blindly reuse original isVGA might be a problem like you said, but
> it does work for me for i915 laptop even if later drm driver loaded.
> With your patch it does not work anymore.
>
> kexec reboot with earlyprintk=efi without initramfs looks just hang, but
> previously I can see all the kernel console logs.
>
> Probably you can make real_mode->orig_video_isVGA = 0 as default in the
> else {} section, and introduce an extra x86 only argument for people to
> reuse isVGA blindly. eg.
>
> kexec --reuse-vga-type
>
> >       }
> >       close(fd);
> >
> > --
> > 2.19.1
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
> Thanks
> Dave



--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
