Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8BC77B71
	for <kexec@archiver.kernel.org>; Sat, 15 Apr 2023 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eV0W3u6GM4bxAGcI7idW9wH8iv0CruMLDR4aw01SlgM=; b=yI0KDNIjZqMMzJ
	c+AsgHU/HjC6i3iSffPuGDB9XrTD1rthTaflevZdYG1veOdBlDH22DCEORLsISgiiexUAmFpMjmYR
	zhAegpgzpXKNIg5nQMhIr2fPmPmF4ouTuoB1UQealbwZF7/1AaK7JBOSdMhtG8ypeBI6bA5jretgl
	8/0kFK3hAY3l4cKaKuLq5ehYLm+PXgTZuZj2SHw5j9u8Pckhfmw4EPj2tut/mQYhHkPcn4kys6bYu
	e5ayUD/DBCkovfkEGBKrlZ9JwbdQ6n+cRCDKbgQUGRz6yPXlo3m2IZ8Phm5vquRqas51zf9GZYQYJ
	vRMPYifrEf6aL6adnrnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMf-00CPX6-1W;
	Sat, 15 Apr 2023 16:03:01 +0000
Received: from bee.tesarici.cz ([77.93.223.253])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMa-00CPV7-0n
	for kexec@lists.infradead.org;
	Sat, 15 Apr 2023 16:02:58 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E8A34156EA5;
	Sat, 15 Apr 2023 18:02:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1681574560; bh=S7MPdPxyGG8krjwG8dnD5Vl2bboPTQf/URtT6FBNA8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkPghoIbU8Utn5YsDgPWczEl9cFz8j6KQ3muEdxBHlnWSMXefhd4ggOK0NQKqk0NX
	 hZ2Ntyortcxeamd5AvRV0tt/cBtmP4Qfaf8UPkRnZwT9TeuqrLLeNdtOVLJPIYapqN
	 4EsdyZanafb8HtEBwZDVjEvBUoH2ELGHwsq8xWq+5ybwmSwwFbY8lTuKlNk6nBmWyB
	 zszPbofqT+qVqHB8dFXWaEj2ePSlSN04tYoZ0nA2HXeeuwf5lez4IO7EPb03T9NNY+
	 0csC/iUOQBSPRuMiMAvIJLWnZuZppyEEd3UQgUEfw2Nj/uVWpzfu1t0Tq4qIHNg7LY
	 HLVAFbzCxHK3Q==
From: Petr Tesarik <petr@tesarici.cz>
To: HAGIO KAZUHITO <k-hagio-ab@nec.com>,
	kexec@lists.infradead.org
Cc: Luc Chouinard <lucchouina@gmail.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v1 2/2] eppic: Fix a warning about redefining ERRMSG
Date: Sat, 15 Apr 2023 18:02:13 +0200
Message-Id: <0913c99bc11a20f5899a56a05c76e0c6837037ba.1681574529.git.petr@tesarici.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681574529.git.petr@tesarici.cz>
References: <cover.1681574529.git.petr@tesarici.cz>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230415_090256_427238_5B9F9142 
X-CRM114-Status: UNSURE (   8.28  )
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

The macro is redefined on purpose, so let's #undef it first to
silence the warning.

Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 extension_eppic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/extension_eppic.h b/extension_eppic.h
index 24189ba..08f1db0 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -71,6 +71,7 @@ typedef TYPE_S {
 	ull rtype;  /* type_t a reference refers too */
 } type_t;
 
+#undef ERRMSG
 #define ERRMSG(x...) \
 do { \
 		fprintf(stderr, __FUNCTION__); \
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
