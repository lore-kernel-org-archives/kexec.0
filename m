Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6902EFA373D
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aQ8Da83VW7Ym0cZAx45Ay1wGXOrUjJEQyenkvbeLo4Q=; b=NmtUf17sllyZcM
	bbhUfrJTpSd0LCmlUCGbRD2OSkH5F0q5tnXzT+UCtS+rvMLGk6JrNaJvn4kc0Du/y6p08uKetIWx3
	ZM6Fy5VjBAxZgKYSrvTYg53U55AYvGZomP1GSH2qB1Zwi7cLXxxU1zZXDb0An2SBxIP0CLTq+cw5g
	mcDKYGkAkjuv7pPijyxAOA9YFXUMs4b7M6tg4WdDIblYV4b9bP12juVLThv6/vVEG6l1Pc+27RkxX
	SiPMCj+Z+sl/4Hzzes2SiYLZ5QOIFFG4tQrS2Oy1VbS8HAOEHKxcguBZBMmJFWe1vI1rfJCbnvARw
	quLYLgy04bU0OMWbUSLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olu0d-008h9n-Ks; Fri, 21 Oct 2022 15:32:31 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olu0b-008h8y-69
	for kexec@lists.infradead.org; Fri, 21 Oct 2022 15:32:30 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 7122C2008F;
	Fri, 21 Oct 2022 15:31:57 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 28C534555; Fri, 21 Oct 2022 17:31:57 +0200 (CEST)
From: Simon Horman <horms@kernel.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Yixun Lan <yixun.lan@gmail.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH kexec-tools] github: add RISC-V to workflow
Date: Fri, 21 Oct 2022 17:31:43 +0200
Message-Id: <20221021153143.125826-1-horms@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_083229_394658_0B6EE26F 
X-CRM114-Status: UNSURE (   9.24  )
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

Add RISC-V builds to workflow

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 3 +++
 1 file changed, 3 insertions(+)

 Hi Xianting Tian,

 Please consider including this a v3 patch-set
 to add RISC-V to kexec-tools.

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index e554751e0017..2731282d9521 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -19,6 +19,8 @@ jobs:
         - powerpc
         - powerpc64
         - powerpc64le
+        - riscv32
+        - riscv64
         - sh4
         - s390x
         - x86_64-x32
@@ -42,6 +44,7 @@ jobs:
         case $ARCH in
           arm)         GNU_ARCH="arm-linux-gnueabi" ;;
           arm64)       GNU_ARCH="aarch64-linux-gnu" ;;
+          riscv32)     CROSS_COMPILER_PKG="gcc-riscv64-linux-gnu" ;;
           x86_64)      ;;
           x86_64-x32)  GNU_ARCH="x86_64-linux-gnux32"
                        CROSS_COMPILER_PKG="gcc-x86-64-linux-gnux32" ;;
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
