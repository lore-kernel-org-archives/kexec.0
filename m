Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449BC35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kzH+dS9kQHRG1BsR9Xs5cp2QsgV83RTMIG9AwL58beg=; b=mS8i+V2oJTCQY/
	66d5EL7eBzx3yCfM6z9NW98iqFIIrEjTmMIYIwKpKEuPOZUg1YPwi9NNHcQvYbga7f6nb/Gu9EiBR
	3fV8rf9DS7c+H4UM67AapXqDZUlcfSRleMZF644fSwgyYRU/IGRo0XKot/0q8/Z/+ieTwf2bGlMo/
	WQtUTcPaZ3bbDYZhMwT+ENR0/rftw2XhtTf2pHF+FiVHKjZx/zUEMVLeEQgxj9T1OU8VCcU7dQFMx
	RJTGZUZbS4kx4LQydOfS7ajBqc8IJXdJ1z0uSlRoDF2/O3g6JJqW8QhmOh7n5qTqDhf3QOV20xZk1
	t4beA4N1z3bz82gsIMgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGHRi-002b4q-0k;
	Thu, 21 Dec 2023 11:42:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGHRf-002b4G-0X
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 11:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703158949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO71qD98XeNn6o22z4de+p4+swSxefVPiivSdhVSM3Q=;
	b=NUzxyK6q8iPYgWiGZ2H/fzJQrR0VqfG/AaQK4nCNJOPZ3aPBywBg1NiCS/FlDsSaOaDPqw
	3N72xToLVzuFKarH0bmJHraFnuWbYF4DEvuTnUqZ6yRZdZr5x/egGQtewtJL1MkHkkugoa
	eblp/8qxEdR8X1/NymC4bGS19Si9Yic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-dSYlwMV3Mn6BjRBhtZiqkg-1; Thu, 21 Dec 2023 06:42:26 -0500
X-MC-Unique: dSYlwMV3Mn6BjRBhtZiqkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB2285A588;
	Thu, 21 Dec 2023 11:42:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38E5F51D5;
	Thu, 21 Dec 2023 11:42:24 +0000 (UTC)
Date: Thu, 21 Dec 2023 19:42:21 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kexec: Fix potential out of bounds in
 crash_exclude_mem_range()
Message-ID: <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-3-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231220055733.100325-3-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_034231_272257_0B55C4F8 
X-CRM114-Status: GOOD (  19.43  )
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

On 12/20/23 at 01:57pm, fuqiang wang wrote:
> When the split does not occur on the last array member, the current code
> will not return an error. So the correct array out-of-bounds check should
> be mem->nr_ranges >= mem->max_nr_ranges.
> 
> When the OOB happen, the cmem->ranges[] have changed, so return early to
> avoid it.
> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  kernel/crash_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

You may need rebase your work on next/master branch to avoid conflict.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

In the current, below commit exists, then code change in this patch may
not be needed.
86d80cbb61ca crash_core: fix and simplify the logic of crash_exclude_mem_range()

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d4313b53837e..b1ab61c74fd2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		}
>  
>  		if (p_start > start && p_end < end) {
> +			/* Split happened */
> +			if (mem->nr_ranges >= mem->max_nr_ranges)
> +				return -ENOMEM;
>  			/* Split original range */
>  			mem->ranges[i].end = p_start - 1;
>  			temp_range.start = p_end + 1;
> @@ -626,10 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	if (!temp_range.end)
>  		return 0;
>  
> -	/* Split happened */
> -	if (i == mem->max_nr_ranges - 1)
> -		return -ENOMEM;
> -
>  	/* Location where new range should go */
>  	j = i + 1;
>  	if (j < mem->nr_ranges) {
> -- 
> 2.42.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
