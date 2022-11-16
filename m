Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052EDC433FE
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JF0Mlp6oICy8Ww7aKyzDpoTnxiukHt+/AKhdAI9zrJ8=; b=hXzvdJZQtnKr1s
	+8Bz86BISf+nJDe0BXVcsFZplK7VKH/605voVOSwTDbSgVLNm0g19X6ebiPWiv5GZOC08fYq3KUaR
	JoWuJJgRiCEB1zzLd2GHuz28ldqBAdBaAJ26YHT0ZmkjtxZRSEjeElU4+X0ggSRLbGB4m6dEp3zgG
	IoPZJQUNZsY3nihM8wQR4i+cPrKxXzG8EYIsvS+IuKxf0lCK6474wdGRBnmMsRvVYRDn4QGXvvBbZ
	0pEPMIkqNZtkir/kPwIiKcQL2h+GY+JytUsdT532O6w9xWZfaMWxBVIgUFmJuIxbzg8DoLYp7egRl
	h41KF1xrbU5z5ogO9ciA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHG0-003GCm-OP; Wed, 16 Nov 2022 12:11:08 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHFu-003G9w-66; Wed, 16 Nov 2022 12:11:06 +0000
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NC21k3B2Bz15Mgh;
	Wed, 16 Nov 2022 20:10:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:56 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:55 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, "Eric W . Biederman"
	<ebiederm@xmission.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou
	<zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, "Chen
 Zhou" <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v4 0/2] arm64: kdump: Function supplement and performance optimization
Date: Wed, 16 Nov 2022 20:10:42 +0800
Message-ID: <20221116121044.1690-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_041102_417961_34C011F3 
X-CRM114-Status: GOOD (  10.74  )
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

v3 --> v4:
1. Set DEFAULT_CRASH_KERNEL_LOW_SIZE to a fixed 128M.
2. Some lightweight code adjustments based on Catalin Marinas's comments

v2 --> v3:
1. Discard patch 3 in v2, a cleanup patch.

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

Zhen Lei (2):
  arm64: kdump: Provide default size when crashkernel=Y,low is not
    specified
  arm64: kdump: Support crashkernel=X fall back to reserve region above
    DMA zones

 .../admin-guide/kernel-parameters.txt         | 15 +++++------
 arch/arm64/mm/init.c                          | 25 ++++++++++++++++---
 2 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
