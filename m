Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F0CA0ED2
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=anlyKdScANYAaS+6iezKfw7kiuIQQH92wE60qiTdXSw=; b=nK+bjFur5N7LOL
	M687pBU9A97Gp6GQbVGum9GDOtD9jLqK1Dtfjjp/r5b0XUhD2c/9qQF7/WcbM+n2dTvVLf/ojzq6J
	z+mSwYHQHbJaHGaoJVnSwtxNnUWt7gibv7sJK0Min8/VhFb65xj9J89zLgB4wk/oIeaLODo4XzFBB
	8z7jBm9YG29pWMy81rWw5lecSsz8KWjX/VEVEkkMK3pgsEt665u0aJHluRdtCZ2Bpn9W6bSU2D2gv
	XzPqd9LnKSIxDu4H4+tnfrxsg9fNKfuDWgLVicRgQthMMGRCg7WxmS7YfvqOUpgaluXxfOOj+ecd4
	T5HNERSQkF7zsG0wkkhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjs7d-00000004UHg-2Gvn;
	Fri, 30 Aug 2024 03:16:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjs7K-00000004UDI-2kD2
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 03:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724987765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y16gZ5ll9x+ZZRQurc1f4Q2jGpW469PmPcdJZo7k8I=;
	b=Bkm+kCp1nF/aynI+HfPIbF2tL5QkvM4rpWGtm+MfdPiSarZKfvR/9HBufxLPrCf5tjGqhm
	rcH2xzHbh0gJhA4/PmCMh7V9vHkWtgqmHoGLgqF+z2ARk3MNvdE+MPZxq3yTVn3+Akn/bL
	iXywMoh8yuWcd1udvxo9zBHRY7mNn+c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-E_cgXM_TMY2lLDSNHnmYZA-1; Thu,
 29 Aug 2024 23:16:01 -0400
X-MC-Unique: E_cgXM_TMY2lLDSNHnmYZA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E21241955D55;
	Fri, 30 Aug 2024 03:15:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3149E1955F1B;
	Fri, 30 Aug 2024 03:15:55 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:15:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_201606_783398_8826510B 
X-CRM114-Status: GOOD (  10.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 08/23/24 at 08:51am, Dave Vasilevsky wrote:
......snip..
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 1aa3c4a0c5b2..b04cfa23378c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -549,6 +549,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool BROKEN_ON_SMP
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool n

If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
CRASH_DUMP will be off by default according to the below new definition
of CRASH_DUMP?

Thanks
Baoquan

> +
>  config ARCH_SUPPORTS_KEXEC_JUMP
>  	def_bool y
>  
......  
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..4d111f871951 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
> -	default y
> +	default ARCH_DEFAULT_CRASH_DUMP
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
>  	depends on KEXEC_CORE
>  	select VMCORE_INFO
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
