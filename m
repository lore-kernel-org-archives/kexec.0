Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A452FD530F
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DJBahsVO2buYBRo6uanQ4akOube4lASCcn5Wc5JuHA0=; b=jDnBAikxr29gOPx7jd4XuOM67O
	GhXAmfX2DSstz79ZB83i+PbHVRQerfbhuxXb1Qpm+E97yk/V647OlsFKQTRBR09hbP2ieQwtZTMSu
	JiUoQc2CL0vMk2hsPq+82KaN3FZ4ztQe/9uz3zkgPmWZSLB777FxPBKEQZTUu3ytl9sjuhMiZ0UUq
	SwaqE7GT68z12ishT7I3ee5QF86WffFPaEbNnr04H8hTU4y75F3u3Ol2LHl4Gouwex/NYxd0bh7u/
	IHhc1JK7y3KSfLB5/AWpo+dn8Gnlqku4k3fm8NdOzMgdACo4urCo0S4XqlMwqBr1zGSBuZindfNcq
	geN8688w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtNB-000000080Oy-2o1e;
	Fri, 27 Feb 2026 08:38:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTdV-00000001u0w-2cEK;
	Thu, 12 Feb 2026 10:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DJBahsVO2buYBRo6uanQ4akOube4lASCcn5Wc5JuHA0=; b=Vi0o7dgqkGdVGsWoZuK9pDk3HR
	HqqPp8XWk9H8xe6pmS+pgkyeFvld1MmhOBMRaZ7FNlWj4i6WjspfhwCGgKqXdPKC5SaPAGjPikqp4
	d+E2LelT0u6K5ETeevvjDEioeKn17aUvTKyTCOzfRobf1tDTDoYfAR+YGHZEmHFj6ef176HmvJXAe
	C2OfxX64hnUzPOLfaytwzoCTv/yDdCBf20ROTCGPUVn7glFuVgkvjhKAuYgyKYaTi4+Kd81Th4PPP
	S58P8OeCbmJsxlaLBuBH0Uiio7j7bm98wwrS6Ysv5SbcMGHbn3xfPm+6lv0lYvzxdmfrAr2nuvm/L
	w6g55ntg==;
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTdR-0000000Alnp-3wD3;
	Thu, 12 Feb 2026 10:09:24 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DJBahsVO2buYBRo6uanQ4akOube4lASCcn5Wc5JuHA0=;
	b=N1Lb/dyTE2h5HOJHrh+NRJNvn9yj1KvCbqkIn6VqWUGF70dIauXoQMrrYoYNwdNWlg3+8a/E2
	vGe1QBnODc9pH2mKsoaHcQbTyBL1aa76SvP3u+XYQm95+qiCFBlYzCsJrRLeFozkScfrLE4vows
	heKtPwy0ISFWrMHfm+RuWZA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBW9p5KLtzRhTq;
	Thu, 12 Feb 2026 18:04:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C35A4201EB;
	Thu, 12 Feb 2026 18:09:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Feb
 2026 18:09:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<kees@kernel.org>, <elver@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<ruanjinjie@huawei.com>, <fvdl@google.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <rppt@kernel.org>, <osandov@fb.com>,
	<cfsworks@gmail.com>, <sourabhjain@linux.ibm.com>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <eajames@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>, <bjorn@rivosinc.com>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <dwmw@amazon.co.uk>,
	<pbonzini@redhat.com>, <kai.huang@intel.com>, <ubizjak@gmail.com>,
	<coxu@redhat.com>, <fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<brgerst@gmail.com>, <jbohac@suse.cz>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v5 0/4] arm64/riscv: Add support for crashkernel CMA reservation
Date: Thu, 12 Feb 2026 18:09:57 +0800
Message-ID: <20260212101001.343158-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_100922_540884_A283E65D 
X-CRM114-Status: UNSURE (   6.53  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:38:19 -0800
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

Exclude crash kernel memory in crash core to avoid duplication. Also move
the size calculation (and the realloc if needed) into crash core.

And add support for crashkernel CMA reservation for arm64 and riscv.

Changes in v5:
- Fix the kernel test robot build warnings.
- Sort crash memory ranges before preparing elfcorehdr for powerpc
- Link to v4: https://lore.kernel.org/all/20260209095931.2813152-1-ruanjinjie@huawei.com/

Changes in v4:
- Move the size calculation (and the realloc if needed) into the
  generic crash.
- Link to v3: https://lore.kernel.org/all/20260204093728.1447527-1-ruanjinjie@huawei.com/

Changs in v3:
- Exclude crash kernel memory in crash core as Mike suggested.
- Add acked-by.

Jinjie Ruan (3):
  crash: Exclude crash kernel memory in crash core
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

Sourabh Jain (1):
  powerpc/crash: sort crash memory ranges before preparing elfcorehdr

 .../admin-guide/kernel-parameters.txt         |  16 +--
 arch/arm64/include/asm/kexec.h                |   9 +-
 arch/arm64/kernel/machine_kexec_file.c        |  43 +++-----
 arch/arm64/mm/init.c                          |   5 +-
 arch/loongarch/include/asm/kexec.h            |   9 +-
 arch/loongarch/kernel/machine_kexec_file.c    |  41 +++----
 arch/powerpc/include/asm/kexec.h              |  13 +++
 arch/powerpc/include/asm/kexec_ranges.h       |   1 -
 arch/powerpc/kexec/crash.c                    |  67 ++++++-----
 arch/powerpc/kexec/file_load_64.c             |  17 +--
 arch/powerpc/kexec/ranges.c                   | 103 +----------------
 arch/riscv/include/asm/kexec.h                |   9 +-
 arch/riscv/kernel/machine_kexec_file.c        |  39 +++----
 arch/riscv/mm/init.c                          |   5 +-
 arch/x86/include/asm/kexec.h                  |   9 ++
 arch/x86/kernel/crash.c                       | 104 ++----------------
 include/linux/crash_core.h                    |  75 ++++++++++++-
 kernel/crash_core.c                           |  85 ++++++++++++--
 18 files changed, 314 insertions(+), 336 deletions(-)

-- 
2.34.1


