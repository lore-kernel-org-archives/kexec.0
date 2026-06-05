Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C8CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jYmKPVlEdqw9nJIpln28SQxgNWXUbITnOaKq2Dm+DFI=; b=cHxpe+4mjANEJsKeLRtGzOuFXy
	2cxKER+DkrW/a9JtHBU28hkY+WYObaxs6LwgFVu48wxulvFRuFnlLLjomGgc0fjZ9DzXs5GWUq18n
	pYKOcUTRmAOb2p08III2REC5dIatIFLtW2h9MOLrUzhOa7zsad7uCeINkgapBsjpE4p35uvejJz0k
	S74/fQ1VkaovtteT6dgJUEpiHvvKJEVGV8C7Lvxo0Gs/d94c5P5uuXlrH5/miCOwqCQIZlAMLAnjo
	BdrVoLbOnQjkydlel8A4WXuwRRQYmQtePrvH0sUSo1OziSD0IdbDyMOHAUACa68B5Mm9nlfuMI6Ai
	QmXIlTBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJq-000000002Fy-2Mln;
	Fri, 05 Jun 2026 03:34:02 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJo-000000002FU-2g24
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:34:02 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-9154ca1aa1dso347883185a.0
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630439; x=1781235239; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYmKPVlEdqw9nJIpln28SQxgNWXUbITnOaKq2Dm+DFI=;
        b=h+wzPLHE/7CbnFhCbur3m7wXJItKhmoyTtFZwt3oFEKTKnn87xi250bUCffq2ygc9f
         s8U8TjKfgZ/ylf8YHohyvo32tQne09pgVPZlqLJzPAOOVopoFQ8dq+r/eqEal6YsZRj7
         WH4DrnDRdqfbOrnvMHEgeR48ipZaO6+PTTAOacU+ZE67DQcu0+1uaS2w9Bf9HVXilfYm
         fZGKl6xQnXwn9SyV+Q0Z7RgSnVkLHnghnsUlMXXI7awKJR2ZSikqo/IepRqRsakIXbG/
         jqSDcODpeIJ+rZUCC+N6Edw7XtcH3TR6te+s8IKZzhnnsCyih40/Uwh7m91fLJb2Pxj1
         WdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630439; x=1781235239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jYmKPVlEdqw9nJIpln28SQxgNWXUbITnOaKq2Dm+DFI=;
        b=i/5o3WmRxGrYkVpitob22R0yrDEnFvWWyJhVu9PRQrmZKB8ofIxFtq3bn8B73TsX5m
         G6lWnVDFs/GJpTR/hycVrvgYQ7H6vAmDSwePHtvp1FMLZ/eEU29XMaPvj7AEAk2zIFnx
         N/6USzCgmXuhsMwAUfOFf/tsDRRuZIcomByM8U3KevxeygLXfO+9Su/qSHpR1coZRYCP
         DGkeIXCjkbCibSbYnqCbRRNbEYWjnPvUEeEtbzjTJh3piaOXzCXM9WBmhHNN6nABOjFp
         L7Hzbx5UOW53teqaF7KQ53HXPypQ80ozA05f/ZBXPtjbK22dNnm4fbFt3WBea2FSkUsW
         5nOg==
X-Forwarded-Encrypted: i=1; AFNElJ9GoV3s/16cb679BWV6EnmRy3gE1kZhOXxtaNTHbhrkxPF7JmdQxcdmk/Lf86rUbPMauV1D6A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVOik9nQ4xheyuVUbXd17qOmVa0Wee2+33JZfgyrzA/KMpo5mn
	hflk/5+uMH1rTwnOQR10/PhuLawAdncPWb6ykD0hHLsNczPUE62HH8UEZp9XMUEltQM=
X-Gm-Gg: Acq92OEP7HPkIL2pdZX1xbigiIIX+xDaqP+Cgn+A2m7QLv6F3jaPKHVoiMYJS/ieKnS
	4ibSG70rkwPjWCSZbvErmacaoKc0mgTLheUCnH8ZtdBJFKbA/5zFaaH7RKvOEbvVoOGwdE7UROU
	20wORpBvmRarFZfX+wjs8pb3Td9QEdR+eKtM8tL2oAw0M3nyZv/MzPx4f1dUJaHoGHsHQ+jfEXe
	LAmrq386w14eRER+E4qEjXmqUU6sCV6AWVXggIsLC3WADwjGbXv8oak6QMRPgZDW89zj5OqXliB
	lx3o6QQXrykGDo3QOCxqykQgxYZlkYLw07iaUIA8ECSszSlS+borHX/tJiePYlBncNun/OZzuW6
	sYtyP2cdsiWtyaqt9T0UScGPNC6dvpuF3p8Mev0mnX5INHI24s2GzRqCFBPb9xgHffArH2lSGHb
	dvHUtOm30Y460F8AWAWUGtkzWG2h5x2eL/atT597Yd6iCVJdYO/+/z8F8Z4pDXRQ==
X-Received: by 2002:a05:620a:450c:b0:8cd:d688:7aef with SMTP id af79cd13be357-915ad197c8dmr107318585a.19.1780630439344;
        Thu, 04 Jun 2026 20:33:59 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91589ea0bcfsm780607085a.0.2026.06.04.20.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 7/9] kho: decouple radix tree compatibility from global KHO version
Date: Fri,  5 Jun 2026 03:32:33 +0000
Message-ID: <20260605033235.717351-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203400_684148_B83B46B8 
X-CRM114-Status: GOOD (  12.72  )
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

Decouple the kho radix tree compatibility version from the global
KHO compatibility version KHO_FDT_COMPATIBLE.

Define the independent compatibility version "radix-v1" for the radix
tree KHO_RADIX_COMPATIBLE in radix_tree.h.

Integrate KHO_RADIX_COMPATIBLE into the composite root compatibility
string KHO_FDT_COMPATIBLE.

Additionally, document the new KHO Compatibility ABI under the
Documentation/core-api/kho/abi.rst section.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/abi.rst     |  5 +++++
 include/linux/kho/abi/kexec_handover.h | 10 ++++++----
 include/linux/kho/abi/radix_tree.h     |  4 +++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
index b61363679829..6acdb7c85239 100644
--- a/Documentation/core-api/kho/abi.rst
+++ b/Documentation/core-api/kho/abi.rst
@@ -10,6 +10,11 @@ Core Kexec Handover ABI
 .. kernel-doc:: include/linux/kho/abi/kexec_handover.h
    :doc: Kexec Handover ABI
 
+KHO Compatibility ABI
+=====================
+
+.. kernel-doc:: include/linux/kho/abi/compat.h
+
 vmalloc preservation ABI
 ========================
 
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index c893b5045078..49ac4b47cc3d 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -8,9 +8,8 @@
 
 #ifndef _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
-#include <linux/types.h>
-
-#include <asm/page.h>
+#include <linux/kho/abi/compat.h>
+#include <linux/kho/abi/radix_tree.h>
 
 /**
  * DOC: Kexec Handover ABI
@@ -85,7 +84,10 @@
  */
 
 /* The compatible string for the KHO FDT root node. */
-#define KHO_FDT_COMPATIBLE "kho-v4"
+#define KHO_FDT_COMPAT_BASE "kho-v4"
+#define KHO_FDT_COMPATIBLE						\
+	KHO_FDT_COMPAT_BASE						\
+	KHO_SUB_COMPAT(KHO_RADIX_COMPATIBLE)
 
 /* The FDT property for the preserved memory map. */
 #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
diff --git a/include/linux/kho/abi/radix_tree.h b/include/linux/kho/abi/radix_tree.h
index f4cc5c02f37a..89cd7eb4a91d 100644
--- a/include/linux/kho/abi/radix_tree.h
+++ b/include/linux/kho/abi/radix_tree.h
@@ -20,7 +20,7 @@
  * This interface is a contract. Any modification to the structure fields,
  * compatible strings, or the layout of the serialization structures defined
  * here constitutes a breaking change. Such changes require incrementing the
- * version number in the `KHO_FDT_COMPATIBLE` string to prevent a new kernel
+ * version number in the `KHO_RADIX_COMPATIBLE` string to prevent a new kernel
  * from misinterpreting data from an old kernel.
  *
  * Changes are allowed provided the compatibility version is incremented;
@@ -94,6 +94,8 @@
  * 4KB.
  */
 
+#define KHO_RADIX_COMPATIBLE "radix-v1"
+
 /*
  * Defines constants for the KHO radix tree structure, used to track preserved
  * memory. These constants govern the indexing, sizing, and depth of the tree.
-- 
2.53.0


