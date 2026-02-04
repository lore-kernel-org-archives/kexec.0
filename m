Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A10E95360
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mFBJiqIwT9NZGyk5qGLbY1mlcpA6eQGqiHTQkqvDMKc=; b=JsyVHlIADXkNlxmXbGabQ9p5vf
	JVPsQ74nLDHgnpPwDOdQK9jm+TrrBTQqt7A8ZJ1bSVmrvKV6Azwcm2rFab1gHZ/H2czChrIb9V/Ht
	W4C7+twPgRNK/AYzMz33+/Yw/rjzc3NC+W6hjae/m/a90yzYFI68x99/xPfD0rhpLs2GpnuyoZznQ
	Rbl0Du0UCVSoAJObozNNhJvLw1/OSM4fR77fSu8UhlbD3BKBJMn9IfPI+F5LH7/N5nE751obOwwrH
	DdKtf2bue+u6SaEqvGPsOYC1AMzIiOIhBHdBvRgCJb5ptlErWQuTFBhbg9bY55Eyrid9ZDIkKpjc1
	h1c3wEtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnZJa-00000008DeY-001B;
	Wed, 04 Feb 2026 09:36:50 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnZJW-00000008Ddj-2DHt;
	Wed, 04 Feb 2026 09:36:48 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mFBJiqIwT9NZGyk5qGLbY1mlcpA6eQGqiHTQkqvDMKc=;
	b=1xqbDBGHV2dYoy3vGnjXu2TA/WZN09CbjC82e2+V5v8DPKKxKAbS/fgjLipQORmfwaL0pUvBs
	FJBu5fvw0+v0LExpIvXW2pSMR2LIhb6URUTKmgEUAj0nd3KCKgtMg/zlMOEspDjG9HYmU/vfTMe
	grDxiK3ovrSLsg2wWnF2HVU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f5Zr04p4mz1prLg;
	Wed,  4 Feb 2026 17:32:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 54A75404AD;
	Wed,  4 Feb 2026 17:36:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 17:36:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<kees@kernel.org>, <elver@google.com>, <arnd@arndb.de>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <leitao@debian.org>,
	<rppt@kernel.org>, <cfsworks@gmail.com>, <osandov@fb.com>,
	<sourabhjain@linux.ibm.com>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <samuel.holland@sifive.com>,
	<kevin.brodsky@arm.com>, <junhui.liu@pigmoral.tech>,
	<vishal.moola@gmail.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<liaoyuanhong@vivo.com>, <brgerst@gmail.com>, <fuqiang.wang@easystack.cn>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Date: Wed, 4 Feb 2026 17:37:25 +0800
Message-ID: <20260204093728.1447527-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_013647_048008_D2E27F81 
X-CRM114-Status: UNSURE (   5.72  )
X-CRM114-Notice: Please train this message.
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

Add support for crashkernel CMA reservation for arm64 and riscv.

By the way, exclude crash kernel memory in crash core to
avoid duplication.

Changs in v3:
- Exclude crash kernel memory in crash core as Mike suggested.
- Add acked-by.

Jinjie Ruan (3):
  crash: Exclude crash kernel memory in crash core
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

 .../admin-guide/kernel-parameters.txt         | 16 ++++----
 arch/arm64/kernel/machine_kexec_file.c        | 16 +++-----
 arch/arm64/mm/init.c                          |  5 ++-
 arch/loongarch/kernel/machine_kexec_file.c    | 12 ------
 arch/powerpc/kexec/ranges.c                   | 16 ++------
 arch/riscv/kernel/machine_kexec_file.c        | 15 ++++---
 arch/riscv/mm/init.c                          |  5 ++-
 arch/x86/kernel/crash.c                       | 39 +------------------
 kernel/crash_core.c                           | 28 +++++++++++++
 9 files changed, 61 insertions(+), 91 deletions(-)

-- 
2.34.1


