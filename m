Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C9C3DA42
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=phW/PoIU9Y/D4I+Yp/oDCyIi07L2wepIW+U0/TxYfAA=; b=YwfHsLetW3l2jV
	Gn5ZZnU2CXL3wP8dBlHuCpZEnTQ2+aHNZkGl2pjnlog/xpqW9M8ByqOATFf7uJGrPFSglav+WPqr+
	EhLZbY+7QA+W+O/1dfiDmrTdQ/iQ1COO8nDu3WNRYTHCQ0k/ykVMeLmaYCMmGXmsL7Rzy3y2ioCPM
	fwhm+yssJzYNRQnJ1GPffj70kGxsO7VGWNyCf6G/VpZI7lhQin3atcnzErSP60R3c+hdvz1aLi3uF
	5inH8LdYD77R0q7L3ScDuIgSr5IJ6heAmnqfYuSeYGc70O3preDa9VEIJ3wrj7Bg3xfC8jh86kBlV
	pklaUOUFOlyEUQLh3ogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRK-00000003uiV-1bij;
	Mon, 08 Jul 2024 13:29:58 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRG-00000003ugf-1OCb;
	Mon, 08 Jul 2024 13:29:56 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WHlMl1wM9znZMj;
	Mon,  8 Jul 2024 21:29:23 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DDA4F140415;
	Mon,  8 Jul 2024 21:29:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <austindh.kim@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel reservation
Date: Mon, 8 Jul 2024 21:33:45 +0800
Message-ID: <20240708133348.3592667-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062954_602688_39DCC383 
X-CRM114-Status: UNSURE (   7.01  )
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

Currently, x86, arm64, riscv and loongarch has been switched to generic
crashkernel reservation. Also use generic interface to simplify crashkernel
reservation for arm32, and fix two bugs by the way.

Jinjie Ruan (3):
  crash: Fix memory reserve dead loop bug in
    reserve_crashkernel_generic()
  ARM: Fix crash kenrel data type bug
  ARM: Use generic interface to simplify crashkernel reservation

 arch/arm/Kconfig                     |  3 ++
 arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
 arch/arm/kernel/setup.c              | 63 +++++-----------------------
 kernel/crash_reserve.c               |  8 +++-
 4 files changed, 44 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/include/asm/crash_reserve.h

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
