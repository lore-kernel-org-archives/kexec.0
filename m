Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE08CE8D4C
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tk/MJG6ETPbjL9I+STB4rCENdOaFkmH/bVv9/0YHmw=; b=hTp3b8kahMlh/vME4DEzIAKXZ9
	R77f6fBNKEi+pWgaDOo9tmi3L6p93GGDFi+X1yFeMf4fAcrFrRKHR01egjRxPMFl+QqQ6G7dRsZ1b
	HklQAjlIuDgHkBUyM/vQMyUugDZKdmdHhvbMrG9FwXF8EvoyHJzGGed+EBUtopS96mKHeCUeFEIvJ
	EpTOJieTrGlhzf1ek+V46HSofdqO0nLfJaRdkiMBg0+YkrUF5MUMQKvwtEQkPTr5px3zNnmhgJGYO
	kcLv1L5MpE5wBVYN5xteR8jr4W9ldqfeLvZXgi9rr2M3ybF7C2OaOuXK4OLToLrtKFTyd4N3mxGXB
	3XFPukdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7r-0000000Ccpy-2oqx;
	Fri, 14 Nov 2025 15:54:15 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7p-0000000CcmB-0Myu
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:14 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-787da30c53dso20778457b3.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135652; x=1763740452; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tk/MJG6ETPbjL9I+STB4rCENdOaFkmH/bVv9/0YHmw=;
        b=hlsP9W8OiS5eoEx0Fa2L/Ki9KTLaRC9fwIxVgGe04PFFrQTWjonIr72/0ux6DQF3+c
         7lwzgH/paLNLmVkKiE6pHoOCSNPOBC1I4D7+NaLvxccLz+v0U9seOhfqKL1W4h7a38OB
         O75JcjWRmciAS4PKBhp3PuKX7HiImr2SrG1/kE/P2x6JGvEFSXYmbM3uRCZhevg0jLx+
         fHsPem49GqeS77+KkS4iZ9Is6JxUFdqRL94Z1MhywwXncufMDAD8UzMStba3aiMskqkx
         FRvfweoWwW88B+0unEfA8sVefTjwsya9POWWYoBvkmTf+Pg7lHJ48yOm0cxrQGDnzca2
         +D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135652; x=1763740452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8tk/MJG6ETPbjL9I+STB4rCENdOaFkmH/bVv9/0YHmw=;
        b=UY/KldU7rnKvwXenbelwhDi9vVP2r771G3NKg7+M6yZXoveo6BVT74D37oOjVyrwGn
         GJPztaQQ8RAPMUL8dCxG9yQJRh6qfJsce6xrHpUtO9j3JR7z5cjkZBQKYkvjhxbih+ZF
         QK4sEhP2ZgwUyscjwEINKZFOujkoqHLb7ZQYcbdsAugBZkjcfX6JJ5m5lPC2WWKNc6w3
         OwlyaQwtg5AN2nIxAUxGdSp6ALcgYB3SwQ8gMlcIGiNu3qhh/Rgv1WjeUzK/zObKMHKr
         hX3QrpfA+piA1QrHX3vK1VXnMMEbzc8g1jZuHzt10Tr5M8TUpfE9Du+gkKsuOmqpm+/N
         WvDw==
X-Forwarded-Encrypted: i=1; AJvYcCXkKrF4q1TYE7dTa85vAYui9wakJzP/uBnwYxmH0RuTAImsjPMaDJwbIrL3FU5+5t/sYu4csQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6AY1oTUY6JAoWcDwsxMeLoWO2NBaVLs9TphCq6cGTw9pmsiBA
	KJuj3rJXT5mbsceriVaqsyXjF7Ujhd2U+u/i9mXF865V8HY4gxH8UyfgcGQp0t0wT7I=
X-Gm-Gg: ASbGncuxGq4p9zudCXBnfBC2IFNgYS3lRQ4+NaGSfBIhpLcXoD6kxd+xdNEU0lgnOxi
	wmBs+08tHHqORlUBenIY0LVEoyT2v1vQQoLQgz9/Hzok6dWSwEDtzbMEJGsO4lTkwi3zhw37rp2
	N9Badop/JxJ+vtFepqtZQj3w7f6Z3t9QwYXjQkjjzf94G2CgqZHNs9HUlrhxHJ4abuK3jwfjgMi
	zlCUzEwWsrv1jI2lzkIgXAtwuopYKxR5GhdZ7BFufuZPySWuuK4FllSgNxuZYVXd3U7azZnIK1q
	3yqu3gRAenTEjRFzyUeBxJPeRBtHlMacWJKQKyPTTQd6Uhn6wjZvRyxP/M5YaavEzkcLmxs5fQG
	Xs0VWwvIk9avxnh4gO0t+ZAL0qMvNMIYpIcFrwEv2aZxrlH1Hnf219AxLZIWW5y4za+RzDPsa6H
	hxVn61be0MRinqgGz0tf5iXMZE8cg3uRIp6p5gVGnm+0Sa0lfhMR9m15GbTuiZXmrmWQtM
X-Google-Smtp-Source: AGHT+IEKPjFYyY+rBQyyxkjYTOGTZ+qMZUOunITIXFEjHuqgVlVgfx0m5Asn01m13RGlg6YW8Khzhw==
X-Received: by 2002:a05:690c:338b:b0:787:d13f:4b49 with SMTP id 00721157ae682-78929dfe0e1mr36529017b3.12.1763135652005;
        Fri, 14 Nov 2025 07:54:12 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:11 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 09/13] kho: Update FDT dynamically for subtree addition/removal
Date: Fri, 14 Nov 2025 10:53:54 -0500
Message-ID: <20251114155358.2884014-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075413_190576_541C0DAF 
X-CRM114-Status: GOOD (  18.21  )
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

Currently, sub-FDTs were tracked in a list (kho_out.sub_fdts) and the
final FDT is constructed entirely from scratch during kho_finalize().

We can maintain the FDT dynamically:
1. Initialize a valid, empty FDT in kho_init().
2. Use fdt_add_subnode and fdt_setprop in kho_add_subtree to
   update the FDT immediately when a subsystem registers.
3. Use fdt_del_node in kho_remove_subtree to remove entries.

This removes the need for the intermediate sub_fdts list and the
reconstruction logic in kho_finalize(). kho_finalize() now
only needs to trigger memory map serialization.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 144 ++++++++++++++---------------
 1 file changed, 68 insertions(+), 76 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 8ab77cb85ca9..822da961d4c9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -102,20 +102,11 @@ struct kho_mem_track {
 
 struct khoser_mem_chunk;
 
-struct kho_sub_fdt {
-	struct list_head l;
-	const char *name;
-	void *fdt;
-};
-
 struct kho_out {
 	void *fdt;
 	bool finalized;
 	struct mutex lock; /* protects KHO FDT finalization */
 
-	struct list_head sub_fdts;
-	struct mutex fdts_lock;
-
 	struct kho_mem_track track;
 	struct kho_debugfs dbg;
 };
@@ -125,8 +116,6 @@ static struct kho_out kho_out = {
 	.track = {
 		.orders = XARRAY_INIT(kho_out.track.orders, 0),
 	},
-	.sub_fdts = LIST_HEAD_INIT(kho_out.sub_fdts),
-	.fdts_lock = __MUTEX_INITIALIZER(kho_out.fdts_lock),
 	.finalized = false,
 };
 
@@ -724,37 +713,67 @@ static void __init kho_reserve_scratch(void)
  */
 int kho_add_subtree(const char *name, void *fdt)
 {
-	struct kho_sub_fdt *sub_fdt;
+	phys_addr_t phys = virt_to_phys(fdt);
+	void *root_fdt = kho_out.fdt;
+	int err = -ENOMEM;
+	int off, fdt_err;
 
-	sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
-	if (!sub_fdt)
-		return -ENOMEM;
+	guard(mutex)(&kho_out.lock);
+
+	fdt_err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
+	if (fdt_err < 0)
+		return err;
 
-	INIT_LIST_HEAD(&sub_fdt->l);
-	sub_fdt->name = name;
-	sub_fdt->fdt = fdt;
+	off = fdt_add_subnode(root_fdt, 0, name);
+	if (off < 0) {
+		if (off == -FDT_ERR_EXISTS)
+			err = -EEXIST;
+		goto out_pack;
+	}
+
+	err = fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(phys));
+	if (err < 0)
+		goto out_pack;
 
-	guard(mutex)(&kho_out.fdts_lock);
-	list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
 
-	return 0;
+out_pack:
+	fdt_pack(root_fdt);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
 void kho_remove_subtree(void *fdt)
 {
-	struct kho_sub_fdt *sub_fdt;
+	phys_addr_t target_phys = virt_to_phys(fdt);
+	void *root_fdt = kho_out.fdt;
+	int off;
+	int err;
+
+	guard(mutex)(&kho_out.lock);
 
-	guard(mutex)(&kho_out.fdts_lock);
-	list_for_each_entry(sub_fdt, &kho_out.sub_fdts, l) {
-		if (sub_fdt->fdt == fdt) {
-			list_del(&sub_fdt->l);
-			kfree(sub_fdt);
+	err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
+	if (err < 0)
+		return;
+
+	for (off = fdt_first_subnode(root_fdt, 0); off >= 0;
+	     off = fdt_next_subnode(root_fdt, off)) {
+		const u64 *val;
+		int len;
+
+		val = fdt_getprop(root_fdt, off, PROP_SUB_FDT, &len);
+		if (!val || len != sizeof(phys_addr_t))
+			continue;
+
+		if ((phys_addr_t)*val == target_phys) {
+			fdt_del_node(root_fdt, off);
 			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
 			break;
 		}
 	}
+
+	fdt_pack(root_fdt);
 }
 EXPORT_SYMBOL_GPL(kho_remove_subtree);
 
@@ -1145,48 +1164,6 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-static int __kho_finalize(void)
-{
-	void *root = kho_out.fdt;
-	struct kho_sub_fdt *fdt;
-	u64 empty_mem_map = 0;
-	int err;
-
-	err = fdt_create(root, PAGE_SIZE);
-	err |= fdt_finish_reservemap(root);
-	err |= fdt_begin_node(root, "");
-	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
-			    sizeof(empty_mem_map));
-	if (err)
-		goto err_exit;
-
-	mutex_lock(&kho_out.fdts_lock);
-	list_for_each_entry(fdt, &kho_out.sub_fdts, l) {
-		phys_addr_t phys = virt_to_phys(fdt->fdt);
-
-		err |= fdt_begin_node(root, fdt->name);
-		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
-		err |= fdt_end_node(root);
-	}
-	mutex_unlock(&kho_out.fdts_lock);
-
-	err |= fdt_end_node(root);
-	err |= fdt_finish(root);
-	if (err)
-		goto err_exit;
-
-	err = kho_mem_serialize(&kho_out);
-	if (err)
-		goto err_exit;
-
-	return 0;
-
-err_exit:
-	pr_err("Failed to convert KHO state tree: %d\n", err);
-	return err;
-}
-
 int kho_finalize(void)
 {
 	int ret;
@@ -1195,12 +1172,7 @@ int kho_finalize(void)
 		return -EOPNOTSUPP;
 
 	guard(mutex)(&kho_out.lock);
-	if (kho_out.finalized) {
-		kho_update_memory_map(NULL);
-		kho_out.finalized = false;
-	}
-
-	ret = __kho_finalize();
+	ret = kho_mem_serialize(&kho_out);
 	if (ret)
 		return ret;
 
@@ -1285,6 +1257,26 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
+static __init int kho_out_fdt_setup(void)
+{
+	void *root = kho_out.fdt;
+	u64 empty_mem_map = 0;
+	int err;
+
+	err = fdt_create(root, PAGE_SIZE);
+	err |= fdt_finish_reservemap(root);
+	err |= fdt_begin_node(root, "");
+	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
+	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
+			    sizeof(empty_mem_map));
+	err |= fdt_end_node(root);
+	err |= fdt_finish(root);
+	if (err)
+		return err;
+
+	return kho_preserve_folio(virt_to_folio(kho_out.fdt));
+}
+
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1309,7 +1301,7 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
-	err = kho_preserve_folio(virt_to_folio(kho_out.fdt));
+	err = kho_out_fdt_setup();
 	if (err)
 		goto err_free_fdt;
 
-- 
2.52.0.rc1.455.g30608eb744-goog


