Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1emOgX-0001QK-NL
 for kexec@lists.infradead.org; Thu, 15 Feb 2018 18:55:16 +0000
Received: by mail-qt0-x242.google.com with SMTP id d14so925775qtg.1
 for <kexec@lists.infradead.org>; Thu, 15 Feb 2018 10:54:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215114419.12705-1-gi-oh.kim@profitbricks.com>
References: <20180215114419.12705-1-gi-oh.kim@profitbricks.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Fri, 16 Feb 2018 00:24:56 +0530
Message-ID: <CAFTCetTT4h7k7gtbm_T41qrg=Sr98ubknPdCnpcS6=opC57fkg@mail.gmail.com>
Subject: Re: [PATCH] add description for jumping back to the original kernel
 in man page
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
To: Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

Hi,

Some nitpicks inline..

On Thu, Feb 15, 2018 at 5:14 PM, Gioh Kim <gi-oh.kim@profitbricks.com> wrote:
> "--load-preserve-context", "--load-jump-back-helper" and "--entry"
> options are described separately but there is not any description
> how to use them.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> ---
>  kexec/kexec.8 | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index e0131b4..b7ac028 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -30,6 +30,9 @@ when configuring the kernel. The
>  option enables the
>  .B kexec
>  system call.
> +After booting into another kernel, you can jump back to the first kernel with enabling

I would suggest using the already prevalent naming conventions - primary kernel
and secondary kernel for the two kernels.

> +.B CONFIG_KEXEC_JUMP
> +option (x86 only).

I think this is also supported on sh architecture, so may be you can
reword this to something like:
(currently only x86 and sh architectures are supported).

>  .SH USAGE
>  Using
>  .B kexec
> @@ -102,6 +105,30 @@ command:
>  .BR kexec \ \-e
>  .RE
>
> +After booting the kernel, you can jump back to the first kernel if you enable
> +.B CONFIG_KEXEC_JUMP
> +kernel option and specify \-\-load\-preserve\-context option.

Do we need to repeat the details of CONFIG_KEXEC_JUMP here and below,
as we have already the captured the same above.

> +You can see

                     ^^^ specify (instead of see)

> +.BR "kexec_jump_back_entry=<address>"
> +kernel parameter in /proc/cmdline file, for example:
> +
> +.RS
> +.BR "kexec_jump_back_entry=0x00000000000810d2"

Better to specify literal addr instead of specifying a value here.

> +.RE
> +
> +Frist you need to prepare jump with \-\-load\-jump\-back\-helper and \-\-entry options.

     ^^^ First (rather than Frist)

> +
> +.RS
> +.B kexec
> +.RB \-\-load\-jump\-back\-helper \-\-entry=0x810d2

Better to use literal addr instead of specifying a particular value
here, to keep the man page generic.

Regards,
Bhupesh

> +.RE
> +
> +Then the first kernel can be rebooted using the command:
> +
> +.RS
> +.BR kexec \ \-e
> +.RE
> +
>  .SH OPTIONS
>  .TP
>  .B \-d\ (\-\-debug)
> @@ -173,6 +200,9 @@ Specify the jump back address. (0 means it's not jump back or preserve context)
>  .TP
>  .BI \-\-load\-preserve\-context
>  Load the new kernel and preserve context of current kernel during kexec.
> +(kexec returns error if
> +.B CONFIG_KEXEC_JUMP
> +is not enabled)
>  .TP
>  .BI \-\-load\-jump\-back\-helper
>  Load a helper image to jump back to original kernel.
> --
> 2.14.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
