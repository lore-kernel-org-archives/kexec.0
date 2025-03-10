Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C3C35FF2
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8DAP9eUkaG75fkMO+dR1XpuCnXAgRk3qwZNeEbFzSE=; b=uwalFxXlIioDqz1WEI1nVrDbn/
	O7RJCDwHkRj/lxF4xwD7YlyxnRskwNOPwhccsID9TRUp9R8vGIob0PvPEIcIhwWKf1FpnqaLH0+8o
	oo6cMfHGONSAXI75Pak31k+UNPAQMr86nW2sGt29MCAYOod9S1wwTB3W+/OCr8aUoMVSDLYOukc1C
	h9wtAIevI8PTqjGc8HWcQhfTbgi2E+Y75OoH+PN8dxyLBGmET3uaLaKMGgrzfpwAXI6mZ/xb4HRuM
	Mr0w4CtxNaimh5ExgTv3Mk0Jv2j0hOGezifA0AjZ1IK28C9RZ7mCRweLAeRcCCLKDwoJrLe4RxxWS
	q/W/FORA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trc42-00000002ZS3-412u;
	Mon, 10 Mar 2025 12:16:58 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trbrk-00000002WIK-1KKd
	for kexec@lists.infradead.org;
	Mon, 10 Mar 2025 12:04:17 +0000
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EB62A60EA5;
	Mon, 10 Mar 2025 15:04:14 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-4JGepy3f;
	Mon, 10 Mar 2025 15:04:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608254;
	bh=x8DAP9eUkaG75fkMO+dR1XpuCnXAgRk3qwZNeEbFzSE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=X8XMfwpKpDu3TGM8eK67J+BXWD2pI0JbT66tVSPMZZ0DiCY2JiXh7/uXc320kZaMU
	 IJHEWFV9cPloQKHvb18wQ0KuvOvE+q0ePmRIbCRYatLzo/haokQJ41l3Mfs/0sOpwX
	 2f3uIuhOrLk7paFJV3a+Y4xsnqPm9YHI58QoRTVk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
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
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 6/7] kexec, kstate: save kstate data before kexec'ing
Date: Mon, 10 Mar 2025 13:03:17 +0100
Message-ID: <20250310120318.2124-7-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_050416_522660_736250D7 
X-CRM114-Status: UNSURE (   9.88  )
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

Call kstate_save_state() to serialize all the required data
into the kstate data stream.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/kexec_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5d001b7a9e44..7dcdaee14bfa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1017,11 +1017,14 @@ int kernel_kexec(void)
 		error = -EINVAL;
 		goto Unlock;
 	}
+	error = kstate_save_state();
+	if (error)
+		goto Unlock;
 
 	if (kexec_late_load(kexec_image)) {
 		error = kexec_file_load_segments(kexec_image);
 		if (error)
-			goto Unlock;
+			goto Free_kstate;
 	}
 
 #ifdef CONFIG_KEXEC_JUMP
@@ -1104,6 +1107,8 @@ int kernel_kexec(void)
 	}
 #endif
 
+ Free_kstate:
+	free_kstate_stream();
  Unlock:
 	kexec_unlock();
 	return error;
-- 
2.45.3


