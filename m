Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AB60A380C
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1i5NoZ5I;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S/0Lb/4h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=; b=1i5NoZ5IBB6Op8EDWAX5DLerRF
	p0A2GFAq2X82HQ9CT52/qfwZVoGd0VJND24QgXJnqlz3D5DkKtgg8Dm6zgEpc9o3/96/nC4vmzZ/M
	QaEMXopHcv5kGXsS/1xQ5Lh1PJ1+zt9hGjDYvKDdOVOozWb4N0mBD2j3WhhRKHuWS1qHtCyCIMHIz
	0aOFT19yRt7tD84ttX3rAYbO+j6Nq4cBkHP0BySwOTsOCsaxMJYTpKt6apMv1E/QwW1aKYYVB1HcI
	WSPZ0ORwvD99tiX+s3f2MFNxzkAqKBlWi8WuJ5jS+KDO4C6pKTBaAGrMIk4bOkJKGJ6al/rWLcHlR
	5yrb310g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0E-00000002Rvo-0MG2;
	Tue, 10 Nov 2026 05:02:38 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzw-00000002RQ5-2ozB
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:23 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c50549f6cf1so9144566b.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286938; x=1794891738; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=;
        b=S/0Lb/4hoJAQatZ84H7WmmxaG0vjXVeBySIlLVJn9Alp2Fuw3buz77nNeCw0kWpKCI
         tx3oaDXeeXLfQWMkyxN0c5tFmOC4oik4PpAYX9oElMMrZREbtd7NJpx/WJUVLaZWilv9
         URiNDC7ZgkSH6w2cNhtONGlSE9EGgPEWACyppmyOoJ+jn+UBPCq5B+eKmxOWAgK37a4o
         qx9zE1BlWgO+ZXCxevhH5XP6mt2OL2ZlCub02DKcIXpEGMu5KQzMg7K+W0lUMO0nUqJA
         Px8EexLtDdeVrQlq6O7xHXHL6qRr8UP3WB4lNT1SsK7rWnLNWd0vlnqeB3+R3XkKwTwW
         KZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286938; x=1794891738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=;
        b=vpBUt74OS9+okwU+xgVcE7W2eEW4pZRaYNeenthC5hgn9ckB5MU+opJk1b1a0xctZw
         I1Jt4e4jyZloBbUiLvjvDuX3sBCdzPzmFtlNyEIIHQH56fz8bJNGjvquihepo6+YYjCY
         4iA23J/tc1IZZ6JLmgc2GvNvkhAiR6XJ8keb9A+RRDUErlHSLcPKrRcDAFhTtgSz1kD2
         wvq2nqPC2+Z7H2X/Qb9L6eJAWK+Ntj//BVLL+zMf66YHDoNNPSUjDfPRsdW0GxEmbsZG
         LmOul6lV+Ofkv79rmMoCnnW9NRn/pWPTHTojmixMIaLArmp1BBUL4vIeFk4FUrXXoK1e
         W8Cw==
X-Forwarded-Encrypted: i=1; AL+hErET2Mz5vIGI1hvExml6Uy0ZRYvXcDtCXZI/46TULa2f82j7lIOo4SyLPlNPmSXOyStMRKX+DQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8yqafls+cwwiJUvSewJ1B3jVyt935j7A6JvsS7tpcRdsLBgh5U
	ZlRKv3qkHTDlQ3q2Y63j+ynjUFIucuTfR78LTSqbuyYA55VHDAFFH9mRs+G1PJEMsA7KS4OK7zK
	JZzkkM8nA5GMckJrCcg==
X-Received: from edzg2.prod.google.com ([2002:a05:6402:902:b0:6b5:8540:2bf])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d8f:b0:c48:a838:c16d with SMTP id a640c23a62f3a-c5049629dbbmr100182566b.30.1794286938072;
 Mon, 09 Nov 2026 21:02:18 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:55 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-13-tarunsahu@google.com>
Subject: [PATCH v4 12/19] liveupdate: Add feature header to struct luo_file_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210220_779561_48F5D766 
X-CRM114-Status: GOOD (  15.01  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Precede each serialized file entry in a LUO file set KHO block set with
struct kho_ser_hdr via DECLARE_KHO_SER so future per-file metadata
features can append fields to struct luo_file_ser without breaking
compatibility between adjacent kernels.

Initialize file set block sets with kho_ser_size(luo_file_ser), initialize
each entry feature header in luo_file_freeze(), and validate the incoming
feature header in luo_file_deserialize_one() before accessing the struct
luo_file_ser payload.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h  |  6 +++---
 kernel/liveupdate/luo_file.c | 26 +++++++++++++++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index bd19211c64e1..38b4658183a2 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -92,6 +92,8 @@ DECLARE_KHO_SER(luo_ser, 24, 0, 0);
  * @compatible:  File handler compatible string.
  * @data:        Private data
  * @token:       User provided token for this file
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
@@ -99,9 +101,7 @@ struct luo_file_ser {
 	u64 token;
 };
 
-static_assert(sizeof(struct luo_file_ser) == 64);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_file_ser) == 8);
+DECLARE_KHO_SER(luo_file_ser, 64, 0, 0);
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 02d09a80d785..2da327f8bdae 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -486,10 +486,12 @@ int luo_file_freeze(struct luo_file_set *file_set,
 	kho_block_set_it_init(&it, &file_set->block_set);
 
 	list_for_each_entry(luo_file, &file_set->files_list, list) {
-		struct luo_file_ser *file_ser = kho_block_set_it_reserve_entry(&it);
+		DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr) =
+			kho_block_set_it_reserve_entry(&it);
+		struct luo_file_ser *file_ser;
 
 		/* This should not fail normally as blocks were pre-allocated */
-		if (WARN_ON_ONCE(!file_ser)) {
+		if (WARN_ON_ONCE(!fhdr)) {
 			err = -ENOSPC;
 			goto err_unfreeze;
 		}
@@ -502,6 +504,8 @@ int luo_file_freeze(struct luo_file_set *file_set,
 			goto err_unfreeze;
 		}
 
+		kho_ser_init(fhdr, luo_file_ser);
+		file_ser = kho_ser_payload(fhdr, luo_file_ser);
 		strscpy(file_ser->compatible, luo_file->fh->compatible,
 			sizeof(file_ser->compatible));
 		file_ser->data = luo_file->serialized_data;
@@ -742,11 +746,19 @@ int luo_file_finish(struct luo_file_set *file_set)
 }
 
 static int luo_file_deserialize_one(struct luo_file_set *file_set,
-				    struct luo_file_ser *ser)
+				    DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr))
 {
 	struct liveupdate_file_handler *fh;
 	bool handler_found = false;
+	struct luo_file_ser *ser;
 	struct luo_file *luo_file;
+	int err;
+
+	err = kho_ser_validate(fhdr, luo_file_ser);
+	if (err)
+		return err;
+
+	ser = kho_ser_payload(fhdr, luo_file_ser);
 
 	down_read(&luo_register_rwlock);
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
@@ -810,7 +822,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
 	struct luo_file_set_ser *file_set_ser;
-	struct luo_file_ser *file_ser;
+	DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr);
 	struct kho_block_set_it it;
 	int err;
 
@@ -848,8 +860,8 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	 * reliably reset devices and reclaim memory.
 	 */
 	kho_block_set_it_init(&it, &file_set->block_set);
-	while ((file_ser = kho_block_set_it_read_entry(&it))) {
-		err = luo_file_deserialize_one(file_set, file_ser);
+	while ((fhdr = kho_block_set_it_read_entry(&it))) {
+		err = luo_file_deserialize_one(file_set, fhdr);
 		if (err)
 			goto err_destroy_blocks;
 		file_set->count++;
@@ -883,7 +895,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 void luo_file_set_init(struct luo_file_set *file_set)
 {
 	INIT_LIST_HEAD(&file_set->files_list);
-	kho_block_set_init(&file_set->block_set, sizeof(struct luo_file_ser));
+	kho_block_set_init(&file_set->block_set, kho_ser_size(luo_file_ser));
 }
 
 void luo_file_set_destroy(struct luo_file_set *file_set)
-- 
2.56.0.506.g506a7eabc5-goog


