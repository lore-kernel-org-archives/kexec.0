Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-x235.google.com ([2607:f8b0:400e:c03::235])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjscQ-0001AL-6H
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 15:26:11 +0000
Received: by mail-pa0-f53.google.com with SMTP id hz1so1434450pad.40
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 07:25:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131122134317.GA4046@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <CAMuHMdUVvhKLBfZo2gBf=FoQxMEM42yzBjYS8r5sVfXgp940ng@mail.gmail.com>
 <20131122134317.GA4046@redhat.com>
Date: Fri, 22 Nov 2013 16:25:44 +0100
Message-ID: <CAMuHMdV4=Z8i0u_rWpQU0HHW0mvyv1k-acW1MyT9ZYy=iNwrfg@mail.gmail.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Nov 22, 2013 at 2:43 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> Looking at kexec-tools, all of arm, cris, i386, ia64, m68k, mips, ppc, ppc64,
>> s390, sh, and x86_64 support ELF.
>
> How many of them use ELF to boot in real world? Also one can easily
> add ELF loader. I am just not able to see why ELF loader should be
> a requirement for this patchset.

Many bootloaders support ELF.

>> Only arm, i386, ppc, ppc64, sh, and x86_64 support zImage.
>> It's not clear to me what alpha supports (if it supports anything at all?).
>
> Motiviation behind this patchset is secureboot. That is x86 specific
> only and bzImage is most commonly used format on that platform. So it
> makes sense to implement bzImage loader first, IMO.

While secureboot(TM) may be x86-centric, IIRC actually loading signed kernels
and modules didn't originate on x86. Anything can have a bootloader that
accepts signed kernel images only.

Even without the signing, I like the simplicity of the new syscall, moving
some bookkeeping to and keeping some info in the kernel (e.g. the kernel
no longer needs to export system RAM chunks and device tree or
bootinfo).

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
