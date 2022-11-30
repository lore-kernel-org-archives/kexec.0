Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24886C4708C
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bGW9r/+BC46diN9HaE5GVMT+rwMB5qm2B5Qod9z+Wto=; b=vjubXZxln1VG0M
	fIzH31u79HUBAtIdOislaBFUbw3mNh7IcEIS4Spp94FFzRyiOr+vEJGc0kj+f3N0HgW4/Q9E8yQ+Q
	4Q9AY5XAsj8p6MvK3eiKgSViWkcQFZObASMGeL94vdyoe98P198uRnEQ7cO5c7LsOx6Y9M5shpo6f
	3FcDaG4UDR5iOGHj2KqVHWoiaosGdpoyvqFJcLUanoomxd33S2XFjOoNLhxs9rKyAqrWU/0G5Kduv
	1ekgJCBt8AHbPD6H2Rnzpbf8Q+20SX3Gl/HeOcTCZCHCaQfzNCQmH8rVCTfCIDpKIzy5crFMybX/C
	zECii824ChmPhplLhCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Py0-000SX2-5o; Wed, 30 Nov 2022 16:29:48 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pxw-000STv-6o
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 16:29:46 +0000
Received: by mail-ej1-x636.google.com with SMTP id td2so28536908ejc.5
        for <kexec@lists.infradead.org>; Wed, 30 Nov 2022 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw5kShSF3E0E3sfHSq2rS1swDqNHSyrtWf4koh3J7SU=;
        b=Kk+o2yEg5yzW1D+dnF/cIcgc8Gk9rEgcTR8uPovDjDPf1PkKrRWq/BDqdOQ2U4PJof
         ZYGyAjHsFgdoX7pMpAU4oGFrUDqQMiu5dEU45Q/vOO5Tz9XhHc2ar79+I0QgPDAmMc8x
         s4z36cBy3fIOu4yKj4AB0btoe+F32/JxNjF18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw5kShSF3E0E3sfHSq2rS1swDqNHSyrtWf4koh3J7SU=;
        b=dp7K5imvP6qNbo0MoRfLZMHdyBUirM4K4Z6weosN8AluaDLDEd6xf9aU+O6MvI2iiV
         6TDv9wNjvj+5fu13hlvcVkuoNe0ZMMzPl2dgHqXy0ZQOafVPyLYIfRGvRrB+tTwfOjq4
         aQZDyz5MX5QnBDLnWyLbevHqqW+lrBxbkYCpWgePDxRyWQN2me2y5568MdfUzaqUUMWM
         VOmX4KC6tRyidSFrT7bfBHiYecCYm37yXp/yaWbzAc1z5XqzB0VBKhgvkXMi8HmIuk6t
         gqWTp4u2FY7LfXDXIXoLTWD2jRnKE149Y/Pau2FRG/75s2SLsukQS8s+JaopjpGSnh+M
         wHpg==
X-Gm-Message-State: ANoB5pleDVARfqeg1EUs4Nnb8IuOt0n3+JjF5w8VTuRisq0kz3eKzIlE
	TEbUmxnMaj1qHvLnTOtS9sQP4A==
X-Google-Smtp-Source: AA0mqf5Uqj/CD0/FukZXXIc0vRyTLddNiAbe2JXdXsEHuMwbmXDMwhTREvJcq30MxLXV+1w0b73ssg==
X-Received: by 2002:a17:906:2302:b0:7b9:de77:f0ef with SMTP id l2-20020a170906230200b007b9de77f0efmr31418299eja.5.1669825782653;
        Wed, 30 Nov 2022 08:29:42 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id cz15-20020a0564021caf00b004589da5e5cesm786114edb.41.2022.11.30.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:29:42 -0800 (PST)
Subject:  [PATCH v7 0/2] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN+Eh2MC/3XOzWrDMAwH8FcpPs/Dlr/SnvYeYwfZVhpDm4C9Br
 aSd5+247DRQfwFP0lP0agWauJyeopKe2llWzmEl5NIC65XkiVzFqAAtIYg25rlXIm+SWoibQ3AZM
 ALBhEbyVhxTQuT9XG78XAp7XOrX38Hds3tvbtr11JJF6zXaLynBG9pqdu9PO6vW72KD960w1gD6z
 yhBUd49t50tBlrwxqBMgajE2rb0Xas7e/n7LyNYQaMHe3G2rG2lLmimiKqjvZj7VkbOivnzOwtun
 /6OI4f1ZmnceIBAAA=
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 30 Nov 2022 17:29:19 +0100
Message-Id: <20221127-snd-freeze-v7-0-127c582f1ca4@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Chromeos Kdump <chromeos-kdump@google.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 kexec@lists.infradead.org, stable@vger.kernel.org,
 Ricardo Ribalda <ribalda@chromium.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=fWR7ZhQQr5ar1fWGLk9Z4Z/KnsEAhZyZVnGAD/1s2QE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjh4Tj1YJB5e2N7FcWhOjD8LaBqVFgwZ6IzdIM0xvp
 aiGFuduJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4eE4wAKCRDRN9E+zzrEiCKbD/
 9ABaeeu+udLacBhMTu+U8I0v2fMtTFzWs53fP+KTDnJE63jhi466UEK2Eu6YjLxuiFFGwoA1H9rm2F
 K2d3T8RyD7FP9KkvaYEU3hdCAqEoYCWqTpseaJwBD1p0TGN2KlklISkClKwEecScrguxuDnBpNc0AO
 IguSucJL9GHuRLPh2bmPzfqk9fXTmWHuXvMQSEbTFm08p7/8tnXD6c4DrF8y2kEkP8UOMYwRvlL3IL
 jQClmEBBVFU9iGyCJlDnZufqBXd2FKl0G/Lle5yT9G4Aa8mXz0vTp7S4ESFrFPTVuZ6cr9a4BeDxF1
 j/q77JY7hvMgmblwDTVpIZPgjoMeNhRvryvPDahtEaj1ysEwkwVR75y7sOPJipu/zHaL/G+c2hL8sf
 efcLlAxITUlGn+K0htYH8F5Rwc3rgK+wmpd/KyshA1HS0vjx9os/T4qJXAoPcLo5v7rXB4nJs/udeN
 NcI98QsNdnRVKpAjwvU8n+jhscLK4Mjf6WXo6ho5aWnkGpRU/bBcaw9IprIt8saDDtjAElFH7/nEL/
 nAx/38CAt8kk5W9Ps6ixILZQLU0QpH9FGz9idFMKpPOQBQaCxbAGub5JOXKA971+4QARa0ecT9mNoh
 HunOaLUT93bmfokQX9++oCdDrS1PKPCPc5SCFGB0AR0a2iI5fzOf3jzWj4Sg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_082944_308437_DA2554B7 
X-CRM114-Status: GOOD (  12.11  )
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

Since: 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
we wait for all the workloads to be completed during shutdown. This was done to 
avoid a stall once the device is started again.

Unfortunately this has the side effect of stalling kexec(), if the userspace
is frozen. Let's handle that case.

To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: Eric Biederman <ebiederm@xmission.com>
To: Chromeos Kdump <chromeos-kdump@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v7:
- Fix commit message (Thanks Pierre-Louis).
- Link to v6: https://lore.kernel.org/r/20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org

Changes in v6:
- Check if we are in kexec with the userspace frozen.
- Link to v5: https://lore.kernel.org/r/20221127-snd-freeze-v5-0-4ededeb08ba0@chromium.org

Changes in v5:
- Edit subject prefix.
- Link to v4: https://lore.kernel.org/r/20221127-snd-freeze-v4-0-51ca64b7f2ab@chromium.org

Changes in v4:
- Do not call snd_sof_machine_unregister from shutdown.
- Link to v3: https://lore.kernel.org/r/20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org

Changes in v3:
- Wrap pm_freezing in a function.
- Link to v2: https://lore.kernel.org/r/20221127-snd-freeze-v2-0-d8a425ea9663@chromium.org

Changes in v2:
- Only use pm_freezing if CONFIG_FREEZER .
- Link to v1: https://lore.kernel.org/r/20221127-snd-freeze-v1-0-57461a366ec2@chromium.org

---
Ricardo Ribalda (2):
      kexec: Introduce kexec_with_frozen_processes
      ASoC: SOF: Fix deadlock when shutdown a frozen userspace

 include/linux/kexec.h | 3 +++
 kernel/kexec_core.c   | 5 +++++
 sound/soc/sof/core.c  | 4 +++-
 3 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-snd-freeze-1ee143228326

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
