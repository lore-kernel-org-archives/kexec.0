Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEE2C3DA61
	for <kexec@archiver.kernel.org>; Mon, 29 Jul 2024 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dwZmyQu8OABeG/dhi9gywhaPGoAnaIpwdKpxeTIAIGg=; b=lcZgHQVomeYl54
	kevsAAZj6TgjkyKK+OLrbnqhTvVB9dDBTFM3dr5M+06ZWE8EApMIQe3RFWvV/I3bp1Qf68biHfF/x
	sEgF3U7kDCKh7Wf9Hwp8Tv2aivxDKqRfj5IYZkWf4o61V+4q+N5EsBjuOwhPFTbP+9B1wSa7dkpLs
	DKvEDG9N/Zifq2laNKxh5JRW2+HLvrYyj1n0jJ107mpMsmJs+1OuVKJYGxGRuuv7ZUJQfhgMmCAWM
	ofH0I1ExndS+gk05SkcJySAP0S+6hQJ2W+K8mDteI245klCaPMsPawTlsK6zh4kIkjL+F8aEkkOQj
	zv38xrWCpCxIEOZfjkzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYOo1-0000000B7L9-0Zjz;
	Mon, 29 Jul 2024 11:44:45 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYOnx-0000000B7IU-0tRq;
	Mon, 29 Jul 2024 11:44:43 +0000
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXc1z68Tzznd22;
	Mon, 29 Jul 2024 19:43:35 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 52FA1140E5D;
	Mon, 29 Jul 2024 19:44:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 19:44:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<rppt@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6] crash: Fix crash memory reserve exceed system memory bug
Date: Mon, 29 Jul 2024 19:50:12 +0800
Message-ID: <20240729115012.1656042-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_044441_445768_4690B1F2 
X-CRM114-Status: GOOD (  12.11  )
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

It's similar on other architectures, such as ARM32 and RISCV32.

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if crash_size is greater than system RAM size and
return error if so.

After this patch, there is no above confusing reserve success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v6:
- Take off Baoquan's Suggested-by.
v5:
- Fix it in common parse_crashkernel() instead of per-arch.
- Add suggested-by.

v4:
- Update the warn info to align with parse_crashkernel_mem().
- Rebased on the "ARM: Use generic interface to simplify crashkernel
  reservation" patch.
- Also fix for riscv32.
- Update the commit message.

v3:
- Handle the check in reserve_crashkernel() Baoquan suggested.
- Split x86_32 and arm32.
- Add Suggested-by.
- Drop the wrong fix tag.

v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.
---
 kernel/crash_reserve.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index ad5b3f2c5487..5387269114f6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
 	if (!*crash_size)
 		ret = -EINVAL;
 
+	if (*crash_size >= system_ram)
+		ret = -EINVAL;
+
 	return ret;
 }
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
