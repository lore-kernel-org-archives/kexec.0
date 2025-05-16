Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8123C3ABC9
	for <kexec@archiver.kernel.org>; Fri, 16 May 2025 00:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L79G3bUaADCLMaIHySbV8zUHfQYcpHCcJ7lOsHDG9sI=; b=B3EQoGRT3vyZ8PPOd6xG9IeElv
	cIpB4wx63JxhiBN9tLMeT+8xuaZfa9Gef5D+dWwMA0Oo1ao8ojvb6e+7GePN53cwMrDj1+tYaUteJ
	J7CDnLWguxl0KbYgZTKAmuipwIKD1hWpdzEhzbeh5Z1VJ6/E+ALpGE10JQ62iZV3wMi0jyWBL3BDK
	K2DqAY1b9eZ+bOnOGYQgFyG59Pa9G5f0Rv0HbSpsB2C6KS/akA5tBaxhtVMXKc7VW8H7OH04fNsMx
	PxBuFGdRD6Ukt8XwYvC7WM/wVMZOkwBpRwmw2v4S157Xr8RNcKIDciHKrzFj/Ntl91ab9NykWXIQm
	oNNKy3JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFiqa-000000027u9-2Uff;
	Fri, 16 May 2025 00:22:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFiqR-000000027qj-2oRF
	for kexec@lists.infradead.org;
	Fri, 16 May 2025 00:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747354952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L79G3bUaADCLMaIHySbV8zUHfQYcpHCcJ7lOsHDG9sI=;
	b=f+XR5A0IkDqdblgUJ21alWnfe3xl5WbXwNfrqD1J1O3EQXoPQLyZXYZHpXl1ZjikPYe4CH
	HBW4n4XkGD6lu2KkZlZocOm0ab8z346ZWHK7k1mLtZiac40i0MF9HnRM/LyFng/wqKG2j6
	z+vcbSQPBoyApF1Dn5w5UOrhcef1Bwk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-oEVTFpYuO4mDdQi3nftzwA-1; Thu,
 15 May 2025 20:22:28 -0400
X-MC-Unique: oEVTFpYuO4mDdQi3nftzwA-1
X-Mimecast-MFC-AGG-ID: oEVTFpYuO4mDdQi3nftzwA_1747354947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15B3C1800446;
	Fri, 16 May 2025 00:22:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4C9030075F7;
	Fri, 16 May 2025 00:22:18 +0000 (UTC)
Date: Fri, 16 May 2025 08:22:14 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
	pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com,
	chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515233953.14685-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_172235_794498_A2F6A8B4 
X-CRM114-Status: GOOD (  25.68  )
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

CC kexec list.

On 05/16/25 at 07:39am, Baoquan He wrote:
> Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> extra memory. It would be very helpful to allow IMA to be disabled for
> kdump kernel.
> 
> And Coiby also mentioned that for kdump kernel incorrect ima-policy loaded
> by systemd could cause kdump kernel hang, and it's possible the booting
> process may be stopped by a strict, albeit syntax-correct policy and users
> can't log into the system to fix the policy. In these cases, allowing to
> disable IMA is very helpful too for kdump kernel.
> 
> Hence add a knob ima=on|off here to allow people to disable IMA in kdump
> kenrel if needed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>  security/integrity/ima/ima_main.c             | 22 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9fd26b95b34..762fb6ddcc24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2202,6 +2202,11 @@
>  			different crypto accelerators. This option can be used
>  			to achieve best performance for particular HW.
>  
> +	ima=		[IMA] Enable or disable IMA
> +			Format: { "off" | "on" }
> +			Default: "on"
> +			Note that this is only useful for kdump kernel.
> +
>  	init=		[KNL]
>  			Format: <full_path>
>  			Run specified binary instead of /sbin/init as init
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f3e7ac513db3..07af5c6af138 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
> +#include <linux/crash_dump.h>
>  
>  #include "ima.h"
>  
> @@ -38,11 +39,27 @@ int ima_appraise;
>  
>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>  static int hash_setup_done;
> +static int ima_disabled;
>  
>  static struct notifier_block ima_lsm_policy_notifier = {
>  	.notifier_call = ima_lsm_policy_change,
>  };
>  
> +static int __init ima_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) == 0)
> +		ima_disabled = 1;
> +	else if (strncmp(str, "on", 2) == 0)
> +		ima_disabled = 0;
> +	else
> +		pr_err("Invalid ima setup option: \"%s\" , please specify ima=on|off.", str);
> +
> +	return 1;
> +}
> +__setup("ima=", ima_setup);
> +
> +
> +
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
>  {
>  	int error;
>  
> +	if (ima_disabled && is_kdump_kernel()) {
> +		pr_info("IMA functionality is disabled");
> +		return 0;
> +	}
> +
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> -- 
> 2.41.0
> 


