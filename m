Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD7C6FD18
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Vq5IA3KUhoFcIDiQ7ehdisBIxmocgH6zvoRgMnimOfk=; b=DTzxegM3et0Uu2
	9vtp450ZpVVnHlnY8AlEyi6f204UElfSrELx8SPh8uUPXQj/1Jk82bYohu7/4F+wTkBfHeEebCRS9
	YMNKAtp1UUcnaHCNr2YxByR9E5SzdmXH9RRLXuxYcVL6T889PG1skIaQ1yIFVlDum82e3/sifx9XE
	92XbBnnxvmclcxHqdzzeMUXMS+Tv4WrzLAJ5y2bng+wCTFWv1H8w2nLiL8EpbHWh+Em0Y2pIc918h
	5lo4Tyvo47d3UsOD//sS8C/KSx+4VGu4kNn6MJT0GHFIxDAQpexRtczYcmGUwDLLjROTH5KqcdJtx
	lh/ihOZwJGAVSUmcFE8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pojuX-0021pD-20;
	Tue, 18 Apr 2023 11:54:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pojuU-0021ng-1q;
	Tue, 18 Apr 2023 11:54:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 165ED6247E;
	Tue, 18 Apr 2023 11:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A8C433A1;
	Tue, 18 Apr 2023 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681818849;
	bh=IwyqCw0ZeRA4BYG/sIG8QCK/6HafSnbXWPI++Rremlc=;
	h=From:Date:Subject:To:Cc:From;
	b=HnV7Gg44KLdEPtO6NSa/XqBBiESq55Dum3jMjkpXMI9O7nRk9We5Rgo/MoFCdPyvI
	 JWnWnbZQGpnI53fmf/120wytyjRBVXIxocsDWTcHxQ449S1rNE7j6fLdQiDT0DvfBN
	 sKRjEFhrO0xM1AM7iVstceNC5N13OVkk4tlGhDZuNMHKGALxloBwPMHFCekA0Xju+m
	 HKpIBtlo11JRgA8CQQCsoPL9Z1Zt0xb2TaqBDdfu9HrdLRXUmLuD44ChLz2iXa9cDV
	 wcUn2DNc16EeY8sE/nqGAcg2HS/k+jchwXFz37jm20J/xST6+hewX8ln2sNecIatl4
	 TnVCsi9DqdgWQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 18 Apr 2023 13:54:00 +0200
Subject: [PATCH] arm64: kexec: include reboot.h
MIME-Version: 1.0
Message-Id: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
X-B4-Tracking: v=1; b=H4sIANeEPmQC/x2NzQrCMBAGX6Xs2cW0KW3xVcRDfr7aoCayqRIof
 XdTj8PAzEYZEpDp0mwk+IYcUqzQnhpyi4l3cPCVqVOdVn07sZHX0PMDBY5DdM+PBwtsSiu3A0b
 ltVbjpKkGrMlgKya65UjMSTiirGeXBId/C+ZQ/vPrbd9/exbtaYwAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, 
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, 
 linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_045410_647438_915A6845 
X-CRM114-Status: UNSURE (   8.72  )
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

Include reboot.h in machine_kexec.c for declaration of
machine_crash_shutdown.

gcc-12 with W=1 reports:

 arch/arm64/kernel/machine_kexec.c:257:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
   257 | void machine_crash_shutdown(struct pt_regs *regs)

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 54f8e2d081c4..078910db77a4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
+#include <linux/reboot.h>
 #include <linux/set_memory.h>
 #include <linux/smp.h>
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
