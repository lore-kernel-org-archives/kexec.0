Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPeWs-00034u-4j
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:39:27 +0000
Received: by vws8 with SMTP id 8so902020vws.36
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 10:38:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110526171209.GA17988@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171209.GA17988@in.ibm.com>
Date: Thu, 26 May 2011 19:38:19 +0200
Message-ID: <BANLkTi=ZrPkRwFSmdkAB60-MKS3fwZOjpg@mail.gmail.com>
Subject: Re: [Patch 1/6] XPANIC: Add extended panic interface
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: prasad@linux.vnet.ibm.com
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 26, 2011 at 7:12 PM, K.Prasad <prasad@linux.vnet.ibm.com> wrote:
>
> commit e668fa1aea7844ac4c7ea09030a2f3e647a4adb1
> Author: Andi Kleen <ak@linux.intel.com>
> Date: =A0 Fri Nov 19 18:36:44 2010 +0100
>
> =A0 =A0XPANIC: Add extended panic interface
>
> =A0 =A0One panic size doesn't fit all.
>
> =A0 =A0Machine check has some special requirements on panic, like:
> =A0 =A0- It wants to do a reboot timeout by default so that the machine
> =A0 =A0check event can be logged to disk after warm reboot.
> =A0 =A0- For memory errors it usually doesn't want to do crash dumps beca=
use
> =A0 =A0that can lead to crash loops (dumping corrupted memory would
> =A0 =A0lead to another machine check)
> =A0 =A0- It doesn't want to do backtraces because machine checks
> =A0 =A0are not a kernel bug.
>
> =A0 =A0In a earlier patch this was done with various adhoc hacks,
> =A0 =A0but it's cleaner to extend panic to a 'xpanic' that directly
> =A0 =A0gets a flag and timeout argument.
>
> =A0 =A0The only user right now will be x86 machine checks, but I consider
> =A0 =A0it likely that other users will switch to this too.
>
> =A0 =A0For example one obvious candidate would be the "no root
> =A0 =A0found" panic which doesn't really deserve a backtrace.
>
> =A0 =A0I exported a vpanic() interface too as a global. That's not
> =A0 =A0needed by the current user, but the interface has to exist
> =A0 =A0internally anyways and I could see how other code would
> =A0 =A0find a v* variant of panic useful.
>
> =A0 =A0Originally based on a suggestion by H. Peter Anvin.
> =A0 =A0Signed-off-by: Andi Kleen <ak@linux.intel.com>
>
> ---
> =A0include/linux/kernel.h | =A0 11 +++++++++++
> =A0kernel/panic.c =A0 =A0 =A0 =A0 | =A0 41 ++++++++++++++++++++++++++++++=
+----------
> =A02 files changed, 42 insertions(+), 10 deletions(-)
>
> Index: linux-2.6.slim_kdump/include/linux/kernel.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.slim_kdump.orig/include/linux/kernel.h
> +++ linux-2.6.slim_kdump/include/linux/kernel.h
> @@ -175,10 +175,21 @@ static inline void might_fault(void)
> =A0}
> =A0#endif
>
> +enum panic_flags {
> + =A0 =A0 =A0 PANIC_NO_KEXEC =A0 =A0 =3D (1 << 0),
> + =A0 =A0 =A0 PANIC_NO_BACKTRACE =3D (1 << 1),
> +};
> +
> =A0extern struct atomic_notifier_head panic_notifier_list;
> =A0extern long (*panic_blink)(int state);
> =A0NORET_TYPE void panic(const char * fmt, ...)
> =A0 =A0 =A0 =A0__attribute__ ((NORET_AND format (printf, 1, 2))) __cold;
> +NORET_TYPE void xpanic(enum panic_flags flags, int timeout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *fmt, ...)
> + =A0 =A0 =A0 __attribute__ ((NORET_AND format (printf, 3, 4))) __cold;
> +NORET_TYPE void vpanic(enum panic_flags flags, int timeout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0va_list ap) __noreturn __col=
d;
> =A0extern void oops_enter(void);
> =A0extern void oops_exit(void);
> =A0void print_oops_end_marker(void);
> Index: linux-2.6.slim_kdump/kernel/panic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.slim_kdump.orig/kernel/panic.c
> +++ linux-2.6.slim_kdump/kernel/panic.c
> @@ -57,14 +57,37 @@ EXPORT_SYMBOL(panic_blink);
> =A0*
> =A0* =A0 =A0 This function never returns.
> =A0*/
> -NORET_TYPE void panic(const char * fmt, ...)
> +NORET_TYPE void panic(const char *fmt, ...)
> +{
> + =A0 =A0 =A0 va_list ap;
> + =A0 =A0 =A0 va_start(ap, fmt);
> + =A0 =A0 =A0 vpanic(0, 0, fmt, ap);
> +}
> +EXPORT_SYMBOL(panic);
> +
> +NORET_TYPE void xpanic(enum panic_flags flags, int timeout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *fmt, ...)
> +{
> + =A0 =A0 =A0 va_list ap;
> + =A0 =A0 =A0 va_start(ap, fmt);
> + =A0 =A0 =A0 xpanic(flags, timeout, fmt, ap);

Why are you calling xpanic() here again?
I guess you meant vpanic().

> +}
> +EXPORT_SYMBOL(xpanic);
> +
> +NORET_TYPE void vpanic(enum panic_flags flags, int timeout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char * fmt, va_list ar=
gs)
> =A0{
> =A0 =A0 =A0 =A0static char buf[1024];
> - =A0 =A0 =A0 va_list args;
> =A0 =A0 =A0 =A0long i, i_next =3D 0;
> =A0 =A0 =A0 =A0int state =3D 0;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Let user always override panic_timeout.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (panic_timeout > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D panic_timeout;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * It's possible to come here directly from a panic-assert=
ion and
> =A0 =A0 =A0 =A0 * not have preempt disabled. Some functions called from h=
ere want
> =A0 =A0 =A0 =A0 * preempt to be disabled. No point enabling it later thou=
gh...
> @@ -73,12 +96,11 @@ NORET_TYPE void panic(const char * fmt,
>
> =A0 =A0 =A0 =A0console_verbose();
> =A0 =A0 =A0 =A0bust_spinlocks(1);
> - =A0 =A0 =A0 va_start(args, fmt);
> =A0 =A0 =A0 =A0vsnprintf(buf, sizeof(buf), fmt, args);
> - =A0 =A0 =A0 va_end(args);
> =A0 =A0 =A0 =A0printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
> =A0#ifdef CONFIG_DEBUG_BUGVERBOSE
> - =A0 =A0 =A0 dump_stack();
> + =A0 =A0 =A0 if (!(flags & PANIC_NO_BACKTRACE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dump_stack();
> =A0#endif
>
> =A0 =A0 =A0 =A0/*
> @@ -86,7 +108,8 @@ NORET_TYPE void panic(const char * fmt,
> =A0 =A0 =A0 =A0 * everything else.
> =A0 =A0 =A0 =A0 * Do we want to call this before we try to display a mess=
age?
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 crash_kexec(NULL);
> + =A0 =A0 =A0 if (!(flags & PANIC_NO_KEXEC))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crash_kexec(NULL);
>
> =A0 =A0 =A0 =A0kmsg_dump(KMSG_DUMP_PANIC);
>
> @@ -104,7 +127,7 @@ NORET_TYPE void panic(const char * fmt,
> =A0 =A0 =A0 =A0if (!panic_blink)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0panic_blink =3D no_blink;
>
> - =A0 =A0 =A0 if (panic_timeout > 0) {
> + =A0 =A0 =A0 if (timeout > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Delay timeout seconds before rebooting =
the machine.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We can't use the "normal" timers since =
we just panicked.
> @@ -152,9 +175,7 @@ NORET_TYPE void panic(const char * fmt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(PANIC_TIMER_STEP);
> =A0 =A0 =A0 =A0}
> =A0}
> -
> -EXPORT_SYMBOL(panic);
> -
> +EXPORT_SYMBOL(vpanic);
>
> =A0struct tnt {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0bit;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

-- =

Thanks,
//richard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
