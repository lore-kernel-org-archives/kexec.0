Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB1ACCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2jZ2P4OIzj3+h+n017BgO1tI1ARmhaxBAnkKFPFY8Y=; b=ZjITKpMGyoLbuxaSTUidvP5ya5
	044+YgPrGlRNMvepcW/d3gbIp7MIN6bRMKon0Wz0E0TI6d7Vxcuu1neL0CQqFA1C3F/O0wyZxQp0c
	FJmHX0OMCX9FnrxE08bk801tBqzyTFcnQgXu9czf0b7rzmgTgQA2mQ1EjxQkcKMhMlrMTnB2x3AVo
	6DPGYsErEMzL4bIPCRDOpahtWeRPsbSuBNoA+9Dc6RXXvjq3yUW9DMQaWgWQNGmszZ4Vg5kj5RdsP
	F2dBFWR4tsIWTDu/hYJtt0sdPFEDwjAxssqpbAGw+pEoj5V+LmjFnr1msVqpodQmegeT0L0xAFX0T
	7BQp8CsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOF-00000001Dcg-3I6Y;
	Wed, 22 Oct 2025 02:15:51 +0000
Received: from [67.11.194.7] (helo=mail.turretllc.us)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOD-00000001DbX-0CpG
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 02:15:50 +0000
Received: from localhost.localdomain (unknown [IPv6:2603:8081:6700:a922:9a57:e032:d602:a68d])
	by mail.turretllc.us (Postfix) with ESMTPSA id B2C3221537;
	Wed, 22 Oct 2025 02:09:54 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turretllc.us;
	s=mail; t=1761098994;
	bh=m2jZ2P4OIzj3+h+n017BgO1tI1ARmhaxBAnkKFPFY8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKrWqFFDUr76MoJ7KFD3WjOC3wm1NYKDgNvAVpJOJm2JPJh0wzzxQawPJMkOMlzSN
	 m4DnXUbYoS7nA3kMdiE7Q8IWbUSCxbtKFNEpFDJMhWCUj3z/nGOGwIse2LdTnyLDj6
	 ZRQuM6FoAMtFvuqls24R0DoMuYfbQf6EcwD13t+o=
From: Mason Rocha <mrocha@turretllc.us>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Mason Rocha <mrocha@turretllc.us>
Subject: [PATCH kexec-tools 1/2] kexec/ifdown.c: Use AF_NETLINK instead of AF_INET
Date: Tue, 21 Oct 2025 21:07:03 -0500
Message-ID: <20251022020703.14200-3-mrocha@turretllc.us>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022020703.14200-2-mrocha@turretllc.us>
References: <20251022020703.14200-2-mrocha@turretllc.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_191549_143624_86F17EB6 
X-CRM114-Status: GOOD (  10.83  )
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

On embedded systems, there is no guarantee that INET support has been
built in.  However, as long as network support is built into the kernel,
we can use the netlink protocol to create a socket to still then use for
the ioctl calls since they don't require any certain family.  This will
help prevent EAFNOSUPPORT from being returned and printed to the console
on these systems.

Signed-off-by: Mason Rocha <mrocha@turretllc.us>
---
 kexec/ifdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/ifdown.c b/kexec/ifdown.c
index 3ac19c1..6a60bcb 100644
--- a/kexec/ifdown.c
+++ b/kexec/ifdown.c
@@ -31,7 +31,7 @@ int ifdown(void)
 	struct ifreq ifr;
 	int fd, shaper;
 
-	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
+	if ((fd = socket(AF_NETLINK, SOCK_DGRAM, 0)) < 0) {
 		fprintf(stderr, "ifdown: ");
 		perror("socket");
 		goto error;
-- 
2.51.0


