Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC139CCA490
	for <kexec@archiver.kernel.org>; Sat, 17 Oct 2026 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+r2mVM6exMXaeETVHquTVwr/XL/75xbpWlK6/Fp1U6o=; b=If4nEh+OOMRXFQ7wlqpU2i1BuF
	mzcZs8fYSKohvxFRPdAImQ0an5BACQD+TItEo2KTlXpMvcg7vU7RHKz11tdvTQpKa9DF6xdd7mG5l
	8Q5jmxhpCD5Fzuo+JgQy4AYASH44qINkCEIbeXALME/Dt+/PyepiJk0DVygKrxx2R+AXeIBzQtBfb
	S5iZAPFsiFDsFax6xvU5Qb0C3/x6+Zp73v8Gl3O6RnbZcq67Zyvle+IguH/71bHjIwWY8ENTISgcb
	9L3ikMIzJhzUZog9cdc26EzN0VTacJtQwrCwMLaPnbYe08PTM/QCythM1WY4bjo0ndTAM9x2ujpkt
	hlR3fQmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHuf7-00000004MRU-0Sax;
	Sat, 17 Oct 2026 03:00:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHuf1-00000004MRL-188f
	for kexec@lists.infradead.org;
	Sat, 17 Oct 2026 03:00:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F5AB447E8;
	Sat, 17 Oct 2026 03:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F3B1F000C6;
	Sat, 17 Oct 2026 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206038;
	bh=+r2mVM6exMXaeETVHquTVwr/XL/75xbpWlK6/Fp1U6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlbgZHKkmbaTJwL+6F/M6ONkkTNMrG25zv2f+y14G34LFvkjzUzCHHjpa6Jk1ntUV
	 bA8zHcOP35QpKjiv1QKbl6GdCpms369F8YzDAOGrcw9dWmmSDNxzXgsN3SyYICyGp3
	 /1/igiAVVgr0JHSTFhnzVfBvXyu3pMxwVBqwUu2VB48tZ5B43oWUKu+xeTY6QJVu3q
	 Lkw9GLAOJvhR4Bp1jDZ/wxULhZa2K5grf3f8KmL/Wub5bSbp/QrKi7498RvHNABMb6
	 oyV9dylAXb5t8XRieL0vs4CYGFhMnrSK8ScLEemm7aALTzXxpln3Q1DA6G20vwPM3z
	 0QHyvlFH+ItFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	nh-open-source@amazon.com,
	Federico Parola <fparola@amazon.de>
Subject: Re: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page() in __kho_abort()
Date: Fri, 16 Oct 2026 23:00:16 -0400
Message-ID: <2026-10-16-1-daily-reply-0011-kho-free-page-2of2-needs-ack-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015144529.76911-3-fparola@amazon.de>
References: <20261015144529.76911-3-fparola@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> This is a stable-only patch. Upstream fixed it as a side effect of
> commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
> removes the tracking teardown from __kho_abort() altogether. That change

Patch 1/2 is queued for 6.18. I'm holding this one until we have an Acked-by
or Reviewed-by from a KHO maintainer (Pratyush, Mike or Pasha). It is a
stable-only fix with no upstream equivalent, so I'd like one of you to look at
it first.

-- 
Thanks,
Sasha

