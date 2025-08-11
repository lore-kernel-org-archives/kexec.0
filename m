Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936EACA0EC0
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wABBNQ3mHZ/Q4oyr/JGJiJ2cVXrJHeWuyGrS/7dyF1s=; b=bYLmVSwpHzc8MufxxCmcSdi3mz
	E5+3IG0Aot+3to34b74MH+fGSlP0OzUkZYuXc6A4L71Ge9hRtveubb+ayLWnhOMFkAWEO7EY9n2N5
	swbnXVQ9C20y39kKynLeVNxgADpyV+3BKte2r81O3UTCgLtTkYM6dASShwu0146AaEJWJGOoHDv2a
	4HCPqMpRTooKcNjdrKPxUeQ7CGl5DL7Nzd6G+BWhE9OmpAT9mdJrKpxpL6DpjMqbvhOhLxhQ0YX2i
	kpavhjmRjKcu7NRZY4xseS/bPkqRdc4k5hyuvUEjVb7TRN+N5k0XaMFxQ22qMeMadN0SANlcI1/mT
	F+PF4lrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpR-000000076xF-16ja;
	Mon, 11 Aug 2025 09:28:29 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpO-000000076rz-1RGE
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 09:28:28 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABBNQ3mHZ/Q4oyr/JGJiJ2cVXrJHeWuyGrS/7dyF1s=;
	b=hwKHGRpTwcj5BnYND7AUt6PvBNz24D5wu7pvV+pT3oIVgQM16TUOiEfmR5zIrUo/zIa/ZN
	33xkg7+hz0dUpiH9gD2Clb6XR36ZEEca1c5Vw1UvnN4KbQa27VE5RBcauGlM9bU7Rf3q3z
	fqGpZNysr9Fdqxk9cgpla5SLDtPx6bY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 5/6] LoongArch/kexec_file: Add "mem" parameter to limit memory usage of kdump kernel
Date: Mon, 11 Aug 2025 17:26:58 +0800
Message-Id: <20250811092659.14903-6-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
References: <20250811092659.14903-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_022826_544460_A2B09250 
X-CRM114-Status: GOOD (  12.27  )
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

From: Youling Tang <tangyouling@kylinos.cn>

Add the "mem=size@start" parameter to the cmdline and pass it to the
capture kernel. Limit the runtime memory area for capturing the kernel
to avoid disrupting the production kernel site.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec_file.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 06def654cc09..7da88c80cace 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -89,6 +89,26 @@ static void cmdline_add_elfcorehdr(struct kimage *image, unsigned long *cmdline_
 	*cmdline_tmplen += elfcorehdr_strlen;
 }
 
+/*
+ * Adds the "mem=size@start" command line parameter to command line, indicating the
+ * memory region the new kernel can use to boot into.
+ */
+static void cmdline_add_mem(struct kimage *image, unsigned long *cmdline_tmplen,
+				char *modified_cmdline)
+{
+	int mem_strlen = 0;
+
+	mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%llx@0x%llx ",
+		crashk_res.end - crashk_res.start + 1, crashk_res.start);
+	*cmdline_tmplen += mem_strlen;
+
+	if (crashk_low_res.end) {
+		mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%llx@0x%llx ",
+			crashk_low_res.end - crashk_low_res.start + 1, crashk_low_res.start);
+		*cmdline_tmplen += mem_strlen;
+	}
+}
+
 #endif
 
 /* Adds the "initrd=start,size" command line parameter to command line. */
@@ -136,6 +156,7 @@ int load_other_segments(struct kimage *image,
 	/* load elf core header */
 	void *headers;
 	unsigned long headers_sz;
+
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
@@ -165,6 +186,9 @@ int load_other_segments(struct kimage *image,
 
 		/* Add the elfcorehdr=size@start parameter to the command line */
 		cmdline_add_elfcorehdr(image, &cmdline_tmplen, modified_cmdline, headers_sz);
+
+		/* Add the mem=size@start parameter to the command line */
+		cmdline_add_mem(image, &cmdline_tmplen, modified_cmdline);
 	}
 #endif
 
-- 
2.34.1


