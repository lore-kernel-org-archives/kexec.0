Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A52C4332F
	for <kexec@archiver.kernel.org>; Sat, 17 Dec 2022 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n62hGRY0x+nn3aItuJFUmvFiU20MO6Wib759h+HTcg0=; b=hUXL0GZkumPEHh
	epqPk3etjf1DsqniuQmJ8gP1gD1oLNzrSh0meTGOMFb17+WfJ81mY4ATWc9BWmy161tQKn57IYYyj
	Ihe7E91O06OgCn5FJ43c/zSh8pdMeQHM9Q3CGVoY90P+Iw7d8y96/ZD199tXJ3VJJkL1t8vjNuxLQ
	3OqzI9/RKB/IUVjPwMzJVwY4+v/fMsY41pPAal5G2ZPwJqkHVFwHd4e/txRBEjTepYqc4VAyxXvsl
	sgWUyypIzeH3S+wIiC3952HA1EK019MnM/2njkr+yZ/wTwGUF4zdKnsRSjzqbSOBUNpwp5Emydb0D
	0FcmPx3iZW2wRkbUGIWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z9F-00Ab1U-Lq; Sat, 17 Dec 2022 15:30:49 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z9C-00AazX-9Z
	for kexec@lists.infradead.org; Sat, 17 Dec 2022 15:30:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 05FC1B802C3;
	Sat, 17 Dec 2022 15:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04457C433D2;
	Sat, 17 Dec 2022 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671291043;
	bh=y+kmgpEiykvKKnDemjnarN7AvnnMPA0u9a6lbU9fUVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZfasNxAH19clQwmspfHc0RQX4Gqbc2ttYaigdT/56euZBSBhyK6Vxy29uj0FLIBZ
	 s6yTriSFIZUShexsSHAJRncoHDwMuHjIC08eSJzBb+ShbLcos6gGqN3H41vk32FsPU
	 cNRQIgp6C/AIpLPKNylR3AaAoaUpMd5M+Tt9luTYTxUA+0IEd1Uxq2BvzlAl4ktS+D
	 9HCpTf/1Sc2WGj8MpcU4xHLhLOdUkH5hz+MPOSHF3ctcDehtJu4X9awsKqaOK4z7Hl
	 3+bcdcYDLRQXB7SnhoFIJ1fvlyN2d+a9vzy2A6CQs+1WvueqCl2K76BD/2gGUja9Fb
	 9dhYkHwXIfNaw==
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
Subject: [PATCH AUTOSEL 4.14 5/8] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Sat, 17 Dec 2022 10:30:28 -0500
Message-Id: <20221217153033.99394-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221217153033.99394-1-sashal@kernel.org>
References: <20221217153033.99394-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_073046_649558_4D1E7AA6 
X-CRM114-Status: GOOD (  12.91  )
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
index 0bfd71bec7f2..2ed309191d91 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1177,6 +1177,7 @@ static int __init vmcore_init(void)
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
