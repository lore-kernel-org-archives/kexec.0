Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D27CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2YcWKgEizOcY9z0vq5q3df4Dwqk/3q2KHCFvnTeL730=; b=FccRaztkHp/g0EqDuFFABnAa8V
	rBR/LeqlCdOm9UsbdiqHI0Jt9zrbFYSbh9LA6gDwNZBbwfW66gu9SPhkWjuxRJGxOxe2NE/k16obn
	yEg8AVIerOHRBoTW9kb9c9fj+Qjrb9GOAnaefsUx5h61NhrYtpej/76bYy2vIge5dvQj7mZnWCGwa
	hfGaDsd50QQYMdR1Zqi63PghJSfzFZmbH2uUvR8P9slak8Z6QwqGFmYhZ2CNHEL1BlJCmqit05dza
	A9Px3VOzzBcfApxTivJTS4Fi/+J0ODwECJNAx/WoRly25g1vT6N4jgCgz7W1gWi78yYvZiSABJOG2
	om4hvjOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLK2-000000002JH-2ewG;
	Fri, 05 Jun 2026 03:34:14 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLK1-000000002In-0an3
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:34:14 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-91591f19716so191405685a.3
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630452; x=1781235252; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YcWKgEizOcY9z0vq5q3df4Dwqk/3q2KHCFvnTeL730=;
        b=OMOmI8LPA5cw5KMPmkcAXedEzn7WGVzENERVu78igd9cRxd50Lp8Nvvopeh8eCT0aS
         CXbs/NRlE9Bb7Td4jN4NlGOHuFRm2Tq5AQgPEdXS73nW99qStNgHQeGLNjdliy0A86xM
         pmW//zRdXBzCaCOLB+SyiDgP6T5rq3NeCWu2iJdaRW3OkuQ+MqS0bwJG/RNRiBmyqPJS
         THWIp/knX7Yys93y1Qx5B0hzVb4oTCYTC6cywkJtX1irWANJ23uQe3iKS8/4/xCv6flk
         sav+PFfiCyL0w9OOEQW1wcKGozRFUaKatdBCsaAnmk0tJ1Y3QuKth/EPwsoTgxV0RPwu
         dGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630452; x=1781235252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2YcWKgEizOcY9z0vq5q3df4Dwqk/3q2KHCFvnTeL730=;
        b=dQQz3tflUNoLXjnCn63K/qm4Sqql/CHQQnwcsFc+XC+2Cch/XujV+gUfbSpPYzXP48
         lQ6KtYJNWGTNtGZy/+KVkQwsDnNwe85M67pUbD/jmE96Lm4Z9juHbdAiXXfwLkBL0WoP
         idD/UqfZAbqTzpB3d0Kyvxt/yRAi+Ao0+s0hN0Cc/n4rwV/zAOu0tJ8I6sZCidJ2wmlt
         GDooGKiS4CINdLmcoeLMcM/aTcMsdiMXzqcn1NZr5NALPr+wm57xaqujAxbkNVT7fDs7
         djCYnaFCkZjMzpx4mLSG70Pz4UkscrdPGRcWTnuahEGzxUx/5fBC+qhaC+8rfhHgrUtf
         gTZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qg1whtrM8qUMAg/FwtH6AkA08Cvq28ckxED/fPKFLPtvTpB9koVSWnSOAd9RGe2Le/zCFLQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwIDE1PhWMuvNvuGjkxOWO1Rp9AVnYB7BnWHfCb2BpwriOpupiB
	S5fnnpbfKK3ryBTGP3ZHmwTvskmIGuzQ/tbPMDe1aAikXenPIe4ZN5d1xQyE0s8Ejac=
X-Gm-Gg: Acq92OFJSBIbCZAQWrsRkos6tmkBP9ieVwiERk3N4PvOo7yOyFp1v7rO+Q1oqreKImK
	dVGQDJuUJLS8XPs3B76abZ4n4cBal0I5NChvsUGgKu6UZ4jLD3UkrjV/4MDfMLUlxkg2TX/RfIL
	77LaEVpeWCs6nJo/E7B4VGlTlPSieITZkBPE38lBb4fJI2yVK8ortBnFwkMPbQwIrwoxhnR9Evd
	TZDS11ROEAnMLYzG/BQnOCYyJf60xZrNE8brJsdyFH8JfleEczxt3vH8iBbS4hGYUO9iunO03lP
	qCDvfc4jzKfe/YjxD2ihe861glmQJALxgIAFHVHRxEDoVw+5To3E7//1+RMSjrQH2cZh0HDoVH1
	DmdquFj9b/eokyhThjwFu3vGRURtoN4YRgziMUsEqBBLTnqwyZ5rim7WrNCj8vAZ2MYrDOB4RiI
	B+rK9ufc1VsZafc3O8CDVa2LEim3mu6wh2vwiJvkc4IIP2fak5P4W1dPvPakAmFQ==
X-Received: by 2002:a05:620a:f0e:b0:915:a953:4b93 with SMTP id af79cd13be357-915a9c4b267mr362733285a.3.1780630451754;
        Thu, 04 Jun 2026 20:34:11 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00b474sm768496585a.10.2026.06.04.20.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:34:10 -0700 (PDT)
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
Subject: [RFC v1 8/9] kho: decouple vmalloc compatibility from global KHO version and update memfd
Date: Fri,  5 Jun 2026 03:32:34 +0000
Message-ID: <20260605033235.717351-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203413_196217_484592C8 
X-CRM114-Status: GOOD (  14.89  )
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

Decouple the vmalloc preservation compatibility version from the global
KHO compatibility version KHO_FDT_COMPATIBLE.

Define the independent compatibility version "vmalloc-v1" for vmalloc
preservation KHO_VMALLOC_COMPATIBLE in vmalloc.h.

Integrate KHO_VMALLOC_COMPATIBLE into the composite root compatibility
string KHO_FDT_COMPATIBLE.

Additionally, update the memfd compatibility string
MEMFD_LUO_FH_COMPATIBLE to include the vmalloc compatibility dependency,
and add a static assertion to verify its length limit.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/kexec_handover.h | 4 +++-
 include/linux/kho/abi/memfd.h          | 9 ++++++++-
 include/linux/kho/abi/vmalloc.h        | 6 ++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 49ac4b47cc3d..f048bc95fed3 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -10,6 +10,7 @@
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 #include <linux/kho/abi/compat.h>
 #include <linux/kho/abi/radix_tree.h>
+#include <linux/kho/abi/vmalloc.h>
 
 /**
  * DOC: Kexec Handover ABI
@@ -87,7 +88,8 @@
 #define KHO_FDT_COMPAT_BASE "kho-v4"
 #define KHO_FDT_COMPATIBLE						\
 	KHO_FDT_COMPAT_BASE						\
-	KHO_SUB_COMPAT(KHO_RADIX_COMPATIBLE)
+	KHO_SUB_COMPAT(KHO_RADIX_COMPATIBLE)				\
+	KHO_SUB_COMPAT(KHO_VMALLOC_COMPATIBLE)
 
 /* The FDT property for the preserved memory map. */
 #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index af310c0c9fdf..24ecbf48cbe1 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,7 +11,9 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
+#include <linux/kho/abi/compat.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/kho/abi/vmalloc.h>
 #include <linux/types.h>
 
@@ -89,6 +91,11 @@ struct memfd_luo_ser {
 } __packed;
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+#define MEMFD_LUO_FH_COMPAT_BASE "memfd-v2"
+#define MEMFD_LUO_FH_COMPATIBLE						\
+	MEMFD_LUO_FH_COMPAT_BASE					\
+	KHO_SUB_COMPAT(KHO_VMALLOC_COMPATIBLE)
+
+static_assert(KHO_COMPAT_ALIGN(MEMFD_LUO_FH_COMPATIBLE) <= LIVEUPDATE_HNDL_COMPAT_LENGTH);
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/include/linux/kho/abi/vmalloc.h b/include/linux/kho/abi/vmalloc.h
index 87650e1dd774..1847b82e147b 100644
--- a/include/linux/kho/abi/vmalloc.h
+++ b/include/linux/kho/abi/vmalloc.h
@@ -9,13 +9,13 @@
  *
  * The Kexec Handover ABI for preserving vmalloc'ed memory is defined by
  * a set of structures and helper macros. The layout of these structures is a
- * stable contract between kernels and is versioned by the KHO_FDT_COMPATIBLE
+ * stable contract between kernels and is versioned by the KHO_VMALLOC_COMPATIBLE
  * string.
  *
  * This interface is a contract. Any modification to the structure fields,
  * compatible strings, or the layout of the serialization structures defined
  * here constitutes a breaking change. Such changes require incrementing the
- * version number in the `KHO_FDT_COMPATIBLE` string to prevent a new kernel
+ * version number in the `KHO_VMALLOC_COMPATIBLE` string to prevent a new kernel
  * from misinterpreting data from an old kernel.
  *
  * Changes are allowed provided the compatibility version is incremented;
@@ -36,6 +36,8 @@
 #include <linux/types.h>
 #include <asm/page.h>
 
+#define KHO_VMALLOC_COMPATIBLE "vmalloc-v1"
+
 /* Helper macro to define a union for a serializable pointer. */
 #define DECLARE_KHOSER_PTR(name, type)	\
 	union {                        \
-- 
2.53.0


