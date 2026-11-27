Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A4606A32C
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F/yAZmgH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW6u8bF2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wO/IOEvgfeJp88G3JhgG/noxUD2JKBD20IHHFxKJYuc=; b=F/yAZmgHzAXLLo
	hMfULAqHSg97nWdUF1Xhenu40rasosMkzn0eAmdKuRv2rzrvBXb0/HtTxk8OGwCOT13uQH94B2JTX
	KtKlsT0Lm5sfp6HH2NEWtV/UdEDXwAMwpDPvetNlBzMQjr5dPPDPFKcmTJjzCd2xu/4ahzSbndMW5
	LdkYeoWC+aQWyxscysNU8r+NN2xoc6uGM/0SGa8XKPRnrwmiwM001WED+FDxGZY7MCNwSMEwLERYS
	rxBb7lztCGK9I9PjTOph8DGrWlU4+zB4zCk1jTHFCqiGcAlsTsaQSruYMIJMqLMTTYktvx0miAM9h
	+XwNWKqKV8UEkHFjn/xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1g-0000000G7Ok-1j7e;
	Fri, 27 Nov 2026 12:26:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1d-0000000G7Ms-3tIY
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:26:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE077417BE;
	Fri, 27 Nov 2026 12:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49071F00A02;
	Fri, 27 Nov 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782361;
	bh=wO/IOEvgfeJp88G3JhgG/noxUD2JKBD20IHHFxKJYuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LW6u8bF2kVNmuWmelsSivsj/jA5wffvdi1FVsMa7rCrDRU+cLnvmXnjGR0S3F8lPO
	 LOrTRj6a/JAKn+Gq3xSuQO7JUVjDJwaouUu7nd4dAS8GKHcBKYF930PNt8ZwwHF0AW
	 nKqXWh71uaU/BVIfWWajGCudQT9HMdSkeb3oFplARqAvV1SonkUm65FWTfaYQWbFjS
	 5jIZ98K93cxNnS4JzZKAv6rChjYiqXdfsDEquIKozcQgejaSHF6uCRo3emRX8gTPdO
	 lVwAZkwlLtUOft+qQqhQ+wchhSggb3UE+b3EVp3rL98D4TXA4i3uupInAHV3TaDw6M
	 bNy8IM7TEipew==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/6] kho: use unsigned long for kho_preserve_pages() and co when KHO=n
Date: Fri, 27 Nov 2026 12:25:30 +0000
Message-ID: <20261127122536.3708770-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Commit 840fe43d371f ("kho: use unsigned long for nr_pages") changed
nr_pages to unsigned long, but it forgot to update the KEXEC_HANDOVER=n
stubs.

Fixes: 840fe43d371f ("kho: use unsigned long for nr_pages")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---

I don't think this is stable material since there is no problem in
practice.
---
 include/linux/kexec_handover.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..a20456b8da20 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -66,12 +66,12 @@ static inline int kho_preserve_folio(struct folio *folio)
 
 static inline void kho_unpreserve_folio(struct folio *folio) { }
 
-static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
+static inline int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
+static inline void kho_unpreserve_pages(struct page *page, unsigned long nr_pages) { }
 
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
@@ -95,7 +95,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 }
 
 static inline struct page *kho_restore_pages(phys_addr_t phys,
-					     unsigned int nr_pages)
+					     unsigned long nr_pages)
 {
 	return NULL;
 }
-- 
2.56.1.839.g22a8290db9-goog


