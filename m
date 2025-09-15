Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A1CCAC592
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39kSYvOEmua0LoxQ7LmRaKJGcrhZgHXmVU2b+XiZ54c=; b=3bELRQGAzTTBwwc9mqu3K/Qd0e
	Ot5xKBGOXqUQ3aqBn5UIpsYSBRhDMBAl/h7Lzc8R7WMPJLSf7PKHvoutpG1uUonMv8bURVPD2gGQI
	TCjdwD/KzoiDxGwK3hf1XGwfx0oMZUzMQ04eAqLSCWfwhEkiXViBbGXNCF14bptvU5ZrVh/ZacKyZ
	zIMVW7d8mB2ImND09U6mapPvzXwypDQ5W9lCSmJI1X0F3aUi6vYzaldZIwougTOvqfNcEzEssCiAZ
	k+L6jIKDrYkfJdmD5+UlitAWT7vrT9y/MXDKjKFsylVubWC8k/+yxrJxdkTLyh0e4hfWujVcr1a97
	59dFvmzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBnX-000000054iX-2G3Z;
	Mon, 15 Sep 2025 16:11:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBnV-000000054i9-0d3s
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 16:11:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B7ED41866;
	Mon, 15 Sep 2025 16:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2521C4CEFA;
	Mon, 15 Sep 2025 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757952680;
	bh=HIvRsMJVPNoUvvqUEpteOLKzrNYK7pX2CMDYd4CRrSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0Lw7dm+WDNqh8UKtgSTrRp1KEGb1+HzQ25D4x3Qlj1zY0y+wipo4fB8Ut2CDs2Kt
	 EO504uFug0dUTpMEOA1YXEr1kOvaK7TM+zIB6iX9Pesk0ENVyuV/l/QR6C7yl28g0F
	 DzZWd4AH4VUK9GRcDdbvRb83Yk25ik7CisUQLJDDV6pT/Uir6R7B7a/RmEqsT0KjDr
	 T+BMOqi0YSOW5RLQ6B25Gbm/IYwjC0uhlhNW+1nAhV1W02NEjCDc0+GFOPRkKyXs7d
	 ROxvsJAhIAUu99ziG6QNm1/eYdnihmAeW60wrWqK+Gd0DQzapA/1ZH4yF+Wh0g3fCF
	 6exIA62+ATVwQ==
Date: Mon, 15 Sep 2025 19:11:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMg6oK6gaUfU9ol2@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <20250908141423.GJ616306@nvidia.com>
 <aMgcHWxsEWnKzzcN@kernel.org>
 <20250915143730.GK1024672@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915143730.GK1024672@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_091121_206953_576945F8 
X-CRM114-Status: GOOD (  13.12  )
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

On Mon, Sep 15, 2025 at 11:37:30AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 05:01:01PM +0300, Mike Rapoport wrote:
> > > kzalloc() cannot be preserved, the only thing we support today is
> > > alloc_page(), so this code pattern shouldn't exist.
> >  
> > kzalloc(PAGE_SIZE) can be preserved, it's page aligned and we don't have to
> > restore it into a slab cache. But this maybe indeed confusing for those who
> > copy paste the code, so I'll change it.
> 
> It really isn't. The kzalloc should be returning frozen pages for that
> allocation and the restoration will not put frozen pages back.

But we don't care here, we free that page immediately to buddy on
restoration.
 
> Jason

-- 
Sincerely yours,
Mike.

