Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABEBC46CD2
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A22MSnOz6FrDotj30xzGGw2A1lW1FNFZyHtyK83dNpw=; b=aKSklySx6QVt4J
	IA7z3RUsy959dEywhBqUK4M00ZoczXXrUhBWLcQDLOCpP+IhpJfe7rQh4PY/xu8w3w8juSY0IevFt
	pXgO724OYH8FmftwEFo28RB1Q7o3BrjQuGZnsAWtRnXxe9f3BwOR8M61iW4ekI+CVt9AAAOC8Hivc
	K30G7vHyh7gbJjNphBfGWQDwBDwnpoiSAJ2KweQTYV5hJSAJCI9iLTUNMq2EuEHbuUFRKQUqU5V+i
	QrxoLTkEEWpDIahqoZVpyPdgDySbpI/hVj7HpJSsH4J52X1RI1M8gwhzTFoM3UIq7s+tsXr31CQ/F
	sFDlURxgo/m8sy7aSqxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc4-00GEhg-2X;
	Wed, 20 Dec 2023 05:59:24 +0000
Received: from mail-m12790.qiye.163.com ([115.236.127.90])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc1-00GEgR-2M
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 05:59:23 +0000
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id DF6E726015E;
	Wed, 20 Dec 2023 13:57:42 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/kexec: Fix potential out of bounds in crash_setup_memmap_entries()
Date: Wed, 20 Dec 2023 13:57:31 +0800
Message-ID: <20231220055733.100325-2-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHktOVkMdTx0aThlPHx4fGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c85cd26650276kunmdf6e726015e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Igw6LzE2P1FOOgI4Cw4u
	NwFPCjpVSlVKTEtIS05KQ01PTk1CVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFITEJCNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_215921_946724_BEC8E19A 
X-CRM114-Status: GOOD (  15.19  )
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

In memmap_exclude_ranges(), there will exclude elfheader from
crashk_res. In the current x86 architecture code, the elfheader is
always allocated at crashk_res.start. It seems that there won't be a
split a new range. But it depends on the allocation position of
elfheader in crashk_res. To avoid potential out of bounds in future, Set
the array size to 2.

But similar issue will not exist in fill_up_crash_elf_data(). Because
the range to be excluded is [0, 1M], start (0) is special and will not
appear in the middle of existing cmem->ranges[]. I added a comment to
explain it.

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 arch/x86/kernel/crash.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..1c15d0884c90 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -149,6 +149,13 @@ static struct crash_mem *fill_up_crash_elf_data(void)
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
 	 */
 	nr_ranges += 2;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
@@ -282,9 +289,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	cmem = vzalloc(struct_size(cmem, ranges, 2));
 	if (!cmem)
 		return -ENOMEM;
+	cmem->max_nr_ranges = 2;
+
+	/* Exclude some ranges from crashk_res and add rest to memmap */
+	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
 
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
@@ -320,11 +333,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 		add_e820_entry(params, &ei);
 	}
 
-	/* Exclude some ranges from crashk_res and add rest to memmap */
-	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		goto out;
-
 	for (i = 0; i < cmem->nr_ranges; i++) {
 		ei.size = cmem->ranges[i].end - cmem->ranges[i].start + 1;
 
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
