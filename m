Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B36BCCD1A5
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BiVSd+VLFxzUQ8KC3SBvA2jjXUG4Pp1LNbqvN1qAyZQ=; b=JTOqA2EXWAUUEFbrPPtdCxuF88
	jpXbl3VKVqfRB7Fnx1FaoDoZGfkargOwJlflUioRYIRBWQbiybh6G/PtYHbUszVSm1vVF3mP+Hfgf
	XlGJVzBdvfbPhTiGfwfrf8YEVXaqmRfXr25X/uKiZpsVyd/Ef/4BiGqVSfqrKF1BR8lUsY5QrQhca
	9wGgE5vst0Ted5oT2layHhCP/+rCCEKfrKkyueEPh39nFMoJbcugq5MImKTorjEN8O/4SRdqJAxRO
	R4Z59UM/jDQBB22bCYGSxfnvFC1+Of275KddhXdAC2erGQisypgt4FOx5nKJEmJchdhErYA2d6naN
	10X5nM0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOF-00000001DcY-2COs;
	Wed, 22 Oct 2025 02:15:51 +0000
Received: from [2603:8081:6700:a921:9b17:f5e:e4d9:4f39] (helo=mail.turretllc.us)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBOOD-00000001DbW-02s2
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 02:15:50 +0000
Received: from localhost.localdomain (unknown [IPv6:2603:8081:6700:a922:9a57:e032:d602:a68d])
	by mail.turretllc.us (Postfix) with ESMTPSA id 41DF2203EC;
	Wed, 22 Oct 2025 02:09:54 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turretllc.us;
	s=mail; t=1761098994;
	bh=BiVSd+VLFxzUQ8KC3SBvA2jjXUG4Pp1LNbqvN1qAyZQ=;
	h=From:To:Cc:Subject:Date;
	b=RHNxu57BArcuCgDnppnOEc8Klcf4kOSj0gAbe2n7dkvKcqlc8SHmLnOGS7Tzd39Gc
	 4r4fHVkES+xhWV487q7tP5+2v4FsrfE/nWhDeVACuiHtW8MbAKW4rdAB5lfxLA1r80
	 eMWlzNHTBQHizcvUQSR4PFwq9hGuhWv1DjwwYO5M=
From: Mason Rocha <mrocha@turretllc.us>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Mason Rocha <mrocha@turretllc.us>
Subject: [PATCH kexec-tools 0/2] kexec/ifdown.c: minimise errors printed
Date: Tue, 21 Oct 2025 21:07:02 -0500
Message-ID: <20251022020703.14200-2-mrocha@turretllc.us>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_191549_115384_703AD42C 
X-CRM114-Status: UNSURE (   8.25  )
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

On some embedded configurations, kexec generates messages when rebooting
to the new kernel.  This patch line helps eliminate these messages in
the event certain kernel options are set.  I'm not too worried about the
second patch, but it is along the same line as the first patch and I
thought that it should included.  Thanks!

Mason Rocha (2):
  kexec/ifdown.c: Use AF_NETLINK instead of AF_INET
  kexec/ifdown.c: Hide error if sockets are disabled

 kexec/ifdown.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
2.51.0


