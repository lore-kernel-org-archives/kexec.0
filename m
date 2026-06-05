Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FFDCD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTLNc6RdVPC/3p3BVrwRRbnK/J4mwuIt5WmEdvU+mDY=; b=QlqZtF/jxW9I27fHKm18y7HEz/
	d333iR0hRrxuOOgYRDeIyVX7wtiiUDEz+3iCr26rhIga4qDT6D8c9ZopAa1/NkKrChIWKuBp5Sn4u
	mlx7901aFF6ICRaWDe9WldASl28DUS+CUtHbBHCQtYR0I5iZPWjiCJltdP2UzaDmK4H7NnYkFRPv8
	hR6LmdGBdATwyUHn4XtJ+a43EQ3dizs9luemZpV2K6+zR4v796wJ4YekGA1GNXuPI3FAHrBnGmrGv
	JHbrnFR227/1E4C59yddIgvJ9O1JK38rZzYPx5UINs2Y7E09nrnZYvEnddHb/gGHIBYfhu/J+A+qW
	eoiZQGpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJe-000000002Cm-1tmZ;
	Fri, 05 Jun 2026 03:33:50 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJc-000000002Bs-2irc
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:33:49 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8cce77eb087so12619076d6.1
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630427; x=1781235227; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTLNc6RdVPC/3p3BVrwRRbnK/J4mwuIt5WmEdvU+mDY=;
        b=CjSbu2ExHp9xUOhGQZg7PJ0c9tlu/0f9U14K05KoIO63bn81H8dRzoH/t8zMG/D1ll
         vF6GRMy9+tUz705BbRodZKPdr+xSLgQSQaZtXDNl9ZBbKIByTeKEtxtrUR+n+aFoVION
         oaZHK7CNTsLad/CAsIo0jcjMvo65TaR/uVmaHAmf8QmRXfdiR4okEVeokT1MGF5Fd1i+
         5SSyIB7y4lH0bQsqv0EquTaiqn7tvebbeXQXwI19KNouyY5gNiqgQ69eKp0YZo1LCLMI
         J6RiaUd1l1oDbCfmKcEROurQ1Y1z4HqwF4tiIwQNeZvqgo3Jdzik+Au+s41xpbE3A3v1
         lgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630427; x=1781235227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MTLNc6RdVPC/3p3BVrwRRbnK/J4mwuIt5WmEdvU+mDY=;
        b=LDfwKJOh59N++08YlzCiz3P2yB6GvqFgVd9JJsauFt7x9WkgbP08siwiD/uRQ+NjwI
         ZrNYPi8wIbj5Bgv3iWhWTn1uaw3xqPE8alPJuN6lOT2WCW98zHchW3nB4eTn79iY0RcH
         lQBurVZqYRu9SIeaVcsb0lQWHEMqgxN2MM2VEMMH80q4+GaLScdpKVu+A0+8eFI6r8C0
         ceviafnE8JaxeWEQbglPNBfdwvfdvX9sRbsEOktI00hSBuy2A2ZxHJsA+e42dw2Obf0j
         HTElUuXZwhoZ5pmM+RyPXzet33SMOwOgUuf6FCJ9nPIzbty5raK9LH3oiW8vPh+hNK0g
         NrwA==
X-Forwarded-Encrypted: i=1; AFNElJ+BJdBYCip049v1sjCTCWBIpFTT3lrD+qoucHq/s4VIPSIgO0m0sHf1088C9A+gZPfuaW8tow==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGi8tZe3Taviq6tOhXbaRu1whPAF6ktUMrbVYOQdAECaDsa7eM
	ZprpB4rxVZSjil7goZbq3nHVqXc3srSoDyQgHueUHsib73afdTGAnOZGOXq3nZdqmys=
X-Gm-Gg: Acq92OEGFmHy+SviTJNS5t/KhoHVFMJYR32bgTwh3fRvxkdHEYK77zS6CrehbifJLSi
	QEYXzW7+OY8zExPI0eEXU1QHwhzRbAzLK5vvYJjOnpLI5zHigoPmLR7/wQMmuAY4Nbcqmou9t40
	Iat82kNxpcLsMrHgmKh8kIcYVuzIDC8VCzzyM2mLAXzfUDPhU2/HyKbkaCHWHqxyIRryJyhwqwQ
	Crb0FljJAV4hwgONGQxL+bmDfA4o4J5RbDyiInmAZZgn2EKPWuVH6iqaRqKzr6s7VkfqnfPileP
	oHXlBTBYGj/A2Ip0MI67+t2hYjc9ITwLQ/LrBBTruXasJYj2oXiboaiMzssvqY88R3FORuuQUzd
	wqqe0VBM+qni/IQynNaa5oJtTzvQk2K2JUqZxcm5oHIXNmWjCNzzrXLHD2laMql8wHy2tjszFe2
	gqM67oLYuWmq/1o15Z2+8Id/jJ3eGscGKBP9HqyRjn4yymqukwrwqbbnG6ivmt8Q==
X-Received: by 2002:a05:6214:8088:b0:8cc:58f2:339f with SMTP id 6a1803df08f44-8cee601673fmr33023096d6.16.1780630427604;
        Thu, 04 Jun 2026 20:33:47 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm70512926d6.5.2026.06.04.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:47 -0700 (PDT)
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
Subject: [RFC v1 6/9] kho: introduce compatibility helpers and decouple block version
Date: Fri,  5 Jun 2026 03:32:32 +0000
Message-ID: <20260605033235.717351-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203348_705403_3C40C295 
X-CRM114-Status: GOOD (  17.31  )
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

Decouple the block compatibility string from the global KHO version.

Introduce a compatibility helper header (compat.h) defining utility
macros for constructing subsystem compatibility strings, specifically:
- KHO_SUB_COMPAT() to append sub-component compatibility strings using
  a semicolon separator.
- KHO_COMPAT_ALIGN() to align compatibility string sizes to 8-byte
  boundaries.

Define the individual block compatibility string "block-v1" in block.h,
and integrate it into the composite LUO compatibility string (LUO_ABI_COMPATIBLE)
via the new compatibility helpers.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/block.h  |  4 +++-
 include/linux/kho/abi/compat.h | 33 +++++++++++++++++++++++++++++++++
 include/linux/kho/abi/luo.h    |  8 ++++++--
 3 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/kho/abi/compat.h

diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
index d06d64b963be..95d13cf677cf 100644
--- a/include/linux/kho/abi/block.h
+++ b/include/linux/kho/abi/block.h
@@ -14,7 +14,7 @@
  * This interface is a contract. Any modification to the structure fields,
  * compatible strings, or the layout of the `__packed` serialization
  * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the `KHO_FDT_COMPATIBLE` string to
+ * incrementing the version number in the `KHO_BLOCK_COMPATIBLE` string to
  * prevent a new kernel from misinterpreting data from an old kernel.
  *
  * Changes are allowed provided the compatibility version is incremented;
@@ -28,6 +28,8 @@
 #include <asm/page.h>
 #include <linux/types.h>
 
+#define KHO_BLOCK_COMPATIBLE "block-v1"
+
 /**
  * KHO_BLOCK_SIZE - The size of each serialization block.
  *
diff --git a/include/linux/kho/abi/compat.h b/include/linux/kho/abi/compat.h
new file mode 100644
index 000000000000..25edd964c390
--- /dev/null
+++ b/include/linux/kho/abi/compat.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_COMPAT_H
+#define _LINUX_KHO_ABI_COMPAT_H
+
+#include <linux/align.h>
+
+/**
+ * KHO_SUB_COMPAT - Helper to append a sub-component compatibility string.
+ * @str: The compatibility string of the sub-component.
+ *
+ * Appends a KHO safe data structure compatibility string to a sub-system
+ * compatibility string using a semicolon ';' as a separator.
+ *
+ * NOTE: Sub-components MUST be added in strict alphabetical order to maintain
+ * a consistent and predictable compatibility string value.
+ */
+#define KHO_SUB_COMPAT(str) ";" str
+
+/**
+ * KHO_COMPAT_ALIGN - Align a compatibility string size to 8 bytes.
+ * @str: The compatibility string.
+ *
+ * Aligns the size of a compatibility string to an 8-byte boundary for use
+ * in ABI structures.
+ */
+#define KHO_COMPAT_ALIGN(str)	ALIGN(sizeof(str), 8)
+
+#endif /* _LINUX_KHO_ABI_COMPAT_H */
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..b502670cd2a6 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -58,6 +58,7 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/kho/abi/compat.h>
 #include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
@@ -65,8 +66,11 @@
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v5"
-#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
+#define LUO_ABI_COMPAT_BASE	"luo-v5"
+#define LUO_ABI_COMPATIBLE						\
+	LUO_ABI_COMPAT_BASE						\
+	KHO_SUB_COMPAT(KHO_BLOCK_COMPATIBLE)
+#define LUO_ABI_COMPAT_LEN	KHO_COMPAT_ALIGN(LUO_ABI_COMPATIBLE)
 
 /**
  * struct luo_ser - Centralized LUO ABI header.
-- 
2.53.0


