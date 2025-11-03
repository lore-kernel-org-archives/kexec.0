Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9348CCF9F8
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 06:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WufCdDOpzfL/WfQ3htR6pHmHReVaZ+8ySuuRY7Lmf9g=; b=YiXHQ3Wc+35CSAGAwBVD5J0YJ0
	bcoJwVF6RJJ5Yae+WeaUav9SBoVHuxX9bgUfKf/Hhr5hD0t5bHw0z3SI3AJMdEJ6D/ynxLznu8f3Q
	KbKThit9IXJ3BB5xwyQRsVF/cyVB4To/zHqrT/b5+xoaa0fTJBWwTWe9+7hcSmaWpEZC9QWRZBRRC
	P8zNPlWUH6Uu8fgwWo9fFxvCM/WdT9WgAuLWKE8KNXGtGCCf9I9D8f9LmodQb+7LDSxa2Y28SAVMl
	ty485l+1x9GA/LZ+qBc4jOmFZ040+wRfd0HUAx18RxRf7gnB4tO2QBkM6ngwQm8vep4AKEXr89dQN
	V3FrDN2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCI-00000009J93-0oDb;
	Mon, 03 Nov 2025 06:37:46 +0000
Received: from smtpbgjp3.qq.com ([54.92.39.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCF-00000009J5i-48tM
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 06:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151837;
	bh=WufCdDOpzfL/WfQ3htR6pHmHReVaZ+8ySuuRY7Lmf9g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Jhn+ka9KF2GqVfy8UT6BZeggDNwBTvacwDomz0ES6MU/OWsEGhAnKLqQsfaS9yoay
	 kUWVruh1xRyLXEEvR12LDo7trq7o76UNZlL0/Q7ZjynOVqGfWwOi0auNdumANxGWqX
	 mwxNJtvzNNBpZMnPAjWUcINIvBly/6XNiB15gegA=
X-QQ-mid: zesmtpgz4t1762151833ta166cf88
X-QQ-Originating-IP: TtKN50SrsQQtnRe964P7y1PWjWRY3Au23BninVfQwPk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4954036096720726581
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 1/4] kexec: Fix uninitialized struct kimage *image pointer
Date: Mon,  3 Nov 2025 14:34:37 +0800
Message-Id: <20251103063440.1681657-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NK5CQ9Y7aNjz+Za4Lz7LPEgSZ3KILfmMXVUdkwjsODIA2MwnTS0Z+GoN
	bQsCLLSbhnJJ4VCdqPX0NQZl6Yq42/yVpq7eVo73GJVaXCxoQEXEj1PdnORZl9ZdHMQQ/Cf
	3UA6Pj7CAHdTAPnv5XajZLFuiGMB2wAmoH+w0scrTHahAPJ00E/57AOAYnU1HQStYK4K0cu
	xQBg9jk2MFqV8TU1E6kZ309JvyCWEJetG5eXnEG0nzgmfQSgr0TjHreDvXTD51Ug5dFMEY2
	J3VO1fv8p2Yf+KdZ3NTbVSipTB1H1TDbNbv1nJergx1FMbLXpwIQUnQ3yASgzoCvl7Pox8p
	RW/KvT6vOAHlwp2dGBvAv7pMVsrCGcrrqq2dRAZLQQq4fdYFrEXrzfkWbfWFv6vUx6rmspf
	3CT6Pd61kpyzPofFznIq4IAB9Kuzaapf1aEkzpmcweq/LpXtmmvQcC4D/S61rmxPtEyCVog
	EHPzJAMI3vnjWahekv11tpeUfga0xnH0H0+dqHS8ZTcBlcu+CDnfM1VwXA45CYCknt7OtcZ
	YwozrhPAC9lLcOvByedso3BQwBGeDmKVXoxIYrMK1/ERnl8rP+CBRA2Rrt+z4x2EqygnGaj
	lLytxyjfTwafgGBoOkkY9Pp18kH1eScPITvi4uo+S0GPXnvEF4xF+AUaRV4mcJmrcB3tUAr
	/plWWgz9XMaQf2aJN9KIRpUY/6bATKJ7ng1gDDU8lNIhCWETCSUG9+teJ7sBvslt6CudyUP
	Y+e1TIBOslzpNk5YFNKRVsV0yYp2cpLzrecOgWWKLhBFxYLV8DC8TSF7DN/+4qe/m+LCAWi
	Hy5BLWxQv3acD1JOTpKZn2LTnVgcx2yuZqtIZoZJKxRYEHObsPk36KVqP5fsjtXoLS+HBpY
	O40pKIKJRmgEGLo8NCbcXKBoaQmfrN6n8OwWczYWgYpR9iLYGFhAiRlYg2T1yuNZnc7bhEY
	JFwpHaAwx8xiEcJJa2nUPm8pXX+swVh28AEMUivIFeWaOLNxZGBBaoYp73sg9iDJTw5BwOH
	BbQ2sLPqfMUDk3FDRm3GXP1/4WeaAEFcj2R7ac8w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_223744_535241_5BABC932 
X-CRM114-Status: GOOD (  10.08  )
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

The image is initialized to NULL. Then, after calling kimage_alloc_init,
we can directly goto 'out' because at this time, the kimage_free will
determine whether image is a NULL pointer.

This can also prepare for the subsequent patch's kexec_core_dbg_print
to be reset to zero in kimage_free.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..9bb1f2b6b268 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	unsigned long i;
 	int ret;
 
+	image = NULL;
+
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a serialization here to prevent multiple crash
@@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
-- 
2.20.1


