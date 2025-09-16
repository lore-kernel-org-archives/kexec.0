Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0F6CAC59C
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcsDuUPDp7mHk0asfeabj5f7EbSnwPO1pJDI4q7ieoM=; b=LxBndsb7HoXrH99OVzl2Mvnwia
	Ay0qG/EOiPeEjAaENvid1FIr8AD6GlIPfKKqrzp5ydkYsWm+DJ/2OL0OZ3PdZ932Uwq9DA+Oc7XNm
	Yp9Scii9mzmmHsyK5Jgm6DmM8sW6DamGPyA9zR6TzoJmPVZmqH0f0VfTUhXlxh8u36GUX8P68aXWg
	7ZOUrxgA7D4Kzw+kjoCIbLk/NY3SeAA688s1RcapzyUok3EOD4eGlD/SnEs8lra1ePwYu0MFmM39G
	36ymctpFshHuaenotjCDWNDBEhiKoamU4u4poxfZJIDo/2sUojVvnVl9NBHvcpoqn2f5kBCGSOmGF
	xMVzequQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxe-00000006D1n-34dl;
	Tue, 16 Sep 2025 01:58:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxd-00000006D1J-1w7R
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LcsDuUPDp7mHk0asfeabj5f7EbSnwPO1pJDI4q7ieoM=; b=buapmTXqg5ecQ2IofNd/KQ0Y28
	uYOfN+ye3x2m8S+1DPpzo5irJ9XdoHN4AjW3sAVBsLFuEzgf5Er4l8+FlCUCGwFwPIgV/seDob/yB
	rc5sKJ6e7FrQWa/w3NrPcfk5QCmuaxRs/8OejaliwQExjshUAKS+rwzY1GloOpt6+ArwrJUUdF0bo
	zQKpP75lblSZeiqXbpaekFbLcQiatuCl+FKMtjmc0Bsl/evjaVPja7VqmTUF9BAN00Or0vDz/agW3
	P1qWR+AzxmTJcqXdfBTkXPlriNt4q6LHSNtsESx3Ng+/u53pIfUoYF9nzCMEOnR4bEEam/tRcRKZr
	I4BX1Mgg==;
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxW-000000077yO-1bI7
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:58:21 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcsDuUPDp7mHk0asfeabj5f7EbSnwPO1pJDI4q7ieoM=;
	b=rhdidD4Qi3fj2U4lRSbVGHI1a7iVD/9OjWFT9XrJw9J3bROPicsMkFpkxqZLKmNg2pOxGA
	7FrMngMNxXf3krcLHWJJ3iufMbhSXURM6SGjeTSdO30LN4cbP7WtgffFuW/Zf9PH6uaFOh
	gO+kjzAy6EcznT8cBHBEo0vcrvDvGRs=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 02/10] LoongArch: Fix comments
Date: Tue, 16 Sep 2025 09:46:47 +0800
Message-Id: <20250916014655.841632-3-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025819_684556_2F47852E 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
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

loongarch_load_other_segments() mainly loads initrd and cmdline. Fix this
annotation.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-pei-loongarch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index 1a11103..f0e0d09 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -102,10 +102,10 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 	/* Load the kernel */
 	add_segment(info, buf, len, kernel_segment, loongarch_mem.image_size);
 
-	/* Prepare and load dtb and initrd data */
+	/* Prepare and load initrd and cmdline data */
 	result = loongarch_load_other_segments(info, hole_min);
 	if (result) {
-		fprintf(stderr, "kexec: Load dtb and initrd segments failed.\n");
+		fprintf(stderr, "kexec: Load initrd and cmdline segments failed.\n");
 		goto exit;
 	}
 
-- 
2.34.1


