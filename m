Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA92C63708
	for <kexec@archiver.kernel.org>; Thu,  8 Dec 2022 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+hFWZwdefMFb1TNfacELGnI5qKKytUhvM8tnewzg6s0=; b=D5gU4alZGS0/Z8
	Qst8GbhwT3xHKs9m7Ce3G8eA8IA2L+gB5ambkg98GPqd3Az0P1daf33Z7lpuCwyzn2e1+4wbnllJu
	A9nqSGN/OLiVBudNp+cBmhi9+4sUgw+4PvV7tfAyJ5Kr2sXSVsXrq2sPhl5LqreCRMXDF9Ts6bBvP
	xSD13NCjR24DxmjJP5LhrNGzXIbD+/HQi7e7NEeCAApuf6ZK9gY42cpdmqNQWpZizX/j5FBWnIca+
	5PlDyh9AGSb05aLHh76jHcGUZniLKfG6g4uXLiZbBFhKEgmrA9nsZVMiUSHUyDuSUYyO/HjrYKtg/
	mxsTFYTGYYf16ydDyfAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Jun-005NLH-39; Thu, 08 Dec 2022 16:38:29 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Jug-005N9v-J0
	for kexec@lists.infradead.org; Thu, 08 Dec 2022 16:38:24 +0000
Received: by mail-ej1-x631.google.com with SMTP id t17so5395676eju.1
        for <kexec@lists.infradead.org>; Thu, 08 Dec 2022 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ3ul1jQRXTmaEsuvA4DkzO41vWZ0ws2E+AUBitFzrQ=;
        b=k/7X3z9v4qZ29jB2yYGyTKe0hRoo77mPXZfDtm/XwjaqyLx2sHjGxg9aBpwD9Ee3qz
         Np0blameSJM60Ssvq6O9wMJFkHCAokczTYCo3ver8LXm+zG6gA+ypMSfMMzlou1PPHti
         ELRuj4yf83+9A377gSgGNh1Ubqx45IuT2Fo1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ3ul1jQRXTmaEsuvA4DkzO41vWZ0ws2E+AUBitFzrQ=;
        b=76Gk6IB9uurHgold7q2x2x0qY8/ejmTUsk/ISbMKCH2x4WTlzWM/F8X8HZMz6UEVK+
         etJhULmfYNYQcmP6jq+JiuHPtKwONJEjZaJySWODnop3f+6TWwWWuGmxqGYmSCZ7Pi+/
         lJ6vugdCHYoxt0mfrL1unv7Pv8YjfgysFUp0XKEHR7z1bpN2e4SobsfyuvqGabn8mcJY
         JszJ/MPHud7kJCXWA8v38UkYo9nwuH9ERhXV1LXMQixNm1OlPN11V40DZHHfgWQ6KUH+
         iQ8u0OzD8USWFre4KnqFxjjYFwbxGSvixyrjRTwLdH/fK+GOwMolZ3NAopnp/Est0asU
         jmzA==
X-Gm-Message-State: ANoB5pnza7MW/N2W0v9G4rpVLESLQVOBt8N9+/MmROfsQ8leqE3KJnon
	HXLJXZaiHA8nwbF5Zimxn9Va4g==
X-Google-Smtp-Source: AA0mqf7ngwJXA0LQ0pE9LI12ePlzBri7eOWpsblIAQol5/TWLcdwNMC2uMVjWTpBXXshpczBCf+Jqw==
X-Received: by 2002:a17:906:3716:b0:7c0:bbab:22e5 with SMTP id d22-20020a170906371600b007c0bbab22e5mr2410973ejc.16.1670517498873;
        Thu, 08 Dec 2022 08:38:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 08 Dec 2022 17:38:01 +0100
Subject: [PATCH v2 2/3] kexec: Factor out kexec_load_permited
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v2-2-c498313c1bb5@chromium.org>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>, kexec@lists.infradead.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=oo014ZHz6Xm+AA2th2qtraBO9RjgGW/IoV0rNAHz2pg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLz9anViJqu4KFmbxZAiE4U2e9028qdN4mFsCU/
 1AN51y+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS8wAKCRDRN9E+zzrEiA5dD/
 9Pnutdugl35mpmsNND3wkKYkKNVhDCU8yN/9efaLGUCOX18rdNdmF3OzB74ulcQOMbIr2OtHsVwpo8
 774SGkYfiSh0s0ZSNKxDlPkWagoP/wxCj6puE4NrwNwCTkvB3kzOeS4FZClutvKDzN/fds75Ulgh9N
 S1EjqrWZhSjN+O/xNJmUUun3CDqvmnmT6D2U+mTDX8RqDAEAp1bNjEObBHgL1hVqYifBtLOZS667yS
 YLSakIjNXJt2J+TIHfM0r+gMO7RIbhNef66a9jQ4Xg2BLiReHsLjFTbeU9C3K9GHvPqkIk1kI/FJ88
 MQRmL8zMvoSiStw8sG5VHDDS/OFaWUCl4rtasmT+CtoQ4EvL17sn42HGV64EDP0kIERzVUnmnQXxXv
 8G/IblodKjK7Yx8/ABySgL3/I3sV1HAwgA0Nfnc6NhEA5yjDHQx//rajtVLww7eodwn+zhovNohNm1
 AVd1ovekbd3kDn1Wtpz00x+ED5qhmZaNi1+IA++Kk+l5J/Uzk1GiY8zAhVg7s07Jky/3/c7XVrCRhe
 rfGeUjRbUmaQnUpA9r7+4wtRsHWQerSnZK6D3nVj2Kz6nc+1Sv2os3AMUPdrbXpKNfHSRzc1QmqDDm
 W2PLGlbTyb6BM1UX4yi0LbPbZivH+/xZAuHbRinNocOiAsO8108osa8eKAAg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_083822_686165_71F0FC9C 
X-CRM114-Status: GOOD (  15.32  )
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

Both syscalls (kexec and kexec_file) do the same check, lets factor it
out.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/kexec.h |  3 ++-
 kernel/kexec.c        |  2 +-
 kernel/kexec_core.c   | 11 ++++++++++-
 kernel/kexec_file.c   |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..e9e1ab5e8006 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -406,7 +406,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
-extern int kexec_load_disabled;
+
+bool kexec_load_permited(void);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..d83fc9093aff 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permited())
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..18bd90ca9c99 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -928,7 +928,7 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
-int kexec_load_disabled;
+static int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
 	{
@@ -952,6 +952,15 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+bool kexec_load_permited(void)
+{
+	/*
+	 * Only the superuser can use the kexec syscall and if it has not
+	 * been disabled.
+	 */
+	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..701147c118d4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permited())
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
