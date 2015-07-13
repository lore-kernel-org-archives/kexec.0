Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x22d.google.com ([2607:f8b0:4003:c01::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZEZWl-0005A3-Fv
 for kexec@lists.infradead.org; Mon, 13 Jul 2015 08:55:56 +0000
Received: by obcsb2 with SMTP id sb2so5871348obc.3
 for <kexec@lists.infradead.org>; Mon, 13 Jul 2015 01:55:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150713022634.175021545@redhat.com>
References: <20150713021353.282890552@redhat.com>
 <20150713022634.175021545@redhat.com>
Date: Mon, 13 Jul 2015 10:55:33 +0200
Message-ID: <CAMuHMdUjz7gvEfQ0q=oBO5GRfXFYLwPatr3yE56e4=43V=5gWg@mail.gmail.com>
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
To: dyoung@redhat.com
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, ptesarik@suse.cz, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Jul 13, 2015 at 4:13 AM,  <dyoung@redhat.com> wrote:
> Because there's general code need CONFIG_KEXEC_CORE, so I updated all the
> architecture Kconfig with a new option KEXEC_CORE, and let KEXEC selects
> KEXEC_CORE in arch Kconfig. Also updated general kernel code with
> to kexec_load syscall.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/arm/Kconfig              |    4 +
>  arch/ia64/Kconfig             |    4 +
>  arch/m68k/Kconfig             |    4 +
>  arch/mips/Kconfig             |    4 +
>  arch/powerpc/Kconfig          |    4 +
>  arch/sh/Kconfig               |    4 +
>  arch/tile/Kconfig             |    4 +
>  arch/x86/Kconfig              |    6 +-
>  arch/x86/boot/header.S        |    2 +-
>  arch/x86/include/asm/kdebug.h |    2 +-
>  arch/x86/kernel/Makefile      |    4 +-
>  arch/x86/kernel/kvmclock.c    |    4 +-
>  arch/x86/kernel/reboot.c      |    4 +-
>  arch/x86/kernel/setup.c       |    2 +-
>  arch/x86/kernel/vmlinux.lds.S |    2 +-
>  arch/x86/kvm/vmx.c            |    8 +-
>  arch/x86/platform/efi/efi.c   |    4 +-
>  arch/x86/platform/uv/uv_nmi.c |    6 +-
>  drivers/firmware/efi/Kconfig  |    2 +-
>  drivers/pci/pci-driver.c      |    2 +-
>  include/linux/kexec.h         |   12 +-
>  init/initramfs.c              |    4 +-
>  kernel/Makefile               |    1 +
>  kernel/events/core.c          |    2 +-
>  kernel/kexec.c                | 1578 +---------------------------------------
>  kernel/kexec_core.c           | 1594 +++++++++++++++++++++++++++++++++++++++++
>  kernel/ksysfs.c               |    6 +-
>  kernel/printk/printk.c        |    2 +-
>  kernel/reboot.c               |    2 +-
>  kernel/sysctl.c               |    2 +-
>  30 files changed, 1668 insertions(+), 1611 deletions(-)
>  create mode 100644 kernel/kexec_core.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c50210..20c48b3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2001,10 +2001,14 @@ config XIP_PHYS_ADDR
>           be linked for and stored to.  This address is dependent on your
>           own flash usage.
>
> +config KEXEC_CORE
> +       bool
> +
>  config KEXEC
>         bool "Kexec system call (EXPERIMENTAL)"
>         depends on (!SMP || PM_SLEEP_SMP)
>         depends on !CPU_V7M
> +       select KEXEC_CORE
>         help
>           kexec is a system call that implements the ability to shutdown your
>           current kernel, and to start another kernel.  It is like a reboot

As this KEXEC_CORE is appearing in all arch/*/Kconfig files, I think it's
time to add an ARCH_HAS_KEXEC symbol (to a common Kconfig file),
and let arch/*/Kconfig select that if the architecture has kexec support.

Then KEXEC and KEXEC_CORE can live in the common Kconfig file,
without the need to duplicate it.

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
