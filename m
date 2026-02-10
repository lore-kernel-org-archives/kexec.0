Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8833E94627
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nrld4QUPFG908ozuxCRcRQrQXDKpD/pbHu8Ax6np3ME=; b=1MvU5AePlb1zwgda7ql2+S5fhy
	bQmzDOyfbhmsh1JJf59XJJ5hzrs9QAFAOtZLrDODhMFqhyGD2aX3SLb+SxGU4vUS/UnTVvIH1e9DH
	fRQQ8QPN3ASErJjffTuQZ6rTDD82R4AuG3PU27j2A1Yd/OKlTdcBXD7fJYH4NjJEeOGwej2jYux/Y
	sYU+EgQVv6rFzf5YuASWwdjFQdSXcMOK+U5v2Y13koubBUn/g0rbbpPyr3x4QEPAUxuKrolpcOmAH
	5VKRSe4fS+gQlqzoyc1c5ehR4AycNhyyeQMppWwBO/sMqcel/7Rp7zK39uA6mwVqdPj0WKnQlSm4s
	YBBMs8Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpdPa-0000000GKJF-2DS1;
	Tue, 10 Feb 2026 02:23:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpdPS-0000000GKIY-1ROC
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 02:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770690203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrld4QUPFG908ozuxCRcRQrQXDKpD/pbHu8Ax6np3ME=;
	b=e0Y1XUIsaNrpsoSj3iLrhbR2zKsG3Q86okyLB0G/LisWdjct2hqjeGRqSerRigKhYegcup
	mowD4O6xTriEsQrajgb7rHQKkJskkkVPW3Pk47vLsTjR8i+WUlVna4VnyIOZf8ifqjeZDP
	ZrLDX/MsMSSid5P0YnVVipsLSvQ8sE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-NzdXD7atM0y6A-MYsrfvaA-1; Mon,
 09 Feb 2026 21:23:17 -0500
X-MC-Unique: NzdXD7atM0y6A-MYsrfvaA-1
X-Mimecast-MFC-AGG-ID: NzdXD7atM0y6A-MYsrfvaA_1770690196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353121955DD3;
	Tue, 10 Feb 2026 02:23:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AC7C1800464;
	Tue, 10 Feb 2026 02:23:13 +0000 (UTC)
Date: Tue, 10 Feb 2026 10:23:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org
Subject: Re: [RESEND PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
Message-ID: <aYqWhWQO265YRnPP@fedora>
References: <20260209133308.118364-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260209133308.118364-1-egorenar@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 6ftwAUzzqSefSiCnV4UtcGR-G-wgYhDtislh_y5WOFA_1770690196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_182326_460905_43702277 
X-CRM114-Status: GOOD (  23.78  )
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

On 02/09/26 at 02:33pm, Alexander Egorenkov wrote:
> The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
> the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
> in s390 kernels built with MODULES=n if nothing else selects
> MODULE_SIG_FORMAT.
> 
> Furthermore, the signature verification in s390 kexec does not require
> MODULE_SIG_FORMAT because it requires only the struct module_signature and,
> therefore, does not depend on code in kernel/module_signature.c.
> 
> But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
> is also incorrect because it makes KEXEC_SIG available on s390 only
> if some other arbitrary option (for instance a file system or device driver)
> selects it directly or indirectly.
> 
> To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
> as well as MODULES=n _and_ also not depend on arbitrary options selecting
> SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
> select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.

Thanks for fixing the issue.

Seems the background and change is a little twisting, and selecting
SYSTEM_DATA_VERIFICATION will cause a bunch of verification feature
selected. While the change is only s390 related, request s390 expert to
have look at this change. If no concern from s390 developer, I am also
fine to it.

Thanks
Baoquan
> 
> Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  arch/s390/Kconfig    | 2 +-
>  kernel/Kconfig.kexec | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c2c7bf974397..385c1052cf45 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -313,7 +313,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>  	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
> -	def_bool MODULE_SIG_FORMAT
> +	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool y
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..df97227cfca9 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -50,6 +50,7 @@ config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on ARCH_SUPPORTS_KEXEC_SIG
>  	depends on KEXEC_FILE
> +	select SYSTEM_DATA_VERIFICATION if S390
>  	help
>  	  This option makes the kexec_file_load() syscall check for a valid
>  	  signature of the kernel image. The image can still be loaded without
> -- 
> 2.51.0
> 


