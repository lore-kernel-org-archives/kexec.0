Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lan.nucleusys.com ([92.247.61.126] helo=zztop.nucleusys.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aSVXS-0004RR-15
 for kexec@lists.infradead.org; Sun, 07 Feb 2016 20:02:30 +0000
Date: Sun, 7 Feb 2016 22:02:47 +0200
From: Petko Manolov <petkan@mip-labs.com>
Subject: Re: [PATCH v3 22/22] ima: require signed IMA policy
Message-ID: <20160207200246.GI17321@localhost>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-23-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1454526390-19792-23-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On 16-02-03 14:06:30, Mimi Zohar wrote:
> Require the IMA policy to be signed when additional rules can be added.
> 
> v1:
> - initialize the policy flag
> - include IMA_APPRAISE_POLICY in the policy flag
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Petko Manolov <petkan@mip-labs.com>

> ---
>  security/integrity/ima/ima_policy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 39a811a..ba0f6dc 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -129,6 +129,10 @@ static struct ima_rule_entry default_appraise_rules[] = {
>  	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> +#ifdef CONFIG_IMA_WRITE_POLICY
> +	{.action = APPRAISE, .func = POLICY_CHECK,
> +	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
> +#endif
>  #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
>  	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .flags = IMA_FOWNER},
>  #else
> @@ -412,9 +416,12 @@ void __init ima_init_policy(void)
>  	for (i = 0; i < appraise_entries; i++) {
>  		list_add_tail(&default_appraise_rules[i].list,
>  			      &ima_default_rules);
> +		if (default_appraise_rules[i].func == POLICY_CHECK)
> +			temp_ima_appraise |= IMA_APPRAISE_POLICY;
>  	}
>  
>  	ima_rules = &ima_default_rules;
> +	ima_update_policy_flag();
>  }
>  
>  /* Make sure we have a valid policy, at least containing some rules. */
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
