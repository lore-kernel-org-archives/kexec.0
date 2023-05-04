Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E41C77B78
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HxIVv9vjvwb2fuOAutT0Ix3N6X5A+H+06CZHjulk/jU=; b=ZseCiMunhq4f8t
	aWUO07WvE9rTWwk9OCln/2TwZV9fF2wRxDi7FW0XAwqxhNvn+xsleaZ5CzFo+S/aknffeg3ptYRqX
	nU0m2YHRjRU8W5arV3qSrZoU9obDNbB3JPZuA9EIy3tsaBHq1aAl5BfYW3b/J9EQLIDh/XM9WJ04p
	JYkg1FwuHF7z0EgBziP0efmqmvu9XtFFwFS7XjfZmBPfzHlUJpyGRrreL1O5Ud52oCuwgWM6A8l4D
	yktd4oxl54IzoZGlvvuGbxkDRhEpT9zuywZxbVQOmUE+uKAiuWvJHu6H34kbD+jV8GVcESMAYGwTH
	zvUQJMWyIj95xJ2RrhYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1o-008M3R-2E;
	Thu, 04 May 2023 16:42:00 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1k-008M1R-1m
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:41:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82872F4;
	Thu,  4 May 2023 09:42:36 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77DA13F5A1;
	Thu,  4 May 2023 09:41:52 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	piliu@redhat.com,
	bhsharma@redhat.com,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/4] arm64: Cleanup _probe() return values
Date: Thu,  4 May 2023 11:41:44 -0500
Message-Id: <20230504164147.1166614-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_094156_654874_94DD5353 
X-CRM114-Status: GOOD (  13.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The decision to process a compressed image should
be part of the image specific detection logic. As such
lets clarify the return logic, and remove the is_zlib_file()
logic in the main file type detection loop.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kexec/arch/arm64/kexec-arm64.c     |  6 ++++++
 kexec/arch/arm64/kexec-elf-arm64.c |  1 +
 kexec/kexec.c                      | 11 ++++-------
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index ec6df4b..a36c103 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -70,6 +70,12 @@ const struct arch_map_entry arches[] = {
 	{ NULL, 0 },
 };
 
+/*
+ * All arm probe routines must return:
+ * -1 for invalid image
+ * 0 valid image in buffer
+ * >0 fd of valid image after decompression
+ */
 struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index e14f8e9..3b7e391 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -25,6 +25,7 @@ int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
 
 	if (result < 0) {
 		dbgprintf("%s: Not an ELF executable.\n", __func__);
+		result = -1;
 		goto on_exit;
 	}
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..97b7226 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1303,14 +1303,11 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	for (i = 0; i < file_types; i++) {
 #ifdef __aarch64__
 		/* handle Image.gz like cases */
-		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
+		if ((ret = file_type[i].probe(kernel_buf, kernel_size)) >= 0) {
+			if (ret > 0)
 				kernel_fd = ret;
-				break;
-			}
-		} else
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
-				break;
+			break;
+		}
 #else
 		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
 			break;
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
