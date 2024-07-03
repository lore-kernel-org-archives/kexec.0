Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D30FC2BD09
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q33zSC05Bq3/bcJSlLiWt0eskl3mJVs7ffTxfhqSdnY=; b=F+kCV2FWFpLh5L
	enrzWArijnPfQ40YcGurjq7Nd1KqNn8nDIUmoY5lb8VtyWBqNIbmheLA6bXrlcxXeZuMX7q0r934j
	kw/ga+7vWYsXGdYHQYLCOca/FdVFWVTejSGgCnIn0CgHb35/J6TVBmEO8I7x6sSjdHrZhDzpRSQKc
	U+D4Q+OG8AYTWVMEbZ9M5tjToLtgiryLIAp59HjdPjX85ZGEAyS9vilSBYD6nrF0DKDonG0xlnX6e
	RJHQM9BuLyIp7STjCUeSLx1tbPvL4LE65BfpxcFwRiB/HB7kfYJnzVGdP5taSdwccEDLu8kXSyALI
	hE2nzJQ9GmyiiSHjJn3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOy63-0000000A0Np-0Oxi;
	Wed, 03 Jul 2024 11:24:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOy60-0000000A0N3-1EdF
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 11:24:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720005859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAx6z8ybWrEwqnsWBtSXMT7hJzeMqbo9bpTukbVaXq0=;
	b=O60MA0eb4VLk2Lv3Z1SStRJ5rY6g0G62biELLSYhAB+2aLn6lRqIx4aHwNRr58Jdn8qJh5
	8+iv4ZrtrtzVCpo99OdoxpqhvAJP63xXKwlzAjAi1BtkoZWvkES90Esa5UkgK9w42x+kk8
	stKXMVVqYUG9ZjrwoE6+wfON7FNU7Ro=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-sOVFyv-tP8-A3NRl9WGXyA-1; Wed,
 03 Jul 2024 07:24:17 -0400
X-MC-Unique: sOVFyv-tP8-A3NRl9WGXyA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4611955F77;
	Wed,  3 Jul 2024 11:24:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF4BD1955F21;
	Wed,  3 Jul 2024 11:24:13 +0000 (UTC)
Date: Wed, 3 Jul 2024 19:24:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] crash: Remove duplicate included header
Message-ID: <ZoU02QtQZ46pmE9/@MiWiFi-R3L-srv>
References: <20240703093517.730559-2-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240703093517.730559-2-thorsten.blum@toblux.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_042420_434949_C2141ED7 
X-CRM114-Status: GOOD (  12.36  )
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

Hi,

On 07/03/24 at 11:35am, Thorsten Blum wrote:
> Remove duplicate included header file linux/kexec.h
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for catching this, while,

It has been fixed by below patch in next tree:

commit 5eb1911a8c63f0e10a5f746f52fcc3c9bbfbc710
Author: Wenchao Hao <haowenchao22@gmail.com>
Date:   Thu Jun 6 17:14:27 2024 +0800

    crash: remove header files which are included more than once

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
> 2.45.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
