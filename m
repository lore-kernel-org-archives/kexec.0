Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AA2C3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kNadNjwd+tRzvilVdVp16QhT3RnAl79xAn7t3vtR0CE=; b=zanUG99fmUSmPI
	3II5JXCN+WNahxXInG9yjzGe643jaa8UaU2qekU/NzYR/+omBYUqQWmwsBVBqIA9/y8BhPE1vBnUX
	KEQQSCYVo6WNM87oEmz/hbIvFeObFWNiALcNKO7i1N015btGf8jS10XEfoesX3KfiSb4hoc+9pCCe
	/elw1vh0e3X5pbsPtYGZtUrTuyRKWLz2VVpzu6EJcooZpGl7BbotPBQKopmu5G4I31V6GVqxCb8B6
	2T6Pwma6T/7vqkg1O8ac38OT3K/82EUlGD4gcMDZ1nRBMcPTOAzIbUz7aCKgpPRW9K2U6DAUXXKtF
	qx9cESlgt5tVPtjQ7pDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpMA-005AIc-01;
	Mon, 08 Jan 2024 13:07:54 +0000
Received: from mail-m12816.netease.com ([103.209.128.16])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpM6-005AGP-2f
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 13:07:52 +0000
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 386114C0297;
	Mon,  8 Jan 2024 21:07:33 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Date: Mon,  8 Jan 2024 21:06:47 +0800
Message-ID: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkIYVk5OGRhKQxpIGRlOT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8ce92f7fc0022ekunm386114c0297
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6Pww5ITczExAPIwoZIik0
	D0wKCg9VSlVKTEtPTEpCSU5PS0lIVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFITk5MNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_050751_092359_D70B1F04 
X-CRM114-Status: GOOD (  13.78  )
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

In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
In the current x86 architecture code, the elfheader is always allocated
at crashk_res.start. It seems that there won't be a new split range.
But it depends on the allocation position of elfheader in crashk_res. To
avoid potential out of bounds in future, add a extra slot.

The similar issue also exists in fill_up_crash_elf_data(). The range to
be excluded is [0, 1M], start (0) is special and will not appear in the
middle of existing cmem->ranges[]. But in cast the low 1M could be
changed in the future, add a extra slot too.

Previously discussed link:
[1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
[2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
[3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 arch/x86/kernel/crash.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b6b044356f1b..d21592ad8952 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -149,8 +149,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
+	 *
+	 * Exclusion of low 1M may not cause another range split, because the
+	 * range of exclude is [0, 1M] and the condition for splitting a new
+	 * region is that the start, end parameters are both in a certain
+	 * existing region in cmem and cannot be equal to existing region's
+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
+	 * condition.
+	 *
+	 * But in order to lest the low 1M could be changed in the future,
+	 * (e.g. [stare, 1M]), add a extra slot.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -282,9 +292,16 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	/*
+	 * In the current x86 architecture code, the elfheader is always
+	 * allocated at crashk_res.start. But it depends on the allocation
+	 * position of elfheader in crashk_res. To avoid potential out of
+	 * bounds in future, add a extra slot.
+	 */
+	cmem = vzalloc(struct_size(cmem, ranges, 2));
 	if (!cmem)
 		return -ENOMEM;
+	cmem->max_nr_ranges = 2;
 
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
