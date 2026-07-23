Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE30C531D3
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nSc6H1n8CfUvbxJc0ENwagioj/mFRPueC/MDVwFsPJ0=; b=4xgXsb/O0iZbeT
	WQDrgYrYlybIvPVPobj+LwOTSfzmdtXG4pKFUsfSYdXi1fyE5PvFclCAJpVd0DtCxmY5+4OOcAGyB
	NFI8pVNyosQQOva6IQ2u+gj0yZLXXKu5TULR31BahX5q3wvB9Y+W0ipARwUJulFqP5XDR5lzp+UJQ
	NltRTJIVyYNyiVA6Eh0qRs2X8iG64tkKLROCNtwWN4mxSnxuUaXdS0zj4Zr9Vr97LlDq1DGd5KERJ
	9OKr5cKcJt4pz2Vyr5/9pkz1Du7k95qO5LShTDbjQZoOtJ3NlH2BYE2jtvGScyPTvMk9A07Ye4MzQ
	Leu+hVw5nkkdmqMey5ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEK-0000000EKnw-2zq3;
	Thu, 23 Jul 2026 13:12:52 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEF-0000000EKkJ-3kA4;
	Thu, 23 Jul 2026 13:12:51 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nSc6H1n8CfUvbxJc0ENwagioj/mFRPueC/MDVwFsPJ0=;
	b=LZrc17NjvFuqc0ZNMkyYqGJLxhfCEHwM6Ms7VhwB4lOZhWJBOzAe0Ye+sIM3YgqNFnOnNAqj2
	vbCWf1cS2hlJ4LgzWQGI8VnjMtIUf6PP9YLAIcOJ4rviEC2IzBoNRx/iogz3rARiSK64MjrQ8Cq
	Escl3Ykk99yeG1PQAvVzi7Q=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWk57tnzRhV9;
	Thu, 23 Jul 2026 21:03:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DC4684057D;
	Thu, 23 Jul 2026 21:12:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:33 +0800
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
Subject: [PATCH 0/8] arm64: crash: Add crash hotplug support
Date: Thu, 23 Jul 2026 21:12:34 +0800
Message-ID: <20260723131242.1537633-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_061248_458313_20E60AE2 
X-CRM114-Status: GOOD (  11.00  )
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

When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch set implements crash hotplug support for arm64.

It also addresses and fixes several critical pre-existing code issues
and Sashiko AI review findings extracted from the previous patch set,
following Baoquan's suggestions.

The major improvements and fixes included in this series are:

- Fix powerpc memory leak, null-ptr-def and overlapping memory
  range truncation bug.

- Fix several memory leaks for arm64.

- Simplify arm64 load_other_segments().

- Implement infrastructure for arm64 crash memory hotplug support.

This patch set is rebased on liveupdate/crashkernel-cma.

Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/

Jinjie Ruan (8):
  powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
  powerpc/kexec_file: Fix null-ptr-def in extra size calculation
  powerpc/kexec_file: Prevent kexec range truncation
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix image->elf_headers memory leak during retry
    loop
  arm64: kexec_file: Simplify load_other_segments()
  arm64: crash: Add crash hotplug support

 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  13 +++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c        |   1 +
 arch/arm64/kernel/machine_kexec_file.c |  76 ++++++-------
 arch/powerpc/kexec/crash.c             |   2 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/powerpc/kexec/ranges.c            |  12 +-
 include/linux/kexec.h                  |   2 +
 kernel/kexec_core.c                    |  25 +++--
 11 files changed, 223 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

-- 
2.34.1


