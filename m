Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x243.google.com ([2a00:1450:4010:c04::243])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTbJN-00027e-4W
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 20:24:29 +0000
Received: by mail-lb0-x243.google.com with SMTP id dx9so1348346lbc.2
 for <kexec@lists.infradead.org>; Wed, 10 Feb 2016 12:24:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-23-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-23-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 22:24:07 +0200
Message-ID: <CACE9dm8bTZdiNEKK9NLv9+27nekBjKvfoG-uYBKmSoArL2X81A@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] ima: require signed IMA policy
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
> Require the IMA policy to be signed when additional rules can be added.
>
> v1:
> - initialize the policy flag
> - include IMA_APPRAISE_POLICY in the policy flag
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

> ---
>  security/integrity/ima/ima_policy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 39a811a..ba0f6dc 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -129,6 +129,10 @@ static struct ima_rule_entry default_appraise_rules[] = {
>         {.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
>         {.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
>         {.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> +#ifdef CONFIG_IMA_WRITE_POLICY
> +       {.action = APPRAISE, .func = POLICY_CHECK,
> +       .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
> +#endif
>  #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
>         {.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .flags = IMA_FOWNER},
>  #else
> @@ -412,9 +416,12 @@ void __init ima_init_policy(void)
>         for (i = 0; i < appraise_entries; i++) {
>                 list_add_tail(&default_appraise_rules[i].list,
>                               &ima_default_rules);
> +               if (default_appraise_rules[i].func == POLICY_CHECK)
> +                       temp_ima_appraise |= IMA_APPRAISE_POLICY;
>         }
>
>         ima_rules = &ima_default_rules;
> +       ima_update_policy_flag();
>  }
>
>  /* Make sure we have a valid policy, at least containing some rules. */
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
