Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250B606D830
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iKDm80tf;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=k8Yyxand
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QR7+RzYUX4/ytxM/0jS+GRtrp88N8Eh0P5U9HMcYULs=; b=iKDm80tfoMlVSa
	D9X/YQA83sW2UyRATf1hOGpi0r7YxViJkZX8Gdonxm3VeI/JWGqcF1eUfwlxYvrKty85S6Qitmxlg
	qEsyfcuwet/L+E8qnpoweKdZcHfzvBiV13CfwiKcMMzhkc89xZVFt9ZgQR7CzTBSq1Mknr6CebB3g
	emq36ScDy4G5kpP6IiJvPyh41amDaeX9xJ6/JEOmFvcLwDtpZ9zXwDbIdZypJCr83vYSdhujaRiWS
	cJ4VJt/fKq39f11PAdW6/byW70g5fsPQoa/ly2oepLol0ugMfcduuzSzSDfO9lin+Vf8jaZ6KlrqZ
	GhlbZOTK8hr9P3x8R8RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpay-00000007prO-42G3;
	Thu, 05 Nov 2026 05:01:04 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpav-00000007pp8-32qN
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:02 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5eac01ff101so575885e0c.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854860; x=1794459660; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QR7+RzYUX4/ytxM/0jS+GRtrp88N8Eh0P5U9HMcYULs=;
        b=k8YyxanddynQsnoZ9iX+cilwbRSTQHGlPHF+HDdOLVBAXmp2T+9+KmJQ310r1y2FEE
         hfLOFDv7YUVgZStnTOraidM7S0UqcH7u1pxNEKY6cG/pPOvvKbbnRgAjq+cBezB4nSfu
         4QrbOuUI3MZ4ut4ikODqUhD2XqZzxTq8RwcU++CS49jDgBDLeC1eoTTasRXhprB6Iuae
         /40lqLbhAch+h5Jwro0ZyTEVrf7+u+yRiqAYWwHJsJKiuYQtp3CQWSqBaauk32Uh6hgK
         TFYxIgvnC6/3qVgiCtUDi3wTElbOKODKyEASYgdtsRhyohdZu34IPngsXIFKyQzKJy5b
         P+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854860; x=1794459660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QR7+RzYUX4/ytxM/0jS+GRtrp88N8Eh0P5U9HMcYULs=;
        b=De1uO4Tfx3sU5V3XnIUneONOIGKYqJMlNXWd4L5qV0DSNM2KfaUA7QS9VK8/j0j+p0
         N4zs18YwSu/8tbXULMfSckvSh+SSQ+5XP+l1hLnHmynPNMxMmQVlm1irO84QPEJRcrQM
         SeX7vG6fir66gjlV+KAmXmOqwJ3COZEdQ1MxBLYam3P3TkkoKAOrBSZVP/UFt153YV7r
         i7eSnfOpW0bVjuFVQggXHwKYh72iVVYVasKN6nJYtRTflViTY4BHPAtj77ng3no2Q7pk
         SZ95+PjjV4C/5Tdg4oiLncbZYmPdWveGIdgn9Tv89I0Z3YZxUQKhB2bsGApBtt8Fnutn
         CI8A==
X-Forwarded-Encrypted: i=1; AKwUvBwfOYFfOm7jQQkJo+bXY2fpNdHP0yaR5+8stPE+AE7WRJrnn6gXulxivdAm/2yjS+iUQFp2Kg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+vIrklObe5N+6AD0R4fQThD04SfPBQDcXMj3u7Mx80Ls8CjK51
	aaViDDcUF6AMBfNG2OHyAdP/gJoB+3fTrSVazYmMgLjcFpVjE5XCbhFR7Uz97F7pWCs=
X-Gm-Gg: AYBFou2W8xfYjzCep+j2c0QQTxx01ZAlSrPYOaepWnqBbBgjtJ3h5ai4SYbGeWaEE22
	XmdpCnMb5Amyo7rKQtoOP2jysJzJ1NeLAtGP9uZoMJMTbvCYLGPicgv9/OMSDAkoFlEV3k6Ntjw
	UsMAyAyyvHmZmuHddotyHsJdANSNwXiFu3xchXimy6QEW5GSkz7UNZjdeHNpJQyXR5Aaa6CEimx
	lNyJhRUKtq0LKn12vvTV0Wm+jhwsNjw4SV+mkMuq+A9Uk90cyFLIl0Z7HWITvdvTjOwnmlDg6ys
	UXk3g670wmJ2Fi5+dokle5T8d/+6dvOZ0l/fnQkTKH8EwwNX1E8QYJVQbePN55I4IhIx3a8pZqv
	wUIz95X/WJVRWMw7dFJdo4RP5bPr3hvmdLhwVSJt2C3fGD132F7LiOE6lJfC7/ZlSyTw2p9ABRr
	00kUOSCzdPnFVl04FmjCI5fe6LJ96c9ol6eYFjvlNFCdt9U2ZlSHAA9cjVBRTM1xotUTPCKKJ5+
	DectPlr0hpo9lAUOPPhOBgOcHbPMkBYp6nX/5Up0iMMWmUhnhDIMvYYTqPNUPp919JmnwnAuzQR
	nYIBUkn5wvI/5RIwOySt0A5u1+vwPnI9piw0ztZp8Kmye7EuHjqSmBKn4sUo/MM5hvxOgKg0Z7M
	y/Z86Q6gX3mBsUIx1YdTIRQcRB0o6pT0CAw8iGlJ5XnaqTb+D6Q==
X-Received: by 2002:a05:6122:512:b0:5da:9b81:1aa4 with SMTP id 71dfb90a1353d-5ec6870c946mr7158777e0c.5.1793854860291;
        Wed, 04 Nov 2026 21:01:00 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:00:59 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v5 2/6] kho: support incremental entry publication in kho_block
Date: Thu,  5 Nov 2026 00:00:48 -0500
Message-ID: <20261105050053.3063001-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210101_792776_F8676F9F 
X-CRM114-Status: GOOD (  22.95  )
X-Spam-Score: -2.1 (--)
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

To allow LUO sessions to be frozen and committed into the outgoing KHO
subtree from userspace ahead of reboot, kho_block needs to support
publishing entries one by one into a live serialized block chain while
new blocks may still be preallocated or shrunk for uncommitted sessions.

Currently, kho_block assumes outgoing block sets are populated in a
single batch during reboot() before the chain is exposed: preallocated
blocks are linked onto the chain immediately even while empty
(ser->count == 0), and reserving a slot increments ser->count before the
entry is populated.

Address this by keeping preallocated outgoing blocks unlinked in
kho_block_add(), linking blocks lazily only as entries are written. Add
kho_block_set_it_append() to copy each entry into its slot before
publishing the updated ser->count and next-block link via
smp_store_release(), paired with smp_load_acquire() in
kho_block_set_it_read_entry().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho_block.h     |  1 +
 kernel/liveupdate/kho_block.c | 86 +++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
index 93a7cc2be5f5..a9e696ef3e08 100644
--- a/include/linux/kho_block.h
+++ b/include/linux/kho_block.h
@@ -100,6 +100,7 @@ static inline bool kho_block_set_is_empty(struct kho_block_set *bs)
 
 void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs);
 void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it);
+void *kho_block_set_it_append(struct kho_block_set_it *it, const void *src);
 void *kho_block_set_it_read_entry(struct kho_block_set_it *it);
 void *kho_block_set_it_prev(struct kho_block_set_it *it);
 
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..2813c6fd593c 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -16,6 +16,12 @@
  * array of serialized entries. Multiple blocks are linked together via a
  * physical pointer in the header, forming a linked list that can be easily
  * traversed in both the current and the next kernel.
+ *
+ * Outgoing blocks preallocated via kho_block_set_grow() remain unlinked until
+ * entries are written into them. Callers publishing entries incrementally into
+ * a live KHO subtree can use kho_block_set_it_append(), which populates each
+ * entry before exposing the updated block count or next-block link via
+ * release-store ordering.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -93,9 +99,7 @@ static int kho_block_add(struct kho_block_set *bs,
 	list_add_tail(&block->list, &bs->blocks);
 	bs->nblocks++;
 
-	if (last)
-		last->ser->next = virt_to_phys(ser);
-	else
+	if (!last)
 		bs->head_pa = virt_to_phys(ser);
 
 	return 0;
@@ -129,14 +133,15 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
 	last = list_last_entry(&bs->blocks, struct kho_block, list);
 	list_del(&last->list);
 	bs->nblocks--;
-	kho_block_free_ser(bs, last->ser);
-	kfree(last);
 
 	new_last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
 	if (new_last)
-		new_last->ser->next = 0;
+		WRITE_ONCE(new_last->ser->next, 0);
 	else
 		bs->head_pa = 0;
+
+	kho_block_free_ser(bs, last->ser);
+	kfree(last);
 }
 
 /**
@@ -144,9 +149,9 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
  * @bs:    The block set.
  * @count: The target number of valid entries to accommodate.
  *
- * Dynamically preallocates and links preserved memory blocks if the target
- * entry count exceeds the current total capacity of the set, ensuring they
- * are available during serialization/deserialization.
+ * Dynamically preallocates preserved memory blocks if the target entry count
+ * exceeds the current total capacity of the set, ensuring they are available
+ * during serialization/deserialization.
  *
  * Context: Caller must hold a lock protecting the block set.
  * Return: 0 on success, or a negative errno on failure.
@@ -318,6 +323,7 @@ void kho_block_set_clear(struct kho_block_set *bs)
 	struct kho_block *block;
 
 	list_for_each_entry(block, &bs->blocks, list) {
+		block->ser->next = 0;
 		block->ser->count = 0;
 		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
 	}
@@ -348,6 +354,7 @@ void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs
  */
 void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
 {
+	struct kho_block *prev = NULL;
 	void *entry;
 
 	if (!it->block)
@@ -356,15 +363,73 @@ void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
 	if (it->i == it->bs->count_per_block) {
 		if (list_is_last(&it->block->list, &it->bs->blocks))
 			return NULL;
+		prev = it->block;
 		it->block = list_next_entry(it->block, list);
 		it->i = 0;
 	}
 
+	if (!it->i)
+		it->block->ser->next = 0;
+
 	entry = kho_block_entry(it, it->i++);
 	it->block->ser->count = it->i;
+	if (prev)
+		prev->ser->next = virt_to_phys(it->block->ser);
+
 	return entry;
 }
 
+/**
+ * kho_block_set_it_append - Write and publish an entry at the next slot.
+ * @it:  The block iterator.
+ * @src: Entry data of size @it->bs->entry_size to copy into the slot.
+ *
+ * Copies @src into the next available slot before updating the block's entry
+ * count or linking a newly occupied block to the previous block, so concurrent
+ * readers never observe an uninitialized slot or an empty block.
+ *
+ * Return: A pointer to the written entry slot, or NULL if the block set's
+ * capacity is fully exhausted.
+ */
+void *kho_block_set_it_append(struct kho_block_set_it *it, const void *src)
+{
+	struct kho_block *prev = NULL;
+	void *dst;
+
+	if (!it->block)
+		return NULL;
+
+	if (it->i == it->bs->count_per_block) {
+		if (list_is_last(&it->block->list, &it->bs->blocks))
+			return NULL;
+		prev = it->block;
+		it->block = list_next_entry(it->block, list);
+		it->i = 0;
+	}
+
+	if (!it->i)
+		WRITE_ONCE(it->block->ser->next, 0);
+
+	dst = kho_block_entry(it, it->i++);
+	memcpy(dst, src, it->bs->entry_size);
+
+	/*
+	 * Ensure the serialized entry is visible before exposing the
+	 * incremented count to concurrent readers.
+	 */
+	smp_store_release(&it->block->ser->count, it->i);
+	if (prev) {
+		/*
+		 * Ensure the new block's first entry and header are visible
+		 * before linking prev->ser->next for concurrent readers.
+		 */
+		smp_store_release(&prev->ser->next,
+				  virt_to_phys(it->block->ser));
+	}
+
+	return dst;
+}
+
 /**
  * kho_block_set_it_read_entry - Read the next serialized entry from the block set.
  * @it: The block iterator.
@@ -380,7 +445,8 @@ void *kho_block_set_it_read_entry(struct kho_block_set_it *it)
 	if (!it->block)
 		return NULL;
 
-	if (it->i == it->block->ser->count) {
+	/* Pairs with smp_store_release() in kho_block_set_it_append(). */
+	while (it->i >= smp_load_acquire(&it->block->ser->count)) {
 		if (list_is_last(&it->block->list, &it->bs->blocks))
 			return NULL;
 		it->block = list_next_entry(it->block, list);
-- 
2.56.0.398.g882cbad275-goog


