Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C72C2BB41
	for <kexec@archiver.kernel.org>; Tue, 16 Aug 2022 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xP6chHfoU2MMLm00PbgdLP52UJJl/I5Wm0U0sIbP1eU=; b=Y1QETed/0ee3bn
	InH0/qdk65kwabzppRJlI43k48pQ/3NRxMU5XCeSJezcOe6Kt4VsJWftZnjNXq7pEePtcSMYFbeQr
	0cHx6TEjCJW0iayVf6iew+bCBaDDCTzfmlfWfGNftCbU1CVe2KdiTiQHUkrP2lHLSeTnxkBoioOUu
	duqQswAnLL7W8zAV2Xvd9TTxq9GD4UaxoAADmP4LQd0g2wCL1Za5nN4hMNr+ld8P8Ep9GZiEfSCua
	3l4GqXZMm6LSaqq5fcu3kqKvN5act5KGvw55P3Ob7EGjgc9av9OGv46IdG6Oj8dZEsAe69jsQbTuq
	3xUduiIOFurql4Qz+8ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNrHh-00Fh1d-GG; Tue, 16 Aug 2022 07:46:45 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNrHI-00Fg0j-W5; Tue, 16 Aug 2022 07:46:22 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6NRf3jXNzlVhj;
	Tue, 16 Aug 2022 15:43:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 15:46:12 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 15:46:12 +0800
From: Chen Lifu <chenlifu@huawei.com>
To: <linux@armlinux.org.uk>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<pmladek@suse.com>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <chenlifu@huawei.com>
Subject: [PATCH -next] ARM: kexec: Make machine_crash_nonpanic_core() static
Date: Tue, 16 Aug 2022 15:42:50 +0800
Message-ID: <20220816074250.3991633-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_004621_276606_8D54624A 
X-CRM114-Status: UNSURE (   8.62  )
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

This symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/arm/kernel/machine_kexec.c:76:6: warning: symbol 'machine_crash_nonpanic_core' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/arm/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..a2e9ac763a9f 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -71,11 +71,11 @@ int machine_kexec_prepare(struct kimage *image)
 
 void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void machine_crash_nonpanic_core(void *unused)
+static void machine_crash_nonpanic_core(void *unused)
 {
 	struct pt_regs regs;
 
 	crash_setup_regs(&regs, get_irq_regs());
 	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
