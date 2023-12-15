Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE08C4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uiOOf6JMYSpfh1QR5CdJ/o2QvnIjUIUaWcWxPE5vtPU=; b=zq9joTEmXRwRj6
	RBwNvOgkseO7G66JqqWUBem42dE8+r7UEclFX32UWa4tB5/m8X60dXG7jx8ygMC5U9xDDD4j0Uwst
	TkQ2pEL6PmAlgC+PkcZtnY/55bUjciG27Ywo04q5xCIlwHO3W2KnGxO3EwMQT0kPZ8yD772Kj0bfP
	iOJTNjDxl15XfCG6u1G8b04pNW8rzlMnsSIkidAePBZX6VH1MooGqOoMkVSucxcHDYnUhrbjMHmaa
	PgePCp6FQU/EkcOicNMo8pSVxj5NvQHdekXdJ7O0HEXPpMNn76rBnng75075kF/o3d2c2+RlKKg33
	EXWqG5xEGK+dbcFiwOwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4C0-002ZXR-1E;
	Fri, 15 Dec 2023 09:09:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4Bw-002ZVg-1I
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 09:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702631347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycG62I0QVkhqLqj8HTY5IOSjAnYemrRYuhWB+WN9E4k=;
	b=EhCn7G/Twsa5pX1BOsc4geNym6lkiYCU+TbLaiazaoFyOvMxnsLWfsZqmasX+pUsTXnx6U
	WYJZXF2WDqecgoI+ZvngC3owjSj4M/Jj2/OK1OKOMESvjMk3IuhEBJbpIAaCbwGWn1hAjh
	dU0qn4uPgiBPAN/hWv7iQTeNeNIBeMg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-GrfJGo9cPce8uYu9onZBYQ-1; Fri,
 15 Dec 2023 04:09:05 -0500
X-MC-Unique: GrfJGo9cPce8uYu9onZBYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E78FA1E441C7;
	Fri, 15 Dec 2023 09:09:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CF1C1121306;
	Fri, 15 Dec 2023 09:09:03 +0000 (UTC)
Date: Fri, 15 Dec 2023 17:09:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH] crash_core: remove duplicated including of kexec.h
Message-ID: <ZXwXrU8YO1FC4A+W@MiWiFi-R3L-srv>
References: <202312151654+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202312151654+0800-wangjinchao@xfusion.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_010908_506649_80457D68 
X-CRM114-Status: GOOD (  13.23  )
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

On 12/15/23 at 04:54pm, Wang Jinchao wrote:
> remove second include of linux/kexec.h

Good catch.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  kernel/crash_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..d72985222b16 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.40.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
