Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A011CAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODUtnXTdqq8MC4mwenjZZ5e3HnlAeD1+Pt29yLPwKkE=; b=1mqbIaeisBbm3EOXfH1uySoeHs
	Q7NExcVZ62gNEPbp3UIuVgfYE0czGU8U8SyXA7C8mFlSfHCXnjsdvgZMxtuguwNKzDItT90CfclCj
	FC0bTF7yvqkodrsJAwUNULv6GhO+pGf1df+lyFcCLxXjiDGrrqAxXoCXJvGVIN5D+g8o79hW+AiFN
	2QDa4Jf/XNUy5AcT1J5X8v4RfIj5/xwVzvaOvWEieXuSUVYzdLAu0QaINqt4ZTmXlAabfnVa65hGd
	ZpA3N2Z28BPceHQxODkRD3juRZAI6+KxMUdBBhrOTIKGIytkyQeMF2pfYVvjYYKmEavVf222UuwPZ
	ERfmTqUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsy-00000006CZh-2HVe;
	Tue, 16 Sep 2025 01:53:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsx-00000006CYk-2XrS
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ODUtnXTdqq8MC4mwenjZZ5e3HnlAeD1+Pt29yLPwKkE=; b=TQdZ8L7lUrIBKmAeC1U7DR2JFC
	3hWBxBCAi2mRDHuGkO6UBMjfrDsgNKYt6WW0MlHNKrAIk08tfxvVKl7soIosUMWzDf7WI483+a215
	oYpbTdTYQo81VojYCE1bcTP7/8hcKNe6qnwPhAZKMPhaR2sIG55xcv/q31nseb24VxvClGdQV5GJz
	6JqWomIxQ8kulVLtMLwv0fXJQu1CDMRxJk+gkvUXAJjBjRjnEK8ajeWabtcfCU98Frg5gBPh4PVso
	PA6DJUtdSIeakNTArqRRGlmGGe5xV37imZErSS3j4cKAH3T3Ior679BqX38bNKgpw/GC2AuCD6Iq8
	AOmwRHQg==;
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsr-000000077kF-47oa
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODUtnXTdqq8MC4mwenjZZ5e3HnlAeD1+Pt29yLPwKkE=;
	b=Oju2zFFMsATgfSYT9xKQl3XxqMIKWovheGrimftxrJ1RVgxI4fMwfM5P/AJW5DB/rn/ovf
	WIZ7jiscnVbxo4I/HmUR2joVTbRMKoiYF8kyNpjFvPravJ5jRgBHIP6HLq48cLxV5oAOE/
	Ugc/OasleIXP/Hq3xbH1QJj8isVKK10=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 08/10] LoongArch/pez: Fix kernel_fd handling when kexec_file is supported
Date: Tue, 16 Sep 2025 09:46:53 +0800
Message-Id: <20250916014655.841632-9-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025330_531464_A31D5CE9 
X-CRM114-Status: GOOD (  10.81  )
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

After the current pez kernel image is decompressed and loaded, this kernel_fd
will be released. When kexec_file is added subsequently, the kernel detects
that the content in kernel_fd is empty, causing the kernel loading to fail.
Therefore, kernel_fd is rewritten for processing.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-pez-loongarch.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-pez-loongarch.c b/kexec/arch/loongarch/kexec-pez-loongarch.c
index 942a47c..e78909c 100644
--- a/kexec/arch/loongarch/kexec-pez-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pez-loongarch.c
@@ -64,13 +64,17 @@ int pez_loongarch_load(int argc, char **argv, const char *buf, off_t len,
 	if (kernel_fd > 0 && decompressed_size > 0) {
 		char *kbuf;
 		off_t nread;
+		int fd;
 
+		if (info->kernel_fd > 0)
+			close(info->kernel_fd);
 		info->kernel_fd = kernel_fd;
-		/*
-		 * slurp_fd will close kernel_fd, but it is safe here
-		 * due to no kexec_file_load support.
-		 */
-		kbuf = slurp_fd(kernel_fd, NULL, decompressed_size, &nread);
+		fd = dup(kernel_fd);
+		if (fd < 0) {
+			dbgprintf("%s: dup fd failed.\n", __func__);
+			return -1;
+		}
+		kbuf = slurp_fd(fd, NULL, decompressed_size, &nread);
 		if (!kbuf || nread != decompressed_size) {
 			dbgprintf("%s: slurp_fd failed.\n", __func__);
 			return -1;
-- 
2.34.1


