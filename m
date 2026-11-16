Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5142606A330
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DvP6iD+d;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2WPmp5+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wrdcdttsZ7Y+FKLVhKP3yfAgeP8cp4gI+kbn3HQkam8=; b=DvP6iD+dmKtWD1
	lSJ0ByCpuV+kHOFz4IPZNuu33CTRzKAOyEx1Q2BXt3OvW1By9A0qWB81+zmqBpV0SA3E4MnZ6RX3p
	2n9tk0cW6P6xuhhAQJYuR6bRh0Mu1GP+uwL7yxYfE9aQTWdtrsB50i+sTCKTtEIFRVnL+odf+xAjg
	2w8ofss3TZa8NArrTjDl5qua3v/veNo4AJfkYmshSgMf8/6wdoXwELLgd1GhQ1DG7Iw+chQW/VQc7
	fyTjLLum8aWNMFoMWS7mvmSK/6IyPS1V4ZX2PPNI1cAXh/gtaay5bzw4Ci8rNhNCuAxIXGg8SrSIS
	0KQUflyntT527WtdtKpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwf-00000002fMZ-24O7;
	Mon, 16 Nov 2026 13:40:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwe-00000002fM0-1VyO
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 13:40:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC97762A10;
	Mon, 16 Nov 2026 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B3E1F000C8;
	Mon, 16 Nov 2026 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836427;
	bh=wrdcdttsZ7Y+FKLVhKP3yfAgeP8cp4gI+kbn3HQkam8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2WPmp5+BJ6A8U6M9SELLKrOsIM4+EP3Sd657t/2tdHbA8zM7d5o+aGG/HrrvNWGI
	 z5iMsQldw8skKSZG2hVSqWw+KwUN1DAhvHwSVfqNUB4TUcs3pPrbvbVY5OEUdZEv+q
	 mD0DUoouUUS57SI0CPZOasMLvRAHl8JiITcte1axz+oiELn4i7FEpJ7KjKIOH28Jnq
	 Jl29UKbapBWXBaNOFhJEFm31ONmDP83um0XNPRtl2KscdiQPBkq+Az8mhyUD9W9QZS
	 oP90ei88TFq2AcU3CryGYKgjyyOMg5Es3yqr7igo19uFD2IdUphHkLtQ2aJ5553TeZ
	 W+kOSiL0rTeLQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tarun Sahu <tarunsahu@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 1/5] kho: add KHOSER_CLEAR_PTR()
Date: Mon, 16 Nov 2026 14:40:06 +0100
Message-ID: <20261116134013.1636689-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116134013.1636689-1-pratyush@kernel.org>
References: <20261116134013.1636689-1-pratyush@kernel.org>
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

Add a helper to reset a KHO serialized pointer to NULL, as a counterpart
to KHOSER_STORE_PTR().

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho/abi/kexec_handover.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 2f4fb9c639421..5fe9c5e10ac89 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -132,6 +132,11 @@
 		(dest).phys = virt_to_phys(v);    \
 	})
 
+#define KHOSER_CLEAR_PTR(dest)			\
+	({					\
+		(dest).phys = 0;		\
+	})
+
 /* Loads the stored physical address back to a pointer. */
 #define KHOSER_LOAD_PTR(src)						\
 	({                                                                   \
-- 
2.56.0.611.g1030f0b940-goog


