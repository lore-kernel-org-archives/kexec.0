Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC657CAC5A7
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 02:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EgrMw8OUo4MtDGHIReF2UnLsHnlmCvC5iilg9eK2sdg=; b=bsSQXsYyyetVZB6EPBohAZ+FRh
	TUKQVSFde4E6mO6TFNDtQNPVYMYgu8mOpXDHjET+aKEMf9MTAQ8yI14HvWeqPkSHkEV9DYY0odIvC
	3v/qDSMdT3v9hmJF8YZFqGD4fAUqogLQQR/dqacBfRdkBXgDhbPRr11voHXOZCDrqI3SgmPddSWZG
	saQtJd5HSMnZUZiCz4FB/V2xV6jf2rPrtOh33uJsDvOq5uzL/cK7BfHZWezP/euHy7LR5L2MgBG8i
	n1TvPbEV+AJIfxLSliiAIednMIncEJJ5IlENaBliInxIfjmIli9YW5Gi296eqwed4DlJiYyQXou4u
	pq+6vGKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0W1a-00000008Z4e-1MIe;
	Mon, 22 Sep 2025 02:11:30 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0W1U-00000008Z0d-0uSM
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 02:11:29 +0000
X-UUID: 67febc9a975911f0b29709d653e92f7d-20250922
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b964ae84-446f-4e8f-842c-9dd0d65d2648,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.45,REQID:b964ae84-446f-4e8f-842c-9dd0d65d2648,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:6394499c850da98a0fa84ae0b74860b6,BulkI
	D:250922101110796I7DNI,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102|8
	50,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 67febc9a975911f0b29709d653e92f7d-20250922
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 917478032; Mon, 22 Sep 2025 10:11:10 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: horms@verge.net.au
Cc: kexec@lists.infradead.org,
	tangyouling@kylinos.cn,
	chenhuacai@kernel.org,
	duanchenghao@kylinos.cn
Subject: [PATCH] LoongArch: Change COMMAND_LINE_SIZE to 4096
Date: Mon, 22 Sep 2025 10:10:57 +0800
Message-Id: <20250922021057.206063-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_191124_618413_689EE444 
X-CRM114-Status: GOOD (  13.04  )
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

The default COMMAND_LINE_SIZE inherited from asm-generic is 512, which
is too small for modern use cases. For example, when the parameter path
in the cmdline of the kdump first kernel is too long, the limit is
easily exceeded when loading the second kernel.

Increase the command line size to 4096 bytes, In LoongArch, this is
consistent with the upstream configuration of the Linux kernel.
linux kernel commit: f7794a4d92ade518c813de69a01b27ca6d8d86f3.

This patch is necessary because the Linux kernel has been changed to
4096. When the kernel cmdline size exceeds 512, the --reuse-cmdline
option of the kexec command will inevitably result in an error.

The COMMAND_LINE_SIZE in kexec/arch/loongarch/crashdump-loongarch.h
is unused, so it is removed here.

Suggested-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 kexec/arch/loongarch/crashdump-loongarch.h | 2 --
 kexec/arch/loongarch/kexec-loongarch.h     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kexec/arch/loongarch/crashdump-loongarch.h b/kexec/arch/loongarch/crashdump-loongarch.h
index 25ff24b..dac9e71 100644
--- a/kexec/arch/loongarch/crashdump-loongarch.h
+++ b/kexec/arch/loongarch/crashdump-loongarch.h
@@ -20,7 +20,5 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
 /* crash dump kernel support at most two regions, low_region and high region. */
 #define CRASH_MAX_RESERVED_RANGES      2
 
-#define COMMAND_LINE_SIZE	512
-
 extern struct arch_options_t arch_options;
 #endif /* CRASHDUMP_LOONGARCH_H */
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index 2c7624f..0bd462f 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -13,7 +13,7 @@
 
 #define CORE_TYPE_ELF64 1
 
-#define COMMAND_LINE_SIZE 512
+#define COMMAND_LINE_SIZE 4096
 
 #define KiB(x) ((x) * 1024UL)
 #define MiB(x) (KiB(x) * 1024UL)
-- 
2.25.1


