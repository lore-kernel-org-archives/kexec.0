Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E58CCD1AF
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIeDgxZ048HUq/QptiVsvTSq/SH6NNfnJz16wRbfAOg=; b=2tfGFUDomqVaOtlS3I+/3TCOp8
	zVfdJVLKaSiBDYsWtbcu8xZ22uA+95BOZ3BO/JslVfNoBww3l0RLj36pwRfxaXdWpEA2D6oDnKWmH
	1SrVgV1fcmOjCE3gVybstfoAHmsWcehK5s/xmfs2aO9jCEncU45fAdiVl/zse+iRvrQunwKEY8/zV
	xPg1M/JxamGd2Ey1O9I82YIU0pCsJyTl0I3awWkM4tqmeiriRCT2x5h0yfKeZ3Xproh93TPm6pAUN
	pf9e+QvpkQIVj32JuaF4BhRBpr5DFeG6QxYti4Sk2mft+oSm6qkvPBAUvQ0GGPgYuLyhB1jdrEaZR
	ipbWwTBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMiw-0000000Aj1T-1nBe;
	Sun, 19 Oct 2025 06:16:58 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMit-0000000Aizo-1xHH
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:16:56 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7a226a0798cso1548891b3a.2
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854615; x=1761459415; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIeDgxZ048HUq/QptiVsvTSq/SH6NNfnJz16wRbfAOg=;
        b=JhbPxQePOkiukaZHlL6PXI8/4fJ2gm3lRms7FWZ5htLm2HQuDlM6KXPKzSBpNcJPQi
         bCqaW4j7bWgSwiAq0XvsE7duQxrC0dRgAD5PiaXTBI6DpLE2TZO0tzobxTEWIPsguvvb
         v9gVx/LqZdrU8M9nnsxuJaeH3ISBMWSmDojaVyiIttSIHWw7uK/Av9lS6ss0MAVkO2z1
         T097hThUz2lZiB9RyyttLIzEKyAVWOeHamNCPtPYVsuCDplzQXsba6yvTHqH8kQdDwzJ
         phVex5QqclydO71N6qRqLYrItNLlDae7RCmFDPR87IC0t5aY2rz3QY8vIKnxMZfanwmx
         5GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854615; x=1761459415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIeDgxZ048HUq/QptiVsvTSq/SH6NNfnJz16wRbfAOg=;
        b=QV4EB21qQ3ya0NqLBtES4OWUa0fiGL79hktHgMQLLmOefehWVNiCqYeW7GKn9fb2AC
         KV7QMoFDqxQn7jbjpMmtpFAYVqy0XtFIinlUU+MmVcqkC8euqTZwPeS72hwNxOUj0abO
         9RwTbt60zVGbjSanV5E8g5jfdTDOGgRFXKQclJVER9fJMkIW/ycvyvx3kjtLYjga/52q
         pernR+nXoVdDSCJ4QcaroV9dUTrfuuu5+UJe8A4R5F4FIaLUxIUBD6lSkPlLlF5KnUF1
         LacWJib6FwT2hCXCY5+5Nmmxrwn4z/ZZoRvN9lx+fXPvOoZ4KPg5+2EnW02CVcXMToF3
         ul/w==
X-Forwarded-Encrypted: i=1; AJvYcCUVxsbugwUaO5oW8lHMGEq3QT1eh60DOTrYz+8YneNVrZShqGkbRJ8NVYXqqO3rcDXMkE4C2A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1O8s9O7UoiZe0n7LZZ+yKQT81Qba5jgVXpmPx+eR0Q/UzqYrk
	U5x50ijmPAFqglPnUGlTo8gUroxVECmp3aaWi1xe0txvYB0lXdhxz/HX
X-Gm-Gg: ASbGncs2a/X+xDLVKfaEQjfxULXyzyL4d2Bl5yTfwOtP24idDllm2AJKt9Gz9Ot/WM9
	0jJpONic48HuL1iDPViT3yV6mRVdZIEgvq55bjwhG+a2sb8OhJH5l7rQ+xMGsNjS5m2qAfR3oMH
	h4cojdQS+O/RrG1mdNBnGYvH5C7Jkifq2Qfq5RMoI/q02LeIGg2gTH2up1yd2t62OpgAorbDdK1
	eYHQ8YeAjykLLlKuexFKYmJmrpg/rZ2nESEJUKNvU3qZS9gZaX4ApBXcOoY0+CIYdQ1DX6AECIs
	Myc42gpxWkw2fKyFQGkzNiLUArfYz1qDmx7xmN0UwFlj7sa/V+a8WwFcZdquoPettSLEaVwB/wC
	9ou7yK863xAfF7C6wNlXB+pTc359MoRrW//iTz3/333/x2HCTQyd8enoYdftxI5WJOQ3Y6KWdqI
	98cqUEK0ZqCczDSE8=
X-Google-Smtp-Source: AGHT+IG0OBW7fmiA2YniV8ymtG2+sPiHKCxBMdY5eWEb2qkoBgohPShQvQn2sQ3XNKwAIyFsb9Df0A==
X-Received: by 2002:a05:6300:4cc:20b0:334:b4ad:154b with SMTP id adf61e73a8af0-334b4ad168fmr5911026637.27.1760854614800;
        Sat, 18 Oct 2025 23:16:54 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 03/16] multikernel: Introduce basic multikernel subsystem infrastructure
Date: Sat, 18 Oct 2025 23:16:17 -0700
Message-Id: <20251019061631.2235405-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231655_519570_2A805CAF 
X-CRM114-Status: GOOD (  16.24  )
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

From: Cong Wang <cwang@multikernel.io>

This commit introduces:

* Configuration infrastructure (kernel/multikernel/Kconfig) that adds
  CONFIG_MULTIKERNEL option depending on KEXEC_CORE, it will provide kernfs
  interface for multikernel instance management, device tree based
  resource management, physical memory pool allocation, and kexec integration.

* Core initialization module (kernel/multikernel/core.c) that provides
  basic subsystem initialization using subsys_initcall() to ensure
  multikernel support is initialized after core kernel subsystems.

This foundational commit establishes the basic framework that subsequent
patches will build upon to implement the full multikernel functionality.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/Kconfig.kexec        |  2 ++
 kernel/Makefile             |  1 +
 kernel/multikernel/Kconfig  | 20 ++++++++++++++++++++
 kernel/multikernel/Makefile |  6 ++++++
 kernel/multikernel/core.c   | 17 +++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 kernel/multikernel/Kconfig
 create mode 100644 kernel/multikernel/Makefile
 create mode 100644 kernel/multikernel/core.c

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..e0fbd7e9af43 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -194,4 +194,6 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+source "kernel/multikernel/Kconfig"
+
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..017ed567f86a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -56,6 +56,7 @@ obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
+obj-$(CONFIG_MULTIKERNEL) += multikernel/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/multikernel/Kconfig b/kernel/multikernel/Kconfig
new file mode 100644
index 000000000000..0e61fd2e505a
--- /dev/null
+++ b/kernel/multikernel/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Multikernel configuration
+#
+
+config MULTIKERNEL
+	bool "Multikernel support"
+	depends on KEXEC_CORE
+	help
+	  Enable multikernel support, which allows running multiple kernel
+	  instances simultaneously with resource isolation and inter-kernel
+	  communication capabilities.
+
+	  This feature provides:
+	  - Sysfs interface for multikernel instance management
+	  - Device tree based resource specification
+	  - Memory pool management for kernel instances
+	  - Integration with kexec for kernel loading
+
+	  If unsure, say N.
diff --git a/kernel/multikernel/Makefile b/kernel/multikernel/Makefile
new file mode 100644
index 000000000000..950bace927a0
--- /dev/null
+++ b/kernel/multikernel/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for multikernel support
+#
+
+obj-y += core.o
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
new file mode 100644
index 000000000000..218424d59cc3
--- /dev/null
+++ b/kernel/multikernel/core.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/multikernel.h>
+
+static int __init multikernel_init(void)
+{
+	pr_info("Multikernel support initialized\n");
+	return 0;
+}
+
+/* Initialize multikernel after core kernel subsystems are ready */
+subsys_initcall(multikernel_init);
-- 
2.34.1


