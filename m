Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9540CCD98F0
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTE+rcIB/kYCY3hU/9MigGBjH+x9aONlYZzCeCO344Y=; b=LxZgsXu+FLFG5rqbTxDvnIiTOi
	9ihV74teKTCvtfZIuE0GhDbd//9sC2A/Gu/dtKjaFnYImoWGN9Y/Qt20XMzYfQ5XvNbjMhxZ1vu9A
	cG+MOJVsb1J0kPOyGqSbPEjJH5kQtNo3NGs/qvENjhikhoY09crhARx7yAEYOnL3R8SKlXfZ/vG85
	nZc/5E3kxeeu18wDzMG2rY1MxlmQov9JEBBpIyRJUcgFO60VN1TheQc47Z9G3C6DL+UbdXKc29rpO
	t8gLoe/FjG8+gLR5iaJXKwkSYbb/QD+/ohgkV/k3W0vajkjCdi1/0W5NW4fj+b0gCBzN+ZfmXnI5w
	DGhS+pqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihj-0000000GeB7-3G3T;
	Wed, 17 Jun 2026 05:20:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihf-0000000Ge98-3ZGe
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTE+rcIB/kYCY3hU/9MigGBjH+x9aONlYZzCeCO344Y=;
	b=W5ejGxuY7u2xRBHaaQ7yPxEpuTVJTcDeWQCXu0ZMkTrOv7aV+/irJsY3P09dwj2QDW+lC+
	r0R+XgXc8KgE2Vs0E9/lQY02vXhDYoEPDi7Xh5D//lKQ1jUyp1+NW/RziKgMUhH5e0r3Wm
	XjVyUSITn4Tdj/ga/eGOBQAd5xQUqSU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-HpPjT9a7P5G_RggR8u3zYA-1; Wed, 17 Jun 2026 01:20:41 -0400
X-MC-Unique: HpPjT9a7P5G_RggR8u3zYA-1
X-Mimecast-MFC-AGG-ID: HpPjT9a7P5G_RggR8u3zYA_1781673640
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8422a0eee68so6974967b3a.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673640; x=1782278440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTE+rcIB/kYCY3hU/9MigGBjH+x9aONlYZzCeCO344Y=;
        b=had0GU7rTyJJKRgkCTPNh5118jNnlIy15RBxsXE3x1/N82adpAQFp7EX5CQge2rSLV
         dp95WZlI94eJXP2lOzGWW1pJbS2Z4n+dae8DbV+Roo8BBRxQZwsGCR8jP7U/34fUzEth
         SNQs3q7Fq+TWpWUdcVuDp1arxD6L+lGRMCYieUiQNVnzFeN38e6FYhwkNXVLeQrK7T3t
         QCZWIccDgzse6xCiaQd1dh43G8xM/i6JV9Ko+kc3qHWVyUPLvEZbd1wjXIDUVHd60IEF
         0n2iKk2QB/E9H4jFWR6KXlVvuweJHOEZbCMeBd5JAU9LdhdQKwaknxRH3pImFI+u+qFP
         MDNg==
X-Forwarded-Encrypted: i=1; AFNElJ94/nrncgEl6g5DxcVff004OYD1UmYKV6ftsjn5gWcdLkyXpNjruGC7IZTCi43g+YcpfiGafA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx42s94JdnqtbnX3rvE8ar+Syt4prbMIZGjY1BHURNjyuW5/FVq
	yvOJTcSxc7dmQy04cguvkmiQQUKxnQswmuJkBsA/vdp+rNDEiqQKkMkt2dEP9yKpsieHAeaH6i/
	VbvEpi8lUxODfxetv6XD6+XZQiW5BwJZsHxCC+bioSOwl6CEu/KXXpsWEarAH2w==
X-Gm-Gg: AfdE7cmqkptwiufdB57Yaf16hhiUgd2PUrMLeR8/XUe4Vcj8QHmLfGUv4lZyRaGcgRg
	nqzm8LwWwbM8myILl68nGAkWlcsJQBYPDPkFT4uJdRSrK9QYXE2beS7WGybSEtYUppXdGPM8WiY
	lUxwmJ63gufAeKtL549eSY4syulqcxHPUc76BuMGFBOfHGwCI1lcsYalwUKwHdP8IYcwVtrb8HE
	9GVB7wLsSV6+mK2n5/M+rAzpmqp69eUEq/QQ9qz6V3Vkm124HG2sUDCQgFBOpPJB2HI9/C43S38
	NWk00HNpKGV3QH2wBb+bKrnDZiqnZEcHuG+h+QbA1+6w4sIBr+DpBzKgmAmfxvbxWpkQUup+AYM
	0mctt5siWyuNCGTqkQv0kthy7TZBFr9baOumFjT3rbvefop9TnA==
X-Received: by 2002:a05:6a00:1782:b0:842:7f81:8085 with SMTP id d2e1a72fcca58-8452442e716mr2192245b3a.8.1781673639845;
        Tue, 16 Jun 2026 22:20:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:1782:b0:842:7f81:8085 with SMTP id d2e1a72fcca58-8452442e716mr2192212b3a.8.1781673639386;
        Tue, 16 Jun 2026 22:20:39 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:39 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 07/10] Add sample extension as an example reference
Date: Wed, 17 Jun 2026 17:18:31 +1200
Message-ID: <20260617051834.95404-8-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L2cfgEEv8tT41_S1SCaMcZkWO81k6-L2OrR6GcjUil8_1781673640
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222043_977005_D146E570 
X-CRM114-Status: GOOD (  19.59  )
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
Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
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
2.54.0


