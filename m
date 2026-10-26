Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04757606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UXAbezlW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=g1O+umsP;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KvWkDFkJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AqQFdK35R3PRDVunxYa3KuNeB3Jy3YGmbat9louWLxc=; b=UXAbezlWEpMOZ9J7Wi+WvQBhao
	A6mCCbHkuGY8lbUH8nP/EnJ4z4QnzLQiBytk8UKaBBlRiQCDEHosDUz7yekXBKbvM1C1bjhLcQ10w
	3sdXOcoR5aKhZuvBV+omBKx4EJLMVHvwLlJqHPWN6UELn4zTYEvUg07kkEKCpjRChyklLPwA2+iKO
	bvWl7mbZfIPaj2RaB/HiUvCGAOo+/XLK+niwZ0kZPRfgS1nCwIhfHAUJfQ21AIqACU+7i9Go1SBj0
	vPcwb9DUshNpxN3XkS/PgpPmX2Lf+hjxe0jPrFH/o+LSVvKxpVh07RiWe6L53WKt+lxmpKH/FD9h3
	RN06+BMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWe-00000001szV-2HkV;
	Mon, 26 Oct 2026 07:53:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWL-00000001sRb-1YEm;
	Mon, 26 Oct 2026 07:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=AqQFdK35R3PRDVunxYa3KuNeB3Jy3YGmbat9louWLxc=; b=g1O+umsPDlXIipkdoRfPNXQ9AN
	bK6HdaHGTcoiP+scaFuylMxM7ErI/HcVH83rE6FwzQ/ScYwYTDL44vwsWZcBjkrjcyuEoHw6nT94t
	Z/+MMF56cNB8sPQ6PMT5q1Sd4KCp7KnPcVqXSt8b71OnYe2npIJ0cY1kx8R9EDx4xeYTc8JbdUZpX
	aASlrBmmZoNlP4zOFCNRgVxL1ojbNbQZCXSYVqLMiTd4vtlkgZVGvABSawNyqvbBSVLT22EQ5XlJB
	xWZ9CSno74Gfr3tK0YGTTV5zw7T6GDf+hcYQFKDcjY/7nXPPPPfETOq7qb6Vt+PZq7NsaePbMtGod
	6ygnXTHQ==;
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWG-0000000DYKe-1mnw;
	Mon, 26 Oct 2026 07:53:28 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AqQFdK35R3PRDVunxYa3KuNeB3Jy3YGmbat9louWLxc=;
	b=KvWkDFkJzXndGvncGFgO/hLjASWJRdQGUv7ZBx9Kd/Y4d/gjf2/tOQPoVj+es5AzzAYYw+fZL
	wpZ+D42NaiYDjO0KhibMF2YG20SX/Jm8lwHyRYfnUO/XjCMujysMoKBsQuUTEMEVfZxGKQ0Cymh
	ytpS/HzSSO+e3Fp8IxNlI6E=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jCm7d1PzKz1T4MW;
	Mon, 26 Oct 2026 15:52:45 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF3A40577;
	Mon, 26 Oct 2026 15:52:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:52:50 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <ruanjinjie@huawei.com>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <robh@kernel.org>,
	<sourabhjain@linux.ibm.com>, <kees@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
Subject: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
Date: Mon, 26 Oct 2026 15:51:46 +0800
Message-ID: <20261026075201.699550-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_075325_177700_8B5DD9E1 
X-CRM114-Status: GOOD (  10.71  )
X-Spam-Score: -0.2 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ARM64, LoongArch and RISC-V load the elf core header, initrd, DTB
and cmdline parameters with almost identical code. This series fixes
the bugs in that path. And as Mike suggested, rework the common part
into a helper.

Patch 1 stops using the Image text_offset for arm64, which breaks CMA
segments in both the load and release paths, and rejects images with
a non-zero value.

Patches 2-7 fix the CMA page and elf core header leaks in the retry
loops in arm64 and LoongArch, also fix a modified_cmdline leak
in LoongArch.

Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
simplfy code.

Patch 11 frees the elf core header from the generic post-load cleanup.

Patches 12-15 add kexec_load_other_segments() and convert the three
architectures, and arch_kexec_setup_other_segments() builds
the architecture specific boot parameters (a DTB or a command line).

Tested with kexec_file_load() and kdump on arm64, RISC-V and LoongArch
under QEMU, including the non-zero text_offset rejection.

This series is also available at:
        https://github.com/ruanjinjie-eng/linux/tree/kexec_cleanup_v7

Changes in v7:
- Rework the kexec_file load code to avoid code duplication
  as Mike suggested.
- Add Acked-by.
- Drop the two non-zero text_offset fix patches
  and deprecate .text_offset in arm64 as Mike suggested.
- Drop the x86-32 fix patch.
- Drop the TOCTOU race fix patches.
- Link to v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/

Previous Versions are as below:
- v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
- v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
- v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
- v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
- v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t

Jinjie Ruan (15):
  arm64: kexec_file: Stop using the Image text_offset
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
    loops
  LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix a modified_cmdline leak
  arm64: kexec_file: Simplify load_other_segments()
  LoongArch: kexec_file: Simplify load_other_segments()
  riscv: kexec_file: Simplify load_extra_segments()
  kexec: Free the elf core header in kimage_file_post_load_cleanup()
  kexec: Add kexec_load_other_segments() helper
  arm64: kexec_file: Use kexec_load_other_segments() to simplify code
  LoongArch: kexec_file: Use kexec_load_other_segments() to simplify
    code
  riscv: kexec_file: Use kexec_load_other_segments() to simplify code

 arch/arm64/include/asm/kexec.h             |   5 -
 arch/arm64/kernel/kexec_image.c            |  33 +++++--
 arch/arm64/kernel/machine_kexec_file.c     | 103 ++++-----------------
 arch/loongarch/include/asm/kexec.h         |   4 -
 arch/loongarch/kernel/kexec_efi.c          |  20 +++-
 arch/loongarch/kernel/kexec_elf.c          |  11 ++-
 arch/loongarch/kernel/machine_kexec.c      |   2 +
 arch/loongarch/kernel/machine_kexec_file.c |  96 +++----------------
 arch/powerpc/kexec/file_load_64.c          |   4 -
 arch/riscv/include/asm/kexec.h             |   4 -
 arch/riscv/kernel/kexec_elf.c              |  11 ++-
 arch/riscv/kernel/kexec_image.c            |  11 ++-
 arch/riscv/kernel/machine_kexec_file.c     |  79 ++++------------
 arch/x86/kernel/machine_kexec_64.c         |   4 -
 include/linux/kexec.h                      |  17 ++++
 kernel/kexec_core.c                        |  25 ++---
 kernel/kexec_file.c                        |  99 ++++++++++++++++++++
 17 files changed, 248 insertions(+), 280 deletions(-)

-- 
2.34.1


