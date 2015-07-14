Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x244.google.com ([2607:f8b0:4003:c01::244])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZEvvn-000638-8U
 for kexec@lists.infradead.org; Tue, 14 Jul 2015 08:51:15 +0000
Received: by obbgp5 with SMTP id gp5so135716obb.2
 for <kexec@lists.infradead.org>; Tue, 14 Jul 2015 01:50:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150714084651.GB4483@dhcp-129-237.nay.redhat.com>
References: <20150713021353.282890552@redhat.com>
 <20150713022634.175021545@redhat.com>
 <CAMuHMdUjz7gvEfQ0q=oBO5GRfXFYLwPatr3yE56e4=43V=5gWg@mail.gmail.com>
 <20150714084651.GB4483@dhcp-129-237.nay.redhat.com>
Date: Tue, 14 Jul 2015 10:50:54 +0200
Message-ID: <CAMuHMdUBBdUuyGES_sGULEXQx6sHpC8NFhH-+-1k+n=ZYvDb=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] [PATCH 2/3] kexec: split kexec_load syscall from
 kexec core code
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, ptesarik@suse.cz, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Dave,

On Tue, Jul 14, 2015 at 10:46 AM, Dave Young <dyoung@redhat.com> wrote:
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 1c50210..20c48b3 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -2001,10 +2001,14 @@ config XIP_PHYS_ADDR
>> >           be linked for and stored to.  This address is dependent on your
>> >           own flash usage.
>> >
>> > +config KEXEC_CORE
>> > +       bool
>> > +
>> >  config KEXEC
>> >         bool "Kexec system call (EXPERIMENTAL)"
>> >         depends on (!SMP || PM_SLEEP_SMP)
>> >         depends on !CPU_V7M
>> > +       select KEXEC_CORE
>> >         help
>> >           kexec is a system call that implements the ability to shutdown your
>> >           current kernel, and to start another kernel.  It is like a reboot
>>
>> As this KEXEC_CORE is appearing in all arch/*/Kconfig files, I think it's
>> time to add an ARCH_HAS_KEXEC symbol (to a common Kconfig file),
>> and let arch/*/Kconfig select that if the architecture has kexec support.
>>
>> Then KEXEC and KEXEC_CORE can live in the common Kconfig file,
>> without the need to duplicate it.
>
> I'm not sure I understand your idea well, do you means like
> in arch/Kconfig add ARCH_HAS_KEXEC which depends on KEXEC_CORE?

No, ARCH_HAS_KEXEC and all other KEXEC config options in arch/Kconfig.
All other KEXEC config options should depend on ARCH_HAS_KEXEC,
which can be selected by architectures that support kexec.

> How about simply move below chunk to arch/Kconfig instead of introducing
> another ARCH_HAS_KEXEC:
> config KEXEC_CORE
>         bool

Not all architectures support kexec, hence my proposed dependency on
ARCH_HAS_KEXEC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
