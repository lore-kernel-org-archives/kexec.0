Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2686C2BD09
	for <kexec@archiver.kernel.org>; Sat, 13 Jul 2024 01:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tUo5476k9/P2F26FIPG8AVzehCvNBIWFqcFWfBCxf8Q=; b=lZGC4NNyTjjXD0
	IzqJO7FgsPLrV9lRYJIPMNiLQSLhakbrDGGNCZOzfk20KpWGwZQuIHlx5wTL4WYJF174cwgAgujD5
	Z9aIyZYd6vt0N032k0BbLM+T7r2P2RImjbx8o6uz5H+o2LHFQhMBQ9JDL/n1kGVqpa7nb2WDGRRbP
	XV0e81SLrJVp9VPLD3LJtYdyc1BxxrVf5Qannjwb/rg4v3EVyXt9PJG1TFhOewuGNg5sIeJjYArET
	qV5ol17RSdyiNxGEPzXu6/sssim2NMVSJDHRh4WLehymhOrl29Nz8IMnRgtDtP1aDzo5hM8iV1zCT
	3oNmhMmxuc7fPBqfykpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSRnu-00000001gtn-3J66;
	Sat, 13 Jul 2024 01:44:02 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSRnr-00000001gsh-1KEw
	for kexec@lists.infradead.org;
	Sat, 13 Jul 2024 01:44:01 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WLWRF1vLyzdh41;
	Sat, 13 Jul 2024 09:42:01 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E7236180087;
	Sat, 13 Jul 2024 09:43:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 13 Jul
 2024 09:43:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<austindh.kim@gmail.com>, <rmk+kernel@armlinux.org.uk>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Date: Sat, 13 Jul 2024 09:48:08 +0800
Message-ID: <20240713014808.1689915-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_184359_553632_65F10526 
X-CRM114-Status: GOOD (  12.08  )
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

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
as below:
	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)

And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
is also ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
input size.

After this patch, it fail as expected and no above confusing reserve
success info.

Fixes: 9d17f3372306 ("ARM: 9190/1: kdump: add invalid input check for 'crashkernel=0'")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.
---
 kernel/crash_reserve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5073ae205f79..5c2148d89da6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -314,7 +314,7 @@ int __init parse_crashkernel(char *cmdline,
 	if (high && ret == -ENOENT) {
 		ret = __parse_crashkernel(cmdline, 0, crash_size,
 				crash_base, suffix_tbl[SUFFIX_HIGH]);
-		if (ret || !*crash_size)
+		if (ret || !(phys_addr_t)*crash_size)
 			return -EINVAL;
 
 		/*
@@ -333,7 +333,7 @@ int __init parse_crashkernel(char *cmdline,
 		*high = true;
 	}
 #endif
-	if (!*crash_size)
+	if (!(phys_addr_t)*crash_size)
 		ret = -EINVAL;
 
 	return ret;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
