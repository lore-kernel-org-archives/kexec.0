Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0673CCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SyhUnIB7u1cGPQFpZTdl65ctCg6xZtHjUwdiH706VHY=; b=i/BwUbsoz6UgcwtpxuOrXobxmf
	YhafGunAz+HugxRdBJ4iT1+Kq0rbSvak7lzhzRG/Lhs5nSFtuKa5whVYpF2xVH2igI97+q49y5U+s
	ILiHtrW/c4qUYc9gh4q2fBfB/jpEfRZbqoo66Qxx9TAKwJQ1f5RP3IVZXl6ep8wn5x5oId3WCAUnx
	9gm6VBIRR3SBp9IcBb7wj5YZJvB+861MIfkg2zgmNCFMq7wbbjlNcxJSCBCFStZ9pLJsw603YRk2a
	HRW4aZmewd7fkL0/c1xeMdK+Ve3GdXxErWpgq2B2+B8+ZoDGeUVl6vhWOmRyvLym9LMOYMBzF50XQ
	jw6xovUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOG-00000001Dcr-1BeH;
	Wed, 22 Oct 2025 02:15:52 +0000
Received: from [67.11.194.7] (helo=mail.turretllc.us)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOD-00000001DbV-0FOu
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 02:15:51 +0000
Received: from localhost.localdomain (unknown [IPv6:2603:8081:6700:a922:9a57:e032:d602:a68d])
	by mail.turretllc.us (Postfix) with ESMTPSA id E82BE2153A;
	Wed, 22 Oct 2025 02:09:54 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turretllc.us;
	s=mail; t=1761098994;
	bh=SyhUnIB7u1cGPQFpZTdl65ctCg6xZtHjUwdiH706VHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oA7TeSFfQcHNV9StsVDecTLosJuO8SVcKrI5lVQ5ZtcHzy35mGVkaGq5TmvvLEFX3
	 0vwT+or39hcjfV3lP0xB/5BW1sRtohSWQZ4eROvi4RIdcquXdclAthHebMrmkwFfi+
	 /xglZ2X/pUBpIWfPOjIYNevxbWH1ggaL7TQeyJJY=
From: Mason Rocha <mrocha@turretllc.us>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Mason Rocha <mrocha@turretllc.us>
Subject: [PATCH kexec-tools 2/2] kexec/ifdown.c: Hide error if sockets are disabled
Date: Tue, 21 Oct 2025 21:07:04 -0500
Message-ID: <20251022020703.14200-4-mrocha@turretllc.us>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022020703.14200-2-mrocha@turretllc.us>
References: <20251022020703.14200-2-mrocha@turretllc.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_191549_153631_72E7E70E 
X-CRM114-Status: UNSURE (   9.32  )
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

Prevents the message "Function not implemented" from being logged when
a system with networking support disabled, as there couldn't possibly be
any interfaces to bring down to the point where we need to make sure the
user knows that the interfaces were not brought down.

Signed-off-by: Mason Rocha <mrocha@turretllc.us>
---
 kexec/ifdown.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kexec/ifdown.c b/kexec/ifdown.c
index 6a60bcb..e6ea0ae 100644
--- a/kexec/ifdown.c
+++ b/kexec/ifdown.c
@@ -32,8 +32,10 @@ int ifdown(void)
 	int fd, shaper;
 
 	if ((fd = socket(AF_NETLINK, SOCK_DGRAM, 0)) < 0) {
-		fprintf(stderr, "ifdown: ");
-		perror("socket");
+		if(errno != ENOSYS) {
+			fprintf(stderr, "ifdown: ");
+			perror("socket");
+		}
 		goto error;
 	}
 
-- 
2.51.0


