Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB0EA811B
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sD0GLwSYXIdm9e+BN8o4k7OyBkQyu546gqHQCZm6No=; b=JIEWotk0H6QhonvdDhoROmVunv
	3XYFwsGWvIv7ZK0Yf6lLb98Jh1bnx025gI758AgTMcE/TsyGfl+zOyMxXyD8MqzC8F3l7RD91IMLK
	K6GGVAmuUDaahXRS0qw/T+KBoSGrOxljC6ePqJt32r831g/Zj8abayBFCcRrSvVM20AJgqCOAHnDs
	lKIi/gog/KbC1o8dN/MsWE89BvGJS6zLrZrK7aV6NJFwyOtE4JeBY0HuSi1sjOIrjFb5Y1E4W5rEy
	ZOQgkKFrVu2NG+ZPjF4Pyp2v+h9wdn1h65TR30CV0aRWM1Wec8EL6nddN/mk0lR/DXx0BC2q2vicX
	KaO8gaMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoDA-0000000H1C8-28aG;
	Tue, 10 Feb 2026 13:55:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoD9-0000000H1Bo-0jA7
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:55:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6200E60097;
	Tue, 10 Feb 2026 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6240BC116C6;
	Tue, 10 Feb 2026 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731726;
	bh=JE2m8NIaql1tE2VnNeufIkHeTWlYa03U2mH/McAh6Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iYIHdFRLbDb9dyt6VlP4jwIQGdzjgP4C0/I3oSr8QEKEq5jTwwRZJUrRJtOzzA3d3
	 ul3zgxJmUr3HgWkJ9HBsTJhVcnU6ZtPIV+vw4ytNw5WIWXRjsP8lMqQVR5eP/ZLhvg
	 gI/eXdV6aJ9aetiEmcgNqbvi75ULz9BNpcAHx5TN+sw/9PfvzzJHmZc57gBXFB11Tf
	 9X9MSeHPJPU+WhI5/mPpj2wApuaADExGIrm2td5yuTzfHvXfi+U9wpB1Fm+hFe+Wmc
	 tvEEIlVNrrB4Ss88kZIoM+FhYl4NG7IQUEtReipVIXgHjLdNh2X6kUfDrpRyr/hDsl
	 qZ1v9M/CP76+Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kho: add support for deferred struct page init
In-Reply-To: <20260210130418.297153-1-mclapinski@google.com> (Michal
	Clapinski's message of "Tue, 10 Feb 2026 14:04:18 +0100")
References: <20260210130418.297153-1-mclapinski@google.com>
Date: Tue, 10 Feb 2026 14:55:22 +0100
Message-ID: <2vxzecmssnxx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Feb 10 2026, Michal Clapinski wrote:

> When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
>
> During KHO restoration, `deserialize_bitmap()` writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> ```
> BUG: unable to handle page fault for address: ...
> ```
>
> Fix this by introducing `kho_get_preserved_page()`,  which ensures
> all struct pages in a preserved region are initialized by calling
> `init_deferred_page()` which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

