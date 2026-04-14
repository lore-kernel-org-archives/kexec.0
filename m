Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEA7ED7B9C
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7w7rDb2x8gWkgwWoNb8pQhwJCMxfZOGcIufrj0Flsg=; b=tHXB223OgzlUGPHgOUnAzu1Vex
	Hiz1oJstzBErpRlTW3NFoRD5ysZHw3ixO0hjhlLvCPdMfTFL7AJVYTs95eOcTHcoI2EXHJ0XMvQQy
	a89FEJ9uKdHI9sf3cF4rhPi5p1++O6WmKdBtESOHtXssKITx3PjUOC9rzx9rwovAPWHnBBeee8oxT
	w3m/+Ml/1tH/4Dd5lYipV4rvxgGZ1JwgUDmG+qglq7muH39MCOTl/ot3uaNzNpORt8asR1SHy7XAf
	sTJ/r8c80rHDSsBvWs5ky1ddlULKYxPr/oQVfKs7LKOli1EZ7FBXc3MwF+Njve0Z1ngWW+80BGTIF
	gdFRHyrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazn-0000000H93U-1e8n;
	Tue, 14 Apr 2026 10:27:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazl-0000000H91J-1r9j
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7w7rDb2x8gWkgwWoNb8pQhwJCMxfZOGcIufrj0Flsg=;
	b=f+8QZ2/htf1Xi6j4M62AkCR46vTNCBIk3hI/o5orYhkbIlya44y0E/spZDp63tikeQy4QP
	o8ibMkTOSWSyd8OOER5OVe95538hH8YvnLvkQtZ6a6OEiwRyCGLbGLA1aiY7C7DWsYFHfh
	lNHBuB5oopZW9VkiPDw1OisAs4w+38E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-xArVzc1GMf6JNLbyYW1GDw-1; Tue, 14 Apr 2026 06:27:47 -0400
X-MC-Unique: xArVzc1GMf6JNLbyYW1GDw-1
X-Mimecast-MFC-AGG-ID: xArVzc1GMf6JNLbyYW1GDw_1776162466
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so38070315ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162466; x=1776767266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7w7rDb2x8gWkgwWoNb8pQhwJCMxfZOGcIufrj0Flsg=;
        b=SriHvhF3vQ9340XCll9wcnSJ/XHBbw6e23+fUQFkp0mv8C1uLbZ9tzOIWEA6jTohIc
         C9K5eMwQ+URomLChAY6CMXkI79QVz4pQx/kNivp5MO9A33/+Dz7y2BuulT2db2q5H9vL
         kJBokHVxUrUgskFTUAGRzHYawKdrHvvwzj9F17T8jWVntTGDwjfamgT8bQefYI6SqkJ2
         a1PNszLpJbheHAFSkg9Z6wZFfTDSqwF0n9aXkMc7Ni4I4U2T3lGpIhdi78aIqg2ehKC1
         bRicb8zF9OI//KDIH9/pFBZ9zh2d1SEwNaHIktyTDEv26/9DR/A7ABWONoOw74DD6VB0
         +vYw==
X-Forwarded-Encrypted: i=1; AFNElJ+iLI3iA4FW0Cps0TypcZJ7+C9qpXFMpbJ250WPRTzdr7wKvbq6ln9RIaVBZm/Iya+lYyC9jw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwjhGxJ5ELlIE2AEnfgi+ss3YEvxk44ZwFp+EMkst08h/6dHZ+Q
	+92yVheRGTAwX7S5JKirAHFb+6K3puuHOOkGCfBqRWXw6ASMZMYLr0wj6LpQDjIsix+1R8hZQdT
	YHwuF9M/YHkj96cKC5oRqyvzgsYs4R9eXU/9FEndlTmPRHIZO58kfrOnMYk3yQQ==
X-Gm-Gg: AeBDievJPfDGg+Un5B5LOKsVd0ZFsxLFvDaYHxVLQ7/okaTWJ6KLAOmHNMoCqzuU5ae
	eulpkssbP5p1Pv6YWD/c9wa2TO2H1x6p+MXGqScbH2c45zr/P0Eb7QEPD5Xe6y4+0CQDIQtfemf
	94IA8h1NaQtx7NjckLIbDCd0ic0pYCHhynAZkgLzHwu411QeDNXqX4TgVOIitRZjyHXU+AWWyfd
	FTTgwl4steVXRyXvtOmwlOGuSUw1lThZ1aFqjh6He6hVwUKVAF8s0ozi7BywEajQ7J6Ia7oZ1bh
	tj2QuOal8HPQW0Xdc9v8ePcRN+x3OzzjxrpGXLfM47VOCvPhz20oa5rUpRBL4RQ2jFYnowM3MaH
	Xp/n8qEuXI09D3Hyaataa+yvBTQ2mzUb4PtUeOPjHE9agCHSL2C7Lirtv+2gliGtsKDiE
X-Received: by 2002:a17:903:248f:b0:2b2:67cd:9963 with SMTP id d9443c01a7336-2b2d5a71366mr129204525ad.38.1776162465869;
        Tue, 14 Apr 2026 03:27:45 -0700 (PDT)
X-Received: by 2002:a17:903:248f:b0:2b2:67cd:9963 with SMTP id d9443c01a7336-2b2d5a71366mr129204365ad.38.1776162465363;
        Tue, 14 Apr 2026 03:27:45 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:45 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 7/9] Add sample extension as an example reference
Date: Tue, 14 Apr 2026 22:26:54 +1200
Message-ID: <20260414102656.55200-8-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N5Bz2TBNYG8oB9V0SBFuv9ZicDFFCdu69_lfAJMdyzc_1776162466
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032749_552859_333B64F4 
X-CRM114-Status: GOOD (  19.75  )
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

This patch will add a sample.c as an example extension for code
reference. The extension will do nothing related to page filtering,
but print a few kernel symbol/type information.

Suggested-by: Kazuhito Hagio <k-hagio-ab@nec.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extensions/Makefile |  2 +-
 extensions/sample.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 extensions/sample.c

diff --git a/extensions/Makefile b/extensions/Makefile
index b23f346..dbaec4e 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO :=
+CONTRIB_SO := sample.so
 
 all: $(CONTRIB_SO)
 
diff --git a/extensions/sample.c b/extensions/sample.c
new file mode 100644
index 0000000..e4938d1
--- /dev/null
+++ b/extensions/sample.c
@@ -0,0 +1,69 @@
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../extension.h"
+
+/* 
+ * Declare the kernel symbols/types that will be used by the extension later.
+ * The btf/kallsyms component of makedumpfile will resolve these requested
+ * info automatically during extension loading.
+ * 
+ * The symbol/types declared by non-OPT macros as INIT_MOD_XX are must-have for
+ * the extension, any missing of these will lead to load-fail of the extension.
+ * This is useful to skip one extension as early. E.g. exit the amdgpu mm filtering
+ * extension when filtering against a vmcore dumpped by a machine which have
+ * no amdgpu hardware.
+ * 
+ * The symbol/types declared by OPT macros as INIT_OPT_MOD_XX are optional,
+ * meaning the existence of these are checked during extension runtime. This
+ * is useful to cover different kernel versions where some of the data structure
+ * are slightly different.
+ */
+/* All kernel will have init_task and task_struct.mm */
+INIT_MOD_SYM(vmlinux, init_task);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm);
+/* 
+ * Older kernels use mm_struct.mm_rb,
+ * later ones use mm_struct.mm_mt
+ */
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_mt);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_rb);
+
+/*
+ * Extension callback when makedumpfile is doing page filtering,
+ * extension should decide whether the given page should be kept(PG_INCLUDE),
+ * discarded(PG_EXCLUDE) or undecided(PG_UNDECID). Here we simply return
+ * PG_UNDECID to let every page fallbacks to traditinal page-flags
+ * check routine or let other extensions make the decision.
+ */
+int extension_callback(unsigned long pfn, const void *pcache)
+{
+	return PG_UNDECID;
+}
+
+/* Entry of extension */
+void extension_init(void)
+{
+	MSG("sample.so: The address of init_task is: %lx\n",
+		GET_MOD_SYM(vmlinux, init_task));
+	MSG("sample.so: The size of task_struct is: %d bytes\n",
+		GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, task_struct, mm));
+	MSG("sample.so: The offset of member mm within task_struct is: %d bytes\n",
+		GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, task_struct, mm) / 8 );
+	MSG("sample.so: The size of member mm within task_struct is: %d bytes\n",
+		GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, task_struct, mm));
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_mt)) {
+		MSG("sample.so: Your kernel is using maple tree in mm_struct\n");
+	}
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_rb)) {
+		MSG("sample.so: Your kernel is using rb tree in mm_struct\n");
+	}
+}
+
+/* 
+ * This function is called when the extension is unloaded. 
+ * If desired, perform any cleanups here. 
+ */
+__attribute__((destructor))
+void extension_cleanup(void) { }
+
-- 
2.47.0


