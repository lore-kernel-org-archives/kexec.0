Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60588C982F5
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20ZJiQbk77XpGyt2zLlFzhTV8L6cgd0AT+Mg72ZNP+o=; b=mBGUiGRtjb3Kwztl3eOcwVTUEU
	hLPndahjluvK8CYuW+ei+oYetT/2AbvucOhCx04r0b02N1sPSZA28hWsNwyKqDab21a2a2ACFaU2Z
	uqmg00pOhsObECZBjtuU31IZlCxGrXIZjEtOTjuMIE0bHQn2sUQGzsHV+cEe/shJL6QBxC+AzBAV1
	amQVz6CdwMQV+3AMVQzRXiZ9hSe+0+oFboDOm46fu9Vdb/eFLoAk1xHJjoFwN//MYOmrUBUaPBQC3
	EHb3tzyoIV1MKY90b11n91Go2PhdXv2j6/2yghHn6RYpF8fWZYRP9U7ve6A8yN3mlC2D1Wt4BbUbQ
	npHAU/OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4V-00000000Mdg-0xGa;
	Sun, 20 Sep 2026 20:23:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSM-0000000E2S1-3uug;
	Fri, 18 Sep 2026 10:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=20ZJiQbk77XpGyt2zLlFzhTV8L6cgd0AT+Mg72ZNP+o=; b=Jxv0cbgspJqKiGryPZPXc0CWgn
	bcuoiH81z6qPYWIxeM1B7apz9I1zIgzmT9TMwJKV1JDIlOtTsHaTA2dYsYMpOg7AiklgZ3R1CTJEo
	vch9kkzCIHdNZ5aRdwwPMuV8nBe3AJH/kenMZ9osiWT8g6WdFM3yBsmwuZHuHmxcLW6J0Yv8eEOI0
	S8v29dpjel4PLbPkENyZ7IYvNHGxBjiE2BWbrBFyeat6ApjtZHrcqVDTYNw6xq6q/PO5PraeysR9Z
	pUtCOfNN0Vg0hV3pdMXvTmmT/5SonVNbmTraMHdEBfUnRg2pYSXSGljVLn5w214R3UcLxXehVxOiK
	HhMCDrAA==;
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7VSJ-00000009tUo-07V7;
	Fri, 18 Sep 2026 10:04:33 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=20ZJiQbk77XpGyt2zLlFzhTV8L6cgd0AT+Mg72ZNP+o=;
	b=h20MzYgrtfLEEV4IsF22m8M0aeU+9fIDiLpJWraCVTgEvlTBvhYu0irkyY7dZ8KlR25j3eFDX
	uDHiuEi34Vyc2FyCL6c39JSfjX+M3Cz00j/vkUz1PTc66H//7kIYPJQEJrTEE3IZKzXvZCqcFXg
	laCNtc/NvKopW2lnm4CTtD4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hmScJ5pDBzmVWf;
	Fri, 18 Sep 2026 17:53:20 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DC0BB40586;
	Fri, 18 Sep 2026 18:04:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 08/17] LoongArch: kexec_file: Fix a modified_cmdline leak
Date: Fri, 18 Sep 2026 18:04:33 +0800
Message-ID: <20260918100442.3841135-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_110431_755101_43C76D65 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

load_other_segments() allocates modified_cmdline and stores it in
image->arch.cmdline_ptr.  machine_kexec_prepare() then copies it to
KEXEC_CMDLINE_ADDR and overwrites the pointer, so the heap buffer is
leaked on every successful kexec_file_load().

Free the buffer after the copy.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Kexin Liu <liukexin@kylinos.cn>
Cc: Youling Tang <tangyouling@kylinos.cn>
Cc: Qiang Ma <maqianga@uniontech.com>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: George Guo <guodongtai@kylinos.cn>
Cc: stable@vger.kernel.org
Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec_file")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/kernel/machine_kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 1883cae93bc3..19ccc91b6f2a 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/of_fdt.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
@@ -56,6 +57,7 @@ int machine_kexec_prepare(struct kimage *kimage)
 		 */
 		memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.cmdline_ptr,
 					strlen((char *)kimage->arch.cmdline_ptr) + 1);
+		kfree((void *)kimage->arch.cmdline_ptr);
 		kimage->arch.cmdline_ptr = (unsigned long)KEXEC_CMDLINE_ADDR;
 	} else {
 		/* Find the command line */
-- 
2.34.1


