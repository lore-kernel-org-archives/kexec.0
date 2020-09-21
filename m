Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKMZU-00005g-0C
 for kexec@lists.infradead.org; Mon, 21 Sep 2020 14:13:39 +0000
Received: from mail-pg1-f197.google.com ([209.85.215.197])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <ioanna-maria.alifieraki@canonical.com>)
 id 1kKMZQ-0006MW-SP
 for kexec@lists.infradead.org; Mon, 21 Sep 2020 14:13:33 +0000
Received: by mail-pg1-f197.google.com with SMTP id r2so8093650pga.12
 for <kexec@lists.infradead.org>; Mon, 21 Sep 2020 07:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200910005429.7059-1-ioanna-maria.alifieraki@canonical.com>
 <CAFTCetR3DK78DDfvFPoaoUFAorSOZZpKav0=zt+DQdT4epj1Hg@mail.gmail.com>
In-Reply-To: <CAFTCetR3DK78DDfvFPoaoUFAorSOZZpKav0=zt+DQdT4epj1Hg@mail.gmail.com>
From: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Date: Mon, 21 Sep 2020 15:13:04 +0100
Message-ID: <CAOLeGd2Um7gB6QSpsAxyfyR65_+PLDhj2+=q-Oqv043CRmWqvw@mail.gmail.com>
Subject: Re: [PATCH] arm64 : fix makedumpfile failure on 5.4+ kernels
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, Bhupesh Sharma <bhsharma@redhat.com>, Guilherme Piccoli <gpiccoli@canonical.com>, kexec@lists.infradead.org, k-hagio-ab@nec.com

Hi Bhupesh,

Sorry for the late reply, I tested your v5 patches on arm64 and x86_64 vms
with 4.15, 5.4 and the latest upstream kernel and makedumpfile works fine.

Cheers,
Ioanna

On Thu, Sep 10, 2020 at 9:42 PM Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>
> Hello Ioanna,
>
> Thanks for the patch. I am partially at blame here (and also for
> top-posting here) as this failure is caused due to the flipped VA
> address space support we have on arm64 architecture now with newer
> kernels (>= 5.4.0) due to the addition of larger VA addressing space
> features (52-bit).
>
> I had sent out a v4 series to fix this issue several months back (see
> <https://www.spinics.net/lists/kexec/msg23850.html>) and I was
> supposed to send an update for the same (v5), but the kernel patches
> (for variable export to vmcoreinfo) took a longer time to get accepted
> upstream.
>
> I have shared the updated v5 version earlier today (see
> <http://lists.infradead.org/pipermail/kexec/2020-September/021333.html>).
> Can you please try the same and share your testing inputs.
>
> Thanks,
> Bhupesh
>
>
>
>
> On Thu, Sep 10, 2020 at 6:25 AM Ioanna Alifieraki
> <ioanna-maria.alifieraki@canonical.com> wrote:
> >
> > Currently makedumpfile fails on arm64 for 5.4 and newer kernels with
> > the following :
> >
> > [9.595476] kdump-tools[513]: Starting kdump-tools:
> > [9.597988] kdump-tools[519]:  * running makedumpfile -c -d 31 /proc/vmcore /var/crash/202009011332/dump-incomplete
> > [9.636915] kdump-tools[537]: calculate_plat_config: PAGE SIZE 0x1000 and VA Bits 47 not supported
> > [9.639652] kdump-tools[537]: get_machdep_info_arm64: Can't determine platform config values
> > [9.642085] kdump-tools[537]: makedumpfile Failed.
> > [9.643064] kdump-tools[519]:  * kdump-tools: makedumpfile failed, falling back to 'cp'
> >
> > The problem starts at get_versiondep_info_arm64 function.
> > This functions uses _stext to calculate the va_bits.
> > Up to 5.3 kernels the _stext would be ffff000010081000.
> > After commit 14c127c957c1c607 (arm64: mm: Flip kernel VA space),
> > _stext is ffff800010081000 which ends up the va_bits getting the value
> > of 47, even though the kernel configuration is 48 bits.
> > Now _stext has contiguous bits ffff8  and matches the 47 bits
> > while in the past it had ffff0 that would match the 48 bits.
> > The va_bits variable is already exported in vmcoreinfo and therefore
> > that could be solved by reading the value  from there
> > (va_bits = NUMBER(VA_BITS)) instead of relying on _stext.
> > However, if we do so, the page_offset is not calculated properly.
> > Currently :
> > info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > The page_offset still depends on the _stext value.
> > So read the va_bits from vmcoreinfo and keep the old logic of calculating
> > va_bits to calculate page_offset (calc_page_offset_variable).
> >
> > Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> > ---
> >  arch/arm64.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64.c b/arch/arm64.c
> > index 54d60b4..2b0fca3 100644
> > --- a/arch/arm64.c
> > +++ b/arch/arm64.c
> > @@ -290,6 +290,7 @@ int
> >  get_versiondep_info_arm64(void)
> >  {
> >         ulong _stext;
> > +       int calc_page_offset;
> >
> >         _stext = get_stext_symbol();
> >         if (!_stext) {
> > @@ -297,25 +298,28 @@ get_versiondep_info_arm64(void)
> >                 return FALSE;
> >         }
> >
> > +       va_bits = NUMBER(VA_BITS);
> > +
> >         /* Derive va_bits as per arch/arm64/Kconfig */
> >         if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > -               va_bits = 36;
> > +               calc_page_offset = 36;
> >         } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > -               va_bits = 39;
> > +               calc_page_offset = 39;
> >         } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > -               va_bits = 42;
> > +               calc_page_offset = 42;
> >         } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > -               va_bits = 47;
> > +               calc_page_offset = 47;
> >         } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > -               va_bits = 48;
> > +               calc_page_offset = 48;
> >         } else {
> > -               ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > +               ERRMSG("Cannot find a proper _stext for calculating page_offset\n");
> >                 return FALSE;
> >         }
> >
> > -       info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +       info->page_offset = (0xffffffffffffffffUL) << (calc_page_offset - 1);
> >
> >         DEBUG_MSG("va_bits      : %d\n", va_bits);
> > +       DEBUG_MSG("calc_page_offset  : %d\n", calc_page_offset);
> >         DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
> >
> >         return TRUE;
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
