Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725D2CE8D6F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7N5yt00Qno1MwWJjfGBPy1ItOdOrLJaGZ6crOfgTrsk=; b=T1XGWvnU8hF9TSvIPrnEHaa2FE
	A/N+36ieW2MTBWuiqVNoPSW3toSC3CYmT1LvdR7oMTFuYP1hktTmBoyhRrHLItgZ3/JNqtm185844
	QT8HQ3CcnU4/QgamaFfhehBRcFx8JEQ9w5YXcE3ypmtQYSZdoXuPGtgon5MSPUwR/ZUxSbGRkVmar
	Ih9skU31oFCQxzx2aZrr5+pZqcm02uw2OZffhgTtbpbsu10awslYfd35VT2r31bAY+2CwnaqJTPhp
	AFBmOPByyua82R+IBj1OxQ8QGURG9n7axRImnCuIeBgjcirBMlrma1OyMIO6GcFXGO2nbY78/mYqk
	DfMlRJ4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1x-0000000CzTk-31Nc;
	Fri, 14 Nov 2025 19:00:21 +0000
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1v-0000000CzPx-0UBu
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:20 +0000
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-641e9422473so1004790d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146818; x=1763751618; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7N5yt00Qno1MwWJjfGBPy1ItOdOrLJaGZ6crOfgTrsk=;
        b=NHFxcLuc9D29iFnTKPXPd7WO8VvML/TRxqojtNbj6/Ej+okbjOCEcqTEae+UecXdIQ
         8WXm0zqAXgxwnLkwEW6xN5H4LqQ1lNnwiFNVW99werVgBcsVeB/lcsdpMq3P9ZJsVOBK
         sSQ035kWnqUAItUxQqCVsUoXVheGwynBQ4p8qzrNUGsVbU4lltNv9BQxJwRPiLSUVLkT
         RhBJanJcCv+gfqPBIJlw1tAV6eevoGlOhNcoDtoEz/YB0hUDAs/5weUTyKJnfVBMhFIG
         y2kImzVuL9GD+ra6PXXAEz+T7BEncNccKMZCSx8bYE/ll7ZhoX+iSpN7TSAyQJunxD7E
         aX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146818; x=1763751618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7N5yt00Qno1MwWJjfGBPy1ItOdOrLJaGZ6crOfgTrsk=;
        b=aOQeWQ3gwRaUHbhoPzQDWFHmL4LQ16dRbmHO2Amhq76BUBSCOzKQtWMHRtHfANcysE
         jVSAORRT+IjKMqfde3AEzT/Xou5oQw4LGlUz/ch3jJQYm8txd44bH02Zaws010ebeQtj
         PPQNtaCe+zQTfp8d59CtlJj63UYVzyllDV3AqFC6XSiN3MDvm1Yv8+e2Gmc1qaEm5JNi
         mzSSr7fdL9TY7pydY5Iedp3AI0eBzTqtJUv0qIMB4b2nRJ1bDugiKBwtmH74bfj4vPyN
         1FQ+jiehH6mzUplDoW8NAxQlOqqSQEjU9oGBeS2dY8WEsB6KuXY5dEBGE6Jrf+0vrPIR
         S8WA==
X-Forwarded-Encrypted: i=1; AJvYcCWJenA0cHiojxEhIae1HxV6H5YdSWernuzPxFGs8BPDVC41423LNlpOoOGBXNvm/7RjvnzhAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzCJqiHbVm+/gtxtJF8ciI3TJtKtq8N+yjiBUftQODdfirs19d
	j+rngzGOkcE5YuqxMZ78AGjmAa8LWkXkSt4MSvgELdN3BhiFfL72JRNvZbPSY8C4NMs=
X-Gm-Gg: ASbGncvi8iWfkQpb9I2t7QSF3IkCQqsb2JRDfyeMxIS0X6ie3Y95cbOhNBgtTkfE47n
	etkZAJcvLZ8etTM5KiJc1+YfS8woEZK0gNopEir1MrwKGM9ZZpYuqgSJB+6LdC2R72zDEI/5b1W
	/KAAIzQPM9vMXa3heui761QvChQnyP6cCb1JCzIBd0krJnZ/OVWK9jqefPIGcem7FFp6nhu3yuU
	0C/cz/0yby3oniSBgRPZwr+e1p8nXgzSP5hlcDkqp0TaefqY1ZrrZgnEfDct+/KXcZscK+hq3/C
	fdSVEPadbFBD8LTIMvKDeOZzC+FUYLDw1726My3N5EuQDvtEQRyG25P6O8a1RmeD+pGpTjKlo07
	ipX4xnAolSQ8OJrMFWT7pvLRiojgfIBbUQfT+h0ZCRl/fOiAqbIGNLF7cSx2lGvhlPQkzFGGDdy
	RnKXY6JEvYKCstVTENuYbOE7bXQWg6kxhr21mTDRZ01LtF3AGKquVG1OaaGry/rqf+JNnj
X-Google-Smtp-Source: AGHT+IEgGDASb7ywJuNlU8tH7U5fvJZheQWqPab57YBnjKIGG/4PXsbTcQgkrxJdQmu9tDmb9/dD3A==
X-Received: by 2002:a05:690c:338b:b0:783:6f8d:e7a6 with SMTP id 00721157ae682-78929ef6a1bmr60582517b3.51.1763146817769;
        Fri, 14 Nov 2025 11:00:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:17 -0800 (PST)
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
Subject: [PATCH v2 10/13] kho: Update FDT dynamically for subtree addition/removal
Date: Fri, 14 Nov 2025 13:59:59 -0500
Message-ID: <20251114190002.3311679-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110019_173144_F0687FB0 
X-CRM114-Status: GOOD (  18.56  )
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 144 ++++++++++++++---------------
 1 file changed, 69 insertions(+), 75 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 624fd648d21f..461d96084c12 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -104,20 +104,11 @@ struct kho_mem_track {
 
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
@@ -127,8 +118,6 @@ static struct kho_out kho_out = {
 	.track = {
 		.orders = XARRAY_INIT(kho_out.track.orders, 0),
 	},
-	.sub_fdts = LIST_HEAD_INIT(kho_out.sub_fdts),
-	.fdts_lock = __MUTEX_INITIALIZER(kho_out.fdts_lock),
 	.finalized = false,
 };
 
@@ -725,37 +714,67 @@ static void __init kho_reserve_scratch(void)
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
+
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
 
-	guard(mutex)(&kho_out.fdts_lock);
-	list_for_each_entry(sub_fdt, &kho_out.sub_fdts, l) {
-		if (sub_fdt->fdt == fdt) {
-			list_del(&sub_fdt->l);
-			kfree(sub_fdt);
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
 
@@ -1232,48 +1251,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
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
@@ -1282,12 +1259,7 @@ int kho_finalize(void)
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
 
@@ -1372,6 +1344,24 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
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
+
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	const void *fdt = kho_get_fdt();
@@ -1394,6 +1384,10 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	err = kho_out_fdt_setup();
+	if (err)
+		goto err_free_fdt;
+
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
-- 
2.52.0.rc1.455.g30608eb744-goog


