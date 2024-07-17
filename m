Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248EDC3DA42
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nAXf7wzKN3FTo5oVA358sp5AgmTvyD6vgOqaPQj84A=; b=YVL7IaDC4O5obR
	nuerrJiH6Od3OIYsNxkBEGSwsvE3mp3uEXTZGLVqYhcdvvRy6TlXPYCKEg76KdjH2qW8GAI82tPlf
	F+JkrDtQQYAH4IP7F8q1SQMwZgjfxWsvXRiWXtkA+DUUBvoC50Oi46XtI1PeVR2R0bOLPGIwDHzkE
	xt8Glxyd2e43OBw2K0dsXkQphr6PHeciplOL4Qsx2AjtkSRsuJLNfq0rL6NC4CUIrPbnNd+9L1iql
	AiTUJMmcpMycBe0E9iYeF3GCri0DniwhvdC9zbZmVvysWHHMSZEFsK3tMHMhf6xUh0/DHOJ2mmmT0
	WPyR9PvcX9JASKYlX/0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0Wc-0000000DEKo-3Uv7;
	Wed, 17 Jul 2024 09:00:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzQO-0000000D1bB-1ZTa;
	Wed, 17 Jul 2024 07:50:28 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP7PC3JZ8znb9y;
	Wed, 17 Jul 2024 15:49:19 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C38F1800A3;
	Wed, 17 Jul 2024 15:49:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 15:49:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <arnd@arndb.de>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<peterz@infradead.org>, <julian.stecklina@cyberus-technology.de>,
	<rafael.j.wysocki@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 2/2] ARM: Fix crash memory reserve exceed system memory bug
Date: Wed, 17 Jul 2024 15:54:39 +0800
Message-ID: <20240717075439.2705552-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717075439.2705552-1-ruanjinjie@huawei.com>
References: <20240717075439.2705552-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_005008_620789_F0826BF3 
X-CRM114-Status: GOOD (  12.04  )
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

Similar with x86_32, on Qemu vexpress-a9 with 1GB memory, the crash kernel
"crashkernel=4G" is ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if the crash_size is greater than system RAM size and
warn out if so as Baoquan suggested.

After this patch, it fails and warn out as expected and no above confusing
reserve success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Baoquan He <bhe@redhat.com>
---
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
 arch/arm/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e6a857bf0ce6..791d5f046163 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1015,6 +1015,11 @@ static void __init reserve_crashkernel(void)
 	if (ret || !crash_size)
 		return;
 
+	if (crash_size >= total_mem) {
+		pr_warn("Crashkernel reserve memory cannot exceed physical memory.");
+		return;
+	}
+
 	if (crash_base <= 0) {
 		unsigned long long crash_max = idmap_to_phys((u32)~0);
 		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
