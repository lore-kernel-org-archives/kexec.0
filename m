Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EDECCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Puhhw/KYQlkth6JZ8nHBxXQPEXoRo970byZVNnmTOX0=; b=UUmgm10E+xFuayjNm7g7bW4UAc
	Q+lhmWt+qo8zlzHZG4yDQRKiJVSaClsATGbtKhtLSSB1GEE56vCd9nbUiyViiMKEMYpedDV/OQFMC
	n7C6oH4SPsx8RNjkT1A5r1H5wK8nEwyFUjOhRmfc66qtEGx28QQ5f7kY5MqozE6FhoBYPA4+zJGkW
	ht0+a1m03BBDb3Xkkc6YO9kq4SrF5WpVEWKRzIojq51s4SdEeMlGO1HuIFWf4/+HqWbLD7MBd+/0Q
	OmKNp2oZgR1VBe3CNNEYqAMSUgIOfqFq7RLSOPPF9Rts7goEaUXscoW0t0bH2nuWrxVcT3twFMCVQ
	rirY0AuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqX-00000006RUL-0JG2;
	Mon, 19 Oct 2026 02:11:29 +0000
Received: from mail-vk1-f175.google.com ([209.85.221.175])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqR-00000006RPr-2NwL
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:28 +0000
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso1086762e0c.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375882; x=1792980682; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Puhhw/KYQlkth6JZ8nHBxXQPEXoRo970byZVNnmTOX0=;
        b=fiMdJPO1dZHS4Olh2CjGzbiTJE6FnKjSUCWoaPSAeBBJTqxUhA8f4dOBYDE1p4HLJD
         Doto77o3ZUJAaJh7pkjgN9ki/l2zXwzYd8bOj/DaaN5yE74v4EqhO+Vo8WAJrIZxCGNV
         N5jK46dOw1uJB2iyQxgcbgb8y6RKbGS9SsWt1hKeaoJmA0rqvp+h8QaK9mz8wUT09lnP
         NTo3oTx21nO4ZBEhNhmhMqDHcsOOZVLHenP95OTNIFpCvJqa1lZxxribGGtRlKxxP2Wd
         qAWo82jkkTdnsGYl5w107Elrt/JY/ybHSHxUClvSo831NmJzi5PdBbU2Q4WKg6b54SMr
         4uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375882; x=1792980682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Puhhw/KYQlkth6JZ8nHBxXQPEXoRo970byZVNnmTOX0=;
        b=Z7GQqtDQWYuAlMIXPS7PNpTLn30vVfvddXOVEkKK0kWxCMtKRpYt5RDfuldmdodIlw
         MH6vrDghedMw0TiOWlqMDjp4iCLnZJBK6hcZFtxEaYcCrrPm80qafGUwB3/zjHySkd9/
         99tSFcjiazQRuRwU7Cw1VenKMa30IwsEI5UCTnscmAeMuQq5jlvmEOKiNqKVwk5QLxPC
         JhMYA6KDFKSRudNfZRuywAUzQiD7C/6Kg7aApsODNE1wXRYJm+mr88pnEpsMkSnwtIAq
         TICgjmF1hDheZXqKmY1rLGJyYfC1Ur6m3fTNL9k4x5qwqKLorB1eI6oYNHIMn1xrrwrU
         CY/w==
X-Forwarded-Encrypted: i=1; AKwUvBzf2Kt8qe+rpHb3ZNonA+yP5O3dvEJhvi7DkeCb5QVOeFK/RmKa58lTpBFckj+KFctipPoTOA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLBFc/b5bWHmPkIy3Zb79BfefvmOXVvx5Slyia7CRTOLm5AFf4R
	ioerkjLL+xnb3Z6lqQAYv5SHhXAKvrX1MVi5HOKE1CdTye0etqJR72E6PXMfKTiP+8M=
X-Gm-Gg: AYBFou1IDUxrpTfraFbRtVO0C2KTxL9H7SyDJTf9Jq0rr+Ncm2kd84NC6VQEU0Mc1QB
	KXtnBDc7J+vZSWGjd3Jd5Gfg/c/4TqLY9pVXHI7vN2XSc4whGSNz1fxmBuJFo3y5lbJ4f/p9rSW
	8/HKfdRy1WHf730iJOuo6d/Klr6hyBV3LhyKLvBKWSEj7heXPpPLHSSV0Bx7TmnF9FCQFBq4kTo
	gVO9arGLKHZDdSMS2+f3VrJF/xcHLWBHGMRXYaZcSAmo1Yq8sBeWtYaNWJesz8wYHfQ+ZkwR2TT
	toMrHitaeGZX8jvQjbDyuUh9eHQoZsFdaprw4Mw3nexLusFejKglFzXf0aBE/nGVs7jgIUmX1wi
	VKCn1VmZiozzshEJtqH4r77luMr9uhb643hzLbvHdxoFYbD5iF36ZruepkmuJovwIvOZ3UTN0nn
	sY8Or9pz7JMQtI8G7+4WOIgja5XnLSiHpF8ssG7FIW50sxymU2podBK8AC+pIih3I+GfTFNmoVe
	SAOYVEN1qbQw5JVaW6V8GeZBw1W83hL4H/H0lb/KS9AsMI/ddSqKTzpytDoD1I5ZW7S+Ba+Yt7/
	bTycfkqflYnlLmBnSFU=
X-Received: by 2002:a05:6122:d19:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5eac90dd9bfmr480991e0c.13.1792375881262;
        Sun, 18 Oct 2026 19:11:21 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:20 -0700 (PDT)
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
Subject: [PATCH v1 3/8] kho: validate preservation metadata in kho_restore_vmalloc()
Date: Sun, 18 Oct 2026 22:11:06 -0400
Message-ID: <20261019021111.990394-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191126_919378_55D8039E 
X-CRM114-Status: GOOD (  14.55  )
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

kho_restore_vmalloc() currently dereferences preservation before
checking for NULL, does not reject unknown KHO vmalloc flags in
kho_flags_to_vmalloc(), and does not validate preservation->first.phys,
preservation->total_pages, preservation->order, or potential size
overflow before allocating the pages array and shifting by order.

Introduce kho_vmalloc_validate() in kexec_handover_internal.h to
validate the struct kho_vmalloc header and convert its flags before
restoring the vmalloc area.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c          | 17 ++++++------
 kernel/liveupdate/kexec_handover_internal.h | 30 +++++++++++++++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index f427cdd9a969..a9c52d998855 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1384,28 +1384,27 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
  */
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 {
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_PROT_NORMAL;
-	unsigned int align, order, shift, vm_flags;
-	unsigned long total_pages, contig_pages;
+	unsigned long total_pages, contig_pages, align, idx = 0;
+	unsigned int order, shift, vm_flags;
+	struct kho_vmalloc_chunk *chunk;
 	unsigned long addr, size;
 	struct vm_struct *area;
 	struct page **pages;
-	unsigned int idx = 0;
 	int err;
 
-	vm_flags = kho_flags_to_vmalloc(preservation->flags);
-	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+	if (!kho_vmalloc_validate(preservation, &vm_flags))
 		return NULL;
 
+	chunk = KHOSER_LOAD_PTR(preservation->first);
 	total_pages = preservation->total_pages;
 	pages = kvmalloc_objs(*pages, total_pages);
 	if (!pages)
 		return NULL;
 	order = preservation->order;
-	contig_pages = (1 << order);
+	contig_pages = 1UL << order;
 	shift = PAGE_SHIFT + order;
-	align = 1 << shift;
+	align = 1UL << shift;
 
 	while (chunk) {
 		struct page *page;
@@ -1420,7 +1419,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 			if (!page)
 				goto err_free_pages_array;
 
-			for (int j = 0; j < contig_pages; j++)
+			for (unsigned long j = 0; j < contig_pages; j++)
 				pages[idx++] = page + j;
 
 			phys += contig_pages * PAGE_SIZE;
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 094b4917a0f1..878e21bd8b00 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -7,6 +7,7 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -23,6 +24,9 @@ static inline unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
 {
 	unsigned int vm_flags = 0;
 
+	if (kho_flags & ~(KHO_VMALLOC_ALLOC | KHO_VMALLOC_HUGE_VMAP))
+		return ~KHO_VMALLOC_SUPPORTED_FLAGS;
+
 	if (kho_flags & KHO_VMALLOC_ALLOC)
 		vm_flags |= VM_ALLOC;
 	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
@@ -31,6 +35,32 @@ static inline unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
 	return vm_flags;
 }
 
+static inline bool kho_vmalloc_validate(const struct kho_vmalloc *preservation,
+					unsigned int *vm_flags)
+{
+	size_t alloc_size;
+
+	if (!preservation || !preservation->first.phys ||
+	    !PAGE_ALIGNED(preservation->first.phys) ||
+	    !preservation->total_pages)
+		return false;
+
+	if (preservation->order >= BITS_PER_LONG - PAGE_SHIFT ||
+	    (1UL << preservation->order) > preservation->total_pages ||
+	    !IS_ALIGNED(preservation->total_pages, 1UL << preservation->order))
+		return false;
+
+	if (check_mul_overflow((size_t)preservation->total_pages, PAGE_SIZE,
+			       &alloc_size))
+		return false;
+
+	*vm_flags = kho_flags_to_vmalloc(preservation->flags);
+	if (*vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+		return false;
+
+	return true;
+}
+
 /**
  * kho_encode_radix_key - Encodes a physical address and order into a radix key.
  * @phys: The physical address of the page.
-- 
2.56.0.176.g3575e65682-goog


