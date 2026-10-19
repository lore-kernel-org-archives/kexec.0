Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C59CCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+N9EQwOcSjySxMS4O9eOeYmAxXFE2sVJ9Vy3mk5tWu4=; b=hXdWEkzEXsJCIazUxFhO06nTQz
	bba5k5qdceNi70R3uhS78N3i4hYkRwilx1+kHuFcy9gIOUqXDzAKPx34CKwXhiZngPmao06dfzIs+
	QIojZJlIAIkXbqm+X1uQnFrpdUnmVvx8YGQrojAUobynWIF6GWn8J2oEN/6bQDoi+ScwV/nzhakE1
	ZzXkCgRQ1MqslIVtK9O2r+teLokSm2hb2o5GYMGf2baXtBr6rnOA2i0Jv3whgMwDypu++osEVQYCI
	Yi05mV6Ga9+KkOqguF5SVBVd2tTWjeksaqbeQEAu11rcTWycjg5DmhCo8WomT/5MfPRFy9EvISMXA
	Q0uBwOKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqZ-00000006RXW-1D50;
	Mon, 19 Oct 2026 02:11:31 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqW-00000006RT1-1X8B
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:29 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5e94a057d9eso1276020e0c.3
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375887; x=1792980687; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+N9EQwOcSjySxMS4O9eOeYmAxXFE2sVJ9Vy3mk5tWu4=;
        b=MHrJmgsE3o/qjEwohNJshaFdOf6aMRFhCYPA0lmZNBc9k6SwO5r5EyA+TLZMFFpsgd
         EB3wfsnad59yT1ZmerTypvJt1z+SviYgr1/h2VNHcMwHg7VKr1h2S0VeTYGK3rJfMFpn
         ciaJqrgYULAhpcLtZvGZujcUlIyw7YcVbbUDEU0zb0sjYIQ11bHde4ENXErszJQ+1zfR
         9SIMOejSWbFutUUd2Z0dqD4DjcmcxHqEfBJs3eCr7LO3eKLtbMR1fZLYd9gTaaO9ckyJ
         m1D8LGUG5h9Ls4dJXPecUN1baXHE3NA/y+iDXkjKuOFnt5iKx/2ZIckAK6J5UY3WEt9e
         P5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375887; x=1792980687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+N9EQwOcSjySxMS4O9eOeYmAxXFE2sVJ9Vy3mk5tWu4=;
        b=IFBec4kuKVFve94VH0v1R9cgUvA+DZU0wK4OZM/vq6LLBg2WMxvS92J3S00FjD0nUI
         szu44DVZMU8yJSPDp1XEBNAxoXGFMh02rSNgpI0FRzD1XvwgXGnkKmUWKDAd7b/BDzqc
         UBmgGvwOZTlYxTODJpIp5DzPOm3IdvPJ1M+Y7c94pWLdqvyMT6RsqvNEjimDlKis5hGu
         wx5zq5dt1E8OyOBzVnMZSgrZt4cRmEZpOECBO6gaFOWmdYdztZRmO4YyAaVHVm1FadzJ
         XrFZC9r8o8DAp/CxzPWj+VfAMEEjWTyQxn50h6/3/Q3jDAyWPzwAULjGxGs+BTGapD5y
         3H3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxhH7JSTObUaYI2EFh/KlI2xnvG6/NMUOS6ikt0JmdFnxzwV1E52IgFI6+8sAkdHGKZ9jD8Rw==@lists.infradead.org
X-Gm-Message-State: AFq9FYKUabuf1HxXOG45kEp+MMzirC+FdVlRkWtOuXmZ60B8kumMQ+HG
	rIH1mgG3zyiMcVSqe1EZSqn8hIoDGAKyunSciaLXxomeQFgvhoHmzhZ2hCebLa3mU2I=
X-Gm-Gg: AYBFou09GRKAUKYD2i5GMorAZW+12x7b02CTdskC746RIK6vWiirPlcSGLfUzinag2B
	EVKNUtoRrooBoznNF5ZE7TxUdJPa5e0OIOubNtTauGciMkKy1rRkj/nlBLBtfA2fBF87qpX3vUj
	kI5tOt2PF2lRIleD7eUQoBPQYpU9PKwyPNBlrkgd/tnBIc+46BpTSw64WJzqpaXZLC54Daw8HN/
	TMv69Pui+ObBZoWuEt/OvRdlNIAMumDQcHncEBBmZ2tb0WObQ8DFCmpF/5oXWixODdAxq+fzRsJ
	my/r5A3zHoeT1+xZEaIjIy7J8iZ2/6ymZdPFlHFlmgwhBybOPDjKfZ+plSIVR9CwRj87OTIpMsq
	E9x2sP4XcOwA2e0mrazA5D9abJUP4svqLbKiZr8lItqLAuemh5iD+TY1jnBWlxiJoWEkGcfUdT+
	TYeN2iPbkPX47KApJ4tza4b6rcdyxE6k3ESrmbuylxao2kpilSuNFp4jCll129qUepTdPYgqQq6
	z2jPZRmFQbUYzDTU85zAqz/l0TTpJOmOI2iiuw6UExBqqEv6NCf/kHm7ssp8NEy+6jCMX4D0Wdm
	pvj4UwMCxeRn0WSN5zk=
X-Received: by 2002:a05:6122:3115:b0:5ea:a749:d33c with SMTP id 71dfb90a1353d-5eaaa66d4eamr2218681e0c.9.1792375887405;
        Sun, 18 Oct 2026 19:11:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:26 -0700 (PDT)
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
Subject: [PATCH v1 6/8] kho: support read-only KHO mode in kho_block
Date: Sun, 18 Oct 2026 22:11:09 -0400
Message-ID: <20261019021111.990394-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191128_424405_2C94E38A 
X-CRM114-Status: GOOD (  15.86  )
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

In read-only KHO mode, incoming serialized kho_block chains lie outside
the kernel's direct map and must not be modified or freed back into the
page allocator.

Map incoming serialized blocks read-only via kho_ro_map_folio(...,
PAGE_KERNEL_RO) during cycle detection and restoration, and unmap them
via kho_ro_unmap() instead of calling kho_restore_free() when destroying
or shrinking a block set in read-only mode.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Makefile    |  5 +--
 kernel/liveupdate/kho_block.c | 76 ++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index f8b09e04bea2..d3587048e619 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,14 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
 luo-y :=								\
-		kho_block.o						\
 		luo_core.o						\
 		luo_file.o						\
 		luo_flb.o						\
 		luo_session.o
 
-obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_READONLY)	+= kexec_handover_ro.o
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o kho_block.o
+obj-$(CONFIG_KEXEC_HANDOVER_READONLY)	+= kexec_handover_ro.o kho_block.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index a4e945f28fad..a3cf5b964b26 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -60,10 +60,32 @@ static void *kho_block_entry(struct kho_block_set_it *it, u64 index)
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
+static void kho_block_unmap_ser(struct kho_block_header_ser *ser)
+{
+	if (kho_is_ro())
+		kho_ro_unmap(ser);
+}
+
 /* Free serialized data */
 static void kho_block_free_ser(struct kho_block_set *bs,
 			       struct kho_block_header_ser *ser)
 {
+	if (kho_is_ro()) {
+		kho_block_unmap_ser(ser);
+		return;
+	}
+
 	if (bs->incoming)
 		kho_restore_free(ser);
 	else
@@ -197,6 +219,20 @@ void kho_block_set_shrink(struct kho_block_set *bs, u64 count)
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
+	kho_block_unmap_ser(ser);
+
+	return true;
+}
+
 /*
  * kho_block_set_is_cyclic - Check for cycles in a linked list of blocks.
  * Uses Floyd's cycle-finding algorithm to ensure sanity of the incoming list.
@@ -205,30 +241,26 @@ void kho_block_set_shrink(struct kho_block_set *bs, u64 count)
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
@@ -266,16 +298,23 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 	}
 
 	while (next_pa) {
-		ser = phys_to_virt(next_pa);
+		ser = kho_block_map_ser(next_pa);
+		if (!ser) {
+			err = -ENOMEM;
+			goto err_destroy;
+		}
 		if (!ser->count || ser->count > bs->count_per_block) {
 			pr_warn("Block contains invalid entry count: %llu\n",
 				ser->count);
+			kho_block_unmap_ser(ser);
 			err = -EINVAL;
 			goto err_destroy;
 		}
 		err = kho_block_add(bs, ser);
-		if (err)
+		if (err) {
+			kho_block_unmap_ser(ser);
 			goto err_destroy;
+		}
 		next_pa = ser->next;
 	}
 
@@ -285,9 +324,10 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 	kho_block_set_destroy(bs);
 
 	/* Free the remaining un-restored blocks in the physical chain */
-	while (next_pa) {
-		struct kho_block_header_ser *next_ser = phys_to_virt(next_pa);
+	while (!kho_is_ro() && next_pa) {
+		struct kho_block_header_ser *next_ser;
 
+		next_ser = phys_to_virt(next_pa);
 		next_pa = next_ser->next;
 		kho_block_free_ser(bs, next_ser);
 	}
-- 
2.56.0.176.g3575e65682-goog


