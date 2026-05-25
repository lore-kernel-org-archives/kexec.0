Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD0CD6E6C
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvtTo5yVQJUszo79qoogTgppaKCyUyd4sKJmJVKzOI4=; b=otZ9eDdaoKDUmH02U0s43VGTcj
	0fsjMVkttsFHULMs8m3Fgq7zEIJ1NdWTBXcWZ2DWDA+RtOOEAYK5iHHpLAJHQqmvXxzYJ5YZMKB3R
	kxc4fq0jKiR3+aUw1qX59ELQxWgv6dHl/QYxsFnH2mZMtKFW+0SUohWTob9niyct4axDabVVzxkcW
	O4trVf8MZ/m72dZnsUma/NiC5RlvXI033IM9IATh1KcsoYSOdFO5nqZ4qFhuLsRJBgWaV70OPqVRp
	h5JkC9gAu9oy6cVEUhwFyzuFnjvJ1J20IiqJcsDnx0NUH99uSkgrx6AIDrgjKiw1KxfBvOTisOzUN
	ejXbdiVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrl-0000000DIJO-2tgv;
	Tue, 02 Jun 2026 15:17:17 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRR1F-0000000Gi6O-41Vu;
	Mon, 25 May 2026 08:50:44 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JvtTo5yVQJUszo79qoogTgppaKCyUyd4sKJmJVKzOI4=;
	b=JO3fWs/WKikI94UfG/E7wBvs+NDCMkeRyhlEXjwph6bX4OEantmFKfyFbq4Dd4Sg4mXJwSLWO
	QQXB5PxpCPiJnjNe+twq1P8DL3+/vdCEZfaCJ424Zeuiq4oiXFKiTiArjU4M/AqSmWleL+SQ8oU
	7Le+TI1wFCAQO54OAxSz3/U=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gP8Xb3KXdzcb0C;
	Mon, 25 May 2026 16:42:55 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7655C40561;
	Mon, 25 May 2026 16:50:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:50:34 +0800
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
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <ardb@kernel.org>,
	<masahiroy@kernel.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <kas@kernel.org>,
	<debug@rivosinc.com>, <namcao@linutronix.de>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <seanjc@google.com>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v14 07/17] riscv: kexec_file: Fix potential buffer overflow in prepare_elf_headers()
Date: Mon, 25 May 2026 16:49:22 +0800
Message-ID: <20260525084932.934910-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525084932.934910-1-ruanjinjie@huawei.com>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_015042_325720_0BCF9656 
X-CRM114-Status: GOOD (  12.38  )
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

Sashiko AI code review pointed out there is a TOCTOU (Time-of-Check to
Time-of-Use) race condition in prepare_elf_headers() between the initial
pass that counts System RAM ranges and the second pass that populates them.
If a memory hotplug event occurs between these two steps, the number of
memory regions may increase, causing an out-of-bounds write to
the cmem->ranges[] array.

Directly introducing get_online_mems() inside prepare_elf_headers() would
trigger an immediate recursive read-after-write deadlock when invoked by
the runtime hotplug notification path (which already holds the hotplug
write lock).

To eliminate the TOCTOU window safely without deadlock risks, move the
get_online_mems() read lock to the top-level architecture image loaders.
Since these top-level loaders are strictly executed on the initial system
call path and are never re-entered by the runtime hotplug notifier, this
approach physically isolates the locking contexts. The system memory ranges
are forced to be statically frozen during the entire layout generation,
eradicating the buffer overflow vulnerability.

Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: songshuaishuai@tinylab.org
Cc: bjorn@rivosinc.com
Cc: leitao@debian.org
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 3f7766057cac..a88362dfbd89 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -8,6 +8,7 @@
  */
 #include <linux/kexec.h>
 #include <linux/elf.h>
+#include <linux/memory_hotplug.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/libfdt.h>
@@ -48,6 +49,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
 
+	if (WARN_ON_ONCE(cmem->nr_ranges >= cmem->max_nr_ranges))
+		return -EAGAIN;
+
 	cmem->ranges[cmem->nr_ranges].start = res->start;
 	cmem->ranges[cmem->nr_ranges].end = res->end;
 	cmem->nr_ranges++;
@@ -281,12 +285,15 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		void *headers;
 		unsigned long headers_sz;
+		get_online_mems();
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
+			put_online_mems();
 			pr_err("Preparing elf core header failed\n");
 			goto out;
 		}
 
+		put_online_mems();
 		kbuf.buffer = headers;
 		kbuf.bufsz = headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-- 
2.34.1


