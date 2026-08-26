Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F57C61DD3
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsSkMIhsameVeQcyubflsAKjqyDPzlK/Dltq516R/Cc=; b=2SYjS9fqMaYZWm/ey2fO0J+hfO
	aVz0HeHc1EogNllwo77TOaZQeYvsnu69ImOqqKNcLbJ4VpQ/fuIlE/J+BHijcDOHCrUWdR7WOfaaP
	Cy7eYGNqFe5U2yBTKK2JFushrgrElcErQ0bge73O+JUBzYuPPYWIigck+L06fk5nIxxzx+cAtHv1m
	H4U1QkIXt5L3km6pfZWPhCAjd9wLQ+tZt4Y+jriCQ+DsXwiAD7ktm0G6+/pwMVjmdhYajfGxAAS/l
	1Fk8l+ezhnAaVG8AFiwJwBM/EDsfCP4/Ah2Fj5gtWtCFIlK7WvoiWT900GRhBU+sRtsfwb/Rdd6Q7
	0jbKK5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9td-00000002BTZ-3G4V;
	Wed, 26 Aug 2026 09:26:13 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9t8-00000002B4I-04LM;
	Wed, 26 Aug 2026 09:25:43 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OsSkMIhsameVeQcyubflsAKjqyDPzlK/Dltq516R/Cc=;
	b=4/tAT6KhStANNCVtYQC+DB5wYYXDiC3tT34fBpKlCqPTh2I1YSkgN/f/nRnKQCczgulZrLa5x
	SMtVukw+4IMcbUBzz4us12yj4rcnLybfHqc3ah2t+jgK2r5itK8c4c82rj9Gk9VcSKgK+3/ji5n
	r0Yl4uQkkWaI+TBCQprUFWY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrX05jqz1prQB;
	Wed, 26 Aug 2026 17:14:52 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8733E4056D;
	Wed, 26 Aug 2026 17:25:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 13/17] crash: Improve elfcorehdr segment identification
Date: Wed, 26 Aug 2026 17:25:37 +0800
Message-ID: <20260826092541.3905933-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_022542_421182_45BDC71C 
X-CRM114-Status: GOOD (  11.51  )
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

Only checking ELFMAG is insufficient, as other segments like the
kernel image or an ELF initrd may also start with \x7fELF, leading
to misidentification. This is especially problematic when elfcorehdr
is not the last segment, such as:

	kexec -d --t bzImage -p bzImage --initrd=/bin/true

Add an "e_type == ET_CORE" check to ensure the correct segment is
identified, and break early after finding it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bd3f82b62751..0730c4ea8054 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -737,9 +737,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 			mem = image->segment[n].mem;
 			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
 			if (ptr) {
+				Elf64_Ehdr *ehdr = (Elf64_Ehdr *)ptr;
+
 				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0 && ehdr->e_type == ET_CORE) {
 					image->elfcorehdr_index = (int)n;
+					kunmap_local(ptr);
+					break;
+				}
 				kunmap_local(ptr);
 			}
 		}
-- 
2.34.1


