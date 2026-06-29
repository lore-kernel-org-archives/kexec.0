Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C766C5DF7C
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAA7ivwOtm53DV6AnhV0IJ8L+74dnrWetZ3y5TX4Mgc=; b=FKOQc07i8l570TvloEAoMZ71hV
	aM4gK/mmbvYju/x0Z/ZJaJp0OdflPK77YVUgWTuWev0wZ+x371dIul5nBEzseHqVqL5KSjc+tFcec
	zQLUbET8q8RpmKXzKY9CJLmRNmOqZQyoLoCwxnPd6QJ6ZTDlI5aB0gkFk+BZLMjpIMatcWW8eQWwY
	u9eMSIR8o5ySFROoYtAWXJ47V+EC6fpFy9NKHkMYx9vQ3rEhaQa/GKiyLebrm9wNsRe8iC00uu0An
	3O04xT9JfFpxEZ0Ma0J5fYMckYvD0hZ9uIyhGfq60PAr8Jp97yd4synpm2C2tdE/GRB0+FO8x1ulP
	Tk/7pY0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95L-00000003cx8-0PKq;
	Sat, 15 Aug 2026 07:45:43 +0000
Received: from canpmsgout11.his.huawei.com ([113.46.200.226])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we8aq-0000000EEKK-1TQ1;
	Mon, 29 Jun 2026 09:47:58 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MAA7ivwOtm53DV6AnhV0IJ8L+74dnrWetZ3y5TX4Mgc=;
	b=S2wal7yLNV7jJ8Q8P+0JAaogRSzjR7vZ8brQh+BYlWGO3IbWDbOXTvqQ/fuW21VfJUfJTeM+w
	0K3JWjfGoYGB82ROj31BycneifKEJoJqljV3MLg6cZu3HIVlYK21SiMLzgvZdc5OBfQyYSFl6qc
	UsYrCeVJ+QJ6Z4vYZVhAFb8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gph6j4ccDzKm4w;
	Mon, 29 Jun 2026 17:38:37 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 939A2402AB;
	Mon, 29 Jun 2026 17:47:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 17:47:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<elver@google.com>, <enelsonmoore@gmail.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <leitao@debian.org>,
	<kees@kernel.org>, <coxu@redhat.com>, <cfsworks@gmail.com>, <jbohac@suse.cz>,
	<osandov@fb.com>, <ryan.roberts@arm.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>, <gaohan@iscas.ac.cn>,
	<david@kernel.org>, <wangruikang@iscas.ac.cn>, <muchun.song@linux.dev>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <guoren@kernel.org>,
	<namcao@linutronix.de>, <rick.p.edgecombe@intel.com>, <djbw@kernel.org>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<vishal.l.verma@intel.com>, <chenjiahao16@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v17 01/10] riscv: kexec_file: Fix crashk_low_res not exclude bug
Date: Mon, 29 Jun 2026 17:47:37 +0800
Message-ID: <20260629094746.191843-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629094746.191843-1-ruanjinjie@huawei.com>
References: <20260629094746.191843-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_024756_963693_8F7CAB50 
X-CRM114-Status: GOOD (  11.66  )
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:39 -0700
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

As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
crashkres_low.") for arm64, while implementing crashkernel=X,[high,low],
riscv should have excluded the "crashk_low_res" reserved ranges from
the crash kernel memory to prevent them from being exported through
/proc/vmcore, and the exclusion would need an extra crash_mem range.

Just simply tested on qemu with crashkernel=4G with kexec in [1] mentioned
in [2]. And the second kernel can be started normally.

	# dmesg | grep crash
	[    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
	[    0.000000] crashkernel reserved: 0x000000017fe00000 - 0x000000027fe00000 (4096 MB)

Cc: Guo Ren <guoren@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
[1]: https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
[2]: https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.com/
Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=X,[high,low]")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 59d4bbc848a8..fa2946aa9b8f 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -62,7 +62,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	unsigned int nr_ranges;
 	int ret;
 
-	nr_ranges = 1; /* For exclusion of crashkernel region */
+	nr_ranges = 2; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
@@ -77,8 +77,16 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	if (ret)
+		goto out;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
+
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
-- 
2.34.1


