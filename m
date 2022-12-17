Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B64C4332F
	for <kexec@archiver.kernel.org>; Sat, 17 Dec 2022 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZGnDG0k/u4nZu2dJLI36jXYwQqVFjJLKuwkKqJrL+UY=; b=4UvxnurBo3JjXF
	vWnx4xtMaC2CinXDwcT0X6cv85X4hob/y1/6dah+kd0QBP59LrEnLxVOFfbKBErIqORMVcxNhyfiL
	+b3mKfgWNOj7OmhZEEPLNi1uM8Pl5Rmsrw0YfuLYy5VWp61kmVEhU4ZXeZOaZFmPBErp1mZdN93jY
	p7ekGDBDzUvFsssufkJNsITEmaRquvRLgaAVr9ZHAMvtfHbPcGaqx+w7QSI+KWvNSTnFbHhlbOV2L
	u9vy4rqk8ZiVopsdvXabe6Lrmn6DOnkw/Au5PZOOnIUrswzy2ewRnB6wDSGOQ2G60N0WidAFfF2mA
	0rWbe90SO07e+/0qpsjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z8e-00Aamp-QU; Sat, 17 Dec 2022 15:30:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z8S-00Aaim-To
	for kexec@lists.infradead.org; Sat, 17 Dec 2022 15:30:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7C3B360C16;
	Sat, 17 Dec 2022 15:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E006C43396;
	Sat, 17 Dec 2022 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671291000;
	bh=h5S1/BnZHF2ZLzb0VuOYYkvTeHbY827TxoAKiSCnIOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCHIUu0pu99v5I581Nt9UzactrqSnpI42rX1FxwnZRI/d6fep22S3mNXEqUgTkPvm
	 /taW6nD69C2YTOhhb3g91ossrRdDNOj2gqu+/ma0YKpko4zrtaSUL2dpMBWVxfphx/
	 QzUGVsEcXGqO08kcg05ENVJpnmQosNWnBssQ+lHT+RitRnV/HXRy/JNwDrFb+WEdtV
	 qOdxzaFlfqzubs5uw9fvCzKCD3vJpB971cj2fvpICU3hPqFLEKlkG6n/9pM1y31pgR
	 eke0m1s+Xl915cwO679cu3Dp0teBno5ORwjmSceGj+RF0gYSoeyGxX+rrTyu9OguJx
	 N9uIWUI+8p3pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianglei Nie <niejianglei2021@163.com>,
	Baoquan He <bhe@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Chen Lifu <chenlifu@huawei.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Li Chen <lchen@ambarella.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>,
	Petr Mladek <pmladek@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/9] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Sat, 17 Dec 2022 10:29:43 -0500
Message-Id: <20221217152949.99146-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221217152949.99146-1-sashal@kernel.org>
References: <20221217152949.99146-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_073009_192799_8026B1D3 
X-CRM114-Status: GOOD (  12.90  )
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

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 12b9d301ff73122aebd78548fa4c04ca69ed78fe ]

Patch series "Some minor cleanup patches resent".

The first three patches trivial clean up patches.

And for the patch "kexec: replace crash_mem_range with range", I got a
ibm-p9wr ppc64le system to test, it works well.

This patch (of 4):

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc().  If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value.  If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Link: https://lkml.kernel.org/r/20220929042936.22012-1-bhe@redhat.com
Link: https://lkml.kernel.org/r/20220929042936.22012-2-bhe@redhat.com
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chen Lifu <chenlifu@huawei.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>
Cc: Li Chen <lchen@ambarella.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b1102a31a108..18e50c207561 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1554,6 +1554,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
