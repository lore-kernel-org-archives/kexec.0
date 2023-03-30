Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B750C6FD1D
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HKNL05bduyqLMRmwRyPjqWOUobOOUW1ymTX/pV/lSW8=; b=l0OZLqmkGhf3gE
	L1W2G7DK5Vt6+CbOULJMXrfRX6JtkEQTDbdUBTGU4eiao+RwmsEFNEsb7SSus4/SiUi0Yfv4LzNG6
	09Pc8oBy0u8xp1wBPvo+Aa6Y0X5CG/yd0WUtTooicLWeUhH2cTCHACOU0AY/lTxpM+6OZ+9aGeeYv
	/BWF/F4MHeSstWfZuTDzqH9KHwtn6coW0lNCV3WsW/SGPgugojc/SYtaGOXhJBuiOsZJMTQuHZh2n
	/kRbTtMcx6B2+e2hfcNKSTogjApzQ4dW0XDn+UejbLaT4x1eDH5C3p9oNXG5+zOGrxorrMm+SzGZB
	0QMLITTbcjHl9TFskA8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqN-003KE7-1J;
	Thu, 30 Mar 2023 09:45:19 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqK-003KB9-1M
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 09:45:17 +0000
Received: by mail-ed1-x52a.google.com with SMTP id y4so74166052edo.2
        for <kexec@lists.infradead.org>; Thu, 30 Mar 2023 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680169513;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmFm2H2aOAkbQY/h2v5MAmP45SXRmGLw4e1al6CBI2I=;
        b=PGpd/3k73zNpbvHVT1UNSiV5gtK0hy3DPGeYWoIayaboLOGFXTitshD+imYv2Js4WA
         MM1Y6zOlUAy2AFVvLHyZtSslq5XKgyyZG3y39FnjeXLrlTVhDhAjXvJZMQx1Us3QGzMi
         qb6Sl0zeTh2D/1f/uRItg4eljeiJoSj7Y+tCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169513;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmFm2H2aOAkbQY/h2v5MAmP45SXRmGLw4e1al6CBI2I=;
        b=PY+Yptc3lR433XhpORsKHYXdmVC4UdpZn6TuGYpvqgjZ6+oDW86voPnfdH1z035yoh
         hO3IKK1VXrUuwMqFVWzY7yQDPbmK08szDNdV+J/Ae/7UXSmmC+ray7rAE1ak8K2RWx3q
         ZtYLQjxMrvboR+7du1Q3o/Upmr1qETpE1dR8K8BFjqTJEQHAD/exyAI83l5Ljr8I6bov
         bvEKEwoKMpxZS/CK9PbzB7EIT24ptBvtUN35uxKJTz6wl05WZ55WDelohqGBcIVo4XIF
         H4vbUxgM3ZL4j3o/NJkWwipOVy2WmGTdWEOUZsDE0dJzWmPhLFd4mqOC57r4miNnP+ao
         Se8Q==
X-Gm-Message-State: AAQBX9df/GXF40oUkNKoQjXj8GPpgTW+ZyPUllcL+qWsIU3RcvBeLzBh
	UZuSA278JD8YA59+Uk+PhcsFZw==
X-Google-Smtp-Source: AKy350ahiWO+Fj4V7FTU9MC6Fk01PllpwoR7WJ4iOZ/5VlJFhikZNy2psVuFakzSi4JpxpkDOWltmw==
X-Received: by 2002:a17:906:5a43:b0:8aa:be5c:b7c5 with SMTP id my3-20020a1709065a4300b008aabe5cb7c5mr24312480ejc.41.1680169513712;
        Thu, 30 Mar 2023 02:45:13 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1396:ff5d:6e2a:df6d])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm17683616ejp.140.2023.03.30.02.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:45:13 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/2] kexec: Fix kexec_file_load for llvm16
Date: Thu, 30 Mar 2023 11:44:46 +0200
Message-Id: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA5aJWQC/33OzQrCMAwH8FeRnq00/dg6T76HiGxp5opzg1aHM
 vbuBo+iO4Uk/H/JLDKlSFnsN7NINMUcx4Ebt90I7OrhQjIG7oVW2iijQV7pSXjGnndQSOtAoTY
 BdIWCM02dSTapHrDj1PDoex52Md/H9PrcmIDL8R83gVSyLgvfosYSbThgl8ZbfNx2Y7qIE2OTX
 gU0AwEUueCg9EX1AzCrgGHAtQoK9EGRL38AdhWwDICxyoFvK0/fHyzL8gYkFJwTdQEAAA==
To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Simon Horman <horms@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=SayQVLE6H72tjacCmNcmtcnOuUDgjnttSSVkCQO8nwU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkJVoXZBZQgBE2mt6hnkD3x10Mo+77PbgkqAlUv
 DUrdUN7lMCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZCVaFwAKCRDRN9E+zzrE
 iAdoD/9iPmpE6/UU41Svse7e7tdRS16SUUtYUJeo/EFBaOCBvwrfjzy8VWZRlbSxOLj6kZtGhxU
 e9QmkiwAYz3MriXFz0LgSFPithiLGCwsyGKGLisVczcoCpN2Mh4gZ7mS0Iugy0rrChSnc0juGYq
 yG2ZrJWuOwycDBefzYLh4UxL08GlvUIP9XC7fBTEcosZQl3k9i3F3F1uUzBqCIUgGDMHmF+9JW+
 VrPi4F2Lz7d2+EVQihLq8QT6IoU+aiwDlHodOl04LQd9a92rzP7UGTqH7idqDJjH6vAXwMh0Qw4
 udF9lMsdLFUqO5ikYkDMtlolratzqThH5Az/A9LFd+c3zpJvTQZ25v1sAKVPnKXUJDZwD2+pIkG
 +KMCpHt02hPHttKKfxolte4FXkQzk1V4hKbdpahadN98uUPVityKckSZvuw5uFFWLJ8j3DRd0tm
 ex5WZCiztgdnpWZ3Z23x7zk+/qVBk9Wn2AYVC8nsgDiJJ9AKa0RKCrDKeh+zIcPPLx/60U5/iDe
 c3MQ7eQqNq1jsrfoET70+HpUDHw4TX7JsWPcMRXgNWjtkBgiRDC79LjlrJOMQoMgfjPMIj/cKCc
 js4lKsxpS5AMD97rqiQKEIybAUTE1U/4s7iGp0UHDdnSaSn5kUJoGok+xMCGMvrrlnygTUIyYO/
 dRH2kKxwSXes4qA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_024516_462404_66D3A27E 
X-CRM114-Status: UNSURE (   9.60  )
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

When upreving llvm I realised that kexec stopped working on my test
platform. This patch fixes it.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Add warning when multiple text sections are found. Thanks Simon!
- Add Fixes tag.
- Link to v4: https://lore.kernel.org/r/20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org

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
 kernel/kexec_file.c                  | 14 ++++++++-
 5 files changed, 87 insertions(+), 8 deletions(-)
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
