Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD253C47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UeWWvcCIct3Z3ZwJgCOeT3FENONwXDOxsDbPP1Dw9Ec=; b=w+94UuoFvjM3lj
	tn/zC4Z/EEmT45IPlxHnYkBmcX30ZVqwIv0hJtqLqSbI6brCnEkkdT+XcMeMPfEA+y6h5xh15Ck7s
	2g3+nZ/lERcGzbShsN/caHSqBkzECXDeHRjMAZi/SuoDnGF+JX5/TT3vqcBlkECXaBb9dIFBPmCOZ
	sdYpKwFd2NcMK5GNUN5iYwt54kDre19FMIYY7nY/RnMIRE5MNlswCCLP3X0SS6ewAOFQ6tOyRpqVM
	Ngj5kzTWWSiNnbK8Q8wC1NBLSIs/vgi89VDQH7ReA29dbbETMrRRSR9iE9Y+YgCOJp7Cl5eSXAw9S
	w9f9AzEohZiYFX9iJtfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8Oz-00000002yUv-3mHh;
	Wed, 31 Jan 2024 11:05:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8Oy-00000002yT8-0Ebv
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 11:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706699105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw3sl0jqj8awhANe163t1OW0xmGJw01n53nAhDpRKqA=;
	b=CCZat1NhsOgbsu+D9a6q8EbuIXK1WMlOrqFfWFUXzAb5IL048GFWPIwfN24krbNB00FN9r
	mGKjAWjE9pdKRSE7lJ47pXlUuD7jwu8s3+Vvu2vBUl4q3f+QIPByNeTjrrZFfcgnJ2/ise
	gEoKOXF+4n66aru9NLtt31rHPz6INJU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-UmiA1SszPACK2lqhE7x0PA-1; Wed, 31 Jan 2024 06:05:02 -0500
X-MC-Unique: UmiA1SszPACK2lqhE7x0PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E81A18C46C1;
	Wed, 31 Jan 2024 11:05:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3904F2026D66;
	Wed, 31 Jan 2024 11:05:00 +0000 (UTC)
Date: Wed, 31 Jan 2024 19:04:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, coxu@redhat.com
Subject: Re: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Message-ID: <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
References: <20240131100508.2013016-1-slyich@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240131100508.2013016-1-slyich@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_030508_193569_37440664 
X-CRM114-Status: GOOD (  16.07  )
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

On 01/31/24 at 10:05am, Sergei Trofimovich wrote:
> `binutils-2.42` introduced stricter checks on what `.arch` can be used
> in 64-bit mode and started failing the build as:
> 
>     $ as-2.42 --64 -o entry32-16-debug.o entry32-16-debug.s
>     purgatory/arch/i386/entry32-16-debug.S: Assembler messages:
>     purgatory/arch/i386/entry32-16-debug.S:28: Error: 64bit mode not supported on `i386'.
> 
> The change moves `.code32` before `.arch 386` as suggested in
> https://sourceware.org/PR31319

I am not familiar with the gas behaviour, the fix sounds good from
discussion in above link.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> ---
>  purgatory/arch/i386/entry32-16-debug.S | 2 +-
>  purgatory/arch/i386/entry32-16.S       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
> index 5167944..297d6f5 100644
> --- a/purgatory/arch/i386/entry32-16-debug.S
> +++ b/purgatory/arch/i386/entry32-16-debug.S
> @@ -25,10 +25,10 @@
>  	.globl entry16_debug_pre32
>  	.globl entry16_debug_first32
>  	.globl entry16_debug_old_first32
> +	.code32
>  	.arch i386
>  	.balign 16
>  entry16_debug:
> -	.code32
>  	/* Compute where I am running at (assumes esp valid) */
>  	call	1f
>  1:	popl	%ebx
> diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
> index c051aab..7a84565 100644
> --- a/purgatory/arch/i386/entry32-16.S
> +++ b/purgatory/arch/i386/entry32-16.S
> @@ -20,10 +20,10 @@
>  #undef i386	
>  	.text
>  	.globl entry16, entry16_regs
> +	.code32
>  	.arch i386
>  	.balign 16
>  entry16:
> -	.code32
>  	/* Compute where I am running at (assumes esp valid) */
>  	call	1f
>  1:	popl	%ebx
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
