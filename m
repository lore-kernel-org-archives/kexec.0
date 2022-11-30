Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2492C352A1
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gtUdo4br5ECxY7FTSIhHEV7xsAcy+e20mLu0fGCTS5w=; b=WTnpqlt6YkhXTp
	q2JnEh1C3YLiEYT8iNP20J16N7TEyp5e4LBL9SsXiPMct+2D6FpRDgXIqktfYjKue413f1as3oW3J
	aAxTmCvdEQ3iiOb9WLwzsgb0md5rrDnKCw1b+JsnKk+tq0gIMkQ2he1APhY/w9ZfdlUPOHmTKHfCe
	IfRnIKgcdEzm0dUkuykt2wOSXNhgt6IPaQncyBV+Fee5NVDvu37Rtf7YPF/omPDo+duVVG7TfEiFz
	h1vN5bvueEGDe20iwo655b3jeiibdqRq1Wx9SNdk450cUOS8wULKi7jfurMVhLrJ46eDRQsbVA4jn
	HDovkQQv2KMgS3PJ6Zwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJQ-00049W-LB; Wed, 30 Nov 2022 15:47:52 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PJM-00044h-DK
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 15:47:50 +0000
Received: by mail-ed1-x533.google.com with SMTP id z92so14168024ede.1
        for <kexec@lists.infradead.org>; Wed, 30 Nov 2022 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fLIsVAH72GYN4wSnEbMTMIto1VdntwqvQJh4XKX1N8=;
        b=RLfl+m/7E/E0w+XzZDQvyhYuzJclHPZLb/xSf+gTZ1X7y2BNXGynHFx0l2nbPf2//u
         QVuR8KoO0bXq/0ozfPU06OZ1ONR6QEfqUq2KJ24AvftES2ghu4Sqfn2ST/mcihAn89Nw
         DoGH5G8fkqo6dsa7Pf7WSY5UXM7UtHAfjZSvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fLIsVAH72GYN4wSnEbMTMIto1VdntwqvQJh4XKX1N8=;
        b=a4SD7OdHiBeue25RdFJkWsMhNm8+ivc0CYMuKZeXokItTkF1nwyDgybDs3GgPzc3RH
         TCzVyZclJRethGn3e/LLQFETTyf+dZ0cdPqhThKvxPXhCZdC+NMaVRPoKgPRuUtURWT7
         0tnemQxIRfkc10JLZhc+IqaM4PbN3oFAOVV//RQXQ0ikGYW4y70bz2v2/WyIGwRDULJ0
         MlJBF7l40Cuh/7Lj7bTI1CT5L840/5smgkPVMDrg+oy8GShnMVSqjbUfvXWMIcFFWny2
         YZpMm8CrYOaSn9CwOgcyXIi024v1SD4tyBzbPnBmN4In9jOR5p6bRjCitSSTY0KacmUA
         UrKg==
X-Gm-Message-State: ANoB5pneKnAFCc92a6EqCT2S6M5Aao6uIbgc1dyxMtueX83M+78RXyMY
	S28lsTLtEJ0srM+MVKXT6QuWBQ==
X-Google-Smtp-Source: AA0mqf4IYiD9H16IuGz/np51rmxmX2exbBKAoU9sx6CGbOo8xnMm+kZ7DVDgJ9emxgRoPNGt2ivddw==
X-Received: by 2002:a05:6402:1f85:b0:462:2410:9720 with SMTP id c5-20020a0564021f8500b0046224109720mr12193484edc.84.1669823266173;
        Wed, 30 Nov 2022 07:47:46 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:5b33:e3f2:6a0b:dcdd])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007bf24b8f80csm775075ejg.63.2022.11.30.07.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:47:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 30 Nov 2022 16:47:16 +0100
Subject:  [PATCH v6 2/2] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
Message-Id: <20221127-snd-freeze-v6-2-3e90553f64a5@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=z1BRJ78WvLmPHnisXXoQjw9rs0LQQZ8YHVqPdLBDGn8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjh3scbdrJzfpRqMNqZtaSFQjjhLnKBxlJMQeOOkOM
 m5234GiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4d7HAAKCRDRN9E+zzrEiN/ID/
 9+jG5ZH/OSbpevz4Xx7ZmZUrjhaPMR5rVP35OfUsqfj/ADrCAhJC2vlwQpcs2lie7FAUKfb1BM4VWQ
 7EozfqEAJPYlbN6HiKf8Xidp9z8sW4/g/0gSEQ60cMBSEnM8UlVrqt2eFXi4ARZeoUzjr58IEXMjVu
 Rr37vapYJMliIJKpJ8oI3Bn8vwDFjC1hLjhEb5ZgTCIESl+/ZZb+jfCIlS2qytNrH4zjpoX5Hk8QZR
 GiiHXMQVXR/ynfZbB8tJI7mn024lZ/0OWniech+uJArvwaJxOM5zt5kxzweiQ9QH/L6IwPwzhfSYJV
 i2rmkKdEI1PYKK1MbUH0ep2XRYWO/B8w8MHBLK6JsqA8fSwJ+5YRMAnN96rHs7hUD6+J8P7rPrkkO0
 cIpHzcnsBkm8JJTTLEkkQI8gzeNzRjjW8yNlqoFnQnR7wi+wgcKAGzESkwWWysMGq7kvLU7+Q6Bwn6
 T9c+1s/pVqGANlQ4BuVOKgO1pgLNzRqfef1yz7c53cJ+VBHCGYGOZDIc29r/tH+Cep1mpSbhJSA2vj
 IGcfgZhuOGIhR9dctOZ/M8+g2BC5LwhhncH5hK6xPdecknFPpzElV3oXw8U8w9FLa/Bhgje6cPjGmS
 Phput94//O2tfEsQ92F9dOxUP5sj5cBNz6LJljSdByoRowt/YVTcfvnHkNkw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_074748_482759_D81847DC 
X-CRM114-Status: GOOD (  12.23  )
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

During kexec(), the userspace is frozen. Therefore we cannot wait for it
to complete.

Avoid running snd_sof_machine_unregister during shutdown.

This fixes:

[   84.943749] Freezing user space processes ... (elapsed 0.111 seconds) done.
[  246.784446] INFO: task kexec-lite:5123 blocked for more than 122 seconds.
[  246.819035] Call Trace:
[  246.821782]  <TASK>
[  246.824186]  __schedule+0x5f9/0x1263
[  246.828231]  schedule+0x87/0xc5
[  246.831779]  snd_card_disconnect_sync+0xb5/0x127
...
[  246.889249]  snd_sof_device_shutdown+0xb4/0x150
[  246.899317]  pci_device_shutdown+0x37/0x61
[  246.903990]  device_shutdown+0x14c/0x1d6
[  246.908391]  kernel_kexec+0x45/0xb9

And:

[  246.893222] INFO: task kexec-lite:4891 blocked for more than 122 seconds.
[  246.927709] Call Trace:
[  246.930461]  <TASK>
[  246.932819]  __schedule+0x5f9/0x1263
[  246.936855]  ? fsnotify_grab_connector+0x5c/0x70
[  246.942045]  schedule+0x87/0xc5
[  246.945567]  schedule_timeout+0x49/0xf3
[  246.949877]  wait_for_completion+0x86/0xe8
[  246.954463]  snd_card_free+0x68/0x89
...
[  247.001080]  platform_device_unregister+0x12/0x35

Cc: stable@vger.kernel.org
Fixes: 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 sound/soc/sof/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 3e6141d03770..4301f347bb90 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -9,6 +9,7 @@
 //
 
 #include <linux/firmware.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <sound/soc.h>
 #include <sound/sof.h>
@@ -484,7 +485,8 @@ int snd_sof_device_shutdown(struct device *dev)
 	 * make sure clients and machine driver(s) are unregistered to force
 	 * all userspace devices to be closed prior to the DSP shutdown sequence
 	 */
-	sof_unregister_clients(sdev);
+	if (!kexec_with_frozen_processes())
+		sof_unregister_clients(sdev);
 
 	snd_sof_machine_unregister(sdev, pdata);
 

-- 
2.38.1.584.g0f3c55d4c2-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
