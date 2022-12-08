Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9CAC3A5A7
	for <kexec@archiver.kernel.org>; Thu,  8 Dec 2022 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=haoN+nZB4e2uf6O6WwUiBL5JLJaIhepz+aH0NxKjHRk=; b=UezwuHKsFtEHpD
	gDg+d5D9B4HdtUt5U40r08VtVdlFKqbcMHDTkhuyx6mvOHTI0xn1BbAToZ957ZpTzJHDUrIks/bv2
	KNyD7tg3xMdDZtfVHwUIPJ6LSo6PnBMk7HJfcCfKLWzKOObHnjn0fYBP2Vng7KZjq1MTMMjo3KbXj
	1rmbjw+tQTpNkLsJBY/fnbVxLbiw7XY3MCjxFKeh/nHd0VFWNT0hUkmiTM9hGfKsCH4S8BPVlIwb0
	Qgvq+Mk0BZW14Qtr8wMzUkDdQOVO4yOGRR+XGMo8lYOtFiDBO+38vMdL+vCNe1CP3867uz03nD5X3
	nmWVPoIRsaUppIaXcSHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Juh-005NEE-Ob; Thu, 08 Dec 2022 16:38:23 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Jue-005N3y-Dz
	for kexec@lists.infradead.org; Thu, 08 Dec 2022 16:38:22 +0000
Received: by mail-ed1-x532.google.com with SMTP id v8so2559501edi.3
        for <kexec@lists.infradead.org>; Thu, 08 Dec 2022 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtUGB6deKRvn6QoEmSpDe75lDhRqv61wD41Q8wWa80=;
        b=luem0n8WFWkWja2+Lv9JWQ+NtS8d+lsAB1pdwuXlv1mobiAy5zJwV/OlL3+I3f3okx
         mwUsp+3XwMnR9KcjNX5CdaIDgWQjlwa7WvLFcRcbUNLwdlM1rNeRmyLA/1mWO6Yx5yNb
         M1slKZeooAQ/yUAV9jsI6EUZVVK5GkIXh06Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOtUGB6deKRvn6QoEmSpDe75lDhRqv61wD41Q8wWa80=;
        b=t+8qLGsEFM8pmlRgDMiawR/Za+9BD0aCmfMx+QGhfJOGSViNRDvT/JQAKaAXz/sJmS
         qSeDwXDiwchaWOkHNmBw1uTwEOOiTCSxuyxeyKvzkV5tBmX/2Ir0bya98yQsJZHNgIKq
         L2oGxcUZJ9t/tusu2ePzH9DK/Qa7pAS/rz0t0+E8Nn+Mpskp1zZwNwb0w3LREntgeZ9W
         W1qK7Hc5hRFXm83ltSa+eN4US9xoptCYuKJ3UzzEsak1EKKiLQDeo8Wo7zOn1ufNxslh
         +aPPboRBaWJbDZikjX6jqKYGiKCvvFKCxxwxNIHiJPpF3vk3HpKyfUuSo1nhkdn2/Ed2
         MriA==
X-Gm-Message-State: ANoB5pkeDY4rFGd00xsoWdL72OWcAtlIGgCkTygkmNzYxxY/qYXi+sFc
	Z2Od4AB3BqAHJJrM5FupBBPxfA==
X-Google-Smtp-Source: AA0mqf6OBO9M0R4/tfeQ7wCA5W1m2OqhyRTihnaGWK/QGkoR17B6i0FAiHXfxux+B4+6fGussdqmUg==
X-Received: by 2002:a05:6402:550c:b0:462:6ba5:7215 with SMTP id fi12-20020a056402550c00b004626ba57215mr2498559edb.32.1670517496878;
        Thu, 08 Dec 2022 08:38:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:16 -0800 (PST)
Subject: [PATCH v2 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOcSkmMC/32NQQrCMBBFr1Jm7UgnVVpdeQ9xkaTTJlgTmGmLUn
 p3gwdw9Xkf3v8bKEtkhWu1gfAaNeZUwBwq8MGmkTH2hcHUxhDRCfuo1k2MT36zR2HlGeniWiZqm6
 YboJjOKqMTm3woblqmqZQh6pzl83taqcT9/+hKWOPgztSb2g9dSzcfJL/i8jpmGeGx7/sXh46T4b
 4AAAA=
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 08 Dec 2022 17:37:59 +0100
Message-Id: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>, kexec@lists.infradead.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CbpfLIuX926ztJbaYvtqTfAOAnBai/eNkyo5FXq7sBA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLppvk90Qatmkolw5wibtDPfBL94H1JvWQvB3WN
 cRKiW5CJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS6QAKCRDRN9E+zzrEiE+MD/
 4jdZg1kfEyEVoTWZAnJ1gKb1scJhScOKm2An2e7s036FbeW+77cKX3+2hRGFOoSM9Q0WJiqkrps2hE
 ZuwISGYDHOVPv1cCAeIMKsaI1nzfqxS0lkdJfh/DVwdMhFCzMwUvzc/dI0cc0ul4qlDeJ1dWLIO2cV
 kxIMUfW5TTza7srzsy0xrrh8WYp+6flBKUCurqA31vYd+BjjzByskXJM7Eor0H5Or/nlTur+ARZrfC
 WeIw/AkROr3dp85JtTcE72FnTkvzMLuz4qesZQYZ4QtGbxRd8sGQLyqDpFAKAizhSoTb4FK0Ds5med
 c4mphKC89svw+/N5CCmsKkm3murdJCVOeMw4OmOsN4iElzjRG91EuBwfjZhLHalLBPT1F93fXRBSP0
 wXVb7HYBRA4Np9kTesGVp4D7QFZB1GQMx3zNfVQqkkAUbNl/VSqmRTJlOzHzUg2nXg964WGpAJ8esG
 DXVUAcdwgvwr7EjTKMcf/RkVMMbjR+wVX81hOQzYZC566o2Ai6l6tn+MdsAjE8lFxHGe4JIwhY4QNa
 ID8Oq2Uke1TrIsB61xgGjEuhLUUL+72eAO5vSkF/sWfCMGrc/9hZnWCaXlofTQYbhvxxt1GeoaZPWn
 h+x13mZFFA0wbhl57zPeqFvTIPojayferH1Lc8pZxfGwUlqCndwqqw9YdV8Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_083820_535392_C2CFF9AA 
X-CRM114-Status: UNSURE (   8.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add two parameter to specify how many times a kexec kernel can be loaded.

These parameter allow hardening the system.

While we are at it, fix a documentation issue and refactor some code.

To: Jonathan Corbet <corbet@lwn.net>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ross Zwisler <zwisler@kernel.org>
To: Philipp Rudo <prudo@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
- Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org

---
Ricardo Ribalda (3):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Factor out kexec_load_permited
      kexec: Introduce paramters load_limit_reboot and load_limit_panic

 Documentation/admin-guide/kernel-parameters.txt | 14 ++++
 Documentation/admin-guide/sysctl/kernel.rst     |  7 +-
 include/linux/kexec.h                           |  3 +-
 kernel/kexec.c                                  |  2 +-
 kernel/kexec_core.c                             | 98 ++++++++++++++++++++++++-
 kernel/kexec_file.c                             |  2 +-
 6 files changed, 119 insertions(+), 7 deletions(-)
---
base-commit: 479174d402bcf60789106eedc4def3957c060bad
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
