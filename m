Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D22C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FqoJ59sm4MkOTt+40wINCeffcgvu6QHyPqdviIT0YqY=; b=a2oeUcaJm/h/yS
	Krn/UzPbtV6WWy4SEMKKgJlraGNdPdgjo2iiLFJwgNkdrjGecNvAPjW6/VE4DFSdplzyqbaYA1AmP
	iwntn3WNyRs0pGWUpz74or+MgB3z9rQq0RRMnVgvHyHL/hMykOoWaerxCL9bIys+BzIIGBnfV8g0j
	TD2MPuGwMCym8L1CeXgTxUcos06ZyzaXbGKZdXQHZ9/ja6kn1Mk4J0t/Hq1m42RTFjgtcLtP5IbT8
	jPU5TXUgJ+gVEUHnmgmM4wcs6i0A29e1uwMUqG6313TTceu53HJ9IFsOX7vxNvqNPziDRpsGwuI7s
	10ajza7smLlDv+3D8wrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFT3e-0000000Cho2-1i50;
	Fri, 07 Jun 2024 06:26:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFT3b-0000000ChnB-1Vg9
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 06:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLp0abxWPWeq0NDH61AYo4VII9n5wY1ynbuZau1muFU=;
	b=AsB2jOEBL2GTSsPQ2u3pZRRqp8bVoMwsnlsjY94vko46MwTR/r68B/g1EN6veSspCaEXZ4
	8PrcaIW6IQPxfUCnPIka10iuzry33ro9IUATEc5y1bPxVHlg7VQMc5F0I9rUgUK3dkqSXw
	5Yt4wAqOy5ULKOQXwLQ1KX+bcfifoIk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-cLVMIi1uP1mjK4jHSN8bWQ-1; Fri,
 07 Jun 2024 02:26:27 -0400
X-MC-Unique: cLVMIi1uP1mjK4jHSN8bWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECE371953949;
	Fri,  7 Jun 2024 06:26:25 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F871955F4B;
	Fri,  7 Jun 2024 06:26:23 +0000 (UTC)
Date: Fri, 7 Jun 2024 14:26:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Wenchao Hao <haowenchao22@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Remove header files which are included more than
 once
Message-ID: <ZmKoCreQLlXdKR7V@MiWiFi-R3L-srv>
References: <20240606091427.3512314-1-haowenchao22@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606091427.3512314-1-haowenchao22@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_232635_496271_7E96B83C 
X-CRM114-Status: GOOD (  13.22  )
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

On 06/06/24 at 05:14pm, Wenchao Hao wrote:
> Following warning is reported, so remove these duplicated header
> including:
> 
> ./kernel/crash_reserve.c: linux/kexec.h is included more than once.
> 
> This is just a clean code, no logic changed.
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

I remember someone posted patch to clean this up. Anyway,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..d3b4cd12bdd1 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.38.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
