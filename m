From: d.hatayama@fujitsu.com <d.hatayama@fujitsu.com>
Date: Tue, 25 Jan 2022 11:50:35 +0000
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
Message-ID: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> @@ -146,6 +157,34 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
> 
> +static int __init panic_notifier_filter_setup(char *buf)
> +{
> +       char *func;
> +       unsigned long addr;
> +
> +       while ((func = strsep(&buf, ","))) {
> +               addr = kallsyms_lookup_name(func);
> +               if (!addr) {
> +                       pr_warn("panic_notifier_filter: invalid symbol %s\n", func);
> +                       continue;
> +               }

Could you remove this check?

panic_notifier_list is exported to kernel modules and this check
prevents such users from using this feature.

Thanks.
HATAYAMA, Daisuke

