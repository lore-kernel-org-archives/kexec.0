Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A58C61DF7
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K3BetRzybLw9YVPPvmL6kHrtr1P8PbFMTCuMWWgbPZs=; b=cmKTVWGNCTORmk
	5AJAPkn2r8Dppi7hRpG7P9DHS1Nx+RGKrC9I3vqlH6bmV/+EHHAGiLYdQ2rY1ik2+ThCjJg3E4Kdg
	VxVpZQuSOyUdeXkbbIMZm6k4Kqk0tY+jdaZoGGsoOGmWDEfPDyg2Crzpr/UyRaxjc1eaGJGZW8thd
	uUSkEEvMAh6jqSGoeAk91D7cs6RYgLuDZzEvRxY4GDhA7PRnSiHCtxvmPB6MNrmk0/DX5TxGPhgIB
	9RlbWAx3B/kFqge/7ScQZd6BS6pB1ZkdN8CUxn5LP2cC1nwyr03E7JvEPa41XDI+rc+WP/ZQ8JStD
	U4Va4qE4xBArZiep01/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r69kE-004stg-2u;
	Thu, 23 Nov 2023 13:27:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r69k9-004ss0-0J
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 13:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700746062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlCNcFS7+nGLr8i/szhMFxjsyTieH5TNHlOyuSvsHHk=;
	b=N4/SHSmUGDfNdy3EytrA6vVPz8w5EiVjWxkSvKyI4ZAYzcOUBXfiNV/VluW4er4kybzMkF
	gPeFmPUjd52ZrjeDENZEiSYHnXaI0zjc1zHzthK8l2hLXyNx8jqWKNH4YUVMlRWnjii+++
	uLr5NBAUFJkyyXwLCje8GBQDmF7DGh0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-LNixVYSgNR6zfKelwTaWZg-1; Thu,
 23 Nov 2023 08:27:38 -0500
X-MC-Unique: LNixVYSgNR6zfKelwTaWZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 368F43C027B1;
	Thu, 23 Nov 2023 13:27:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1BD36E2;
	Thu, 23 Nov 2023 13:27:29 +0000 (UTC)
Date: Thu, 23 Nov 2023 21:27:25 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	ebiederm@xmission.com, takahiro.akashi@linaro.org
Subject: Re: [PATCH v2 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <ZV9TPRw65TiCeXyS@MiWiFi-R3L-srv>
References: <20231114091658.228030-1-bhe@redhat.com>
 <20231114091658.228030-2-bhe@redhat.com>
 <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_052745_222644_05331665 
X-CRM114-Status: GOOD (  25.29  )
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

Hi Andrew,

On 11/15/23 at 09:00pm, Baoquan He wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code to load kernel, initrd etc when
> preparing kexec reboot.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> - Use kvrealloc() to reallocate memory instead of kvcalloc(), this
>   simplifies code. Suggested by Andrew.
> 
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)

Gentle ping.

Could you pick this patchset into next tree so that it can be run on
testing robots?

Thanks
Baoquan

> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 14f5cfabbbc8..db7fe25f3370 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -331,6 +331,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>  		    int (*func)(struct resource *, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +			int (*func)(struct resource *, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
>  
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 866ef3663a0b..e8a244300e5b 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -27,6 +27,8 @@
>  #include <linux/mount.h>
>  #include <linux/resource_ext.h>
>  #include <uapi/linux/magic.h>
> +#include <linux/string.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>  
>  
> @@ -429,6 +431,61 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  				     func);
>  }
>  
> +/*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res, *rams;
> +	int rams_size = 16, i;
> +	unsigned long flags;
> +	int ret = -1;
> +
> +	/* create a list */
> +	rams = kvcalloc(rams_size, sizeof(struct resource), GFP_KERNEL);
> +	if (!rams)
> +		return ret;
> +
> +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	i = 0;
> +	while ((start < end) &&
> +		(!find_next_iomem_res(start, end, flags, IORES_DESC_NONE, &res))) {
> +		if (i >= rams_size) {
> +			/* re-alloc */
> +			struct resource *rams_new;
> +
> +			rams_new = kvrealloc(rams, rams_size * sizeof(struct resource),
> +					     (rams_size + 16) * sizeof(struct resource),
> +					     GFP_KERNEL);
> +			if (!rams_new)
> +				goto out;
> +
> +			rams = rams_new;
> +			rams_size += 16;
> +		}
> +
> +		rams[i].start = res.start;
> +		rams[i++].end = res.end;
> +
> +		start = res.end + 1;
> +	}
> +
> +	/* go reverse */
> +	for (i--; i >= 0; i--) {
> +		ret = (*func)(&rams[i], arg);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	kvfree(rams);
> +	return ret;
> +}
> +
>  /*
>   * This function calls the @func callback against all memory ranges, which
>   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
