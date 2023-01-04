Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD34C4708D
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bSeZMN41bLrYY84Smncrh9b4Z8aUerlca2fKU91yY48=; b=0EiEpyZJ4l1ylb
	NpE0/UFXCNQsDN8faqg/W2N7IX9MxoYL+/sVGp218LUY/uS2QDVtNKLAAGoxTPdf6P1KRHcARUgO3
	kBF6CWLwWY2mQwi3dcFNVgPPi2q2gU4OiKyYOetNs/g3EXM4pKrhcvbqVUlNapPfIDJuV6wnVxnI5
	zKZHEd/vYQVH9h2c7aIKk9MmaLa3Ui1bJZk/+huSo9GPM0pWd/F7/oVsPlHA3HPHjRNrypG+RAic4
	+fjCgA/bgo8LosKA9I+JZD0/F6+taKeszbmiQOg1hQSpdq+SHWiyu9hJtWQYhzzs8TASQ9i/n4k0o
	y09/UPCjgWFjeMkmtivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD70J-00AVbp-H3; Wed, 04 Jan 2023 16:52:39 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD4vA-009lIO-Ss
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 14:39:15 +0000
Received: by mail-ej1-x636.google.com with SMTP id gh17so83155405ejb.6
        for <kexec@lists.infradead.org>; Wed, 04 Jan 2023 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=r18xklAWjx+TF7cp4UJMeABFqPp5Oxq9PAiHHqbB0/I=;
        b=PtY+76iieGZzTCVc1gjR6aZ+8MvRz9PqsQ0ayTQxgKbt8QP7cSj/FZbnfstwRXPrMI
         73s3I45OrA0oT2wKijU9NsqK7vtDWmHe3gBEfBLL23YK4TapuYRy+z8JV7JBDFlIfxk1
         LbwDPzTXFQQv21t1CW87DQCQA/KsosQnCRulQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r18xklAWjx+TF7cp4UJMeABFqPp5Oxq9PAiHHqbB0/I=;
        b=O1Y5eOJ3bZzt9lS3uSgd7P0uXKEX0kMgGfIhppMC39sfc6D/Vo7VKHEE1/RsCjGIKH
         oxmwZFTH8zcTkb3A5JexrqcK4D4Yg5oKkl+wIkXMvPMf3Hkv24mxjLsmdqX6jgauQaOD
         DuzFLOsfwfOrHn6S+OMnUzfZ43DU5ZkpGxRnPzaOT0aW9gzHqiWjBL31SsFsoTfopU8I
         K4ndUdQYWWkHlBcV8m74Weh6M+2XjJ8XlsG1OZ+9v30wt8CBobFhDWOYje69Vu9Gnu3f
         kGiWqkm9nHwrGdcpAulk30DY3CiXolhNUclf4lzyES9kq3yVf381PYiZVRz9neisSwl4
         QvGg==
X-Gm-Message-State: AFqh2koJ4IXSwejzAMaeOuQDuyqh0L7PhTX0zmCety9IS9WLbt+56hCx
	snxSODAuyHaDyDUrshFysI1+IQ==
X-Google-Smtp-Source: AMrXdXtRrxJEj9EhqTE6p1tDDzc93nU9PeSS+3TXfb8wSuNaG9ZU0KGU7Y84GuMj88gdoR3bMuV19Q==
X-Received: by 2002:a17:907:7d8f:b0:7b5:911c:9b12 with SMTP id oz15-20020a1709077d8f00b007b5911c9b12mr51581842ejc.1.1672843147655;
        Wed, 04 Jan 2023 06:39:07 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:07 -0800 (PST)
Subject: [PATCH v6 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHWPtWMC/43PwWrDMAwG4FcpPs8lsp3a7mnvMXawZbkxSxOw27
 BR8u4TPZZQchK/4P+EHqJRLdTE+fAQlZbSyjxxOH0cBA5hupAsibNQnVIAYGQqLcSR5A/9EspKjW
 4SfLQEYLV2WXAzhkYy1jDhwN3pPo68HEq7zfXveWkBHl/v0QVkJ3PsIakOs7PwiUOdr+V+Pc71Ir
 6ZXNQORjGDxjsNGiHGfoPROxjNjKFsyCsfUj5tMGYHY5gJ0XUeXfLO4QbT72B6ZiAmbTFkjfb1qX
 Vd/wFLtDDu2gEAAA==
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 04 Jan 2023 15:38:45 +0100
Message-Id: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
 kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=OajjYlRvNHsgrXyvUbmCD5R6Ksvr+o7Qr/VxU7sn1d0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY970v3EmwV32lI5jOI4b9gfVlAvFBW6wkzR0+PI
 jpl8aYOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPewAKCRDRN9E+zzrEiHrJD/
 9fEKDNuonXKXxBHNhx0IxcHbN/OOBcBuWjqTI4prRhjr/F/h2r6uFgSrokHEbNdjPBJhCLSFw5qmqP
 5duMbJPDtzDnLBpZz7oWggPB0qGuGbdE0dJK+/6CeXDIWQaeLztkqPrP47gPG6o4XRia7wChR91J6V
 Of7wnXxZsxpfaKxNQOsLrCXPvIaplJZgH43vq6g9Got8Di372Ks2FcenODuE71OrmXf0N230vXajSC
 SHBKQalEt+J+c/bp+UFr3jAmessUxYoWC39B/F+apr/zq3YuebgeEbrmVV7XuHAuHozA5zsarWHfw8
 meopL40YT/+AtimjB0bSIAd+Pd6pLDL4QY8NASwiYpAzX4X+8YV4qsKadvC1LUcQegcvUcwr2+g1c0
 J1RpnKvE1t/ow4X1K+adRNCuaW2J0M06e2vNQnw+UhAVP+FsSoT+4TN8lgQt+A0JqqDBxAmwZA2VCN
 wLVNLFaRGPmK8aOx/5T3IdHg+HmcoMINhKOVNTh2Ruz9V0+jS69vJkOSocMZh61ljBJ2i82LcGIy4w
 48f4f4p18CEzOjcdT6VPgOiSea4fRLfFcT5UOznlJtl9lk/W3AHPJe3PdVloA0hT57DPAJardujq4D
 xSpdxH9QMBvGdsR0eeh3eLVxiVXnXFufRy3WjyvpHLyzeVbC7H2Ao3dGDMPA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_063913_035015_80EFA90E 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Petr Tesarik <petr@tesarici.cz>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v6:
- Fix kexec type on kexec_file
- Match the length of the table borders to the sections underline (Thanks Bagas!)
- Fix typo on kexec_load_limit_reboot (Thanks Petr!)
- Improve commit message (Thanks Baoquan!)
- Link to v5: https://lore.kernel.org/r/20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org

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
