Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E4C83F1B
	for <kexec@archiver.kernel.org>; Thu, 10 Jul 2025 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2TAL88Wkty1Y1yqbOfq0NaXUR5A1pT3ULgs9nfzh+M=; b=Fo59AuRxcf2dWNq/YIqVCc3MYL
	Jar0ZAXIPC1iwY10mr2bCGRnCiT8BZXf5WKz0F+Ay56+dg94vNzT9lukj8kNaxqh8ylMIN69jPPZ4
	IKFOESIi2ae09S+3RZLntvfJQ+MDg38A8TifyUu5e5oWKdUpbvwITNliEs4Q3KNMl0tukhdr8yipx
	FQiVUnLEoPYvrfTRgI1Ttwqy3rxtG0g1g7wUY/H9ZUuHdCBtIDOt9m3JZjiySpm1VukJVuvKHAtDV
	OHmVadGSBkkdnc+H+m3C4LsJuKDC3h4zSSvEbEgLvjq658WJ8lDTfXuo6y2hoqQkW4BtHKNS2ufr9
	nX+7P1OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZsZv-0000000CATt-3OKH;
	Thu, 10 Jul 2025 14:48:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZr53-0000000Bt86-0Ueu
	for kexec@lists.infradead.org;
	Thu, 10 Jul 2025 13:12:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A49A45C6AC4;
	Thu, 10 Jul 2025 13:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2B7C4CEE3;
	Thu, 10 Jul 2025 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153172;
	bh=q9abc7oDZLcrtsMuNt1PO9GtWY5Cpp2InagfHvwx58A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4eB/E96oPfoYrzKEEkI+GgqjVDfIsE8xFcwhS0OUm/BBiiSk2RYf2RUf0N9rFBqa
	 cyeWTdcEiHkGjmWnAQ4+PqdIss7v/rC5faUUdtvgrSBKIfUzFHlXD/BLb1Y5P+Iwtn
	 Dm+9JdtsGuzG2cBgU5Sx+UJ2YyTLfwDlmE+nYHCVknsIVXg+YOR4SdyywciLOShV6j
	 FsqIzluUatlkHPWYrfk6D/MsKAn65jl9ezdWI1S9csY1M6VB/f/Tnsa24lSdojVjJX
	 5kG38VgKR0AoFKfy6Z0dsL6F03PhwxR3jgNJd/BI/HEus9uKShLrl6AkZ93Smo2OkV
	 SzYf97dkstYHA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP flow
Date: Thu, 10 Jul 2025 15:10:41 +0200
Message-ID: <2396879.ElGaqSPkdT@rjwysocki.net>
Organization: Linux Kernel Development
In-Reply-To: <5046396.31r3eYUQgx@rjwysocki.net>
References: <5046396.31r3eYUQgx@rjwysocki.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_061253_201101_46432CA1 
X-CRM114-Status: GOOD (  10.87  )
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If dpm_suspend_start() fails, dpm_resume_end() must be called to
recover devices whose suspend callbacks have been called, but this
does not happen in the KEXEC_JUMP flow's error path due to a confused
goto target label.

Address this by using the correct target label in the goto statement in
question.

Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core code")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/kexec_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1080,7 +1080,7 @@
 		console_suspend_all();
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
-			goto Resume_console;
+			goto Resume_devices;
 		/*
 		 * dpm_suspend_end() must be called after dpm_suspend_start()
 		 * to complete the transition, like in the hibernation flows




