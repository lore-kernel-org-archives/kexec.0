Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6851CCA476
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ibfSbZvRgj9j6yQ0MCtEacyn1TcRaC1JpE6HwVQGXI=; b=YdfviB8AkObHpS/5svyVhV6VFi
	nzmO+cO7ogUNrG2xdFqk/PlaFEe8F+jamLCuYPTSfldQZVPG1sU4BntUczuosZ/MSdo2xICq86cXL
	ip8TIqAFyAPo4dBvLHcGZL2tEukLPUg4ZgKYVKAZm39MEf6GlgjPEaZOc1jok851C7hQm/UM191S4
	+spGLaEw5tLRHO+s9FDegNhIM8DhpF9Fr4MIcMdQchnLCrCkW0+JPStm4CbR+CmqKAkaD2oic57Bx
	fxl1lVDEi88pDNeT7e5lAODAuQG1hLBeqYwyLI0plDOhBRlg8KQUyPxCoo6fvdMfOw9St9zJkP4kc
	yXGxUGNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVa-00000006Vdx-23F4;
	Wed, 01 Oct 2025 01:19:54 +0000
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVY-00000006Vbq-06ec
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 01:19:53 +0000
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-828bd08624aso1290021185a.1
        for <kexec@lists.infradead.org>; Tue, 30 Sep 2025 18:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281590; x=1759886390; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ibfSbZvRgj9j6yQ0MCtEacyn1TcRaC1JpE6HwVQGXI=;
        b=K2ETomdht51ep212l9lJUplNbFPm7In9cdzynEhlacarRmULH0UHmjAWTYnxVKE4Fc
         8IRjsnQRUJv3NgHQjZTJEBKvt9GPg1i/n9Ah4UDIVBmQu+gjiqneG42Kmu1+fd6/tZuV
         Acc8Mvcn9ixxuqHpRjMDBoTjUFHPQ8OMiYIsmPHAVOB/SZYv7kLYAz8ayAyDcX8nq3xs
         dfAxdsmwrDlRKesfqlEDZ2EBhD/VbldbcpB22JFASXSPpPZo0RXvfu+t2S64HUa2fXr3
         qoDgX0PYZ4OMsCOsMEgncIYLRQ3YvykcOQKdO+byx/Dw807B+PxqHnqvzNBluryKhHFk
         sFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281590; x=1759886390;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ibfSbZvRgj9j6yQ0MCtEacyn1TcRaC1JpE6HwVQGXI=;
        b=L1KDAzSGoObjxNaIg6xgaB7+OFWR/uVW1iXdMini1ZnJ4GkIu9wlNi9h5UpZW4jTyT
         xq2sCOzpnTdGe1gzINyjs3oWh+BS6h/zjpChZTDz6ZwTxRYhDojyUPCAZxVpxN67kpSC
         6f3Y4fjdYomPK7GJ1xl7uid1ob4b6riL85NkfF3G+F2OvhiUZcU3gnM1EYERygX8Hs27
         CRyhfUwGlbgX6gG51VUt0J2CgtuUnJtABM3VbfJXYA6uSsoQf/ZTwab0Qhbd74nSOjeE
         6kcm220GjtfSE0/eFhDPoy5Yl+dGURDqTXv9GV0McmWqiXCnqeB2Jm20WIMj2xDm9p4U
         Vn9A==
X-Forwarded-Encrypted: i=1; AJvYcCWltTy5PKuUb0R9Cn8BSoX5sg2SMh5bvbDXwjtb68aOJByx495sp4Kwi5k/OEdgmCybh2IPcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZtBjHCbeoSfi1uhWUIQuiiBdEsn4g114FvyM06JUWYis/naM+
	ZWawG2gQ5JvyjH7q8G9V1q4O8dN2SAeb/ewOh6lfGR1u0Pxv+O7esxFlzstS5V/Ur/bslhK3TVG
	Yn8JrL+1rJcwyLg==
X-Google-Smtp-Source: AGHT+IGndh3BKmmwYu3HLjg8lqiwBwPnFbZVMWVM52TvRbv89JPU+RpTm1KO5ghpiMevFLIMLJgkTv9IkxTRLg==
X-Received: from qkpg1.prod.google.com ([2002:a05:620a:2781:b0:863:2d0a:f9a6])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4723:b0:82e:6ec8:9887 with SMTP id af79cd13be357-87371172610mr285500485a.24.1759281589908;
 Tue, 30 Sep 2025 18:19:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:40 -0700
In-Reply-To: <20251001011941.1513050-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-3-jasonmiu@google.com>
Subject: [PATCH v1 2/3] memblock: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_181952_078055_D2B93876 
X-CRM114-Status: GOOD (  18.78  )
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

Remove the KHO notifier registration and callbacks from the memblock
subsystem. These notifiers were tied to the former KHO finalize and
abort events, which are no longer used.

Memblock now preserves its `reserve_mem` regions and registers its
metadata by calling kho_preserve_phys(), kho_preserve_folio(), and
kho_add_subtree() directly within its initialization function.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  5 ++--
 kernel/kexec_handover.c        | 48 +++++++++++++++++++++-------------
 mm/memblock.c                  | 45 +++++++------------------------
 3 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index c8229cb11f4b..9566c90a3501 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -27,7 +27,7 @@ bool kho_is_enabled(void);
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
@@ -58,8 +58,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 34cf0ce4f359..ee4f430dfae0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -640,9 +640,21 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 	return 0;
 }
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+	struct dentry *dir;
+	struct kho_serialization ser;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+};
+
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -655,16 +667,29 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
+	struct kho_serialization *ser = &kho_out.ser;
 	int err = 0;
+	int root_node_offset, subnode_offset;
 	u64 phys = (u64)virt_to_phys(fdt);
 	void *root = page_to_virt(ser->fdt);
 
-	err |= fdt_begin_node(root, name);
-	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
-	err |= fdt_end_node(root);
+	/* Reload the KHO root FDT to the same buffer */
+	err = fdt_open_into(root, root, PAGE_SIZE);
+	if (err)
+		return err;
+
+	root_node_offset = fdt_path_offset(fdt, "/");
+	if (root_node_offset < 0)
+		return root_node_offset;
+
+	subnode_offset = fdt_add_subnode(root, root_node_offset, name);
+	if (subnode_offset < 0)
+		return subnode_offset;
 
+	err = fdt_setprop(root, subnode_offset,
+			  PROP_SUB_FDT, &phys, sizeof(phys));
 	if (err)
 		return err;
 
@@ -672,19 +697,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-	struct dentry *dir;
-	struct kho_serialization ser;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-	},
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..602a16cb467a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2510,39 +2510,6 @@ int reserve_mem_release_by_name(const char *name)
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 static struct page *kho_fdt;
 
-static int reserve_mem_kho_finalize(struct kho_serialization *ser)
-{
-	int err = 0, i;
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-	}
-
-	err |= kho_preserve_folio(page_folio(kho_fdt));
-	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
-
-	return notifier_from_errno(err);
-}
-
-static int reserve_mem_kho_notifier(struct notifier_block *self,
-				    unsigned long cmd, void *v)
-{
-	switch (cmd) {
-	case KEXEC_KHO_FINALIZE:
-		return reserve_mem_kho_finalize((struct kho_serialization *)v);
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	default:
-		return NOTIFY_BAD;
-	}
-}
-
-static struct notifier_block reserve_mem_kho_nb = {
-	.notifier_call = reserve_mem_kho_notifier,
-};
-
 static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
@@ -2583,7 +2550,7 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
+	int err, i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
@@ -2592,7 +2559,15 @@ static int __init reserve_mem_init(void)
 	if (err)
 		return err;
 
-	err = register_kho_notifier(&reserve_mem_kho_nb);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(page_folio(kho_fdt));
+	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
 	if (err) {
 		put_page(kho_fdt);
 		kho_fdt = NULL;
-- 
2.51.0.618.g983fd99d29-goog


