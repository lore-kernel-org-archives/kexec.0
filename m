Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455A8CD6E69
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOHJL6mB3QG5vHKM18gpTSqf5pouid7XPpWu+feKDDU=; b=1jrFsdKduNWl3d9wCRO4WZ+YtX
	kizYuU6R5bJfuQQrRzsazpADscC7KzFWzTf3yMG6UcfFaVzUm74wRV+oNVBG7+HNWuT9l8uQE0lLe
	lrzZ+8HmunYe/X61NuF0w35ls3MHM9YNgo9bNSTGCmV+D+lkE7SCzYZDTplOIR5Si+jff9fbxu0NP
	yosR22whsiSxr0R5tP6kMs6I/T1qXn+Z5Lqcbr4loy2njOhXMIGp/ZEO5anjKodBkKKv0DlE9VK9P
	o43p+UPtIQviN+m6tICtYuADFPlxIeHuK7K0w3PKCH9R7jkbhzgagQ8mgLjVqxqUlUlfWP+oRkFMO
	41zkwl4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQs1-0000000DInC-3qBN;
	Tue, 02 Jun 2026 15:17:33 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzGh-0000000AX2G-2CVq;
	Mon, 01 Jun 2026 09:49:13 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KOHJL6mB3QG5vHKM18gpTSqf5pouid7XPpWu+feKDDU=;
	b=CGyYVbD74f6ojvlQ2RjjD+G63/AYVfLUPyObucsAa1qv1wH5L6x6HyV1k861pqznz+0ZdBfVH
	cEgjV9n20kMLCmaxIM24r48pPiCMvW1SmTf5FnuwY25bpdgeKC3N+uylR+JeqvJVYmccZSBBmGU
	tnuZ1w/PVmvl1SLSIysESLM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVc4GQwz12LGX;
	Mon,  1 Jun 2026 17:41:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B822201E9;
	Mon,  1 Jun 2026 17:49:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:49:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 09/23] kexec: Fix UAF and Double Free in crash_load_dm_crypt_keys()
Date: Mon, 1 Jun 2026 17:47:51 +0800
Message-ID: <20260601094805.2928614-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_024911_893765_4EBF5412 
X-CRM114-Status: GOOD (  14.84  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:11 -0700
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

A static memory safety review by Sashiko AI identified a high-severity
Use-After-Free (UAF) and Double Free vulnerability in the dm-crypt keys
handling path during arm64 kexec image placement retry loops.

In crash_load_dm_crypt_keys(), when the segment allocation fails via
kexec_add_buffer(), the error path invokes `kvfree((void *)kbuf.buffer)`
to reclaim the keys buffer. However, the global pointer `keys_header` is
left dangling with a stale address, creating an insecure memory trap.

When the top-level loader image_load() retries the next available placement
hole, crash_load_dm_crypt_keys() is re-entered. Since `is_dm_key_reused`
is a read-only global configuration managed by user-space configfs,
it cannot be mutated by the kernel. If it remains true, the loader skips
build_keys_header() and blindly reuses the stale `keys_header` pointer
for kbuf.buffer, triggering a severe Use-After-Free or a Null pointer
dereference during kexec_add_buffer(). Alternatively, a new headers build
can trigger a recursive Double Free inside build_keys_header().

Fix this by setting the global `keys_header` to NULL immediately after
it is freed in the failure path. Concurrently, upgrade the header
regeneration check to a composite condition:
	`if (!is_dm_key_reused || !keys_header)`

This ensures that if a previous retry attempt wiped the buffer, the kernel
will automatically and safely trigger a fresh header regeneration
internally without modifying the user-configured `is_dm_key_reused` state
flag, achieving absolute data consistency and memory safety across all
retry paths.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: stable@vger.kernel.org
Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_dump_dm_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index cb875ddb6ba6..2c5462876337 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -412,13 +412,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	};
 	int r;
 
-
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
 		return 0;
 	}
 
-	if (!is_dm_key_reused) {
+	if (!is_dm_key_reused || unlikely(!keys_header)) {
 		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
 		if (r) {
@@ -437,6 +436,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	if (r) {
 		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
 		kvfree((void *)kbuf.buffer);
+		keys_header = NULL;
 		return r;
 	}
 	image->dm_crypt_keys_addr = kbuf.mem;
-- 
2.34.1


