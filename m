Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718FCCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6zwDstldVmXf/ueg8Pj8Y7VNOqQQCrCwNlROG+82/Xs=; b=yKgb7whUHgPZpg3j2bFfgeGwpf
	Vtr6iitUyn+eTI5gV6sJf3FwkNexFKkqrupX/VvwcENxvHxnbWBGtKrhHZmYM9ZihmiDItw78fN2T
	H2JVmlqLAFfrpVN0P4G0lrJ4YQzfX1DR6QeHiwxfJcOGoZQkvMcOEryxYkn1HqmhfekhoSS+Z3XAR
	2lr+MJ+sHbw0FeJ/omHcKqD6D5j0DrEfyJs0RFHV9yWqzmONh6VY2DigZlaXNDgOMQy3p7JaM1DG9
	lCNkevMsqIZIquO3Yz371CHmtbqFRr+gd9B/ptkcyWyKSYuNIcgr7Oxr7FIMxi9f22r8LXY4w7y/y
	kzA9VqYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXGY-00000002hfV-25sT;
	Wed, 22 Oct 2025 11:44:30 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXGR-00000002hbc-3w80
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 11:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6zwDstldVmXf/ueg8Pj8Y7VNOqQQCrCwNlROG+82/Xs=; t=1761133464; x=1761738264; 
	b=RzdajbTbUqgxN9yfX+j6ChXM5OxIdNqV2C95thhJwrEReUgpjrLuQdk52ErDCP91yXPFG1pvDPf
	TWwhHk6t3hgxiMTREhDbPI+p61YQ5GQbEJipMVI+7A38psQu6AWfo8trbyZa6YWDK8ZDPtSwwlVvS
	QvUYwIdEsaFh6sxJxmhHOuhBrfI62HM9LK96bFfHuFjIHLvJVaFG9LVaoQ/nZLLA+w2+gHXOF2M4c
	vyY0G0W6CcBiX+kPZQh05ZyR0AbGMAAlAF5A1+USKHpvtr2zZdTR+rprzKLMH6cZ1W763Et/DNo/U
	rQvvw6H7ssqYwV73d0pedZpr+bQXzRr9rqbg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vBXGM-00000003EiQ-4968; Wed, 22 Oct 2025 13:44:19 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vBXGM-00000002rQl-3Hka; Wed, 22 Oct 2025 13:44:18 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.98.2)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1vBXGM-0000000019q-1wxy;
	Wed, 22 Oct 2025 13:44:18 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid@gonehiking.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 1/2] kexec-tools: powerpc: Fix function signature of comparefunc()
Date: Wed, 22 Oct 2025 13:44:12 +0200
Message-ID: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.52
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_044425_289443_0D9FA437 
X-CRM114-Status: UNSURE (   9.35  )
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

Fixes the following build error on 32-bit PowerPC:

kexec/arch/ppc/fs2dt.c: In function 'putnode':
kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' from incompatible pointer type [-Wincompatible-pointer-types]
  338 |         numlist = scandir(pathname, &namelist, 0, comparefunc);
      |                                                   ^~~~~~~~~~~
      |                                                   |
      |                                                   int (*)(const void *, const void *)

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 kexec/arch/ppc/fs2dt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index fed499b..d03b995 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -292,7 +292,8 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
  * Compare function used to sort the device-tree directories
  * This function will be passed to scandir.
  */
-static int comparefunc(const void *dentry1, const void *dentry2)
+static int comparefunc(const struct dirent **dentry1,
+		       const struct dirent **dentry2)
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
-- 
2.47.3


