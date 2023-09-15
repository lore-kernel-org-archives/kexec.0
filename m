Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B788EE021A
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xxi1XG8k15mb3Y8Co9GclYG8zKFQdH5fBbQaxwU7Dd0=; b=z5MjPyaQlMEuqz
	agUOIZbjorEzX61Kpv78i/XLQ0/R0M7+kxcK2PfYolHOExTv/nRyADu2rCf+p4NW2SVkyPG14KkpX
	CaKusmK4iBs4V2M2Ip4J4Yz60O/8/vRIo44nt+5y1BBe6XRJjjNRhX+IA2E7Q+RwOxiOgez+yU1pE
	MKKoWSJ7tFd9c/V4WRnJ98Rj06m9CrGEoKpovwzdZPVWP9NX31S8zq0OFSESkQQNGVgKp8O+cpnXA
	AEl4+43oyoA+/NAhd/+lZopCwDXLGSHS+27w3REkR1lrjSoUjEuyrcthQQQChdT7wI1i727JYGhjf
	uqaCuh3Q9z5BkqWxBE8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzvo-009hhB-31;
	Fri, 15 Sep 2023 03:55:48 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzvm-009hgn-1D
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:55:47 +0000
X-QQ-mid: bizesmtp62t1694750129tb767lqi
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:55:27 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 7QbCsSX/jDb6mKYzusoH0bHI8Li7dnD/j/8gTAiQ3Tam/3oSSvPo6L7Gyorva
	zcPEerEVu4hArJDiAHyTC+m3ENUv8WFY+eELOshXNyl2vUPcrGZrNQLvvhTkfcYStZkJQyu
	tH7xajhfWE3tY2t+WFkB1V5W7cmGcRNWYTSnhvXOLJmgX40++w3QovsoUBvB7EPlIpE70Y9
	KLt74NSFRr8jSJkZEtzGtbHdW66euifd0ZAmftyM1WB/43kyR+pod+IOiNPBDpW3IHX4Xny
	BFHHjTpljFM0maeGzDQQyGOLtB25xbLcJjwZYDx04dszXGxTPj+Fn4YJZXvtJkWUGvcVm3Q
	eTVw8BJcrMz3dmTsKgZSIXNzQA++TSByt+1TRln13PI+SqPKRs1AUx+5pGHwQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13157645311845946866
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 4/7] RISC-V: Correct the usage of command line option
Date: Fri, 15 Sep 2023 11:50:10 +0800
Message-Id: <20230915035013.1582679-5-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205546_740718_DFBCA31F 
X-CRM114-Status: UNSURE (   9.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RISC-V process OPT_CMDLINE with the "command-line" partten,
but the riscv_opts_usage shows the "cmdline" option.
So correct the usage's output.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/kexec-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index a6f1b6f..00ae869 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -33,7 +33,7 @@ static const char riscv_opts_usage[] =
 "	--append=STRING		Append STRING to the kernel command line.\n"
 "	--dtb=FILE		Use FILE as the device tree blob.\n"
 "	--initrd=FILE		Use FILE as the kernel initial ramdisk.\n"
-"	--cmdline=STRING	Use STRING as the kernel's command line.\n"
+"	--command-line=STRING	Use STRING as the kernel's command line.\n"
 "	--reuse-cmdline		Use kernel command line from running system.\n";
 
 static struct riscv_opts arch_options = {0};
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
