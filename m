Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE179C6FD1D
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KxnYfxCdmAMAZ6T0KGrza6ONZXqNKp+ia9fJIL4H2BQ=; b=WaUsUOOxO9J1lz
	AeHdl64ZmpNMUkYpv+y3D47/CbF3gUpv3xUvYrT9e6L57QX8irgexV/Gw+1ufwUmhO1EQJyyTrFqz
	vKITtrA5fZNi2lIDwAd4OXYLkMocMh9y+zPOT7YtNKbPslaYYH2FVLmStADkWnf4SnPSH8kCuQ81Y
	auk4uT2BAWpSZfdcB+4eCK2dO3dC46xciZ2GbzDnF9quQ6gD5sPMgmMdQ/qCQIHlLT/EpnInKvGhi
	k54bqL4HvZNqpk/gWuKKzouS1GAJS5saDES4oeJIvoF9qWt2w9KDN/m0cWZJe79UaDCfviEJnjHjj
	tPz1zVTbJP5hHDWgy3ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgoRD-00BSDd-0m;
	Mon, 27 Mar 2023 15:07:11 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgoRA-00BSBu-1J
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 15:07:10 +0000
Received: by mail-ed1-x533.google.com with SMTP id er18so26282871edb.9
        for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679929626;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0UFEbGRqt7rcAskYsh6grJN74iOCdchpE+7TjNCjkL4=;
        b=Uk5DlJVQiFOCAyO438dQ7y0Ej9U8TJAs8QHDwkE8teva/DjvMijj58U7AhXnoBjQ/G
         sMbocm7tv2KfAU+4waZe+mvPneY1Q5hEX1Lrpg0DRJGJd1CjrR9Hl3L7lkeZ4wQa8ODj
         aODv3RNO6FnmDWelqP9k6fnKiRWop4LOPMcPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929626;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UFEbGRqt7rcAskYsh6grJN74iOCdchpE+7TjNCjkL4=;
        b=iv4HEmyOTiGoqW2U5vSuT7u1NgWINCkKzLiWrzUTv63wmHoI7uX2GXyZkZTi5HbWRM
         QrXw55Kx/1pXEg38C6bjcKDNuOp3aJUVgbQAMgOSjKsuJ6i33ViIxKiU7msGhShHS0QQ
         MgE0MLi31PGFnIV8jL3rMUSmKHJI1Jk4iSGMPmG8z1qdVVmrOhQR8fQFhHvA8/Voyqw3
         b7n5PdjyGdsXw/KF2CyI6D0TFsrdETtSw3dKpauEQoKKEQkNnxmWU+wzG27cGRSL2yug
         rDqlqWFv5LJCqo9X1/eGNvo/py39m2u15gmwIZIr3qmJYc2Bm2lbll1RYK15dTevhbPF
         WLgw==
X-Gm-Message-State: AAQBX9f4ATnNN/OvNR2zA85gkIzSI3Ij+KSp/INJogw6VZx9JITG1jta
	URaWPk4AWIsjmcMMQowfk9l6KA==
X-Google-Smtp-Source: AKy350actXROnpcdn2lmx5wDV0TPEejAcfimbqFaHL731CO4ATVjrEQu1XuGrt9lvpNKvZKC6/f/Nw==
X-Received: by 2002:aa7:c609:0:b0:4fa:ecdc:e44b with SMTP id h9-20020aa7c609000000b004faecdce44bmr12080742edq.24.1679929626563;
        Mon, 27 Mar 2023 08:07:06 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ed3c:5e9e:b8e4:8695])
        by smtp.gmail.com with ESMTPSA id t9-20020a50c249000000b005021d1ae6adsm5312428edf.28.2023.03.27.08.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:07:06 -0700 (PDT)
Subject: [PATCH v4 0/2] kexec: Fix kexec_file_load for llvm16
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAyxIWQC/33N3Q6CMAwF4Fchu3Zm3fj1yvcwxkBXYBFGsgnREN
 7dxkujXDWnzfm6ikjBURSnZBWBFhfd5Dmkh0RgX/uOpLOchVbaKKNB3ulJeMOBb5DLNAOF2ljQFQ
 ruNHUk2YTaY88tPw8DL3sXH1N4fX4swOPyj1tAKlkXedmixgJTe8Y+TKObx+MUOnFlbNG7gGbAgq
 LMZlCUefUDMLuAYSBrFeRYWkVl8QVs2/YGHtmubzQBAAA=
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 Mar 2023 17:06:52 +0200
Message-Id: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
 Ricardo Ribalda <ribalda@chromium.org>, Philipp Rudo <prudo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=c/Cef+C3wMgRslM3TKLYo/Fx7R2kWnifW8QXo2DyqYc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkIbEOxUf1VwPNCpjkoRxJUrAGmu9A9fnWdmb5L5VA
 wW+pMCGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZCGxDgAKCRDRN9E+zzrEiOjND/
 9IHDPa+BnNrrVbx15zUGOg/Puq2djPp0nMs1Bjy5OtucU4d8Mm5xg0Q9TwgufJuZ0NqYk8kGbja9Nu
 y6/2suuXEdMr9W0Zi1rxHlYgO2XAklZR15uUjk73Cx97mKWDt68p+VLcnNS967KJjB/6+Pi5uiLQ3l
 3XKSfKrN/XZeqMzbViurzi0mWw7lO8/EwIgd23jYeButR4rSdqUWm3sdVLbm6PSgkAVdfOvP+BFvu9
 1ytum13E5pu08RpMV8Zpj6tA0lcZTnAZ+2y+z2CL9BqemWA2PHfUtuS8jjOpUpmJyyjVQuOmznnEys
 gQ15HtMS2lVAYuG3g5oRk2mPjqEzkfkuql8384sq1uKzJ4HswLj4qRckUb+JQwE8NsNtHWvPXiX73g
 EyNoTPxWWp1I2uLyd9OhEWD1qGyKXhG5o5OuL+lOH7tIOw8P7xsLmKNz0jc5b3ASdjrUEgsWVo2QMF
 0WTg5oXJ+GybniwJaGqZf6tq1LgzBXEtbVLYc4wMPg46eyALDK/pXJkW8mt7snIYk85cVBj6kHWnmH
 DIDC86y0ogc4WKXaqRcg7Srs9pPWWVes9VAKbTthTWMkM+Oev09qbdFB1M9Upic9XYO8kWt7Mz11l9
 cnjS2Lt/NrLGwv14oa5zOpPSV495yV2BSx5ko0aGP+Xy8NdYt+73I0yHsxXg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_080708_469151_C393F8F7 
X-CRM114-Status: GOOD (  10.10  )
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

When upreving llvm I realised that kexec stopped working on my test
platform. This patch fixes it.

To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <zwisler@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v4:
- Add Cc: stable
- Add linker script for x86
- Add a warning when the kernel image has overlapping sections.
- Link to v3: https://lore.kernel.org/r/20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org

Changes in v3:
- Fix initial value. Thanks Ross!
- Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org

Changes in v2:
- Fix if condition. Thanks Steven!.
- Update Philipp email. Thanks Baoquan.
- Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org

---
Ricardo Ribalda (2):
      kexec: Support purgatories with .text.hot sections
      x86/purgatory: Add linker script

 arch/x86/purgatory/.gitignore        |  2 ++
 arch/x86/purgatory/Makefile          | 20 +++++++++----
 arch/x86/purgatory/kexec-purgatory.S |  2 +-
 arch/x86/purgatory/purgatory.lds.S   | 57 ++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c                  | 13 +++++++-
 5 files changed, 86 insertions(+), 8 deletions(-)
---
base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
change-id: 20230321-kexec_clang16-4510c23d129c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
