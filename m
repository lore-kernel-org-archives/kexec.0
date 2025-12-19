Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A24D7496F
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CsstEA46zKV1wNVzxkf3V07JtHmGKihsOIZECd1KNS0=; b=Zf1SfG6wVq34AX+3bRTBVSUzDb
	t50xfa/pEnZwJLcqt5jTIBahgbQv0lxaCppFIUnoJld0ks6WqWJ9J3R6JN0HHutSZR7lOwQN8NsDC
	Y1oThNVubf918CaVv5rwhlDDPc5p4UnHB0w+dHsXRRdSMm0mlWaofz6ZQ3t3Xd+EpJinEJ+A2VU7U
	gUcV8PXaxIi46IEU3POCYMXES3xypwYE2ACJ+fdym0qmWP3MFw/bz7ro9fs5emiNC40OMZU+D/yL5
	mf8labizFnJm3wsgilWwMEynFjfIQ5XlTCRt7JARX5jdamSCZDbL3AWeapjZwfBkbgrbK6rcisSSt
	0DCwdqNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsX-00000009xit-1dHd;
	Fri, 19 Dec 2025 09:34:29 +0000
Received: from smtpbgsg2.qq.com ([54.254.200.128])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsU-00000009xcE-2U3a;
	Fri, 19 Dec 2025 09:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766136812;
	bh=CsstEA46zKV1wNVzxkf3V07JtHmGKihsOIZECd1KNS0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OsCMpu25IiKRs9xt6ZuPcjF2ZNBOIfhxgSmv+W/gxSlvd1SCy0Pw5x9814HSOosyK
	 0Fg8wcmWeANKTBPCWbqkRZ4iMbBSvGlFnDNCwZrmaaZLYeizaee33BwmcnsQdJVt8b
	 XGj3TEVdm4pZ+PJIHBv0Y8vq9Wh9j0EpFOBSFIvM=
X-QQ-mid: zesmtpsz5t1766136793t8812160a
X-QQ-Originating-IP: XII8C5yfw3W2vrob4u8AIAwNm0u3w/1PmsfPNU5Tfsg=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 17:33:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16146975386883553815
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 3/4] kexec: print out debugging message if required for kexec_load
Date: Fri, 19 Dec 2025 17:31:33 +0800
Message-Id: <20251219093134.2268620-4-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251219093134.2268620-1-maqianga@uniontech.com>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OWDXxJVoAuOzf0LbSbzR5ZQ5RYkMP14fzhkTBSzkKYCXd0ON5obD8yOq
	i+Ju/Swj0tr4QNvWj6t1zkReeHQJFm45GseeBqN3gBjXC7o5frSCtDdq7qTAi7f3cSKBped
	YiIPuh8c60653I+zKgqVHE70rcofj2wkXWKTZR83bWg3rOukORTp7ZV3v+GE8A2trwjP1gx
	kgn4MfRqCG8tHpwgMebCFSgFElbn+8qrwi4BWLYe9UdZmM69iy8DsfmN/uG2LIc4lwW6+If
	hSWAVdAFY9mjkxx5CeA9sz0CmvqVxVK4RK5JpqIZ4TdQ5OfsT43TDbxNwfQBYK5AovAfg8p
	EMjuOW8jX6zD1dRsco4Zmnsz8oG4uc57NLsxHZfM3837ppDx7lzKMmzLpdl3wqBnp6TsWtH
	0g9nIrcYAwxE/WP1a9lBM392zDQWj2uzwj01YI9FI8ULpx8wEv8np4FM4CFfgoBGXVkWPX7
	40qX1Af5OpEmDb2hxWg8LqC1QYOqVLPSd9PNUw34FBqz9sd3M3xJ6n08JBRZjKN5fYnetb2
	bMOPNtu5uztC8+W6I3HIXyWsJ4eetHyT15zZfIBi0gC6YKLQvhKzgzg0sdQSWNjSnMWloul
	bwRuyWBAJ7tV6gTB/M8ZXG5gdNfT914sXYt2eUhBhqr1oQuQ6T5n73ITh7AX3h9Zukll+ca
	qtgScEqfnrdQCTQXt1O9271/rtamfb7utKs3cerlBa3ttC6lsM8Eo1S75PpTZ6hLY3SNm6t
	Jh9EKtLF7JBFG5uOuRk7o1NpIGgupmmxYytFq9hLsH9M++57JERk0L0t7usCsiVaVsl99kt
	AtBEIi7TmDMGKxdyFTNXKxwDCowC4d6Ye06Xp5Z9U8C7RJJmdMx514m3SJ7n2BT/F7XJ2uB
	KssyVpvrFld235D7pLpJ4eHJeO+ZXL9yR342NbMoMBfRmB+zc/U+k+0XbL653fxi9dc774U
	4C6btp75a+QMdQ9nZM0iwW3TUfbNxRpUw5I352OZ8LAxb2NdFBt8DBl2gzSnoufisOZhLiM
	rj5KzFEu9i4EFW6hYlrYFI8C4KasLeumOhS0qLkYk87i1CHpV1PNcnIx8IGalRTEv+wDsPM
	ucxHIFw2/mLS24CJ2OXlOY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_013426_982479_7F834D9D 
X-CRM114-Status: GOOD (  10.86  )
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

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

As a result, when using '-d' for the kexec_load interface,
print nothing in the kernel space.

Since the segments debugging message has already been printed by the
user-space tool kexec-tools, it will not be printed here in the
kernel space.

And print out type/start/head of kimage and flags to help debug.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f6c58c767eb0..37e4ac8af9f3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -166,6 +166,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


