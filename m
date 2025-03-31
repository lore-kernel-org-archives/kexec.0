Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6246C36017
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRbl2E9KuHrsPvsucKmeR/s8QLAnJPVGduQbCvLYF7M=; b=xcw7kJs9oFs1iYQzcGDtxtyy2Z
	LoqjpKkPUobXiEeDRxzxVSCsXdChzZHPDJa3mS5W8WYxuvCiV1AZHcXNpGcJX4be1nFBz7kPPTQ8m
	U7epuwnYLxWhoNLFC4gxINZOG86kP0h1yBjHO6kiqiNfAgRMZAB9cK3Ug2S/2v9s2Hy3AeYz5fsc+
	J/ZGlTSZIMCmlrlOY1GoqTY1be6iwP9enz0lCZH43VL9feB4uyfvzzQy2fNQgJ3V+ioGL0IQGF5Ze
	sn2pMw8X0E58uXO+8uurfP3di6NZ1spjk8wFy48a91PM6+CLbF3+/VS6RJmklMdN06WBb9ZsuZM8n
	8diC53Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8Xq-0000000H648-3Juy;
	Mon, 31 Mar 2025 06:22:50 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8Xn-0000000H63n-25UG
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 06:22:49 +0000
Received: from [192.168.0.224] (ip5f5ae850.dynamic.kabel-deutschland.de [95.90.232.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9DCC861E64783;
	Mon, 31 Mar 2025 08:22:27 +0200 (CEST)
Message-ID: <42ae3379-992e-45fc-acfc-0f808ff0d406@molgen.mpg.de>
Date: Mon, 31 Mar 2025 08:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250331061611.253919-1-bhe@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250331061611.253919-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250330_232247_678193_1D05BD21 
X-CRM114-Status: GOOD (  20.84  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dear Baoquan,


Thank you for your patch. I’d add the knob name to the commit message 
summary/title, so it shows up in `git log --oneline`.

Am 31.03.25 um 08:16 schrieb Baoquan He:
> It doesn't make sense to run IMA functionality in kdump kernel, and that
> will cost extra memory. It would be great to allow IMA to be disabled on
> purpose, e.g for kdump kernel.
> 
> Hence add a knob here to allow people to disable IMA if needed.

`initcall_blacklist=…` could be used already. I prefer a dedicated 
parameter too though.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 28b8b0db6f9b..5d677d1389fe 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,11 +38,27 @@ int ima_appraise;
>   
>   int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>   static int hash_setup_done;
> +static int ima_disabled = 0;
>   
>   static struct notifier_block ima_lsm_policy_notifier = {
>   	.notifier_call = ima_lsm_policy_change,
>   };
>   
> +static int __init ima_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) == 0)
> +                ima_disabled = 1;
> +        else if (strncmp(str, "on", 2) == 0)
> +                ima_disabled = 0;
> +        else
> +                pr_err("invalid ima setup option: \"%s\" ", str);

I’d add the allowed strings.

> +
> +	return 1;
> +}
> +__setup("ima=", ima_setup);
> +
> +
> +
>   static int __init hash_setup(char *str)
>   {
>   	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>   {
>   	int error;
>   
> +	if (ima_disabled) {
> +		pr_info("IMA functionality is disabled on purpose!");

… on Linux CLI.

> +		return 0;
> +	}
> +
>   	ima_appraise_parse_cmdline();
>   	ima_init_template_list();
>   	hash_setup(CONFIG_IMA_DEFAULT_HASH);


Kind regards,

Paul

