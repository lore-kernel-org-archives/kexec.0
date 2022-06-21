Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75727C43334
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fjwrVY0omjYVIwrXXAPWkGdeYXQT9LtSWAP3PodR/XE=; b=pfuQnFHStCGJoJ
	jDOBHikhoNPZ3meebcldf/1xuwmgtlXWzFf0slKh/l4mOXyY36IqmO/7gX3sIb918FT1zMh88KdEs
	i/BGm3Akj3yZ/xdqU+CJ2KOzJ0UtKY4jB9CrvKDskGnio5uXabedCI6bA5ARbr098BoQN8jdfrVyQ
	kjaySaHDCI2XlWSYU/dMksI7Do7e8ohLVEetQyh5JjLzd8N5ix/bj8de5LaldPDMOSVzd4CV74hAL
	tT35VsDtNmunyysKhvu0BoDSxxpob4YxfrZTLWNh+nhGofCmLRBFaB5ay+wsrG2Pd2nhDBdNYmbpo
	pXEx7a+PXRMlyD3cPtow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3dFP-005PIW-JQ; Tue, 21 Jun 2022 12:44:47 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3dFM-005PGV-Jz; Tue, 21 Jun 2022 12:44:46 +0000
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LS5kz5jl2z1KC0B;
	Tue, 21 Jun 2022 20:42:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:41 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:40 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap
	<rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, "John
 Donnelly" <John.p.donnelly@oracle.com>, Dave Kleikamp
	<dave.kleikamp@oracle.com>
Subject: [PATCH v2 0/3] arm64: kdump: Function supplement and performance optimization
Date: Tue, 21 Jun 2022 20:42:45 +0800
Message-ID: <20220621124249.1315-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_054444_862312_98A0FBD5 
X-CRM114-Status: GOOD (  12.52  )
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

v1 --> v2:
1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
   is specified but "crashkernel=Y,low" is not specified.
2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
   will be considered in later versions.
3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
   But to avoid subsequent duplication of effort, I'm glad it was accepted.


v1:
After the basic functions of "support reserving crashkernel above 4G on arm64
kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
three features to be improved.
1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
   the default crash low memory size is provided.
2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
   fall back to reserve region from high memory(above DMA zones).
3. If crashkernel=X,high is used, page mapping is performed only for the crash
   high memory, and block mapping is still used for other linear address spaces.
   Compared to the previous version:
   (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
       mapping, leave it to the next time.
   (2) The implementation method is modified. Now the implementation is simpler
       and clearer.

Zhen Lei (3):
  arm64: kdump: Provide default size when crashkernel=Y,low is not
    specified
  arm64: kdump: Support crashkernel=X fall back to reserve region above
    DMA zones
  arm64: kdump: Remove some redundant checks in map_mem()

 .../admin-guide/kernel-parameters.txt         | 10 ++-----
 arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
 arch/arm64/mm/mmu.c                           | 25 ++++++++---------
 3 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
