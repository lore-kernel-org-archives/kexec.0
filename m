Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6460A2610
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ruUJ4Zt2;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UFyQr3M0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hq4FetZ9TbMuXfM2xTa4nRWlSTgcNRWAkocFboOGKak=; b=ruUJ4Zt2xBAu+K
	rBPsV7XkOwM2Ds7sNAx45VcB4qsdBvXXmPKT3nH5UAdfcdET7oYKYdp99nfN68/76Fzo3verOodNu
	e9bCtJprDiBDrneoMTYt0r2KNng6O2Qrqksun+Tdw0yINJEUWCEOEghT46OSpmYjIbr6N3v0v9TrV
	t0n9rnR6XJf58MCRvFx4GQbQQY2yFgtc8nidHREf2VRt25gppvRfcU3f6UcLZu68TiXWMZnCCBzbs
	TOYwgGDEbKikeGjrxTN8+NwVneAskxYRjIb0Bb/dURAd8nROm8K1Q/F/mTIt1Le3QeBFE+RNnJ367
	f5vLZfG0a8zFwB0864bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD8-0000000AJeN-2Kne;
	Wed, 18 Nov 2026 21:28:58 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD1-0000000AJaW-3lqo
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:53 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so230342e0c.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037330; x=1795642130; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hq4FetZ9TbMuXfM2xTa4nRWlSTgcNRWAkocFboOGKak=;
        b=UFyQr3M0koDbO95ptYyjPEVuIv7YW8CxnpNzxjNStkKTgL7oYPpYXSm4qBrSpVjueu
         MgJ893/PRgH6civBkrEHmIoOlclfe6a71x8KPAGQm5rBPWVxSFDM0Xk0ja7zuCyJFaUP
         RqRy/+gz8DExOJCLX6M4uYzR7376C6k+X2OZ7eLUICAWReWm6NKiqQIRToHoAn+/DwiE
         z9PUZlBx0tMwRITYq9zCISv1WlkQxpA+Rp6+beERYHwSQr7ibCO2FS7cKEYZcb4M01lD
         VW/pvhc/tPj6norEGPbxa8bJb0cvgA5MnDQrrC3LAYCXKONh3Lx6h8UICCSSX1R5H8Og
         XIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037330; x=1795642130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hq4FetZ9TbMuXfM2xTa4nRWlSTgcNRWAkocFboOGKak=;
        b=y1sPuE9q8fCQ77a0g3WS0C3b+U4EC8hAUvCnxThGGzRv8iBaM32ChSaR5lGdrUfQHP
         H8NN3syAcCCmqSjE2weDQUKsNbZibyB/E9iha/infzvas73izUax1Ezd6R67k0Y8ftOY
         VoxYtN8uEkCtNVekQ6+G14Jnl2+Hn1lYO/vPrW+k+FCR/IAK0okmRtcI2JeVUvzJyNzE
         eq16BF4eC+wN+Dc32dKLgEBVAbjmSv85nrZIrkq1MP4IJQWqD5mn6A6lVgm173lLEUj1
         EkHZxKGk3kXW7ahVkjje1xAoKV1PISFutQZa2PbMlnWz8MZeX1aiofl9KiuouTwCf7nN
         UACQ==
X-Forwarded-Encrypted: i=1; AL+hErG9bdbXFndoJK21iVxILnNnH9WWnLxkXG/VSKHyq1VTI5oD8wu77ZxxRJxHZKRZ8oHegG7Ntg==@lists.infradead.org
X-Gm-Message-State: APuU4Z9F46PzpVJ3b9oiXP9oIfaSTy0/6Wj8oZaYaIXiaZeGcqouk5jJ
	6mBQlocr6uct3H4OM2BBVzNuNVGMkR1peNHtceIyO6JrQtRWqqexEZJ4IcBiHyN+AA0=
X-Gm-Gg: AYBFou0815S15Og/kG8gGwX8we+skDYVRIA+SAEtl6e6l+Prs2Du048LgdQ5lhJTyD3
	iAhvqSdLQO9C6mN5vsVSIcKBwIk/yzcQobAQVSsCVEOK3LTAZKhzztsd10PXlsPv4m/yEY8rd4+
	vB4zjXvdGEci+/3fUnAiaJPvInMHArt6lvVISUZNXk/9apTFixxcHxvgMEDsiUhjHNIcQqrN6Yl
	/l/CRct8CY6zTeZzz2+95P6A/4rffi8MsTceP1wIglqsYfrfecWds/b0qAQKj0ahbLHCtvs3Omf
	0a7HXwfRjXXvd4Oi0aG9JFLkknSqQvqZSX2tGpeh6BX7d+A/KbI4OGTfPa/qC/MhgCbUSo/hG4h
	UTrnc7YHV5Cv+E+aYOCrFn2nokKI6Fdjl2AvR0IGntciebReV0vY8msp8QZY2BjBfun150B8scc
	03hZ0i7xbDPGvONiI8sipowdo2B+7p5Jp20X5cmQytW8vuUQxAVHCuG5slAKZtb3kJgvk7diORk
	P3cqRH6kXJverAFaQDWhS6c6RpcMEv6oe/QvRhb0fCJBJrovrraZpC32r3zDJESIx9INzJG3xh/
	aySVAzSRANpEXgbByhQ9EtCoQDyYYvvne4j+rj2d6OA6AzcI+MicltGwPWITW262N3YrdNBCi+j
	65cHmOL8jduWAeg//nIKKOThdDiWYLr+DczqujbFy//IO8I2p9E6y
X-Received: by 2002:a05:6102:548e:b0:7ba:b5ea:c4b8 with SMTP id ada2fe7eead31-7d6cb42f39emr262542137.1.1795037330488;
        Wed, 18 Nov 2026 13:28:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:50 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 2/7] kho: link outgoing blocks lazily in kho_block
Date: Wed, 18 Nov 2026 16:28:37 -0500
Message-ID: <20261118212845.2855249-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132851_954573_CD87F954 
X-CRM114-Status: GOOD (  19.73  )
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

Currently, kho_block_add() links each preallocated block onto the
serialized chain immediately, even while it is still empty. This
assumes all preallocated blocks are populated together before the
chain is referenced by KHO.

When sessions are serialized incrementally ahead of reboot, extra
blocks may be preallocated for sessions that have not been serialized
yet. Keeping those blocks linked leaves empty trailing blocks on the
KHO chain.

Keep preallocated outgoing blocks unlinked in kho_block_add() and link
each block lazily in kho_block_set_it_reserve_entry() when advancing
into it. Also unlink blocks in kho_block_set_clear() and stop at
unlinked blocks in kho_block_set_it_read_entry().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kho_block.c | 38 +++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..21cee45fa1cc 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -16,6 +16,11 @@
  * array of serialized entries. Multiple blocks are linked together via a
  * physical pointer in the header, forming a linked list that can be easily
  * traversed in both the current and the next kernel.
+ *
+ * Outgoing blocks preallocated via kho_block_set_grow() remain unlinked until
+ * entries are reserved via kho_block_set_it_reserve_entry(). This allows
+ * entries to be serialized incrementally without exposing empty trailing blocks
+ * on the physical chain.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -79,7 +84,7 @@ static struct kho_block_header_ser *kho_block_alloc_ser(struct kho_block_set *bs
 static int kho_block_add(struct kho_block_set *bs,
 			 struct kho_block_header_ser *ser)
 {
-	struct kho_block *block, *last;
+	struct kho_block *block;
 
 	if (bs->nblocks >= KHO_MAX_BLOCKS)
 		return -ENOSPC;
@@ -89,15 +94,11 @@ static int kho_block_add(struct kho_block_set *bs,
 		return -ENOMEM;
 
 	block->ser = ser;
-	last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
+	if (list_empty(&bs->blocks))
+		bs->head_pa = virt_to_phys(ser);
 	list_add_tail(&block->list, &bs->blocks);
 	bs->nblocks++;
 
-	if (last)
-		last->ser->next = virt_to_phys(ser);
-	else
-		bs->head_pa = virt_to_phys(ser);
-
 	return 0;
 }
 
@@ -144,9 +145,9 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
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
@@ -312,12 +313,15 @@ void kho_block_set_destroy(struct kho_block_set *bs)
 /**
  * kho_block_set_clear - Clear all serialized data in a block set.
  * @bs: The block set to clear.
+ *
+ * Resets entry counts, unlinks blocks, and zeroes all entry payloads.
  */
 void kho_block_set_clear(struct kho_block_set *bs)
 {
 	struct kho_block *block;
 
 	list_for_each_entry(block, &bs->blocks, list) {
+		block->ser->next = 0;
 		block->ser->count = 0;
 		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
 	}
@@ -340,14 +344,16 @@ void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs
  * @it: The block iterator.
  *
  * Reserves a slot in the current block during state serialization to add a new
- * entry, advancing the internal index. If the current block is full, it
- * automatically moves to the next block in the set.
+ * entry, advancing the internal index. If the current block is full, it moves
+ * to the next preallocated block and links it onto the serialized chain via
+ * the previous block's header.
  *
  * Return: A pointer to the reserved entry slot, or NULL if the block set's
  * capacity is fully exhausted.
  */
 void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
 {
+	struct kho_block *prev = NULL;
 	void *entry;
 
 	if (!it->block)
@@ -356,12 +362,16 @@ void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
 	if (it->i == it->bs->count_per_block) {
 		if (list_is_last(&it->block->list, &it->bs->blocks))
 			return NULL;
+		prev = it->block;
 		it->block = list_next_entry(it->block, list);
 		it->i = 0;
 	}
 
 	entry = kho_block_entry(it, it->i++);
 	it->block->ser->count = it->i;
+	if (prev)
+		prev->ser->next = virt_to_phys(it->block->ser);
+
 	return entry;
 }
 
@@ -381,7 +391,9 @@ void *kho_block_set_it_read_entry(struct kho_block_set_it *it)
 		return NULL;
 
 	if (it->i == it->block->ser->count) {
-		if (list_is_last(&it->block->list, &it->bs->blocks))
+		if (!it->block->ser->next)
+			return NULL;
+		if (WARN_ON_ONCE(list_is_last(&it->block->list, &it->bs->blocks)))
 			return NULL;
 		it->block = list_next_entry(it->block, list);
 		it->i = 0;
-- 
2.56.1.708.g77570a6a1d-goog


