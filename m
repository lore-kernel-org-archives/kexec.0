Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAE8D48981
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n49KhjW2NsQ+2SNxbG1v3wDY3eQ+clYh/VdzFfptK9k=; b=g8o9Z2jXZ7c1M2OU6UNJg1NJLW
	GfwYogpRFsXCiCJaMXHbEJXn5lHb2H3tvu1jR2pvrT3y8IhZPYCat8yeFPllGfZkt945ZyqiDhx19
	36wX79kx9kKbWVHevrDsg0vApVAeKg6Rmb3sj8ebfj79doRbBBnZ/OQpbHQDvg6jcf8dKnCrc9NOR
	q5eKsHsjc6gYOeU5mIgGbPRJ1gYOnwWDxm0ohGnzEExtkhPpDJj32+Z6tvUPEoxha5ABMnznfoFbN
	hVRm2OUFgnsMAKwdjKZS5RB8xTXrmcIIDzIzYp6eBXiiZu+4CFl0pjzP+Sy+c2350yJXBtv8aZ1/M
	ZIJb1eBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuR-0000000E2fE-3UQ0;
	Fri, 16 Jan 2026 11:22:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuQ-0000000E2f7-1PL0
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:22:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADA3C601A9;
	Fri, 16 Jan 2026 11:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2BC19421;
	Fri, 16 Jan 2026 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562549;
	bh=HI5uvGIlqzXI3+OmJCO8lS9DhG0KNYjy8q9FNzSY5eA=;
	h=From:To:Cc:Subject:Date:From;
	b=KyoeoSDSFo2BaxDmONFMoa04Ar+lKIkzTgYdZIGcIgVdOZFJQ/6Kdwp/IcXNswXAr
	 a6HNyddDo1qqChE/i3VKfZjTVtg4RRwkAVf5HA4QY+ja6W/C/ZIth4k/lTUl7WXq97
	 qSQ+yEca//KoslvyrCm9E/skYJwFDc6ZDcZgWmFETQ5Z1HpJee/7YELArcCCWha0bS
	 nWs8iuA/1KhN925Y/DVhRJv35n/csY0qmXF0Idq3wJb7OH5u6MZHINN3TOWan7oONr
	 4mkTt0+/9wMlLlhbYHOyq4I70XAEt2vWw2etx/DcvZveObtcuqPeOpwE/O7sCnxwMH
	 vb82CMnoDderg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 0/2] kho: clean up page initialization logic
Date: Fri, 16 Jan 2026 11:22:13 +0000
Message-ID: <20260116112217.915803-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series simplifies the page initialization logic in kho_restore_page(). It
was originally only a single patch [0], but on Pasha's suggestion, I added
another patch to use unsigned long for nr_pages.

Technically speaking, the patches aren't related and can be applied
independently, but bundling them together since patch 2 relies on 1 and it is
easier to manage them this way.

Changes in v2:
- Use unsigned long for nr_pages.

[0] https://lore.kernel.org/all/20251223104448.195589-1-pratyush@kernel.org/

Pratyush Yadav (2):
  kho: use unsigned long for nr_pages
  kho: simplify page initialization in kho_restore_page()

 include/linux/kexec_handover.h     |  6 ++--
 kernel/liveupdate/kexec_handover.c | 47 +++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 20 deletions(-)


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.52.0.457.g6b5491de43-goog


