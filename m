Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C821D4A5EB
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 03:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWLya1dhQNEc2PDrSyTdG72OD3leiyaAynZDfpPJDd8=; b=tVIX1nJrs4oTSdnPWPzLQ+fK6P
	2ggYM4k4wAzGemdrK5+g6XdoDKdxl9dmBekISTmIXN75JxlJoQ+D+4vKorMspmAHZ3kUNXVQV9d2P
	+uD6N9RhmdNTXyjIZCaw4FdsTsx3zdKObmz9IxFYhH8OUJHTpibLZqc0VoiLqxZN3H3hfLIc3gLGK
	9bGgx5oy4JeHif62QjTXll8KSCQG/Ns3Zv93006opopXGPuM3DwM+btAywSaKY7CcGeI2igIQUjB5
	ahVCSkrjXKq11sbYa7mWu8rnGt5HwO4mp9JJBN3jHcHNd5ikEeLXHRk13QS6LUFbuKGCypTWlQeD7
	UQX/kXQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhftz-00000001JSR-0Nic;
	Mon, 19 Jan 2026 03:26:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhftu-00000001JRN-330B
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 03:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWLya1dhQNEc2PDrSyTdG72OD3leiyaAynZDfpPJDd8=;
	b=Sr/WbDdh2I1uXlSQU3IFGZv1TUjRho8lhPqy53DJv8aodXfiKoNR8Qmz6HPF9y3OxDWgT4
	vQWWCaEw/lszjUBOCgOARqj/P143HdNihdfPmsBLHFYlJN9zdBT0Lu+pzJbeSJVcMCDr3Y
	S5yF7fr+omOI4mCzZK7kTKQrtCZQROI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-utvPLdATNoeFcSBB5BRvfw-1; Sun,
 18 Jan 2026 22:25:54 -0500
X-MC-Unique: utvPLdATNoeFcSBB5BRvfw-1
X-Mimecast-MFC-AGG-ID: utvPLdATNoeFcSBB5BRvfw_1768793151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC471956096;
	Mon, 19 Jan 2026 03:25:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 906531955F22;
	Mon, 19 Jan 2026 03:25:39 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 03/13] kexec_file: Introduce routines to parse PE file
Date: Mon, 19 Jan 2026 11:24:14 +0800
Message-ID: <20260119032424.10781-4-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_192558_836902_AC5DBAEA 
X-CRM114-Status: GOOD (  20.06  )
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

The incoming patches need to handle UEFI format image, which is in PE
format. Hence introducing some routines here.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Makefile         |  1 +
 kernel/kexec_internal.h |  3 ++
 kernel/kexec_uefi_app.c | 81 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 kernel/kexec_uefi_app.c

diff --git a/kernel/Makefile b/kernel/Makefile
index e83669841b8cc..f9e85c4a0622b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_BPF) += kexec_uefi_app.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018bc..8e5e5c1237732 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -36,6 +36,9 @@ static inline void kexec_unlock(void)
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
+extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
+extern int pe_get_section(const char *file_buf, const char *sect_name,
+		char **sect_start, unsigned long *sect_sz);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/kernel/kexec_uefi_app.c b/kernel/kexec_uefi_app.c
new file mode 100644
index 0000000000000..dbe6d76d47ffa
--- /dev/null
+++ b/kernel/kexec_uefi_app.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UEFI appilication file helpers
+ *
+ * Copyright (C) 2025, 2026 Red Hat, Inc
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/pe.h>
+#include <linux/string.h>
+#include "kexec_internal.h"
+
+/*
+ * The UEFI Terse Executable (TE) image has MZ header.
+ */
+static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
+{
+	struct mz_hdr *mz;
+	struct pe_hdr *pe;
+
+	if (!kernel_buf)
+		return false;
+	mz = (struct mz_hdr *)kernel_buf;
+	if (mz->magic != IMAGE_DOS_SIGNATURE)
+		return false;
+	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
+	if (pe->magic != IMAGE_NT_SIGNATURE)
+		return false;
+	if (pe->opt_hdr_size == 0) {
+		pr_err("optional header is missing\n");
+		return false;
+	}
+	return true;
+}
+
+bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
+{
+	char *sect_start = NULL;
+	unsigned long sect_sz = 0;
+	int ret;
+
+	if (!is_valid_pe(file_buf, pe_sz))
+		return false;
+	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
+	if (ret < 0)
+		return false;
+	return true;
+}
+
+int pe_get_section(const char *file_buf, const char *sect_name,
+		char **sect_start, unsigned long *sect_sz)
+{
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct section_header *sect_hdr;
+	int section_nr, i;
+	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
+
+	*sect_start = NULL;
+	*sect_sz = 0;
+	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
+	section_nr = pe_hdr->sections;
+	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr +
+				sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr +
+				pe_hdr->opt_hdr_size);
+
+	for (i = 0; i < section_nr; i++) {
+		if (strcmp(sect_hdr->name, sect_name) == 0) {
+			*sect_start = (char *)file_buf + sect_hdr->data_addr;
+			*sect_sz = sect_hdr->raw_data_size;
+			return 0;
+		}
+		sect_hdr++;
+	}
+
+	return -1;
+}
-- 
2.49.0


