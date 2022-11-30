Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5FAC433FE
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=myHVXWULKFhfOVKyK5aVs95p/X0e51BXVMgTVsU0JVo=; b=MdeXfYIqJoj24+
	uWCMeBWHJi1lYSxuTabk42/oY0VaVgmlM+wKd1IO2jq0phWAHvlO7m8mUr1O08b7/s4Kl5s38Q1iF
	8hwexKKhlr78TtNoKRWF0uzCfbUaQLltzSBtbG3Z4qv4yArV71dfDT2eTgYgGqN5ukg9ci7SYM0om
	pHBDh8qUxNvewEtWdYCuGi6brXl8iMzIlbuEDUCS2M1CgC7WE/riVCVKDzSURMDtCAbjxiZ4Pu5+r
	hbNwzvO4o8VDkvG169jGHNM/uDNwBZ7/1BYqWtZLz+3qqe3okREGZevz0znfN0qE6xs3XDfPEZ9+3
	uFozMA+9rZculP/0t1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJO-00047y-3b; Wed, 30 Nov 2022 15:47:50 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJK-000435-Nd
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 15:47:48 +0000
Received: by mail-ej1-x634.google.com with SMTP id vv4so42373523ejc.2
        for <kexec@lists.infradead.org>; Wed, 30 Nov 2022 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=EcYtt4TvCK6BJCf6X9l4DaZy+QVb6a2ZN0d4hYVvO5M=;
        b=HkNQp9YU/g8x0KR+AJ4lyzhOvHqTcw8p0Lo+9qzPNb+bGgbOIGX+8QfYWOekwN10Y0
         j5Xy7dXUm2URn1NLg0LZ+uYuMwWrc7VWPI/adrLJ5KwaDGbDpK0KQDmECZYZLoC/ibPU
         qCk/dypWPhNOBgEQKAtUPvJGOv5/zvkocjG4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcYtt4TvCK6BJCf6X9l4DaZy+QVb6a2ZN0d4hYVvO5M=;
        b=pa9YEhI7mc2yEIxbxjoLuV+DY6VjiSeRBAn1NzeegIaKPOOKqTQzoieiSb/SFWPsdY
         jupDBZAdKfs8hQUKTAWffECZTp1rNzMHwFoXc4SV8jUvG8D9eQeqUWxOrE9nsRVHZXHQ
         wQhyLPBVYmc0uOngrkNywSyQNyQAZSmTnIKJmEuGqBQ64+g2/2uRlKpOxjcMnbpe46QM
         hF8q7dFQl3DmFToxf1aB7fk+6nCpZZ3jgtBiVgvo3TUhVNgzvuYHvRfCaCCLKIMDYui0
         RSDP/LgXf7xONNfPtvvc/TjtVXIzWslZ7imTuNYBy7iE0BY5HquJU55R+eZFwdVRow00
         YCwA==
X-Gm-Message-State: ANoB5pkyxw8aij9n9eK4lW0oll10XPR4asZLGx2LeTqfuHredLw53opg
	Es33Vq+6WUIGPdBGPvu/M+fR8w==
X-Google-Smtp-Source: AA0mqf6Z1je942r9oeXVz/mlwkUzKcyf4WjxIsYxEuWQeNcO0op0aSlw6z0KssbOi2JnutK+MAi57Q==
X-Received: by 2002:a17:907:9190:b0:78a:52bb:d904 with SMTP id bp16-20020a170907919000b0078a52bbd904mr35398243ejb.630.1669823263729;
        Wed, 30 Nov 2022 07:47:43 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:5b33:e3f2:6a0b:dcdd])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007bf24b8f80csm775075ejg.63.2022.11.30.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:47:43 -0800 (PST)
Subject:  [PATCH v6 0/2] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAJ7h2MC/3XO0arCMAwG4FeRXltZ0q6bXvkeci7SNrqCdtC6wT
 mydz/RS9nIRfgDX5KXqlwSV3XavVThOdU0Zgluv1NhoHxjnaJkhQ0iAHa65qivhfmPNTCDNYi9Qa
 cEeKqsfaEcBiF5ut9lOKT6HMvv58AM0i6ru2bQjW4764CMcxzwHIYyPtL0OIzlpn5k04zbGkXHni
 y2TEfnzIo229qIJuRInYFAYFe03db2/bk4Z313RfIrut3WrWjLUco3vafmSy/L8g/3tjM2pAEAAA
 ==
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 30 Nov 2022 16:47:14 +0100
Message-Id: <20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0IpYWvaM1nSCLes2AAhkL8u1zUltWsSBA7Q7jAHaGa0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjh3sRb5TNdySmknidfqXIO/9uwnM15fXaAOYH1a7B
 CsZYzoyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4d7EQAKCRDRN9E+zzrEiHMJD/
 wOyrlwuTrdzgZKh/vpQf1F1krDwjjxFuxAWO6DF7eyp/O92Lm0IMo6CSCttg4VXQz1Dh33wT1nsAbz
 OtCKyiQx+Uxj9D2fv4V1pxus4Bt4eaG1Q7rUMDaFOf/6+w/XOmcZCsSRc3T8b6fYlzqHi5y1pafgb8
 0J3nsBlYFU8LwiWXkVJ3FR9Q2vqc8ft/ttb9p7S9NWL96g6MxuviygZN7+SUVvLzh18h0pMXyo0u4k
 bXZJdZgj743SD5Jgq1dAC+EDo7SzwSfeMqdPv9pmTHiWLcPkAmlTCDBaG1921XxGfAwdRh9D0BArwR
 kcMFumuoEBMYPnkCcdmGpcPfoJKJ9nFV6mz2dri01o+cCf0YbCWYZRITxOVlOZgoq0hXhaK/PeAeaZ
 NmeA2bYOe/HTSDUyCqfGurAQf7WC7OFqwvd5YCQkHXBDfdEIThvDWtCqz/iE/4a/BX6zwkhBuPAnTR
 I81RRoUr6wNJ1JNAqsgDlEXsGvhalrV/EZkkIQN4PZeXedA/nm0Vxmwcv4HLy/q4O4S5uAbBBWChOv
 PiZwAjkYcVc1TZm8+yGlWkYaXA3E72DdKdi6g4fsRKXSNcX7wh3Rvtjr+3PprsuFOSbMZbqJafyvCh
 JHhakZZOqmtBsIsR4TrkSzSw9TosMuXQZxnGgsNl562FPWAnz7D2Yk+c7Ulg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_074746_873184_E1839547 
X-CRM114-Status: GOOD (  12.14  )
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
