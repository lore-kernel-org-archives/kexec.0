Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44CED4336B
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xqDNPQMA0ZXb9beqvbbiNQ2l/epurNxInDyeK+Wd+xQ=; b=SRhQ57rswUN7Hpk5Zo02jhGATv
	7cgx2i7DM/5mxtMjg/+9nmFc2qWROzxhWZ+LG51bD8KVnqbFswiEroM0tcXnykxp4uu/MFoldigxd
	qhrs+cCqeI8KDNL0MDEOQs/pGAExVb5z7C4OOx1KMhFm1jPM2aorVlgrsFsAXlZX/sr/eyvHGRPA+
	JzRcaH8jIX1oOeX2EIPX+lci+3xyO07eFGxe8uLJV0T53DjnZQajkXyPn1EmpnB+oYVCIRi3ZpiQ+
	R/TK0yzVMSczlTxgjJ/6T/av0fOScSqscL5L6aXwCZuZUn60lGyfZ5eUz0VWv9zrRsCNFNuXcnJwL
	Y0tYwu+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTxQ2-00000000CFi-33I8;
	Fri, 12 Dec 2025 07:18:26 +0000
Received: from smtpbgau2.qq.com ([54.206.34.216])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTxPz-00000000CE9-2OvV
	for kexec@lists.infradead.org;
	Fri, 12 Dec 2025 07:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765523873;
	bh=xqDNPQMA0ZXb9beqvbbiNQ2l/epurNxInDyeK+Wd+xQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=N8NbqwK9GwWGSMFJxoCYEr4s/Izl8lVKjIJTBYcN5/wFmpGYZVVjgppMI5NFHopKX
	 zW2GpYfHeXdBk6abeT4HOJsCmkHOuwcixnX+m+oQht8RVOWpyHYmMI973dRHmxxytA
	 /ZJOEh7BsMIo22QaF8I+o5rFzIU/IDuRpyrxQAkE=
X-QQ-mid: zesmtpgz3t1765523868t4cd87e0f
X-QQ-Originating-IP: Yg3483df6YQga4Ka682rLXb/HS16D3bbdDLlND/VZow=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Dec 2025 15:17:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6577007258687033009
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
Date: Fri, 12 Dec 2025 15:16:56 +0800
Message-Id: <20251212071656.834079-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M5AoSkhGr8pk9OXVH0aNOypp7UmeW5dgMh83rLQvnTULcORfb3UGs1wj
	8F0heAm2bSqPxbk5UaKBuPkEXj404m3d8hDQLfsnBKZuyqQz66C2vNYywqtTGDlpwXsNXa9
	K9CjGDxzfmpLDBEz10RUn7KeE8Ca0+sr2Ta+2goRFrIIYkmuqEqgZDnfeE6hrrzHaC8HWtA
	2QFdHkbw6Xhp2dSQVu9jbodbYTjWd3+Hv58Z6H2yJodUAUA1hAR5sf3QK6OMVWam/tbX05V
	0FUwCdQn1JsmdmFfTmajAWKenuecjQC3N76Yd7fFaVn36uaQvsNeAltxx6apa0Sx4EchAwr
	93mud9cSbpUJKHQqomVuyYSy/OUAbyyZRTEUy1zJnE6MKl3MqEDjqCErVWRPzB4aKy+Q1uP
	TtAhnWYK9b6GSPgmPd+JF8EtCaZreLDsTVbd+v4zvikKYgHUsUCra7ZIFLnUY2pFG6DoigK
	1XvvXCxREFQo/uUfT9ioEEqrcm1LUvRTttmBazivD/6lXpv7GpVQxGycKgv6xG6aoXKYbDj
	m1C2g/UAe+FYf7JewFFJ+TwnU0+BAQdPzRmpaxsKHWup66r92G+7Ma4K/MEX6HJdOd6hXGO
	SESsY6zMRbh2AjJjoisGF2S3290P+EspiFyyWQGuDptRNSss88EtEi/0A9D5AfXQOsAWAzN
	voC+IsF45GJ1MX0+Y6gyq/l+iVnBLPXXAlIByi+ulmB/KUEz2mf6cdxjEZtQ1pkofZVCBUH
	sHs62kEyPPXuCLNtsJQQ0IpleH0wFPMvni3IZxEXfo1am1W1pMeBKKxejUSqp5+L29L8idw
	Upflo0S97BAslDas18EFUewR6X5ZG054DeAaT7RMfgPFd12IvsLrA6HWGd6dUGPmfPJbe7m
	tLmxHrAh27ZklIFop8YCs1GrmKW1Q+zzl4EHRTjlYIz/5iXqF5BJhVMBftuRhqijBLsjKJo
	5trgOj0obZLo36OE2pIQoklFJEgRSAoHn3th0pBtwWv8DkwbOMF2ddA0FA2u6zfGLKdF0vf
	B0PTwHbcfRj161RE/KjLvJav7M8DQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_231824_472003_F719A7F1 
X-CRM114-Status: UNSURE (   9.20  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The image is initialized to NULL. Then, after calling kimage_alloc_init,
we can directly goto 'out' because at this time, the kimage_free will
determine whether image is a NULL pointer.

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


