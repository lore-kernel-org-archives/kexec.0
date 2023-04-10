Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576FAC77B70
	for <kexec@archiver.kernel.org>; Mon, 10 Apr 2023 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nr7kczGSQ+4ZY44e3Y4Au2Xv3TjELhEfPoRfRjzscyk=; b=Bpr3BtDfkhYcHz
	4EL7Jh/UOPQfj0tGTRg/ON1teZ+XA003Bsf2X3Z0XZN2osuH88giZyNUPP/jf924WTydU19DXhBhZ
	BDWeBFiiIqoaZBqxTsMDLtfLRMPZF14SxWnOlP5VzRXWrKCL/k46A7lD0nrVPxpIIaqysNOLc5Ihv
	bHhYE1cXSyXhYLf1QR4Cl9Dl1KvKxTyppuaOkbzbsnPtq29yl1eNp4hx1BMs3PJHKt7BA24Vwan3U
	gveJ1wem7nvunCBpmndha5msqqAoUf5V+5EG0BiSKvQ+qMGlMuUIUarVew9vNFQTEmO82/8EJ77r7
	9e3U9iQSedJ5w6YNpUhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plrDr-00FGHN-0c;
	Mon, 10 Apr 2023 13:06:15 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plrDm-00FGER-2E;
	Mon, 10 Apr 2023 13:06:13 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pw8N02SGmzKrp9;
	Mon, 10 Apr 2023 21:05:20 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 21:06:02 +0800
From: Chen Jiahao <chenjiahao16@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
Subject: [PATCH -next v4 0/2] support allocating crashkernel above 4G explicitly on riscv
Date: Mon, 10 Apr 2023 21:05:51 +0800
Message-ID: <20230410130553.3226347-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_060611_139589_1786F6C1 
X-CRM114-Status: UNSURE (   8.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On riscv, the current crash kernel allocation logic is trying to
allocate within 32bit addressible memory region by default, if
failed, try to allocate without 4G restriction.

In need of saving DMA zone memory while allocating a relatively large
crash kernel region, allocating the reserved memory top down in
high memory, without overlapping the DMA zone, is a mature solution.
Hence this patchset introduces the parameter option crashkernel=X,[high,low].

One can reserve the crash kernel from high memory above DMA zone range
by explicitly passing "crashkernel=X,high"; or reserve a memory range
below 4G with "crashkernel=X,low". Besides, there are few rules need
to take notice:
1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
   is specified.
2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
   and there is enough memory to be allocated under 4G.
3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
   specified, a 128M low memory will be allocated automatically for
   swiotlb bounce buffer.
See Documentation/admin-guide/kernel-parameters.txt for more information.

To verify loading the crashkernel, adapted kexec-tools is attached below:
https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2

Following test cases have been performed as expected:
1) crashkernel=256M                          //low=256M
2) crashkernel=1G                            //low=1G
3) crashkernel=4G                            //high=4G, low=128M(default)
4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
6) crashkernel=4G,high                       //high=4G, low=128M(default)
7) crashkernel=256M,low                      //low=0M, invalid
8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
10) crashkernel=512M@0xd0000000              //low=512M
11) crashkernel=1G@0xe0000000                //high=0M, low=0M, no enough low memory, failed

Changes since [v4]:
1. Update some imprecise code comments for cmdline parsing.

Changes since [v3]:
1. Update to print warning and return explicitly on failure when
   crashkernel=size@offset is specified. Not changing the result
   in this case but making the logic more straightforward.
2. Some minor cleanup.

Changes since [v2]:
1. Update the allocation logic to ensure the high crashkernel
   region is reserved strictly above dma32_phys_limit.
2. Clean up some minor format problems.

Chen Jiahao (2):
  riscv: kdump: Implement crashkernel=X,[high,low]
  docs: kdump: Update the crashkernel description for riscv

 .../admin-guide/kernel-parameters.txt         | 15 ++--
 arch/riscv/kernel/setup.c                     |  5 ++
 arch/riscv/mm/init.c                          | 71 +++++++++++++++++--
 3 files changed, 79 insertions(+), 12 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
