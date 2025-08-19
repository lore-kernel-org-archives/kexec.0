Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD24CA0EFA
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13sGefhnWe2CJDYK7uGoV4Nh9pOaDg7e8bCWQfdEJ7s=; b=d1nhL+a2WdZFHu6EqFn/GJdVqG
	soN/1WZkM7bl4iVHDgMI6Ek6PFHKgCH97790/+GcBb9EhV4wmFcXYpg+0LCkI2q0YU9qTjI2Wy//r
	IMqdPXEkEWitGlQwbZWafL6yQqkOJOAXEc32oav7oRwCXykd4jd/L0BTzhaW+EZz9LxCGTjFIKB/A
	q8C7wOp67HdXR67cONJu63SdVO0tv/VJriPBHschx4cJfe/TDBiwNDZob999vVStMT7ZuBxI7oMJg
	CeIt/k/2C4OA5iWmzIOf4cfxHqGWXa/k0APkm3gSyuv4QgAfmTdvajGx42ne/X85MDzd+kW2kUqWe
	8iQJ3RnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqv-0000000A0Dw-2rWZ;
	Tue, 19 Aug 2025 09:42:01 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIIQ-00000009tTW-0epI
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UeC1t+qZsswMCNwvqNROSXtDjtlbHFRZkjXhBgXal9ZXisIxELsQUpOcs7UFVOmbCL9q80hq/X0m46XO6UdlUbAutHn/y+6w0e3eN7KCeF0qUeMJbyKiuoqdI2OGZ2uJO5GrEQe86gnJB7o6n2fq3jLKLuHvi5iX00qkWg1NadA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594353; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=13sGefhnWe2CJDYK7uGoV4Nh9pOaDg7e8bCWQfdEJ7s=; 
	b=H97uK5qRLzYXor6aOMzGmEuD/UtYsG/4puvRe/QjhJ+698AhSVusuW00ef9MQ5kYY3lDd6BaaUoAaHCgEJliHXv9d+oBO21POqeoNH57VswO4mfINx7InRv8DdsxMYpjuTuZhvpRzrTkMKnkbnWx3XOyvLof46feeBdWlMQ+zsk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594353;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=13sGefhnWe2CJDYK7uGoV4Nh9pOaDg7e8bCWQfdEJ7s=;
	b=KH+vqJ4AWTQpONt2KOtWOUkODSBfMhO2RP+jr4hbET2jZO8eEDFWe9dfgr04zBb6
	2/udfVIZGU6j3Xu1PFRiv9rSNc/wW1T6VWu/1hGoRVArBWeWpC1ZQewEVr40Vv4guEn
	e7k+M2CvJtUttb18Jh+e4UmdyE0b+YvHmK4fIsvo=
Received: by mx.zohomail.com with SMTPS id 1755594351553709.7305083293504;
	Tue, 19 Aug 2025 02:05:51 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 3/6] kexec/arch/i386/x86-linux-setup.c: replace %d with %u
Date: Tue, 19 Aug 2025 09:05:02 +0000
Message-ID: <20250819090505.647690-4-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c7554b5d0cc6103c88f7157400001bb9960ea035525ff9d0a0bf371cbe29d56eb9df2fc09c65da:zu0801122780db122a4b5d9b62108f7abd0000cd02ed758edae69f49c3da579553619dfa3b891f4a7deaa897:rf0801122cb460b67bd6d26ed61607690c000048c3c96de0dc523ead7b12e8fe442b861660ca0255146a0f2c8ceef62d3e:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020622_225324_21BFDD83 
X-CRM114-Status: UNSURE (   8.36  )
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

...because e820[i].type is unsigned

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/i386/x86-linux-setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index c716e1b..94d9dd2 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -761,7 +761,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%d)\n",
+		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%u)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
-- 
2.47.2


