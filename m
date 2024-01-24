Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED96C47422
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NS5GOrNJuX+6UAlAFlJPiz9NXJnzTA8Zhh6h1qxtppg=; b=gKsHRFELRJg1sZ
	0FIfPNR4qjQ77V2wHkftusfroHE5AGx7HpmSMpDxwh+n+PtVq3aRBRLrpuHX+xiFxKI3dvI0LkXen
	VCeO5igPeIcnAjhDTR1KM2ch6Ds0v1HQcA/5ry1jxceHG5sf4gsuKagRGzpbU+vSA4OS87NdYRE/1
	2EtzaWNRh/dXo4BwPdAZKYTSlbRgADasE2PTZig2XCWz5T5J4fyrd3De2dPpTG9KfOFFRqa9iQ9WL
	AqD9v6tun/vHLL9Iw4t6aHMiW5lXwSwkaKaja6S2p87yUdkBwvYBc7n/x4Nwc8uaRlUmdB3fALB9a
	M03Cz7CrYYNubONEr/lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVbZ-001Xvt-0b;
	Wed, 24 Jan 2024 05:15:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVav-001XMW-1V
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 05:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIZYlTsptXiAI7dlXg4SxNVNXFZexCcZy74a3rSLM5Q=;
	b=ARJUO+huJd3mliwI7bs1XrEGuC7NGqMAJCBONKKTT/GaBIUmACqAmRlnUOYjS2qojXVbql
	9p6K6fd81nNmXvdX7HOti3J56vEUxi1i4nw6/cFu3qQo1ciF2MywedV1b9bvuKgw4GiyEM
	UI8uffhRE/aspLvnCXco9nDuDb43pGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-vrDbGUhWNFqeQwQpMZG3Sw-1; Wed, 24 Jan 2024 00:14:34 -0500
X-MC-Unique: vrDbGUhWNFqeQwQpMZG3Sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83719837224;
	Wed, 24 Jan 2024 05:14:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEA7C1C060AF;
	Wed, 24 Jan 2024 05:14:27 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 13/14] arm, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:53 +0800
Message-ID: <20240124051254.67105-14-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_211437_612213_BF50B773 
X-CRM114-Status: GOOD (  10.26  )
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

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on arm with some adjustments.

Here use CONFIG_CRASH_RESERVE ifdef to replace CONFIG_KEXEC ifdef.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
- Fix the lkp reported issue by using CONFIG_CRASH_RESERVE ifdef,
  giving up the earlier IS_ENABLED(CONFIG_CRASH_RESERVE) checking 
  in v2.

 arch/arm/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ff2299ce1ad7..7b33b157fca0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,7 +979,7 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_CRASH_RESERVE
 /*
  * The crash region must be aligned to 128MB to avoid
  * zImage relocating below the reserved region.
@@ -1066,7 +1066,7 @@ static void __init reserve_crashkernel(void)
 }
 #else
 static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
