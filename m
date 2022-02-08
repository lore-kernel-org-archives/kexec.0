From: Marco Elver <elver@google.com>
Date: Tue, 8 Feb 2022 14:39:05 +0100
Subject: [PATCH v2 4/5] ubsan: no need to unset panic_on_warn in
 ubsan_epilogue()
In-Reply-To: <1644324666-15947-5-git-send-email-yangtiezhu@loongson.cn>
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
 <1644324666-15947-5-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <CANpmjNOFL1vTZS28z_DWSz+X64_ghXBiGj3Fhee=wpRexZy7kA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, 8 Feb 2022 at 13:51, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> panic_on_warn is unset inside panic(), so no need to unset it
> before calling panic() in ubsan_epilogue().
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/ubsan.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index bdc380f..36bd75e 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -154,16 +154,8 @@ static void ubsan_epilogue(void)
>
>         current->in_ubsan--;
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
>  }
>
>  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1644324666-15947-5-git-send-email-yangtiezhu%40loongson.cn.

