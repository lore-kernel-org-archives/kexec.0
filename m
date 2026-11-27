Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAE606A31E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ez54SYQr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0IIX6t+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bg93s8E2qpiOXI1yg+RWP0SFq8cNRtNnpPDwdNib6R8=; b=Ez54SYQrCTMYiL
	yGUc74mxjQWkwv5jdZyO8ZryH0GPkmg09e2Sl8XEK+OrdnwcwrsrataHRpM5ARHNQKHEN7HQ9PLpC
	+5RnEE0oaJEnxiAQJXM9aTYHBUb+mB3buk0qTDP4NXSf+UVt6Ksq54f5ON9qEeRGNIKIeExCAZ4oa
	woK2Zsd9RhG2X3IfHK1ctSo2ypXg0CyI/1i/95vRr2LOR1TdG+isc8p8RdbVZ7Orhzy3XYzOWovyD
	rc4a/IEYN/OW9eLdKRWSSjLgL0UUoi1vBsmGvNCv/fRDuK4WvWAiUMCACuc1OS7z4KSY7YliWrcnP
	cp5eh88TfqJiXVjDqKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1n-0000000G7Tn-0rjK;
	Fri, 27 Nov 2026 12:26:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1i-0000000G7QB-1Eta
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:26:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BAC81629CE;
	Fri, 27 Nov 2026 12:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1371F00893;
	Fri, 27 Nov 2026 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782365;
	bh=bg93s8E2qpiOXI1yg+RWP0SFq8cNRtNnpPDwdNib6R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0IIX6t+zutMiF55Susal3PFvq6aiLSRkmxkwqPipXuMFrZ93zliUC5V2CKvPwfdQ
	 krRhxyZjzHgjMJXE6FWBLzxTw73NHDgXMGmglqeselfTCPTNx30Xv6xv59vp2KWumb
	 eM9M6RX5iSa+q1vc1gt8I7WY71fPqlxMbqOTJ/J8WRgvaoRzE/tlkNOEj9+3vZFA36
	 KhmaJZedzie2/kNbRDe7B+NTJheXmcpOqX6JOTPLBUoafGU8IErF1ucWcpBjtArpiz
	 Roq3DD1iyJaiquku45grPzzBTugp3kwhQ6cgusx6rE/XoMzx54PyZBvaOvBRuNXMvi
	 ePpFfD2N+Q1BA==
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
Subject: [PATCH 5/6] kho: fix kernel-doc return for kho_alloc_preserve()
Date: Fri, 27 Nov 2026 12:25:31 +0000
Message-ID: <20261127122536.3708770-6-pratyush@kernel.org>
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

kernel-doc complains:

  No description found for return value of 'kho_alloc_preserve'

It does not recognize '@return'. Use 'Return' instead.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kho_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kho_core.c b/kernel/liveupdate/kho_core.c
index 3f9d408b9d29..580cdb3ea070 100644
--- a/kernel/liveupdate/kho_core.c
+++ b/kernel/liveupdate/kho_core.c
@@ -1584,7 +1584,7 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
  * Note: The actual allocated size will be rounded up to the nearest
  * power-of-two page boundary.
  *
- * @return A virtual pointer to the allocated and preserved memory on success,
+ * Return: A virtual pointer to the allocated and preserved memory on success,
  * or an ERR_PTR() encoded error on failure.
  */
 void *kho_alloc_preserve(size_t size)
-- 
2.56.1.839.g22a8290db9-goog


