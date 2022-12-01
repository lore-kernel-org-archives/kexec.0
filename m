Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA2C4321E
	for <kexec@archiver.kernel.org>; Thu,  1 Dec 2022 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dgkIdh0BQHitfxv4AzHFqhmj69RNzkc6IDckceKMc68=; b=RXbB4kYp/XPrBC
	Q5whuhmRPZRuM4Uq32IGeCFafTLr4DFp4adl7233MdFO8O4Mkg5zOYfji5W4YYVfZ//yXUmAbpoT5
	tVBOO8+fEvSVHUVxgRrr+HPhZwn+VSOFhxICB/GnRFsHWkGgniKyZsGzdrid4lASkus9VnaxRZYJo
	lmUCK93uPFQX0o2vDP+XKLjpZ1Kk7KDqUdZXQrO7gjYIXdu9D7UZNkzW5lg4Z9VVWS734Ml8do+s3
	UtPKiY1vh1GPTxrFTCQ7Twmtv90nclSx49ThX1pndlH5jLhcKHdSHWM4Br1FDpsHHon9iqbh1JT9E
	eZIk80A7vIW67GeEObHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0hWA-006zLl-As; Thu, 01 Dec 2022 11:14:14 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0hQu-006x47-2c
	for kexec@lists.infradead.org; Thu, 01 Dec 2022 11:08:51 +0000
Received: by mail-ed1-x529.google.com with SMTP id d20so1968668edn.0
        for <kexec@lists.infradead.org>; Thu, 01 Dec 2022 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=lGm4cyBDbhcC+E+E+8rSuqE3igb1lprN1pN6/M3QLys=;
        b=ZRHyoajEwFC4By5LI1rVbOp/xLGzBq//9Xi/KMCz0lo8z9Pc1kxGrZQGSfdmpQmaMd
         1GnniREAshZoCU4tyHuy1piJbRVEDqwJVixje9ZJzJ77PtUXKFFljT/b8/IV0BWReOGd
         SqBdcc0wshVkJyGCE+uvwuRmeLcgRNVAq9pdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGm4cyBDbhcC+E+E+8rSuqE3igb1lprN1pN6/M3QLys=;
        b=NavLCXpzQDLagSGbED6T9YjS2KFaBwic9YUcyzwl4YoX5Zs7XZYX7VkcgmppRdig0B
         9dOP8eFwoHYI4JzbdRMREzZl+uJ9rRMs08tqfD1lzXaIDakN1FSWRC+bD2X27Wbk51SF
         8V/34zSsPEfGicG2W4pduuLdyIfYTP45qIqd38RZyLAoEbvnhYbwtvwXQ7ns+tkliyGc
         MZyGM+iApniaeLpq8/JiWb8LS4S/h8ZoWui1Lh8wj2me5ma56+vWfcbJzBRGX2TFAGA5
         szzHEgsw4Xmmx/B9d4EcFpQyfztsmUiMDsntSdpLQmZmIcEhqA7MOtrcb76w0V4Sdd6M
         3EqA==
X-Gm-Message-State: ANoB5pnhWIDRvB2Ip0WevZi8CEPsSI+qAcpls5R/5jWErCpMQXkPrt5Q
	68nytQw3FMRhUqP5YfKt3BYSsw==
X-Google-Smtp-Source: AA0mqf5zzNn9de5BfFPh0J6RLCpw0dw9HFYWDLvw7kVxPfSHwhQH5HyYQ8cKCqwRv03JB5G51Q4CsA==
X-Received: by 2002:a05:6402:4516:b0:467:b88c:f3af with SMTP id ez22-20020a056402451600b00467b88cf3afmr43151776edb.24.1669892925587;
        Thu, 01 Dec 2022 03:08:45 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:f554:724a:f89a:73db])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b0078e0973d1f5sm1663824ejd.0.2022.12.01.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:08:44 -0800 (PST)
Subject:  [PATCH v8 0/3] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACSLiGMC/3XPzWrDMAwA4FcpPs8jln/b095j7CA7SmNoHbDXwF
 by7tN2HDY6CAk+/TxFo5qpicvpKSrtueWtcBFeTiKtWK4k88y1gAlAKfCylVkuleibpCJSRgMEDU
 4wiNhIxoolrUzK43bj5prb51a//hbsitN7d9au5CStN06hdo4SvKW1bvf8uL9u9So+eNIOYw2s54
 AGLOHZOd3Reqw1awSa0WuVUJmONmNtfi9n50z0C2DsaDvWlrWhmSNOIeLU0W6sHWtN58lavTiDtq
 P9WHvW3Es2wMIP/P/7OI4f/KJYEyACAAA=
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 01 Dec 2022 12:08:20 +0100
Message-Id: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
To: Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>,
 Chromeos Kdump <chromeos-kdump@google.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Len Brown <len.brown@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Eric Biederman <ebiederm@xmission.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Joel Fernandes <joel@joelfernandes.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Pavel Machek <pavel@ucw.cz>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dexuan Cui <decui@microsoft.com>, Takashi Iwai <tiwai@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org
Cc: kexec@lists.infradead.org, alsa-devel@alsa-project.org,
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org,
 sound-open-firmware@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Rud9IUdbPKIRkkkE6G4uaTZbcmuiccX+lZS5manvrHM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjiIsuiQZl7CGQiKdplkqC0gHCzURIkJXoavQjeFfS
 sEPmEE6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4iLLgAKCRDRN9E+zzrEiIaWD/
 9SLVqH6ELG3Nj4DmzbcOc+YbsFvyvs/zS4DGTKOm4a1dsJ6EojOhIs9fpuGLT8o3p3+9VsWHC0In/y
 k6Iuhsi7YI2K91jtIDrxVIf4dUlmsglcYsc4qe5s+tqH0tWT7y7OlpaNM4+W605lNX2FMTKjGgKfHe
 jHVMfBfB0ebLbt7OhLXieR55yYucbmtChn3v49MHNc8u6oY5Zy9bC4bNkMJDJtd+ce/qqb8Bp4QeMA
 rOQjtJMeieO5qtXaDb8EfsUc4gu1PYL42HfoTN2sr18FL9SKNzVejr4Jq0RhUCNg/rf+Oqoqn7EEmV
 sjud45VDHbBcOD8OQJa/GQAuRwLJQYje6ycI76nIB/gnEiR08+uB3nK3tlAkKMMWbb4wS5vuWnCX2U
 3YF/ZK8xWASICm+G0JmfVBdajYCKUxaboXr7DPbP7oCUFU3bLEQqtBpNgeyfU46D4Q0gnTD8/frbVt
 UgY++3lpoKK+Pxg3zbTIKOvN4fumazPJdSB+a586EbWiw7LhOtWns3EsiPZqFybXoW0BptbVq0Aqan
 TLmIsVZkJSOl85YER762XGxsWyl9LeYioTLO/h4ozDLEbfseFlKxfz67nGgS7NBgsHBJDuc7Pu2/XP
 dfaTOEkimDz87TdwqvVEa5v67H9Ve4p2lif6Z3g7ymf71PA6yB0dtq2z/ZqQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_030848_301249_E07D2FB8 
X-CRM114-Status: GOOD (  15.22  )
X-Mailman-Approved-At: Thu, 01 Dec 2022 03:14:08 -0800
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

To: Joel Fernandes <joel@joelfernandes.org>
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
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "K. Y. Srinivasan" <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Ard Biesheuvel <ardb@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: stable@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-hyperv@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: linux-efi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v8:
- Wrap pm_freezing and kexec_inprogress in functions.
- Do not run snd_sof_machine_unregister(sdev, pdata) during kexec (Thanks Kai).
- Link to v7: https://lore.kernel.org/r/20221127-snd-freeze-v7-0-127c582f1ca4@chromium.org

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
Ricardo Ribalda (3):
      kexec: Refactor kexec_in_progress into a function
      freezer: refactor pm_freezing into a function.
      ASoC: SOF: Fix deadlock when shutdown a frozen userspace

 arch/powerpc/platforms/pseries/vio.c |  2 +-
 arch/x86/kernel/cpu/mshyperv.c       |  6 +++---
 arch/x86/xen/enlighten_hvm.c         |  2 +-
 drivers/firmware/efi/efi.c           |  2 +-
 drivers/pci/pci-driver.c             |  2 +-
 include/linux/freezer.h              |  3 ++-
 include/linux/kexec.h                |  5 ++---
 kernel/freezer.c                     |  3 +--
 kernel/kexec_core.c                  | 12 ++++++++++--
 kernel/power/process.c               | 24 ++++++++++++++++++++----
 sound/soc/sof/core.c                 |  9 ++++++---
 11 files changed, 48 insertions(+), 22 deletions(-)
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
