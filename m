Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB75BCCD199
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 10:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWYMfKzAMwpC3rMo+EO7RJrq8DN+4fyyYi/w0NuGFhk=; b=snsVkFDts9OV66gleMF4thlou4
	Y7nyyi+j2AlOGya0SaaaziGqSYPFigopFi4Ph/xI3CzQbna02lpNrjVzZgbvsZbZWxICQk13D/R5l
	qvOH522hbIxvVQolXL/ilwcnuxb4/w2rJ8n2CDAIzDnzI4n8eJovUc3pBNM34WeTZIKp7eP2Fw9n7
	EMh1b0+yz8U7o9VN++gq3iLdMOiMO/oyZ6T1F79PlG8SGEGTvFBkYakE07eUj9nrwMOt6ziiDOrnU
	Lj6gNSbM1vxNMN4cLF7wTnxseNp05hx+zDiLzLRRcWIHwsimXkbaudxb+oVz+FPQb2YVLzibkx69c
	pQ2yllTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjV-0000000Ci8M-3bXv;
	Mon, 20 Oct 2025 10:03:17 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjS-0000000Ci5W-3Dt3
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 10:03:15 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso2878702a91.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954594; x=1761559394; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWYMfKzAMwpC3rMo+EO7RJrq8DN+4fyyYi/w0NuGFhk=;
        b=13IwLEuYehl9W3BjfdNo0Nu+o8xiEd/ZyfLkFrhI9giz1XqZtZuNIGd2e1hoI68KYR
         uJ/aUyeX+VpmurLlnAg8saNLKH8wMYBEaHbx9e+KJTBDjRBsDVn45YTizJRH4w2hALh7
         VebVgCEkzLigGceEZ5d3ui82Gwlw6ZX/wcfY8Vs85IhI3Ti5buz8DMZeoM41oG9Cc8l+
         eWQY3ri8Lk8QOmOc0n4ElinU9S2rLfZ2pIc0nir7ObHyhTMqB9N0A+aPapQHtucLUL2S
         mpaLgPHKopezSUDtl6bRkgnhEq0dqnaGzaSfYctm2D5CDr2ZuYZVCfsmC3rkS4EhdwAO
         5fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954594; x=1761559394;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWYMfKzAMwpC3rMo+EO7RJrq8DN+4fyyYi/w0NuGFhk=;
        b=TZZIo5i6YaY95HBwtMvrUzgKgRRHWr0n2fvSm6bbVgY6oC4JikHoJN4XH7bcfjN4r/
         14Q0nhJaXL4DizvMWjscXTjPjV0smNQCsJjT4BlVFh9V4+/AR5xf4w7bgTeSXJFqCyGE
         qs3U1rE0a9ROAy7EMayRn/IBxHBFyeoqHxuku8EgpKnueHAR1B438JX9D5yvhTUeSxgB
         2qTRJ6vw270FgCvK/jJb2ICjr6iafwzSQpMC4xcvSe6O2qUkrMAL9fd2y32v6egdMwGC
         IVev1VRw1O18LiFv7bW9PBT1Sg1SZ0cIq3KsCzFHeRYdVHtSiXBccM58ElzabRpi0pQr
         dPog==
X-Forwarded-Encrypted: i=1; AJvYcCVYRaA6/ewacykMwmDiAB9Xs3VpDRvUcZhdrPl93G2x0irlNkzOv932DOY8IjXEKn6FZstHTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyqQIis547pC1rGKJ7xUnPdCRtMsWhVXHYtExfeKXow+jojrh/j
	S6yN2s2+CphZZJuhQHdBIP+1J340LWe+/e7XR48mNcXK6Bh4N+9iVT78GIeFN7qgRElH8dInGgw
	JyK20rOoF751nPw==
X-Google-Smtp-Source: AGHT+IEYcb3O7V1ky5jKWFnqxa+/2YZV8/a9EZaxLZJsoQaIasplHaDB8TXWgZyuKJmpJffHcKoX/v4QSLaLJg==
X-Received: from plll4.prod.google.com ([2002:a17:902:d044:b0:290:b0eb:f853])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d586:b0:268:db2:b78e with SMTP id d9443c01a7336-290cba42358mr144766195ad.60.1760954593812;
 Mon, 20 Oct 2025 03:03:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:05 -0700
In-Reply-To: <20251020100306.2709352-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-3-jasonmiu@google.com>
Subject: [PATCH v2 2/3] memblock: kho: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_030314_818662_CA534B6C 
X-CRM114-Status: GOOD (  18.96  )
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

KHO selftest is also updated with this deprecation of notifier.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h     |  5 ++--
 kernel/kexec_handover.c            |  3 +-
 lib/test_kho.c                     | 28 ++++---------------
 mm/memblock.c                      | 45 +++++++-----------------------
 tools/testing/selftests/kho/init.c | 19 -------------
 5 files changed, 18 insertions(+), 82 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index bc2f9e060a79..1f2ca09519a1 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -27,7 +27,7 @@ bool kho_is_enabled(void);
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_remove_subtree(const char *name);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -59,8 +59,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 2fc5975690a7..1138b16fa546 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -688,7 +688,6 @@ static struct kho_out kho_out = {
 
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -701,7 +700,7 @@ static struct kho_out kho_out = {
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
 	void *root_fdt = page_to_virt(kho_out.ser.fdt);
 	u64 phys = (u64)virt_to_phys(fdt);
diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b45..e4307587a713 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -38,33 +38,16 @@ struct kho_test_state {
 
 static struct kho_test_state kho_test_state;
 
-static int kho_test_notifier(struct notifier_block *self, unsigned long cmd,
-			     void *v)
+static int kho_test_preserve(void)
 {
-	struct kho_test_state *state = &kho_test_state;
-	struct kho_serialization *ser = v;
 	int err = 0;
 
-	switch (cmd) {
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	case KEXEC_KHO_FINALIZE:
-		/* Handled below */
-		break;
-	default:
-		return NOTIFY_BAD;
-	}
-
-	err |= kho_preserve_folio(state->fdt);
-	err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
+	err |= kho_preserve_folio(kho_test_state.fdt);
+	err |= kho_add_subtree(KHO_TEST_FDT, folio_address(kho_test_state.fdt));
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	return err;
 }
 
-static struct notifier_block kho_test_nb = {
-	.notifier_call = kho_test_notifier,
-};
-
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
 	phys_addr_t *folios_info __free(kvfree) = NULL;
@@ -191,7 +174,7 @@ static int kho_test_save(void)
 	if (err)
 		return err;
 
-	return register_kho_notifier(&kho_test_nb);
+	return kho_test_preserve();
 }
 
 static int kho_test_restore_data(const void *fdt, int node)
@@ -295,7 +278,6 @@ static void kho_test_cleanup(void)
 
 static void __exit kho_test_exit(void)
 {
-	unregister_kho_notifier(&kho_test_nb);
 	kho_test_cleanup();
 }
 module_exit(kho_test_exit);
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
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 8034e24c6bf6..211d6bda8961 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -27,22 +27,6 @@ static int mount_filesystems(void)
 	return mount("proc", "/proc", "proc", 0, NULL);
 }
 
-static int kho_enable(void)
-{
-	const char enable[] = "1";
-	int fd;
-
-	fd = open(KHO_FINILIZE, O_RDWR);
-	if (fd < 0)
-		return -1;
-
-	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
-		return 1;
-
-	close(fd);
-	return 0;
-}
-
 static long kexec_file_load(int kernel_fd, int initrd_fd,
 			    unsigned long cmdline_len, const char *cmdline,
 			    unsigned long flags)
@@ -83,9 +67,6 @@ int main(int argc, char *argv[])
 	if (mount_filesystems())
 		goto err_reboot;
 
-	if (kho_enable())
-		goto err_reboot;
-
 	if (kexec_load())
 		goto err_reboot;
 
-- 
2.51.0.858.gf9c4a03a3a-goog


