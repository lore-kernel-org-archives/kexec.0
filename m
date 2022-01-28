From: Marco Elver <elver@google.com>
Date: Fri, 28 Jan 2022 12:52:10 +0100
Subject: [PATCH 4/5] sched: unset panic_on_warn before calling panic()
In-Reply-To: <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 28 Jan 2022 at 12:42, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> As done in the full WARN() handler, panic_on_warn needs to be cleared
> before calling panic() to avoid recursive panics.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/sched/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 848eaa0..f5b0886 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5524,8 +5524,17 @@ static noinline void __schedule_bug(struct task_struct *prev)
>                 pr_err("Preemption disabled at:");
>                 print_ip_sym(KERN_ERR, preempt_disable_ip);
>         }
> -       if (panic_on_warn)
> +
> +       if (panic_on_warn) {
> +               /*
> +                * This thread may hit another WARN() in the panic path.
> +                * Resetting this prevents additional WARN() from panicking the
> +                * system on this thread.  Other threads are blocked by the
> +                * panic_mutex in panic().
> +                */
> +               panic_on_warn = 0;
>                 panic("scheduling while atomic\n");

I agree this is worth fixing.

But: Why can't the "panic_on_warn = 0" just be moved inside panic(),
instead of copy-pasting this all over the place?

I may be missing something obvious why this hasn't been done before...

Thanks,
-- Marco

