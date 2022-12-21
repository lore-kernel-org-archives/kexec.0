Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1347FC4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ie3USX8wGKSiEZ9HADYXYkBy32jvkxfNiv7mMne6MVE=; b=zr3bwdUDHv3rwr
	mJOItcYpJeFqsYksQB4Wle9tMyyGILpPCDFnd4m891amgiKjNNAaySPkWHWM8xjQzu1JCVL4DlfsR
	8sH/bOSaLgM4SOUC26qaK182NPLc2UKlzRWUoQrmoxhYvoMUIFmP02wRwQZBinO0LBg03jzciBSS2
	1srcE6G4jHxpjy3dlBwzNn+FF5h2lS2l3+tqcQkBG81VfWKYiOGfQO9e55NZcVVPbCewXxjPOf9oR
	kK/aAjMYlCqQ1gPD0ayM+yJEIwS655Dhu9Ap4OHMxAmReoRTZtES8RNXJrjjgoXe8ztU+5SsjM2a6
	OYaeDd/GUPDesYCIWMRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852j-001Nlj-9K; Wed, 21 Dec 2022 19:46:21 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852b-001NW6-4f
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 19:46:14 +0000
Received: by mail-ej1-x632.google.com with SMTP id x22so39218591ejs.11
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=h5QqjbWC4xPqNCugqJ9inOxUkbx/4jCQyhj7e6d+JX0=;
        b=gy8HEbmVaGXlWVpYtQSfYtXKoJlAwrX2PiZnxXo9HoTMGvawfZ+wlH6pOBMI2rJ95R
         /oMpWzeHuxdhZYx7w9UuejGKiMy7C9Y7/uVbbkZWbiC5EySjHA14dJohFrdn7hjbfX9W
         worysGPSqMzZPNCuYeUhwE2dBuffLaUUIFjxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5QqjbWC4xPqNCugqJ9inOxUkbx/4jCQyhj7e6d+JX0=;
        b=NGURBYkD5PsWerFA0stbEL9KhR/ogUVWxY8/NX2ENxg00FVfXlByPbiyyVkj1d/ncz
         5G4Juy5Um92NwjPMr9CFaUvLK05J72MuiMZxC8Dr2IbTISdt1ZbtbIhC429zoUdDHFv/
         KmmR1yMSXy95azaUmRhr7ACCX/fiK59xcGuiOkF4FtiT9/cY4SqUd3tqggkUuik6ivbN
         kLj2FOlm6IWwv/b1sRPvhDFcDpdxbprOpBgsXjBDLfUU2s64+IeYsHiw9kJqfO7Ce1/L
         gvIgUnxTZcfcbdAMRj8nySh48Sv4Qv75ytVKk5tAbOZt5ZI5EDZbfGjpGNlmQpY2wThX
         o1CA==
X-Gm-Message-State: AFqh2kpNExaRDBdhiTNAcqC7lz+0no+sPWf3Pm0x6E9OHaOtHEVbum2l
	ynsPy2hOej4r+IAX1MC8nDodKg==
X-Google-Smtp-Source: AMrXdXtRt6qphcfjVI4QjTn7e3c297nIpVXd5Stx/oZg+CVvsEnswh01KNoB+LTkOeEQPOYsYa3+Wg==
X-Received: by 2002:a17:907:d50e:b0:81f:fc05:2ba0 with SMTP id wb14-20020a170907d50e00b0081ffc052ba0mr2675538ejc.2.1671651970624;
        Wed, 21 Dec 2022 11:46:10 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0046cbcc86bdesm7382008edu.7.2022.12.21.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:46:10 -0800 (PST)
Subject: [PATCH v5 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHRio2MC/43NwarCMBAF0F+RrI10ktQmb/X+Q1wkk4kN1hYSLY
 r03x1cikhXw71wzzxFpZKpir/NUxSac83TyKHdbgT2fjyRzJGzUI1SAGBkzNWHgeSZ7oSyUKWrBB
 c6Aui0tknwMvhKMhQ/Ys/b8TYMXPa5XqfyeH+agc/hNzqDbGQKLUTVYLId/GNfpku+XXZTOYkjk7
 NawShm0DirQSOE0H5h9ApGM2MoGXLK+Zj2XxizgjHM+GAbhzY6a/GDWZblBd8zzw2TAQAA
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 20:45:56 +0100
Message-Id: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>,
 Philipp Rudo <prudo@redhat.com>
Cc: Ross Zwisler <zwisler@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org,
 Ricardo Ribalda <ribalda@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=pHYAwK2HBx9n8zpILJY4+z4Vwehv4LFp5obwLjvJPUI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2J2bQVimyy1/Vsjq4S0a4azyR8AdmG30PBxAZnh
 G4wJW8GJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NidgAKCRDRN9E+zzrEiI/FEA
 CG6+MF4+l8zL5dE4Gt3+i0jiytzzPAhfXFs4fHRSCsUD2O2MNBscf1A4mFZLPnTaW7vBMNVrfFEufO
 7gIESmiyNGt6ayHX1VooSQ1ShQsdAWtyVGe1W6o4w6yeO83drpRi+sU/5OpDYnpEASg0y+NSwRqzAZ
 Z+nysGMjXUNaB+2sTaWHHEFHRM7ALV7br6WhBL2WCHQTTSVE6XpRl7twTUn3Yhcef9ec0pX+jduF4g
 ScjmpYOqWv5hXqMymVLqbg/BjCGdVWVuWcfFdp7JIEmC73e15DUmlJRpZ9cyUk20l61NuMK2R4vRqx
 B6LzBRyuBMFF0SupmUNcjJRZsniObm/UscQJdm/zeX5TLZ9jo5iPjHGLwAsTEzb/hr8uaymqCyka2Z
 0MST/nj60mrMDj5cTcvVfdglJxBr/RgDggDuGPbLNYUMacpuQWqR/IarPTHekEP3MJRWLll+Gse4i5
 i0I0ECLpz6rDav25LJLgdE/4Nk+5fqUI5glc5OmDmkhlD95fzmg5DSpFUCf70EMQb0w57j9SFbWwcX
 tStaxYotNcUOSxPw+TUcc3RL504iw0GF8kKxKmBAiFHVEB/K1CHUXy4D8oo3q7GVk1IAnGAwDsMzWf
 bP2mw6WT2gEgAAPMNLnnG9094iJ41CQS6r/kA3eIYyo1cPjcJHKui7ZnTSQw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_114613_280402_927DE895 
X-CRM114-Status: GOOD (  10.37  )
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
To: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v5:
- Remove maxlen from ctl_table. Thanks Steven!
- Link to v4: https://lore.kernel.org/r/20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org

Changes in v4 (Thanks Steven!):
- Uses sysctl instead or module_parameters
- Pass image type instead of boolean to permitted
- Fix typo on flag handling
- Return -EINVAL for values that does not change the current value.
- Link to v3: https://lore.kernel.org/r/20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org

Changes in v3:
- s/paramter/parameter/ Thanks Ghilherme!
- s/permited/permitted/ Thanks Joel!
- Link to v2: https://lore.kernel.org/r/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org

Changes in v2:
- Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
- Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org

---
Ricardo Ribalda (3):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Factor out kexec_load_permitted
      kexec: Introduce sysctl parameters kexec_load_limit_*

 Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++-
 include/linux/kexec.h                       |  3 +-
 kernel/kexec.c                              |  4 +-
 kernel/kexec_core.c                         | 94 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 127 insertions(+), 10 deletions(-)
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
