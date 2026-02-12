Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63831EB4912
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AOmFVA8F7A36GVrkgjTKaK7VCkhN532H0IBcW3fjmfE=; b=1ZsjOPrjULF+a4m75/A+FsjV8T
	jW5msE+nV5QKSYrfsLZG3in+TTzpJ2pzd1wz2wda4Ump4ks2euk99yQFQqSbLBigwLoZFVAEWpCgI
	h32uNhQvsZoJ9gAmxwzFhhRhdAI6AzpneMO3DkiIrNb6l/83n33EjZMTcnsjomqWS0ndYwcLQcbh/
	J0xYcwzVxD6jjTQ1kuEQBS18DTeG2A93orIzbF6tuIuo99UqEzLJP8EtfDEJaI5lz58qSILAI9Wh2
	9DCeBKaCPRsQoLARPJuVs/OD8GBngyHX9v+M9sfYV0WDN+bOdEyW4DvdEEissboe50xYkbp/lgRk8
	UrQuBI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqV4Z-000000020uM-1RPl;
	Thu, 12 Feb 2026 11:41:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqV4W-000000020tc-21Cn
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 11:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A8E2405B6;
	Thu, 12 Feb 2026 11:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C7AC16AAE;
	Thu, 12 Feb 2026 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896483;
	bh=ZH+HbmVIIzMcIEa9LGN6wkR8qjpnh0O5mXXLZ+jp/ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRwvhRXhOyGP3akEut1HqTFpeodKL4dVxRPzvaQknwLED6HfcBS/051ZarH20JOZ3
	 enUK0HUxeog6dcdFzX6w9NeBTgKb69cst6G1M4cmliddugqq9a3bfjTB8jHrp+53pH
	 3KqJK/uJgPyOUsjRm47AYQgpJhH4HW1u2rkNTLARSwLv9l8YBaLC2cLrKkTETszu1+
	 xB+moFk/aQrxBvZ4ti4W3TmizA5rUqf+GpXLtnw+u90WdnPDwBJzbd3yU2A3Z55GbN
	 U091G3xG/XyFhlDnHRtsjGr9J81Bkmo1TPjGDo6u/lmh2RNQADUT36vV+5bV5U7sqO
	 flsTA3feP8fUg==
Date: Thu, 12 Feb 2026 13:41:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] kho: add support for deferred struct page init
Message-ID: <aY28XI1AR90kCiec@kernel.org>
References: <20260211173954.2091119-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211173954.2091119-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_034124_540981_A5672515 
X-CRM114-Status: GOOD (  13.34  )
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

Hi Michal,

On Wed, Feb 11, 2026 at 06:39:54PM +0100, Michal Clapinski wrote:
> From: Evangelos Petrongonas <epetron@amazon.de>
> 
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
> 
> During KHO restoration, deserialize_bitmap() writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> BUG: unable to handle page fault for address: ...
> 
> Fix this by introducing kho_get_preserved_page(),  which ensures
> all struct pages in a preserved region are initialized by calling
> init_deferred_page() which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

As Pasha mentioned, please add Co-developed-by.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

