Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE29606A330
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KkQDq6jx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtKR3jM0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8DZ4mPEBjUmR27wH31ZCXCx6rDwt85HZoDNwiNUBwYs=; b=KkQDq6jxLRCyKsqYE24cT8ppLb
	UKh6kayM3PpeoF+MDO4RkaxsOH6OpAucYYXtEnfH56vZqdXTdqBWxfH8GyhrN8ZhT4KDu0sHWV9w/
	fxQ9VlwWk0mZqb55x1kpfK7/eUCOmdm21Yv+0imJkwnMRwPZKIcojmxNT1QzaG4o57ZDaZ0uJF7Gq
	NyUmke1xfluig8bepk1+KsHNfE90xgnkSvlzxMSx0SHKlTsh7QHjRh9fAvFbKWt46SUv/q8rYn8bD
	oqVn0d5oO7iE17Fpzu06kUSVTKq3W3hk3bvc5ftYs2zdjM2G58UOTKWI54TwG2FEylG2ACvIqtPax
	2u/40mwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU6qY-0000000Czve-0ycI;
	Thu, 19 Nov 2026 18:26:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU6qW-0000000CzvC-2aKV
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 18:26:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 11E9D4424B;
	Thu, 19 Nov 2026 18:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052C1F000C4;
	Thu, 19 Nov 2026 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795112815;
	bh=8DZ4mPEBjUmR27wH31ZCXCx6rDwt85HZoDNwiNUBwYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FtKR3jM0xbMz1npQDKTHSOZ2Z4Pqwh6sOxEWnBVmzin2nJEBX9dwZ6GQW93/xmHwC
	 tL1SyEGSU6oZwiCIrBfhW/d3dGUvgJQjlW8e+XdOHnmaZ+V9CZacMN74agW4bZascV
	 SOR6QYNhxO5Y+Eq/+XuOO/tH1gJjaPFoxX9grfqpz2ClL6gzRP/nF4LpaJdumhvSkA
	 2fMdt690Sgjg0rYcGIOfqJMiDzjk3DvSkCwAcop2sQQckLPk2uNPl3i4gfU8ia62ky
	 xTVEV5ABSlC5K9ysPF6CKr0yoJqZrO71KwHfANKR0LiDTGtWlM55ThaPE9RQ9VVNLv
	 YgWJbKeiEFdQg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 01/19] liveupdate: Remove the list of steps from
 luo_preserve_file()'s comment
In-Reply-To: <20261111002358.1842967-2-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:39 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-2-dmatlack@google.com>
Date: Thu, 19 Nov 2026 18:26:49 +0000
Message-ID: <2vxzv75s3ceu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Remove the numbered list of steps from the kernel-doc comment of
> luo_preserve_file(), along with the sentence that introduces it, which
> repeats the first sentence of the previous paragraph.
>
> The list only restates what the code does, and goes stale whenever the
> code changes.
>
> Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

