Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B0C3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nmtOKCJjIfP6qPqFGsUoSYbH3BN0RH9Zx9SGUNnrOEA=; b=5Gvyov57lM/tUh
	E4Db/5chvbzo9oERUNaSRCALBQaY52Nv45kdBfkJKLIX2lVQ1rlNiT45dxDwgcZYX7X4z16fnze5J
	ZG/YQZmndj9+3qiQnmHbMDK/BCnJ7INBLCm9Os0MCiGkZKHgUtz/Z3mubSu4ztsjsXK2Ir7LXd+0m
	sGT5ruuoScxDc8wAI/62mUZpwmLO8ujD69Vd7zu6r0nEuj3Zm7BwfjeYn42oyZeMpPaf7sShpRjvn
	zUfanBWTZvKrzzgh+9mf4dCX6UVpxDHsEXu+sIRymFKKtjXLL1SEzAZR5xxxHI/SjA9tB/pQLUBLa
	wsd+g5Z1vH6W7aZsipMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRJ-00000003ui9-320p;
	Mon, 08 Jul 2024 13:29:57 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRG-00000003uge-0p12;
	Mon, 08 Jul 2024 13:29:56 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WHlHl00R7zQksh;
	Mon,  8 Jul 2024 21:25:54 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B5267140415;
	Mon,  8 Jul 2024 21:29:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:47 +0800
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
Subject: [PATCH 1/3] crash: Fix memory reserve dead loop bug in reserve_crashkernel_generic()
Date: Mon, 8 Jul 2024 21:33:46 +0800
Message-ID: <20240708133348.3592667-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062954_455656_89F426C4 
X-CRM114-Status: GOOD (  11.52  )
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

If the platform do not support memory above 4G, such as 32 bit arch,
and CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX, the high
crash kernel memory reservation is meaningless and it will cause
dead loop and system stall:

-> reserve_crashkernel_generic() and high is true
 -> memblock_phys_alloc_range() fail and return 0
    -> search_end = CRASH_ADDR_LOW_MAX(same as CRASH_ADDR_HIGH_MAX)
       -> call memblock_phys_alloc_range() again and fail agin.
          -> search_end == CRASH_ADDR_HIGH_MAX satisfy again
	......

However, the current check only considers the case where
CRASH_ADDR_HIGH_MAX is greater than CRASH_ADDR_LOW_MAX. Fix it.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..e18fb1bb5d28 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -390,6 +390,11 @@ void __init reserve_crashkernel_generic(char *cmdline,
 	} else if (high) {
 		search_base = CRASH_ADDR_LOW_MAX;
 		search_end = CRASH_ADDR_HIGH_MAX;
+
+		if (search_base >= search_end) {
+			pr_warn("crashkernel high memory reservation failed.\n");
+			return;
+		}
 	}
 
 retry:
@@ -410,7 +415,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * low memory, fall back to high memory, the minimum required
 		 * low memory will be reserved later.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
+		    CRASH_ADDR_HIGH_MAX > CRASH_ADDR_LOW_MAX) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
