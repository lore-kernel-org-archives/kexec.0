Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C6606A323
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dj9349Lu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HC6izpFB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rBVVW3tHabgwrKT2QwycDYkPKCsMYjmGYVvwfvGvrhE=; b=Dj9349Lu7y0rSI
	nrEr+Lc05cH5tALCAkTOZsRn4LCC31wlzN/rLtpQl+LNx+Zk0HPhOjV68mCNtxLHhOV2QCTp3N6Pc
	FUZbJz47w2WhJHy6qLZ2ypcfLLCFu/jA//DzLhYgiTOpbVgj0Y+7Yh1cCg9igYQ7vDG5pfgfHNahI
	18CvR/z+6StNZbVzDxi0Xwk6n3BQhXIlKxx34aKIbvvvnHyLMgZEEVIiRRC4Hn0t4KwsfLEa933Cz
	X1LNPIPkDUZ06IAJwo1dG8ZMyiqsp7A4d1TzpvY8MDhEEJN4IIlh8pK7dYEfcPOgGNvPTw4edLSt1
	8X3IIZjiCOdhid+HGe5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxk-00000009yaK-18gO;
	Thu, 29 Oct 2026 17:30:52 +0000
Received: from out-226.mta1.migadu.com ([95.215.58.226] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxh-00000009yYF-30KN
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:30:51 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=7EdBEd5XL5wRdZvYlylGxvVrrhD/K6K3u333eKYP51c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793295047; v=1; x=1793899847;
 b=HC6izpFBgx9Os0a9ApbmT2Glk501euie4yvJGNNb7zQBjlxydSGvilwWczTel/QZIX6ywO4n
 MTUMT5QvMBh0ouFgHp4Nv4X3nrI2oItKbxYRkNG+LllR7xNIV3QSufQWwP14HJ5/bGcN9HFVUX0
 L2/ocLWMVGp1/+3XWj/tMaXk=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 155dc8602c7bb9c2;
	Thu, 29 Oct 2026 17:30:46 +0000
X-Mizu-Trace-ID: 155dc8602c7bb9c2
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v6 4/8] kho: Add kho_disable()
Date: Fri, 30 Oct 2026 02:29:51 +0900
Message-ID: <20261029172956.20791-5-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029172956.20791-1-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_103049_907022_8CAF0836 
X-CRM114-Status: GOOD (  12.90  )
X-Spam-Score: -2.8 (--)
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

From: George Guo <guodongtai@kylinos.cn>

On LoongArch, KHO state is passed to the next kernel only through an EFI
configuration table. Only the EFI stub installs this table, during a cold
boot.

A kernel entered through kexec does not run the EFI stub, so it cannot
create the table if the previous kernel did not provide one. Without
the table, it cannot pass KHO state to the next kernel on a subsequent
kexec.

Add kho_disable() so architecture code can turn KHO off when the EFI
configuration table is missing.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/kexec_handover.h     | 3 +++
 kernel/liveupdate/kexec_handover.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..6f80e1b0ccd4 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -15,6 +15,7 @@ struct page;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
+void kho_disable(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
@@ -54,6 +55,8 @@ static inline bool kho_is_enabled(void)
 	return false;
 }
 
+static inline void kho_disable(void) { }
+
 static inline bool is_kho_boot(void)
 {
 	return false;
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 74c4633f5afc..3280533eaebe 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -82,6 +82,15 @@ static int __init kho_parse_enable(char *p)
 }
 early_param("kho", kho_parse_enable);
 
+/*
+ * For architecture code that finds, after the early parameters are parsed,
+ * that it cannot pass the KHO state to the next kernel.
+ */
+void __init kho_disable(void)
+{
+	kho_enable = false;
+}
+
 struct kho_out {
 	void *fdt;
 	struct mutex lock; /* protects KHO FDT */
-- 
2.53.0


