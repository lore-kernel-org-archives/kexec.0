From: Marco Elver <elver@google.com>
Date: Tue, 8 Feb 2022 14:38:22 +0100
Subject: [PATCH v2 3/5] panic: unset panic_on_warn inside panic()
In-Reply-To: <1644324666-15947-4-git-send-email-yangtiezhu@loongson.cn>
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
 <1644324666-15947-4-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <CANpmjNOySkeK6u-JieNBQ4DmAO3LogdZ6gXv1Noz8jUOi3ThDA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, 8 Feb 2022 at 13:51, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In the current code, the following three places need to unset
> panic_on_warn before calling panic() to avoid recursive panics:
>
> kernel/kcsan/report.c: print_report()
> kernel/sched/core.c: __schedule_bug()
> mm/kfence/report.c: kfence_report_error()
>
> In order to avoid copy-pasting "panic_on_warn = 0" all over the
> places, it is better to move it inside panic() and then remove
> it from the other places.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  kernel/panic.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 55b50e0..95ba825 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -185,6 +185,16 @@ void panic(const char *fmt, ...)
>         int old_cpu, this_cpu;
>         bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>
> +       if (panic_on_warn) {
> +               /*
> +                * This thread may hit another WARN() in the panic path.

Alas, this may actually fix another problem: doing a panic() not from
a WARN(), but then hitting a WARN() along in the panic path. So
"another WARN" is irrelevant, just "a WARN" would be enough to break
things.

> +                * Resetting this prevents additional WARN() from panicking the
> +                * system on this thread.  Other threads are blocked by the
> +                * panic_mutex in panic().
> +                */
> +               panic_on_warn = 0;
> +       }
> +
>         /*
>          * Disable local interrupts. This will prevent panic_smp_self_stop
>          * from deadlocking the first cpu that invokes the panic, since
> @@ -576,16 +586,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>         if (regs)
>                 show_regs(regs);
>
> -       if (panic_on_warn) {
> -               /*
> -                * This thread may hit another WARN() in the panic path.
> -                * Resetting this prevents additional WARN() from panicking the
> -                * system on this thread.  Other threads are blocked by the
> -                * panic_mutex in panic().
> -                */
> -               panic_on_warn = 0;
> +       if (panic_on_warn)
>                 panic("panic_on_warn set ...\n");
> -       }
>
>         if (!regs)
>                 dump_stack();
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1644324666-15947-4-git-send-email-yangtiezhu%40loongson.cn.

