Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A2C4453A
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=77lCXIJOUcG7tXFVWP1KPzJcluoW+7zUs7HIRFXD6Pc=; b=yg7xla802Xih1m5QczJ+8+KXqM
	KoSFFM3VFDFkutYWNTr3P//T4OmxODabRZDmsbL/gd3eTayWrZjVUG8kWTRUhUBrHGwQDZSTfGtT/
	bVSXlbytUz6/iPY/+8lkUSEgIv2iWcXsMUmYI3KzxuTFiR8dYxhkPvaOc+mB0weWImCnIeHqRrQu4
	FEZbxbqLAyGK4cqCZfY/tvDyX8rUuYOH2rkjusUAB3KFH2OeYRJlA8nylIU2q+hOOxegfz4cvEksH
	A7IO1rYVWhphERhgZt43HvR5lDPNmp5CwPs6QYLazXJEKoHkz75wBjaMs3PBfo6M6QFlcmrR5llG9
	bz7oJeDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeMd-0000000Cnnn-42NB;
	Wed, 22 Jul 2026 21:20:27 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeMb-0000000CnnK-2kU6
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 21:20:26 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cede6375caso26865ad.0
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784755224; x=1785360024; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77lCXIJOUcG7tXFVWP1KPzJcluoW+7zUs7HIRFXD6Pc=;
        b=mGrJ4SUyi/eUo1XjtRi6yOkHpzOlSftYMFyhJmiJYVjS+x+e6uq1YJW5UgNhzQK9pF
         U/f08w8q/FugRABZhVgiMmK2tDB3KBK7fYCnNmV+eiVgetkruuV85GCd3jlopunOWm+m
         6xRvmkBzdr6l3WeZ7OkHxDplKyBv5La2UsUk5CgrnMHHpaMQNRPHtVoWAgGpNQTDjqrp
         +0aWrUNM8O+tFSltehOFcj/zCoy9Qwyg+fN3OPl2rCfWgxnIjBrZL8xlV6AkbXHe5V4c
         We54D06rszinzYWhBs+x+i9gQqIJfsyYZnLt+phAvP5Iip2nIoV+8GaRgOyvu4EkfdVE
         P5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755224; x=1785360024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77lCXIJOUcG7tXFVWP1KPzJcluoW+7zUs7HIRFXD6Pc=;
        b=r2xNP7T3lxDe7Wo0ViyMD8ZPtvIbe5sgAFGIpCbnBsMoZ9StU7mUU8O1LUJfLn9y36
         00IDJyAd8Dz0xDmyo1DfnFb0xgxvog1eCTV/b3W4WIl1FXj+N2tplb4pJM3cwZ7MlXqv
         XpcOqX3N6BAxeBOZ4rJLJHaf1Rt9tsJETACQV4aeoKYYhgIgNykRBCDDWlLhF5gaA3WQ
         EzLoh8DWJivCQq6Z7BrfL3XDRofCZSVILFBrOiGSIWPn1efcAsMw89x5Y6fTxPsCuqep
         JUJKrADfx+Mp8lRILXHR/aJo9/yQYrPBIkVLMzHZwXmMdS70LSI9Saw9KipvTSCs+vM1
         PPwg==
X-Forwarded-Encrypted: i=1; AHgh+RqzLwAZVFw/207m+Ip+rElQemlalUnUmx+4hij0lhHibP4lqXxdU5LHTVvK9GNUyxpj0RF+iw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9dnYfsOqiwMpub56dbNT1Pp9CiksOEwJWMN9ZK4kOjeXF9wGb
	mqHBWydk31MhhxLN6EZS8WuNlbBcnV9xhaJ1Xer1CfRuIyUbnUed95/0lq+0LMhOUQ==
X-Gm-Gg: AR+sD13iAPnhkV1CiWZkn9zrtnMOe5x7p/0NN+l35DSz4eD4vU6V5KbxSVzIDQhregN
	AUhBpEqTDQgPim6CAswTrb2IiVZLV/39meNIWBZ3QyXnJRTB65iNSTXyPVYUuDW3HHthVeUlihl
	DX9UaFLHMmWkDH3AO7skSrn4JX6enB61HOLasHAa66zx4DAIgHyiPc5bE5z1pmri6RrBxXPHtAn
	lj7Bza0egpFUdhglB9hrtiERvTCjFpi3SqZkzGurcqFLebmPCN0sOk/rVj85Db+aPRkQ+RQsC5p
	RGhg8SkuTgPI3xOXGyNMqwBEcUqocgBI4yc7rZR1TVpZPPj2AJNlHxW6i5wkRT4OldKZwkEPdIi
	z64U4X8awEmowQ+6aOPexFCVQfzuVzyF8Ho9jXkKFeDEEFfHpAzuuwLFpiGrFahbWiY7BDGJXst
	L5Lv6DM6tGJIXN6W1dPtfRuT8PHnhGF2RGP1S8
X-Received: by 2002:a17:902:c40d:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2cfa4e71220mr1307355ad.12.1784755224018;
        Wed, 22 Jul 2026 14:20:24 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm11985348eec.0.2026.07.22.14.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:20:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:19:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] kho: Introduce preserve/restore APIs for
 unsplit pages
Message-ID: <amEz-Tv7H7O1VVij@google.com>
References: <20260713204935.3069000-1-praan@google.com>
 <20260713204935.3069000-3-praan@google.com>
 <178456663513.143128.14871307686052703561.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178456663513.143128.14871307686052703561.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_142025_699679_BF216A45 
X-CRM114-Status: GOOD (  20.59  )
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

On Mon, Jul 20, 2026 at 07:57:15PM +0300, Mike Rapoport wrote:
> > The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
> > that multi-page blocks are split into independent 4KB pages during
> > restoration. This is incompatible with high-order non-compound pages,
> > such as DMA buffers, which must be restored with tail pages having a
> > zero reference count.
> > 
> > Introduce explicit preserve and restore APIs for unsplit pages,
> 
>                                  high-order non-compound ^
> 

Ack, will update the commit msg.

> > which preserve and restore a high-order page block as a single unit,
> > applying a refcount of 1 to the head page while leaving tail pages at 0.
> > Rename the existing internal helper to __kho_restore_page().
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> >
> > diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> > index 8968c56d2d73e..6e2c75b16209c 100644
> > --- a/include/linux/kexec_handover.h
> > +++ b/include/linux/kexec_handover.h
> > @@ -22,6 +22,8 @@ bool is_kho_boot(void);
> >  

[...]

> > +struct page *kho_restore_page(phys_addr_t phys)
> > +{
> > +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> > +	unsigned long nr_pages;
> > +	union kho_page_info info;
> > +
> > +	if (!page)
> > +		return NULL;
> > +
> > +	info.page_private = page->private;
> > +	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
> > +		return NULL;
> > +
> > +	nr_pages = (1UL << info.order);
> > +	page->private = 0;
> > +
> > +	kho_init_unsplit_pages(page, info.order);
> > +	adjust_managed_page_count(page, nr_pages);
> > +
> > +	return page;
> 
> Hmm, it copies a lot from __kho_init_page().
> We should keep the common part of order-0 page/folio/high-order page
> initialization in a single place.
> 

Alright, I'll break out a helper.

Thanks,
Praan

