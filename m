Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB25C43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFGbMiPIQbORKlXAvmb1zQCk6r/kZuhJn/PPaYuiAsg=; b=LTTaotp+JHTtDoc5WVlc8osx78
	hgr9X2TsyGzcr8JFBvERioIPEawcHDyYRmzrWjZwkOvnoPViw5H2iBh0NmTn/+ghbjNXFF6tJqQIP
	FnA1hFcCXRkPYbqxHSDd7oyTE0HNTawnm2KXwO1gtpX66x9KUUUs9rnjeTeT0297f1q6WQNFzbscl
	WWq1KKuFvn4WlvbZjIDoac3Co72l02ZiWdMPwj2JGg0NYockT5x26t13CUZzLKK2X4+LYs4UMMnXd
	PXwpEpOJAV38/hPQ+I39RBekHqVkw23++twpa/wAhCqv6gvNQMgzR4mKjdBzv3LwK9aQkrwCNpKOR
	RGd519vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1Ae-0000000ETkd-0cRM;
	Tue, 07 Jul 2026 08:28:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1Ad-0000000ETjz-0zKm
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 08:28:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ACD5A618AE;
	Tue,  7 Jul 2026 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C821F000E9;
	Tue,  7 Jul 2026 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412926;
	bh=zFGbMiPIQbORKlXAvmb1zQCk6r/kZuhJn/PPaYuiAsg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZPndqliwgmXu5kmh+bJz4fuHhudb3ocCu8zmLAbMuL9PVvQEPh6SQu/jJ6Qh4/LfM
	 Lpq1L0SIRqwvbTEkVMa8DrKCTtdkpGXD+aLresfXY4/E2iZsSEXH05ccH5lTqF4X1k
	 TwGGeDcxqfRYyaXMfROP55Ai6+4xE5cb9KGQWoxQ2KBIra44VvLd0nSBm+XFJ/u2ho
	 I8tXZJZw1rHSnOj1MDJJEGkoGXTYGxV9+eHldyXUMT5nFDPQwiKO02IzTG7/cSmIWt
	 +OH6P4J/L5rjqLxObllhoMUrqO2KxYegM8rFQC3o+1evYoG+bJCJZxAM1lQxgW/ojr
	 4S85VUgSSvivA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 4/4] kho: Introduce kho_split_preserved_pages()
 helper
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703020832.1731864-5-praan@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <20260703020832.1731864-5-praan@google.com>
Date: Tue, 07 Jul 2026 11:28:28 +0300
Message-Id: <178341290877.3292146.993563652569119942.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> A driver may need to split a high-order allocation that has already
> been preserved. If the pages are split using split_page() manually,

Why?
Are there particular examples?

> the refcounts would change but KHO won't record the change in the
> preserved page-type, resulting in a metadata mismatch during
> restoration in the new kernel.
> 
> Introduce kho_split_preserved_pages() to handle splitting of preserved
> pages. The helper follows an unpreserve -> split -> re-preserve sequence,
> while ensuring that the KHO radix tree is updated with the correct
> KHO_PAGE_SPLIT type bits.
> 
> The helper returns 0 on success, or a negative error code if the
> re-preservation fails. Callers must ensure the provided order matches
> the original allocation and that the operation is serialized against
> other preservation API calls.

Let's put this on hold until there are actual users.

-- 
Sincerely yours,
Mike.


