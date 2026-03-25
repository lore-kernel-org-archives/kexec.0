Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908BD39420
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AOVYfpfg79yD7eFn4CZ9+BNhSBjLdVbtAdmSv2LXRjg=; b=4DhemWM086pgRgyt9d8EguipBI
	TVMoEN7GQPJ1agOIidDzLJPBmlRaZUGQwFgLLouG7SHS+/7Q/NKquMMJ1ELR1GMBtxznO3xONQTU2
	+OK1kest5CvhNWohwhmMgpyfLMB28jR4GldQcnMcLEYQsx4Gm4o3enC/emQZtzGjuZq2vS0WYj2D/
	yMqHidIkEjmPxpr2fDGThB7J+CrnAfSyzMp6mV0N+cBqxuvGVPZClGJPAc6434riX4x4MoIEHl5Az
	jLrBCxWsKBfDDf2Hp2pjt+SqCQGiXkIZ3oTaEgRkVx/3O9pkRIa9EcO7nyKcPXlidu6dGwGxka5cA
	bnnexqnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFs-0000000048N-410k;
	Thu, 02 Apr 2026 12:34:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ERL-00000002YgL-34GO;
	Wed, 25 Mar 2026 02:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=AOVYfpfg79yD7eFn4CZ9+BNhSBjLdVbtAdmSv2LXRjg=; b=I/W0ZqbBcrbUaoUm62rD9EUh/A
	fKjYsh7ecM82/zhY3YZtIIs0hhwQID2gHNsh4I/Sg01NHnP7SjUWHdKUGxw/3m28wEZc4ZkVgvZGO
	RyPXRT7xU7BzhzPF4m5qkL+tfIpxJ8fp7bdyapcNr9XzIvU9i7daFPkwyZLxBtPIJlW9PnMlTgoUj
	rynM5E8K/uzHbzJZj7Wqnkp8FVq8HKiPWWzG8567D5XE7iShgdbcD8tBf2YKaPLIr46qfYgEChOaP
	1Yz9rDZOmTsD156KH+JmddcciNkq/HiHKYFbEZzv2wAnV5T7uTZWi80J4c4gFDIfKxCMfg5BiLn0x
	SWYPp4gw==;
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ERG-00000005JRl-0cZ2;
	Wed, 25 Mar 2026 02:57:50 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AOVYfpfg79yD7eFn4CZ9+BNhSBjLdVbtAdmSv2LXRjg=;
	b=vuDTFtJIXlWi3WQM2PetFjfxW+SnD7MBA2PxvSdlatPhSOtT4gx1oqMa4NOtQZuws+JbJ1ZyC
	Fm/mjPn8ztEHvKsUG0OBHWrhyCwVn5lMss21RWhOewdNhpZm429kOdv0hEv9v6goginDjZIvENq
	vzFeYjGnhNXtq6oWpCAjFpE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fgWf72074znTWd;
	Wed, 25 Mar 2026 10:52:15 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 16CDB40565;
	Wed, 25 Mar 2026 10:57:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 10:57:39 +0800
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
Subject: [PATCH v10 6/8] arm64: kexec: Add support for crashkernel CMA reservation
Date: Wed, 25 Mar 2026 10:59:02 +0800
Message-ID: <20260325025904.2811960-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_025746_993879_73F614AC 
X-CRM114-Status: GOOD (  20.93  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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

Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
crashkernel= command line option") and commit ab475510e042 ("kdump:
implement reserve_crashkernel_cma") added CMA support for kdump
crashkernel reservation.

Crash kernel memory reservation wastes production resources if too
large, risks kdump failure if too small, and faces allocation difficulties
on fragmented systems due to contiguous block constraints. The new
CMA-based crashkernel reservation scheme splits the "large fixed
reservation" into a "small fixed region + large CMA dynamic region": the
CMA memory is available to userspace during normal operation to avoid
waste, and is reclaimed for kdump upon crash—saving memory while
improving reliability.

So extend crashkernel CMA reservation support to arm64. The following
changes are made to enable CMA reservation:

- Parse and obtain the CMA reservation size along with other crashkernel
  parameters.
- Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
- Include the CMA-reserved ranges for kdump kernel to use.
- Exclude the CMA-reserved ranges from the crash kernel memory to
  prevent them from being exported through /proc/vmcore, which is already
  done in the crash core.

Update kernel-parameters.txt to document CMA support for crashkernel on
arm64 architecture.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v7:
- Correct the inclusion of CMA-reserved ranges for kdump
  kernel in of/kexec.
v3:
- Add Acked-by.
v2:
- Free cmem in prepare_elf_headers()
- Add the mtivation.
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/kernel/machine_kexec_file.c          | 2 +-
 arch/arm64/mm/init.c                            | 5 +++--
 drivers/of/fdt.c                                | 9 +++++----
 drivers/of/kexec.c                              | 9 +++++++++
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..afb3112510f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1121,7 +1121,7 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ppc] Reserve additional crash kernel memory from
+			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
 			CMA. This reservation is usable by the first system's
 			userspace memory and kernel movable allocations (memory
 			balloon, zswap). Pages allocated from this memory range
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c338506a580b..cc577d77df00 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 #ifdef CONFIG_CRASH_DUMP
 unsigned int arch_get_system_nr_ranges(void)
 {
-	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
 	phys_addr_t start, end;
 	u64 i;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 96711b8578fd..144e30fe9a75 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -96,8 +96,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 static void __init arch_reserve_crashkernel(void)
 {
+	unsigned long long crash_base, crash_size, cma_size = 0;
 	unsigned long long low_size = 0;
-	unsigned long long crash_base, crash_size;
 	bool high = false;
 	int ret;
 
@@ -106,11 +106,12 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
 	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..037926ed30fb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -871,11 +871,12 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 /*
  * The main usage of linux,usable-memory-range is for crash dump kernel.
  * Originally, the number of usable-memory regions is one. Now there may
- * be two regions, low region and high region.
- * To make compatibility with existing user-space and older kdump, the low
- * region is always the last range of linux,usable-memory-range if exist.
+ * be 2 + CRASHKERNEL_CMA_RANGES_MAX regions, low region, high region and
+ * cma regions. To make compatibility with existing user-space and older
+ * kdump, the high and low region are always the first two ranges of
+ * linux,usable-memory-range if exist.
  */
-#define MAX_USABLE_RANGES		2
+#define MAX_USABLE_RANGES		(2 + CRASHKERNEL_CMA_RANGES_MAX)
 
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index c4cf3552c018..57950aae80e7 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -439,6 +439,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			if (ret)
 				goto out;
 		}
+
+		for (int i = 0; i < crashk_cma_cnt; i++) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+					"linux,usable-memory-range",
+					crashk_cma_ranges[i].start,
+					crashk_cma_ranges[i].end - crashk_cma_ranges[i].start + 1);
+			if (ret)
+				goto out;
+		}
 #endif
 	}
 
-- 
2.34.1


