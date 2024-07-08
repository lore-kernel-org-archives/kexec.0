Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFA5C3DA42
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hvs9ebAqifuVzdxLz+2MWLm2dE1KzF7KkrMqgeaB4YM=; b=j0VPqED7oSxx8q
	lmEDPgW0REIqBXtbnoyIiOSjXLBDsZDDcGc26Zg69SjFYyiRGAlDafyTo311GMTqaU+tGDLuAcjNx
	3bBL2Gbw7r0O7ABvBXpvKQtNKS4DQ5AHkjhB45ZcMBoWorPYop5+5kyOB541N9xGqkHEuc32XAgE1
	irdfWhfLU64Qd3Dxkyendy2XD2JK7WBcbu+JJIF/G5zAuBAn7BezINvVTg+IxQ6FP261RgBEtKjrz
	Ws5IVLdjkAkF5eO6DWZC7LR6TEsjHbIVsmIuyeNNppBjzZTsvO0qsTfqVJx2Jziv2SENjDAhsqwRw
	OvXAWXTOoiW6EXn8H7dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRx-00000003v0m-1ZAf;
	Mon, 08 Jul 2024 13:30:37 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRI-00000003ugm-21ih;
	Mon, 08 Jul 2024 13:29:58 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHlGs2J4bzwWPg;
	Mon,  8 Jul 2024 21:25:09 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8465C180087;
	Mon,  8 Jul 2024 21:29:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <austindh.kim@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/3] ARM: Fix crash kenrel data type bug
Date: Mon, 8 Jul 2024 21:33:47 +0800
Message-ID: <20240708133348.3592667-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062956_720478_147C79B6 
X-CRM114-Status: GOOD (  10.55  )
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

On QEMU vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
is ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The above info is confusing, because the System memory is as below:
	# cat /proc/iomem | grep Sys
	60000000-9fffffff : System RAM

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but used with "phys_addr_t" which is
4 bytes in memblock_phys_alloc_range().

Fixes: 9d17f3372306 ("ARM: 9190/1: kdump: add invalid input check for 'crashkernel=0'")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e6a857bf0ce6..59e1a13b5cf6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1012,6 +1012,7 @@ static void __init reserve_crashkernel(void)
 				&crash_size, &crash_base,
 				NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
+	crash_size = (phys_addr_t)crash_size;
 	if (ret || !crash_size)
 		return;
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
