Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F6606A31D
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NlH8T+7f;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=i55A+5mj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7dxq8eDBlDPCIVTBkGYSUFbRjgK/3rDeHdp3Ckw4nU4=; b=NlH8T+7fxM8ZdX
	A3FoGYQOEyP1nvk7sAitVI6RMt0jFiW/1sasLo/nQRz1bOuxeR87X8irgh/jiGY5a/zv2eDHz/Wx8
	ddZ3dB3sWF4dJbIv3IjbBRbcrFRxw7PXSqH86DBA3pyBKz+OOS6sFb7++c8xVgQ2U4n20WhM8kVmP
	p21iBO039fz/OtF7imkRGeiZPB/DbbZN23Jcx5roIO9UnXLfY/5EF6UoEx7tQVPTW3g5nU7iSvD1Z
	HxVkE6I8eclDcb3bh4IMLKkirJFC6l1kLfKaSichxw9GWqc7lLa2tA1sxJQaDHFBfABx9Xh1bUQ24
	5HB2+yy0Wq/Nklcmg4iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cw-00000001F5p-49ec;
	Sun, 25 Oct 2026 17:40:34 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cs-00000001Exi-24l7
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:33 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-98febe968deso1807068241.0
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950029; x=1793554829; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dxq8eDBlDPCIVTBkGYSUFbRjgK/3rDeHdp3Ckw4nU4=;
        b=i55A+5mjXE8Mx5x1yWanxbuNOMS1xORFB6H/fRcYrcRADgfAMQAcvIdmy2ip0vQu8H
         PmK85E2ME7MFNKdEJNBwljmjmVEMp7Sjf78szMX4UweRBboPFXMedHNPslXRmqppPjCJ
         fTm7XCuSTA/dN7jrFdUVJVhJRAziM9ByThM6hQsbnyLWSysEOIokEX70Bw328Rrotu6C
         vQ2S1ynwHClQ9xCnGTw175mcRpC13Giok04/64O5rOrIIGYQHX/n0qNXzhTk5sLNPySU
         0B5HsLSBD5OZuSM0YGR3yeKVrXrkR/RIeVhYc2K2kTO/8+b+oULqWMLlV8rqjwWHBfET
         sYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950029; x=1793554829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dxq8eDBlDPCIVTBkGYSUFbRjgK/3rDeHdp3Ckw4nU4=;
        b=DMJyrjVhEfCm1VCOQOqNTmkDGXS6IxeVLxwc37SYW1ZSAiscRiBEhmhEVmWwJlfAdN
         UhUCuCKIzpKwRahoKZRjlS3p+Mag11kKFldB0EYVAm0fl5z9SgKOyhlhw2tMK24SwNik
         88dlLZRIhjWuaBaUlxeSzNbUifbwt69EuCKT7kJXiBz1oLfIOWYF55bI2dc3QH5C1MEg
         aP+VRg8hfBaKTS8J89wUEGJx6dWLnVFrrjEINBH3UyOimivFeFKZHcYXfRgttERKKgqr
         9+Ucc7sSEUm0L/5qUGInaEr/f33iB2ZBYytLQ651R0asLKAatpJW9VCcWHILDPBUFB2L
         7Bcg==
X-Forwarded-Encrypted: i=1; AKwUvBxPjGtzflurvZNiXl0QREbv2a9iu5iuUH73Fj/2BeLEVeLRMUrdEsqm4YlHnRXMwv67pXRePw==@lists.infradead.org
X-Gm-Message-State: AFq9FYId3PYrvA7v69ZXhcus00Zqg0mpgDM7H+vNOsBn3r2E2U1lep7f
	YXX8Cj0ehrHnqqZesv9+nEbhBeqnX9mbTMq2UbKT3UTHgSpX3f1281tGDbJO+hThRX4=
X-Gm-Gg: AYBFou2ei/QPCaX9+rW2P1HsGV8snCrlpFAMvHPPWCjQYDuatmyDg+7f7FePds81p0n
	Clzh6Y4zjwQcQbX71CTTtNIGm0hjAPhWazk/YjyzMDKppkbMAQ4ys3AduknvqzFPPVnuSpkggH3
	47SWp1mq1qEIiuqh2gqbkW4hAM9OrVoq4pNgbT4/TX5G4WmxynjvWduxxTY4NquzMxpI+cNInln
	sdoafZXabHD05c7n99qf6PIv9y847dvEBlFNQBRQ1gJe/kf3pOzBqcJZkq0PjYDa3Cdsfv2vUTN
	FPl/3/X90BI0Vt1jj9YckTwP7vOQeIrck8n13OqIkGYWHtWFUjYVVpBXedbLrElYpGh7w80FmBS
	pWVs+rBMSQyrRmXz7bVH+tb9byJZoaTDBVyaqexNxtAqHUlDIC38+8kKca2u3aVxyj65K7BE+UY
	FkX3k2pLmYtdWt6/5ILYscwxb4LErFdZplrje4ZCe0fnfQn4cbEwlvRe7n6tnQkLx7M/Dl1wr9B
	yheXar1mchTsz02POICUfl+dPj0Z46TX5u7TX6wW/0FgKPMDGskxNOtat4BNTlzEO3hQEZjhjMq
	WAk5lni9A6lfZ2Tflb0XPmhTZMCKgkYemUvzcLBQZUkZkMNu6ymbC5L4Hc1qsh2YsWMJTxSBsit
	8
X-Received: by 2002:a05:6102:41a3:b0:7cc:2f04:a078 with SMTP id ada2fe7eead31-7ce5ce4cc06mr1588692137.37.1792950029106;
        Sun, 25 Oct 2026 10:40:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:28 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 7/9] kho: support read-only KHO mode in kho_block
Date: Sun, 25 Oct 2026 13:40:14 -0400
Message-ID: <20261025174017.3870481-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104031_217421_768C6A8F 
X-CRM114-Status: GOOD (  14.32  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In read-only KHO mode, incoming serialized kho_block chains lie outside
the kernel's direct map and must not be modified or freed back into the
page allocator.

Map incoming serialized blocks read-only via kho_ro_map_folio(...,
PAGE_KERNEL_RO) during cycle detection and restoration, and skip calling
kho_restore_free() when destroying or shrinking a block set in read-only
mode.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kho_block.c | 62 ++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index a4e945f28fad..5b08bd8a9623 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -60,10 +60,24 @@ static void *kho_block_entry(struct kho_block_set_it *it, u64 index)
 	return kho_block_entries(it->block) + (index * it->bs->entry_size);
 }
 
+static struct kho_block_header_ser *kho_block_map_ser(phys_addr_t pa)
+{
+	if (!pa)
+		return NULL;
+
+	if (kho_is_ro())
+		return kho_ro_map_folio(pa, PAGE_KERNEL_RO);
+
+	return phys_to_virt(pa);
+}
+
 /* Free serialized data */
 static void kho_block_free_ser(struct kho_block_set *bs,
 			       struct kho_block_header_ser *ser)
 {
+	if (kho_is_ro())
+		return;
+
 	if (bs->incoming)
 		kho_restore_free(ser);
 	else
@@ -197,6 +211,19 @@ void kho_block_set_shrink(struct kho_block_set *bs, u64 count)
 		kho_block_set_shrink_one(bs);
 }
 
+static bool kho_block_step_pa(phys_addr_t pa, phys_addr_t *next_pa)
+{
+	struct kho_block_header_ser *ser;
+
+	ser = kho_block_map_ser(pa);
+	if (!ser)
+		return false;
+
+	*next_pa = ser->next;
+
+	return true;
+}
+
 /*
  * kho_block_set_is_cyclic - Check for cycles in a linked list of blocks.
  * Uses Floyd's cycle-finding algorithm to ensure sanity of the incoming list.
@@ -205,30 +232,26 @@ void kho_block_set_shrink(struct kho_block_set *bs, u64 count)
  */
 static bool kho_block_set_is_cyclic(struct kho_block_set *bs)
 {
-	struct kho_block_header_ser *fast;
-	struct kho_block_header_ser *slow;
+	phys_addr_t fast_pa = bs->head_pa;
+	phys_addr_t slow_pa = bs->head_pa;
 	int count = 0;
 
-	fast = phys_to_virt(bs->head_pa);
-	slow = fast;
-
-	while (fast) {
+	while (fast_pa) {
 		if (count++ >= KHO_MAX_BLOCKS) {
 			pr_err("Block set is corrupted\n");
 			return true;
 		}
 
-		if (!fast->next)
-			break;
-
-		fast = phys_to_virt(fast->next);
-		if (!fast->next)
+		if (!kho_block_step_pa(fast_pa, &fast_pa))
+			return true;
+		if (!fast_pa)
 			break;
 
-		fast = phys_to_virt(fast->next);
-		slow = phys_to_virt(slow->next);
+		if (!kho_block_step_pa(fast_pa, &fast_pa) ||
+		    !kho_block_step_pa(slow_pa, &slow_pa))
+			return true;
 
-		if (slow == fast) {
+		if (slow_pa == fast_pa) {
 			pr_err("Block set is corrupted\n");
 			return true;
 		}
@@ -266,7 +289,11 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 	}
 
 	while (next_pa) {
-		ser = phys_to_virt(next_pa);
+		ser = kho_block_map_ser(next_pa);
+		if (!ser) {
+			err = -EINVAL;
+			goto err_destroy;
+		}
 		if (!ser->count || ser->count > bs->count_per_block) {
 			pr_warn("Block contains invalid entry count: %llu\n",
 				ser->count);
@@ -283,11 +310,14 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 
 err_destroy:
 	kho_block_set_destroy(bs);
+	if (kho_is_ro())
+		return err;
 
 	/* Free the remaining un-restored blocks in the physical chain */
 	while (next_pa) {
-		struct kho_block_header_ser *next_ser = phys_to_virt(next_pa);
+		struct kho_block_header_ser *next_ser;
 
+		next_ser = phys_to_virt(next_pa);
 		next_pa = next_ser->next;
 		kho_block_free_ser(bs, next_ser);
 	}
-- 
2.56.0.307.g5fe7bd680c-goog


