Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27360D3941D
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8E4spcrmYqVzYUlBqOGzHHrelMM+VkOSD8iaO6+byhw=; b=t3QFNrN0RjjvmlW/mG1Niv1to0
	3VdjwvK26lSZNAoxGWcf2puFkFRuLbX5ogQ+TxKLJqvCVH+Mz1t7rvZTIHt0W+6INkPlN4LmzKzF2
	flTVwDAZYlr0ffYnM5dZF+/kVgsIlhBLInt2XSclp/XM7u33eguofn1doGw6HHaxSDD53PyIiNMJj
	2Bqx+5exyKJExsRGdzr8PxK5Je0Ek1S+T6L5czIr1OOIcyAec7bQQDTzf46+V9E8IeuT2WI34TLmZ
	SAK9uSy1STPLUNuqYa6YHNASW+SJTLUJWQCoA00L5uFkONKTX0avxpAHLmEWfucF76JGt72/aYG+6
	BzAuAJiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFt-0000000049T-2R0Z;
	Thu, 02 Apr 2026 12:34:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ERS-00000002YoC-2IP8;
	Wed, 25 Mar 2026 02:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=8E4spcrmYqVzYUlBqOGzHHrelMM+VkOSD8iaO6+byhw=; b=jXQafIY1605coRwZYXGIj5IKdn
	QELjF/HRnVWY2/18BjNaR+xbRzZkPKBaeBdFoZI14NCsuKXDUkYkrudhtXwidZU8liaKl6DMa7K39
	5+1RxoFOWuCIZBZQxhniizV+JGqNctNtAWo4xYFkFUA1j20Y8CBqljb5CNcbRGZWQW3WC+jd1ytR0
	zhwDXBzEJ+H0hyEJ8Ef/KBgFaCftautVG7y6N0zZz2OAX1cPXbrrC82+XZkQrPXIKvrV0SgIUC+Rs
	9jJ5mVdAJZdkNQqWhTZnDHVqkas6ji8CqRb0Wxgp8Tn7ntL0F23v4cAYBusK+vApOrSPWoDDv/6xv
	SRuc07hA==;
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ERL-00000005JVT-45g3;
	Wed, 25 Mar 2026 02:57:57 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8E4spcrmYqVzYUlBqOGzHHrelMM+VkOSD8iaO6+byhw=;
	b=xqNJJTRYyggCzXZzuIVa391GmVhP2M1AywiTzUCVIdevfMWk2W0+G2iNIudjPzgYPiCgaIuhE
	5THdqWRaQk7mWGN7AJ7Xy8EnMOPizyjjR001GpeKPLFi3V5PkCr2VJzvHZC7VITILAKNTbQjTE4
	da7qaeuWWHQjW0U1XLO75kc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fgWdn6WXHzcb0r;
	Wed, 25 Mar 2026 10:51:57 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FA2840561;
	Wed, 25 Mar 2026 10:57:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 10:57:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <ruanjinjie@huawei.com>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>, <osandov@fb.com>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<jbohac@suse.cz>, <fuqiang.wang@easystack.cn>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <james.morse@arm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v10 8/8] crash: Fix race condition between crash kernel loading and memory hotplug
Date: Wed, 25 Mar 2026 10:59:04 +0800
Message-ID: <20260325025904.2811960-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_025753_586334_00D9642F 
X-CRM114-Status: GOOD (  12.48  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

There is a race condition between the kexec_load() system call
(crash kernel loading path) and memory hotplug operations that can lead
to buffer overflow and potential kernel crash.

During crash_prepare_headers(), the following steps occur:
1. arch_get_system_nr_ranges() queries current memory ranges from memblock
2. alloc_cmem() allocates buffer based on queried count
3. arch_crash_populate_cmem() populates ranges from memblock

If memory hotplug occurs between step 1 and step 3, the number of ranges
can increase, causing out-of-bounds write when populating cmem->ranges[].

This happens because kexec_load() uses kexec_trylock (atomic_t) while
memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
with each other.

Fix by adding lock_device_hotplug()/unlock_device_hotplug() around the
critical section in crash_prepare_headers(). The lock is only acquired
when CONFIG_MEMORY_HOTPLUG is enabled to avoid overhead on systems without
hotplug support.

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 300d44ad5471..f01d03d42c67 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -326,15 +326,25 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	struct crash_mem *cmem;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		lock_device_hotplug();
+
 	max_nr_ranges = arch_get_system_nr_ranges();
-	if (!max_nr_ranges)
-		return -ENOMEM;
+	if (!max_nr_ranges) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	cmem = alloc_cmem(max_nr_ranges);
-	if (!cmem)
-		return -ENOMEM;
+	if (!cmem) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	ret = arch_crash_populate_cmem(cmem);
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		unlock_device_hotplug();
+
 	if (ret)
 		goto out;
 
@@ -355,6 +365,12 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 out:
 	kvfree(cmem);
 	return ret;
+
+unlock:
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		unlock_device_hotplug();
+
+	return ret;
 }
 
 /**
-- 
2.34.1


