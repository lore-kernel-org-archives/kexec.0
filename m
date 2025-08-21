Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE74CA0FE1
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWqXjjUHM7c8KFNVFeI4qCz3BhL3hy0rWcMQ9gV1+Ag=; b=z0fa+reuM0eAhveSz8PEA6Pjgy
	/dSkWYgDjMG09coGYy57usb0HfTs3TZIYQbJUAtyzMyjDc1H5clFuAt6pSJ84sgbFdFfx/CEHcEHl
	o/OkfEaXDwbuvhM0At2MdBgEnPsTsHVLA+jYRvWjWtTEHc6u40JCBXCy8WY9gAtXw9u7vFAdzDCq6
	BMgv4GkQyxv3hrZ7J26hrU2tcZk3lGkFkE/hKqs13ITy4je61Z5cwJzTMh0pcPFsAdQxfMji6SCyl
	PoIHRBBWPKhvvOqUoSt+ANZVS+34CauPlHPbWnYY/3EFNTQ61/1Jm52+nNCqnejxeoivkQ6bkqAcm
	X+v/L/OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upEWJ-00000000uiI-2t3x;
	Thu, 21 Aug 2025 23:16:35 +0000
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.35.192.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up9Zn-0000000082i-3g4h
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 17:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799191; x=1787335191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWqXjjUHM7c8KFNVFeI4qCz3BhL3hy0rWcMQ9gV1+Ag=;
  b=XAN7fErJYmle0xPECroRqKQtX/spb2FcuGzwiOO90zA9QOAzzvCUpPHP
   KqPDHtLWOxtL6ySHnSxEFJAiTdvoZ867i+Uak95jw+H5dq1JU/Qly9lg9
   Y03DeuOiTkPXfmR7B68pGKDk0nDmaTMwgnlfnUXEdmoX4DrrG8kJnYjub
   7JcTD3RreaHNZsy4DZ+tnPBem4mKU+hLsKg8yCAMqlqxgtrVWrBJcP3Zp
   M0lPbn9RlXBffkCH+twSdve/xAhHf5zUuOlriYcASVaWTbJJwz4LI5Gww
   ddPSvbFB3YfVRdam6hFLXO9477WH0uaAxoK4zbvGl2Vakwa7s8tgLvJPh
   A==;
X-CSE-ConnectionGUID: HLKZcqGhSiCPiLwCU2nt1w==
X-CSE-MsgGUID: /M1cOzOZQPSmCqzALH8bdQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1453129"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:64601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.152:2525] with esmtp (Farcaster)
 id df03885c-7dc0-4034-8426-e40e01b7df25; Thu, 21 Aug 2025 17:59:48 +0000 (UTC)
X-Farcaster-Flow-ID: df03885c-7dc0-4034-8426-e40e01b7df25
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:48 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:46 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 1/2] kexec: introduce is_kho_boot()
Date: Thu, 21 Aug 2025 17:58:59 +0000
Message-ID: <7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_105951_966643_9A1BF62D 
X-CRM114-Status: GOOD (  12.50  )
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

During early initialisation, after a kexec, other components, like EFI
need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
function is not enough as in the early stages, it only reflects
whether the cmdline has KHO enabled, not if an actual KHO FDT exists.

Extend the KHO API with `is_kho_boot()` to provide a way for components
to check if a KHO enabled kexec is performed.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v3:
	- Condition Only on the existense of the KHO FDT and ignore the
	cmdline `kho` parameter

 include/linux/kexec_handover.h |  6 ++++++
 kernel/kexec_handover.c        | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..559d13a3bc44 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -40,6 +40,7 @@ struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
+bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
@@ -60,6 +61,11 @@ static inline bool kho_is_enabled(void)
 	return false;
 }
 
+static inline bool is_kho_boot(void)
+{
+	return false;
+}
+
 static inline int kho_preserve_folio(struct folio *folio)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 69b953551677..52e80e0c2238 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -925,6 +925,26 @@ static const void *kho_get_fdt(void)
 	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
 }
 
+/**
+ * is_kho_boot - check if current kernel was booted via KHO-enabled
+ * kexec
+ *
+ * This function checks if the current kernel was loaded through a kexec
+ * operation with KHO enabled, by verifying that a valid KHO FDT
+ * was passed.
+ *
+ * Note: This function returns reliable results only after
+ * kho_populate() has been called during early boot. Before that,
+ * it may return false even if KHO data is present.
+ *
+ * Return: true if booted via KHO-enabled kexec, false otherwise
+ */
+bool is_kho_boot(void)
+{
+	return !!kho_get_fdt();
+}
+EXPORT_SYMBOL_GPL(is_kho_boot);
+
 /**
  * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
  * @name: the name of the sub FDT passed to kho_add_subtree().
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


