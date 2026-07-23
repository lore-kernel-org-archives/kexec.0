Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C469CC531CF
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=; b=FaeNV2oygbfSTwQFb+9tTDiHPT
	KPY1pXyTI07HOGm6m/d91Sa7bebkp1dwvYKJl4Zmq8QqDkoRMB2i+3kmnKC2jlwszgpRs1kpb4rdY
	+1r56BDZWYLSPf7neZF42sYPJNqduFl7lkrGvTqfZZbEewoH0Py3tEuUHBdl7v2zEbXoqJ6/WAaJD
	MxzaRqQP1OSPCegZ0kiRT6/q3AX5jP9Fmp11SufIuudmqzFyr/wgMYLlMo4vCBM9wQveEdIoAVWTG
	ihAlNJkC7dba9HN2cFTfo/5lMVAZznh3kInYukUpzoWKsV3xDXXfri0sYYayLncZeAd249MQOzyMk
	8b6iapsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEZ-0000000EKym-1tyN;
	Thu, 23 Jul 2026 13:13:07 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEG-0000000EKkP-1men;
	Thu, 23 Jul 2026 13:12:52 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=;
	b=urWVc2P0ENx4blIXgZ5M+OtVOKt+sYZN9XXmSTw7XVqALzzXo3TdRX3PE3VyxIOZg4VByloEe
	b5mediW2Oh8/2F/+uq6eOWGBNEW5vePZYXQabopjTR9MCFdRxcV0zfyBmUqk4FKqGTQWuwkCBw2
	vOlOwKMDaDkSBYHJGl9FVOM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWh261Gz1prKd;
	Thu, 23 Jul 2026 21:03:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B9D8640538;
	Thu, 23 Jul 2026 21:12:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 1/8] powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
Date: Thu, 23 Jul 2026 21:12:35 +0800
Message-ID: <20260723131242.1537633-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_061249_024682_3D002821 
X-CRM114-Status: GOOD (  11.86  )
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

In get_crash_memory_ranges(), if crash_exclude_mem_range() failed
after realloc_mem_ranges() has successfully allocated the cmem
memory, it just returns an error but leaves cmem pointing to
the allocated memory, nor is it freed in the caller
update_crash_elfcorehdr(), which cause a memory leak, goto out
to free the cmem.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 60a917a6beaa..775895f31037 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -502,7 +502,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	ret = get_crash_memory_ranges(&cmem);
 	if (ret) {
 		pr_err("Failed to get crash mem range\n");
-		return;
+		goto out;
 	}
 
 	/*
-- 
2.34.1


