Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C0DCCA471
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4HnKiiE09rl43LC3UECv7NDLXowg9VsBNh2ns+1RXE=; b=oleEozY7uXzZvVbIgDdWWn8RZz
	PcnPtc7GJ0BaCpBcAa2p9U0uVWNRBXN1Xe+L2xfO7vYx20/q+8A4IzhpOqVzDLS86z+jVlP77y+Y5
	6xhEWqdl6FSFXkn99Zsux6/ohOa4laITtBgI/uORcyxOglJGYGxpdUAcitH4L3rctSrCODidFN86Q
	fFyujdXC/nWVI0x+6U+2P8VozaJB988K5cQeH8vuHmUKXrHxhVi8Zq5LSzGZGunRF3RPjDmcmy7ky
	4Zsr/TxPsZpgrsKz4Av+R2QcLanGb58B3V2pPeIbqJpFV2OFYVd9Kt7Bu6iX48QERR0GU5yr/Ln+3
	cS7JQdIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVa-00000006Ve8-3B56;
	Wed, 01 Oct 2025 01:19:54 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVZ-00000006VcY-1X4u
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 01:19:54 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2681623f927so62402545ad.0
        for <kexec@lists.infradead.org>; Tue, 30 Sep 2025 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281592; x=1759886392; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4HnKiiE09rl43LC3UECv7NDLXowg9VsBNh2ns+1RXE=;
        b=tagdQ7/2S0+Tk3uqYoEUgREoTEiNu403SfdrM1Gh8FDK/lJiYhIJ1uw9OJ63tmdmAT
         VbMx4N3YULHBdqxpUbClPn8CAsLaaCckykB2lgbX+TV0xzqbhP7LPMGMY1Ov+kkUkkH3
         3pnMvdtr2X5uN3FwBIS63uxOBPt6K8u8LFQYS3V8eDyaYGQLHk6XJdcJ+QqLSBLnStrb
         DdV9RJymdZvmPHgHC69O1Kx7AqsiSsxFuGpWG++iejKNm5hkpln7P0tsU2taWlSFbHso
         coiPSvexJ271GEOAVkspOHhZoK1LwCZsWdvs3TGWRmyR7MgUE7EgW9P4UKXBshsjXlkj
         8o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281592; x=1759886392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4HnKiiE09rl43LC3UECv7NDLXowg9VsBNh2ns+1RXE=;
        b=e2oWxvq0chiZQtGcsioteO20BELT+eKNQkCJHiT65E7h9OmszcdO2l9XHrW/CL8zm+
         lKHGL/pHpQMv2j0M0hDdRgPkr/qsIv18spHJZFIQ0WMU3mMb6ehwqXToTeFQoz5howNb
         YYxULSg7JfnJgMGJd9GXsGLOeDLFXpUTHvN9rU1IEbcGDicBeOunwC3ZZ58PDzCqsMIa
         yeU+DJGRQKiWazLditHu5ouNk8Y/r7gMpF+MtGNmdWHVjFa9FeOeLwB2jhEBoS73D57t
         3suedBAb523KpnWzuHmALRltdJqAbBt5lw+HcJ0MNWZIsV3vPlTOrEnerh08nuRKvKb/
         EAnw==
X-Forwarded-Encrypted: i=1; AJvYcCU0CGnOLZchu94RUNBokhg2L/O9pYLTzfKjna7CBtwx2tNavFr7gMtGBRm3HOBybT7yDLOu4w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzC2kqUyCWHFC2Vr/Wd4hfEzC/jHiNbxqqgRjz975iEfYCokCEY
	m43DkHwmpM1zHFuMidyHaFVaZQm6jxnRmW+OtjBL7Yf2WpKlsYxBR8XCDCVPJZ2uwVi+pz3cfK0
	5d2TA9GyqzLl+ow==
X-Google-Smtp-Source: AGHT+IEBtmTt/de8ZAH/Gty67fG7K6wz+DH/TLooGqCBdKidWKsNfouEipgjC7MTQ3Jd+/633JnpD2gkYNbqjw==
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:24b:1657:c088])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f642:b0:266:ddd:772f with SMTP id d9443c01a7336-28e7f276df7mr19249665ad.9.1759281591707;
 Tue, 30 Sep 2025 18:19:51 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:41 -0700
In-Reply-To: <20251001011941.1513050-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-4-jasonmiu@google.com>
Subject: [PATCH v1 3/3] kho: Remove notifier system infrastructure
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_181953_408563_FA020AF6 
X-CRM114-Status: GOOD (  11.77  )
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

Eliminate the core KHO notifier API
functions (`register_kho_notifier`, `unregister_kho_notifier`), the
`kho_event` enum, and the notifier chain head from KHO internal
structures.

This infrastructure was used to support the now-removed finalize and
abort states and is no longer required. Client subsystems now interact
with KHO through direct API calls.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h | 22 ----------------------
 kernel/kexec_handover.c        | 15 ---------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 9566c90a3501..09e8f0b0fcab 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,16 +10,7 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
-/* KHO Notifier index */
-enum kho_event {
-	KEXEC_KHO_FINALIZE = 0,
-	KEXEC_KHO_ABORT = 1,
-};
-
 struct folio;
-struct notifier_block;
-
-struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
@@ -30,9 +21,6 @@ struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -68,16 +56,6 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
-static inline int register_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void kho_memory_init(void)
 {
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ee4f430dfae0..fc290226e58b 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -16,7 +16,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/rwsem.h>
 
@@ -641,13 +640,11 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 }
 
 struct kho_out {
-	struct blocking_notifier_head chain_head;
 	struct dentry *dir;
 	struct kho_serialization ser;
 };
 
 static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
 	.ser = {
 		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
 	},
@@ -697,18 +694,6 @@ int kho_add_subtree(const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-int register_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(register_kho_notifier);
-
-int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(unregister_kho_notifier);
-
 /**
  * kho_preserve_folio - preserve a folio across kexec.
  * @folio: folio to preserve.
-- 
2.51.0.618.g983fd99d29-goog


