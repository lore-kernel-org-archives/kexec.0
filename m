Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32C5CF6D3D
	for <kexec@archiver.kernel.org>; Wed,  2 Oct 2024 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKK2NRfU29F32TCOlhPHSGNLAAVfPhCP6e3Ad6cvhEA=; b=vHvmyiHMiw6YAh
	qmBeTkt8olYLGpODRwHIY8vjYJaDJk44p458Y0aqOa7eHHtVpXPwUliyVy7GOULSPvmSGqPBKE5HI
	wI/j8wLCCntp3n340wgei87AhCf2bedp+nD55fngb1iJjCNfiJjeqJXzmDS629vzTyBQ5LTgF8U3V
	c/fbaoPEETLYTDTwQBxWLOzMIyR68i1lX+aQU7wcfQrY9pXI/tNuJsgCCEqYbQsBc99CclUws9WAx
	fAkU+TB+x7u0iai7AeE3/YUDT78YIkhKzJI93DXpEm0Olis9635aFUiSf/SSdiY5DIq0jcB2AoXok
	HXmdQouRQQ3a24crH2oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uT-00000006rWK-2GLp;
	Wed, 02 Oct 2024 16:09:05 +0000
Received: from forwardcorp1d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:df01])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uN-00000006rQK-38f2
	for kexec@lists.infradead.org;
	Wed, 02 Oct 2024 16:09:02 +0000
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 41C2460A74;
	Wed,  2 Oct 2024 19:08:58 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-cMZ3bEDP;
	Wed, 02 Oct 2024 19:08:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885337;
	bh=jFKAUNHTYomsdDtZ7yDs1yniRUoGKOv+DuJ1bapdrNI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=qPH+N7keP7fgNy1yVdHKgLdk6Vbwy5VUI37bXZuORZnoZCxar0lhhrLgbGMX/rOtr
	 LTEiQPxkzr/9Y1AEX6RNxsh7BzoT/zDNJBuWYiGmRAwpny8Drj92A+n8avkCV2ys3e
	 +ZVTj+7zFN+pwSdGU0uASrLQaonWOGPG+JWQX8yM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 3/7] [hack] purgatory: disable purgatory verification.
Date: Wed,  2 Oct 2024 18:07:18 +0200
Message-ID: <20241002160722.20025-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
MIME-Version: 1.0
X-Yandex-Filter: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_090859_996950_CD98B65D 
X-CRM114-Status: GOOD (  10.74  )
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

Kstate changes data in kexec segments after the calculation
of the checksum, so we don't pass purgatroy verification stage.

Disable it for now. Proper solution will be later, in next versions of
the patchset.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 arch/x86/purgatory/purgatory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index aea47e7939637..cdec5f21282a7 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -45,6 +45,8 @@ void purgatory(void)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_KSTATE))
+		return;
 	ret = verify_sha256_digest();
 	if (ret) {
 		/* loop forever */
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
