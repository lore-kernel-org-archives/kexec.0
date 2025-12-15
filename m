Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C50D59D99
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 02:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYycTAAbDWrCDfyhapYRbhXvfMQh9O9/yE26ZBKxBs0=; b=NPxPX1+ONuro7dZW5KDchz50KM
	6l6PUC4/26pTur9zv0+EsrJSdYveusVx4nbakUVkCX+BB1/AN+iIfmxoCpE+7yCeYsqyqtPUOxGtT
	P7iRUDm2fj7oVtz6z14tVORrs6Nuw7RUl+sLjOEczbaAsEyyKFSlNBr5E5s1xPsrk0ZTkmNuRr5q+
	7kCwR5Ve5G3IR+1Cn1iBvgWztsUVOcjYlTd8zC5ljmVfXYetdWd1nBAJab6DVB6Sa3nw4LtnDWDs7
	bwR+ijfKn4LFJYs1MLyfXMxpatxih4MSMyfi98JiDu7frhzPp9shrjBwK8MlTqyM7Wn1nAxPhslFO
	Eizepi4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUy5h-00000002w3C-3q38;
	Mon, 15 Dec 2025 02:13:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUy5e-00000002w2p-2gwA
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 02:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765764813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYycTAAbDWrCDfyhapYRbhXvfMQh9O9/yE26ZBKxBs0=;
	b=Lgn7fnfj/0SiV3kd7fpS8eGnmJ2CHn6Uwq/oDJw3GBL1Yo5J/8SFQrU4z2sLWWhcCc8G3S
	vViK3mWGA/WeYmCMg8VebNv6slvMf1RGzJJnggEb6YmU8jjJxLQIze/VItQ8e/ajzbRkCc
	9AsKBa7kV3pCd7N2b++Nc9b3pseOS2g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-bUZ6CqMcNGKZvxewYcFLXg-1; Sun,
 14 Dec 2025 21:13:29 -0500
X-MC-Unique: bUZ6CqMcNGKZvxewYcFLXg-1
X-Mimecast-MFC-AGG-ID: bUZ6CqMcNGKZvxewYcFLXg_1765764808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80ECD1956054;
	Mon, 15 Dec 2025 02:13:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.95])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE9CF1953984;
	Mon, 15 Dec 2025 02:13:25 +0000 (UTC)
Date: Mon, 15 Dec 2025 10:13:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, coxu@redhat.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] crash_dump: Constify struct configfs_item_operations and
 configfs_group_operations
Message-ID: <aT9uwXK8XFdXei/L@MiWiFi-R3L-srv>
References: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_181335_446862_B234C017 
X-CRM114-Status: GOOD (  19.31  )
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

On 12/14/25 at 06:57pm, Christophe JAILLET wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   16339	  11001	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   16499	  10841	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Sounds not bad, leave this to Coiby to test.

> ---
> Compile tested only.
> 
> This change is possible since commits f2f36500a63b and f7f78098690d.

I don't follow here, why do these two commits have anything with this
patch?

> ---
>  kernel/crash_dump_dm_crypt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 401423ba477d..0d23dc1de67c 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -223,7 +223,7 @@ static void config_key_release(struct config_item *item)
>  	key_count--;
>  }
>  
> -static struct configfs_item_operations config_key_item_ops = {
> +static const struct configfs_item_operations config_key_item_ops = {
>  	.release = config_key_release,
>  };
>  
> @@ -298,7 +298,7 @@ static struct configfs_attribute *config_keys_attrs[] = {
>   * Note that, since no extra work is required on ->drop_item(),
>   * no ->drop_item() is provided.
>   */
> -static struct configfs_group_operations config_keys_group_ops = {
> +static const struct configfs_group_operations config_keys_group_ops = {
>  	.make_item = config_keys_make_item,
>  };
>  
> -- 
> 2.52.0
> 
> 


