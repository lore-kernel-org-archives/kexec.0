Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3C8C7EE33
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=33zLTSb92pOUC+90DE8jASpWsQ3bowzFUSF5Kb4h74c=; b=UFCaZ+tH8x9UVt
	/Wd4ihSpM1R4g6QkAdV+JVzTECEZC6znPGLHVZ5V2D4DghUCFnFatZtFqDXcSJ4Rzc5XG7dzm0Ex9
	9VvktG/RZ8HLP8ucU/ca91llPA1T2cazfhYdkHiqyP4PbKEeChDv4HamZfSYfXVBfdCq54ryYZET0
	QCffeTTmyFJVuRTE+2zkZB7wulzia5O+YIZ+I7NtBT8XJUSXPovG9Z8YXT3y0ryBGmTNqn/fGLLYf
	Hpk74tDj7GIDp17Z72E+a1W1Ge8vj5duZaprvJriPhlBfAc4ALPxxNS1AYfQi+596WQwiuwi9s4TG
	s9ulHR2OVpwbHnnqqHuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9Q-005ino-0s;
	Sat, 27 May 2023 12:36:04 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9J-005ijQ-2H
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:36:00 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QT1SR3mYTzLm9y;
	Sat, 27 May 2023 20:34:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:46 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 0/6] kexec: enable kexec_crash_size to support two crash kernel regions
Date: Sat, 27 May 2023 20:34:33 +0800
Message-ID: <20230527123439.772-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053557_962073_DF3A2B07 
X-CRM114-Status: UNSURE (   8.78  )
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

When crashkernel=X fails to reserve region under 4G, it will fall back to
reserve region above 4G and a region of the default size will also be reserved
under 4G. Unfortunately, /sys/kernel/kexec_crash_size only supports one crash
kernel region now, the user cannot sense the low memory reserved by reading
/sys/kernel/kexec_crash_size. Also, low memory cannot be freed by writing this
file.

For example:
resource_size(crashk_res) = 512M
resource_size(crashk_low_res) = 256M

The result of 'cat /sys/kernel/kexec_crash_size' is 512M, but it should be 768M.
When we execute 'echo 0 > /sys/kernel/kexec_crash_size', the size of crashk_res
becomes 0 and resource_size(crashk_low_res) is still 256 MB, which is incorrect.

Since crashk_res manages the memory with high address and crashk_low_res manages
the memory with low address, crashk_low_res is shrunken only when all crashk_res
is shrunken. And because when there is only one crash kernel region, crashk_res
is always used. Therefore, if all crashk_res is shrunken and crashk_low_res still
exists, swap them.


Zhen Lei (6):
  kexec: fix a memory leak in crash_shrink_memory()
  kexec: delete a useless check in crash_shrink_memory()
  kexec: clear crashk_res if all its memory has been released
  kexec: improve the readability of crash_shrink_memory()
  kexec: add helper __crash_shrink_memory()
  kexec: enable kexec_crash_size to support two crash kernel regions

 kernel/kexec_core.c | 92 +++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 28 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
