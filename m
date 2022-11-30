Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFAC4332F
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2//kpzW07YJOAhF+Yj/ZWkPh1C5U/LLNHq2oTVEtVA=; b=pIhBFZqLtyT56s
	4Mo45IvA9njUewGENzRXBo7YDdVPc7NuizOD83KhbPFH/DcHhWGbSP5KyZFWv7K2ILLPpwZ21wptm
	GB1m0N1RakRPBFH3YEIqfDASJQxyATvkQhkTVlyY3VnV1Sgr8Zo0LRzqdoR5rhdJY5swoS6WJ2vyi
	/Qtp/VQrV5snER2LQk2agOCL/hKpracSyIIKWP+c6/GSHRVYsQP+MutIUQ1mG1ib2y1Nnn+nTPAYz
	XBl3iEEFdwERF2hF0/AUrPOervVkeZggMRSdd3YO0yPb2k10BQ3povUktbywXz2Oz+1PEzZPkiZuK
	gDvxsux3ArcKTADAtzxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJP-000495-GF; Wed, 30 Nov 2022 15:47:51 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJL-00043e-5c
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 15:47:50 +0000
Received: by mail-ej1-x632.google.com with SMTP id fy37so42284109ejc.11
        for <kexec@lists.infradead.org>; Wed, 30 Nov 2022 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpwU6lO07Wd5+RTLzDaFrlMeJKtxn3n7JzQ4dKSGqkc=;
        b=f6hF3vFsxSnGCy9wCKWuHFT0WJZyRYdEltOsfQYOfxdVzNYA56H5+kI6SDsG8Jv8iP
         xpMthqB2d9L+tvEU+8mmi4lIjO4ZSwm3TkU6BjYGKxkfEgyV/Y1KWwmQJzZXLLRuOccr
         jLgTTdIqz4gsM+g+psj9xMSLrrxOY19iAPPkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpwU6lO07Wd5+RTLzDaFrlMeJKtxn3n7JzQ4dKSGqkc=;
        b=CCelPXZm4fe4HcDx6EBUI3pV+y07tReWRLAVUhZn3NUvbvxH69oDtIOmrQBejjp82Z
         WjkpiZQkwSjeDQLc8j2/nmd6D0g0ygaAdAzQzZbsQCoAu13ZY90w2OOwxkhIpr5UZ2rn
         J+Hag0WcMvxzN33tDRzHRLuaamc+bm08mDYGkB4gF1GoDNuUGnLKVbpN19crIHSLK5RV
         /4vhTiPATRb0JQWq0TjijnAz2b58hcEcon1996AwIeDSk3zK1lcVK9OQ53h0s/eRk5Px
         F17yaIxG8XEaKHz1TRygM+r9rbdY6A4YcJb8AE7pH7dzmNsjCyvUGoKdbE9k+T41zG5/
         1OAQ==
X-Gm-Message-State: ANoB5pl+9D+TUWCZkZsdsB4KfD9cVEydQKaxGEeRCt4wTr0Q88v4NtCb
	O1HR4NqLK1AhCtjtU+6/hyWd7g==
X-Google-Smtp-Source: AA0mqf7DwqNEHgiWsouxEwORa56y6/ebKwumRyswcDnFFZOeUNCe+tAd3MtXuHm+kPXx5zdP5k9qsg==
X-Received: by 2002:a17:906:7d50:b0:79e:4880:dd83 with SMTP id l16-20020a1709067d5000b0079e4880dd83mr42393283ejp.166.1669823264990;
        Wed, 30 Nov 2022 07:47:44 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:5b33:e3f2:6a0b:dcdd])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007bf24b8f80csm775075ejg.63.2022.11.30.07.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:47:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 30 Nov 2022 16:47:15 +0100
Subject: [PATCH v6 1/2] kexec: Introduce kexec_with_frozen_processes
MIME-Version: 1.0
Message-Id: <20221127-snd-freeze-v6-1-3e90553f64a5@chromium.org>
References: <20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org>
In-Reply-To: <20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org>
To: Chromeos Kdump <chromeos-kdump@google.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Eric Biederman <ebiederm@xmission.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 kexec@lists.infradead.org, sound-open-firmware@alsa-project.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=8KNJHp4bIWX3457t5aVwfPrimmRsszM5ZU7XjdRn1bo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjh3sY6zR75vurA7LbZ/y+DlMy3+LOHJvYsQBT5ZNe
 OrXrGryJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4d7GAAKCRDRN9E+zzrEiGE7D/
 42IsMvDeI6JrkcVeMw7Hlfq60ybXBrbBYP6z6lfI2McsZDckIPRHulAy1YaBGvwleMujpo8QR/zGrv
 mQVQYgRmSc/2j1YZq+QAOeY3qRY0FBGqtTaoHMfhOUkHVWWxYzK1oltg2HO43+cIyylRYtSCfOLY5Y
 w53p26AsgVTDQ4fxK/O8jrjIkW13Jbt5WH3L37A+QIIs+kYAXvmpPtzhP9EHsAb6rSD641jnBqRWBN
 gbRcoyer/rWDxvP3MvKiV4I9ZNjo3aikeI+quK7XKCDXM1cQrDeDfqCfASH4iKEcwlNvutYUARz8Cn
 T6Cz2A8fhHfYiC2zgz9H7jkg6DbSnFtm2Qug08WDdUHpVlsEuv/RjNNNkVM3OZ2IucOUqqCnIgXyxv
 t0Q1FJf6kMOV7Ro0xS3QAYlKrKX/3qKHTvhHpzzJjTl3dGv+MDaTKiJ1gS2SEQlpTNiyMoZ9GPlHMK
 CQ/VXwvDyESv6ppBKX/2vD5RkxySkE9xFNbVCW8EhvZPTgBpROM1bBm0AMhea5nSN5WlHi43N35JXE
 JWQV0jbgACSFhMdc1LxqiQhXKKpZNV2M7draG29cUlIVxJ5ofMLzLBFWk4AykI+eXVMeXzrY515t8R
 5B0mNX5S0bm/nLJ9+PeTGx6CTZ2XUspcyg7KtBfwXj1O/SeVQeoo5rmGgVEg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_074747_243653_5CFAF6EF 
X-CRM114-Status: GOOD (  14.08  )
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

Drivers running .shutdown() might want to wait for userspace to complete
before exiting.

If userspace is frozen and we are running kexec they will stall the
computer.

Add a way for them to figure out if they should just skip waiting for
userspace.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec_core.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..c22711e0f7b5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -426,6 +426,8 @@ extern int kexec_load_disabled;
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
 
+bool kexec_with_frozen_processes(void);
+
 int crash_shrink_memory(unsigned long new_size);
 ssize_t crash_get_memory_size(void);
 
@@ -507,6 +509,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline bool kexec_with_frozen_processes(void) { return false; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..8bc8257ee7ca 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -54,6 +54,11 @@ note_buf_t __percpu *crash_notes;
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
+bool kexec_with_frozen_processes(void)
+{
+	return kexec_in_progress && pm_freezing;
+}
+EXPORT_SYMBOL(kexec_with_frozen_processes);
 
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {

-- 
2.38.1.584.g0f3c55d4c2-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
