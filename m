Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22344C10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 03:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RO7h0UiZoc3/FYHnJVZsqI0y00V0sqo16Ds3ewqahaQ=; b=u7HYb74/zWHEij
	wUoWMyDckvRANpq1FjS2HIFyfMnP/6sQEjYvjCRqmqWyxnXnqZ+hK1DWnO9Lxt5RdyZUiBXjfBX2O
	E9eA9iJT4aDO8h9aBnU6xReX/J2kQfF88Azq3ajkbsJ0eH/ycG7a4XMWTBsQTgw+uZaN07ZIfbtnu
	LW8poE7XcLmB+VxW2Da85lRCvVanxbWhD/K/ppPXSqbEOEDZifNDtv56wetW2SLdTJd7QNuvkGpIs
	aYRwu2vYkgJ8nz2sF64PXpVuF9lw0yEyc5UWatYn1AuNqQWcW6Ohr3ceeBbGZtJ8ervS8r4ShrVbC
	XiKcSNnNFuLmJu21aihg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4uqH-00000000F7Y-2H6Y;
	Thu, 09 May 2024 03:53:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4uqE-00000000F5a-0bHc
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 03:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715226785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCcmKp6zmQN78GXbnv+RsBfflPl7otSTmRS2SgT3gkA=;
	b=Soah4PO8i390gOpRXL69KObMYETstGC+xmJzrgO2w+RKMwKqNAE+GpeWUaHeuYgxSkGNGv
	FwWtC4IJjLlGauaws5wfrfh3aOSJvbuIiUWUB6zyQJ16VCE/G1eN286bL8y3EmQLeNena7
	lRpyq9NMisba9qb3LswHDwXm11QGrfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-W7pSZSILNT2NU-yL1iRcpg-1; Wed, 08 May 2024 23:53:02 -0400
X-MC-Unique: W7pSZSILNT2NU-yL1iRcpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00FEC800053;
	Thu,  9 May 2024 03:53:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EBE1005B83;
	Thu,  9 May 2024 03:52:59 +0000 (UTC)
Date: Thu, 9 May 2024 11:52:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Rik van Riel <riel@surriel.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
Message-ID: <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
References: <20240507091858.36ff767f@imladris.surriel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240507091858.36ff767f@imladris.surriel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_205310_280957_8B0A5B29 
X-CRM114-Status: GOOD (  19.78  )
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

On 05/07/24 at 09:18am, Rik van Riel wrote:
> While taking a kernel core dump with makedumpfile on a larger system,
> softlockup messages often appear.
> 
> While softlockup warnings can be harmless, they can also interfere
> with things like RCU freeing memory, which can be problematic when
> the kdump kexec image is configured with as little memory as possible.
> 
> Avoid the softlockup, and give things like work items and RCU a
> chance to do their thing during __read_vmcore by adding a cond_resched.

Thanks for fixing this.

By the way, is it easy to reproduce? And should we add some trace of the
softlockup into log so that people can search for it and confirm when
encountering it?

Thanks
Baoquan

> ---
>  fs/proc/vmcore.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..d06607a1f137 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -383,6 +383,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
>  		/* leave now if filled buffer already */
>  		if (!iov_iter_count(iter))
>  			return acc;
> +
> +		cond_resched();
>  	}
>  
>  	list_for_each_entry(m, &vmcore_list, list) {
> -- 
> 2.42.0
> 
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
