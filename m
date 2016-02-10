Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x242.google.com ([2a00:1450:4010:c04::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTaVx-0002JB-7M
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 19:33:26 +0000
Received: by mail-lb0-x242.google.com with SMTP id dx9so1291635lbc.2
 for <kexec@lists.infradead.org>; Wed, 10 Feb 2016 11:33:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 21:33:03 +0200
Message-ID: <CACE9dm_knTPnEfw8RXzFux50gJqaECFfGeTDaeLxWuc5KNqvxQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/22] ima: refactor ima_policy_show() to display
 "ima_hooks" rules
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Define and call a function to display the "ima_hooks" rules.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

> ---
>  security/integrity/ima/ima_policy.c | 63 +++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0e18cc..43b6425 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -903,6 +903,40 @@ void ima_policy_stop(struct seq_file *m, void *v)
>  #define mt(token)      mask_tokens[token]
>  #define ft(token)      func_tokens[token]
>
> +/*
> + * policy_func_show - display the ima_hooks policy rule
> + */
> +static void policy_func_show(struct seq_file *m, enum ima_hooks func)
> +{
> +       char tbuf[64] = {0,};
> +
> +       switch (func) {
> +       case FILE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_file));
> +               break;
> +       case MMAP_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_mmap));
> +               break;
> +       case BPRM_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_bprm));
> +               break;
> +       case MODULE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_module));
> +               break;
> +       case FIRMWARE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_firmware));
> +               break;
> +       case POST_SETATTR:
> +               seq_printf(m, pt(Opt_func), ft(func_post));
> +               break;
> +       default:
> +               snprintf(tbuf, sizeof(tbuf), "%d", func);
> +               seq_printf(m, pt(Opt_func), tbuf);
> +               break;
> +       }
> +       seq_puts(m, " ");
> +}
> +
>  int ima_policy_show(struct seq_file *m, void *v)
>  {
>         struct ima_rule_entry *entry = v;
> @@ -924,33 +958,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>
>         seq_puts(m, " ");
>
> -       if (entry->flags & IMA_FUNC) {
> -               switch (entry->func) {
> -               case FILE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_file));
> -                       break;
> -               case MMAP_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_mmap));
> -                       break;
> -               case BPRM_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_bprm));
> -                       break;
> -               case MODULE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_module));
> -                       break;
> -               case FIRMWARE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_firmware));
> -                       break;
> -               case POST_SETATTR:
> -                       seq_printf(m, pt(Opt_func), ft(func_post));
> -                       break;
> -               default:
> -                       snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
> -                       seq_printf(m, pt(Opt_func), tbuf);
> -                       break;
> -               }
> -               seq_puts(m, " ");
> -       }
> +       if (entry->flags & IMA_FUNC)
> +               policy_func_show(m, entry->func);
>
>         if (entry->flags & IMA_MASK) {
>                 if (entry->mask & MAY_EXEC)
> --
> 2.1.0
>



-- 
Thanks,
Dmitry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
