Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC93C77B76
	for <kexec@archiver.kernel.org>; Sat, 15 Apr 2023 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nFhW5V2xZnS+SZX8QzvgRiM7PlTa2FFhahYR7gadBXY=; b=zcEB93Wudmp29l
	j5tAnXsSn1AVnxG2lowHZwXauF1EWnTW7ZIEEB7EqUdbmwa2rsaRphu+h0XtJsGxZESmf6uvSizs9
	gGhePkCSfx53EM38sV/V21w9aFCQusu9K00pw8Lvq6x/nE0ZAT29BUybb40gsN+G7pb9ESh4DYqng
	M9KY2yFaJFkP7M3a5WYCdlDsGiqdpJ7x2cyeVj8SpajI+vDxlu85gTVE8KNvG3/YX6jhywgMkyw+2
	AtUJdRIKcYUmy1nG2udVPiSu2cE7xDmemV83wjD3QSazFfEmN06uvAGhR1wSHq/DgvRu+sOMEfsBm
	DxY1xUqNZpGTl8u+LrJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMe-00CPWm-1k;
	Sat, 15 Apr 2023 16:03:00 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMY-00CPV9-2V
	for kexec@lists.infradead.org;
	Sat, 15 Apr 2023 16:02:57 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8311415542F;
	Sat, 15 Apr 2023 18:02:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1681574559; bh=v8lLfkZHKEAZh7uRc2nuSxF13Kl7IBiCoPHtaAu7Wpo=;
	h=From:To:Cc:Subject:Date:From;
	b=QoDNDetmoUU6YjI6CibNiqgPqQiqTHnj3cPn1K6KRj8YRoCfPNvJ1da8LuVAVYP0X
	 CAnMJqrIMy1eWj1SrY1H9kgjTV+TpzraD3uDQen0iQON/32zGru6JmsufmH1N1/L8W
	 26w1nUCmrmm3z5E59QmRUvWOnkI5E4XVjPRkspnsXRKWuzFL/8G2bgTwR5acweqqJT
	 3qTYl9ooGWXUXH7y1pgaLcZ1dXW1VB0x0dQObDt9//WD+fXfg+qmYWfN9AMELzdzzS
	 qKYnoiIEL3hl4SYdWd+UYMAbF6F6Oq0PSI7b3ewU0fD3WvE7FMdVbwl9m5io15gBlM
	 eHv4cwljMvBJQ==
From: Petr Tesarik <petr@tesarici.cz>
To: HAGIO KAZUHITO <k-hagio-ab@nec.com>,
	kexec@lists.infradead.org
Cc: Luc Chouinard <lucchouina@gmail.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v1 0/2] makedumpfile: Fix a couple of warnings
Date: Sat, 15 Apr 2023 18:02:11 +0200
Message-Id: <cover.1681574529.git.petr@tesarici.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230415_090255_289387_4C7DFC01 
X-CRM114-Status: UNSURE (   7.16  )
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

Although none of the warnings is a real issue, they clutter the
build output, making it easier to overlook another, real issue.

Petr Tesarik (2):
  eppic: Fix incompatible pointer type warnings
  eppic: Fix a warning about redefining ERRMSG

 extension_eppic.c | 4 ++--
 extension_eppic.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
