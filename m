Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E8C4332F
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GQ4iF62x7ijAulK9QBq9jg+UrjwPe0XDjAH2nfd0mrM=; b=HoJnDh8cQWdCBP
	FgVeMisdEM4vI0LFBcLZ+iWsj0ItP2DuSjS1Q5eimq7LSsqgWmccjMq35EnPQHGCrj8ukO1yST4ox
	SY4tTeNYCXah1+nteqIxQvhG5R8VvvRujVCy6Ejdd+nhg1rJi3QqcMZdcqlyQRu8SgbTFpbmjUDR/
	+2aOvl5MSPLjTq0TeMdeDEi5ykNX1mfNlYYaGxLF2KnuyAoPUw2dmr7gTa3WPNdrHwHv9pCVvguHH
	Nka8G3CJPte+Re6sE9R3avd3AZJPwM90GAGPAGTuLIioFIK4LBcFNa7fwtH8bq8qoPuZWwlIa5joN
	vXNpxYxdNmp0BCweHAeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kka-004qhg-P3; Tue, 20 Dec 2022 22:06:16 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkT-004qYj-7n
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 22:06:12 +0000
Received: by mail-ej1-x633.google.com with SMTP id qk9so32572457ejc.3
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=qguXqp2j+6VtyLB8eUBD1D9muuuDDTBR/GzC0b/pu1k=;
        b=O4vVH20xii9YmkpEcTbvxvo0Kpp7cn68jcaqvG8QZqgPD0IaQ5BbajyX4g/nZKmoIe
         5fStIY1Es5sM4ze2N4kebYQNPt8U637KvF8TtUBsrOyLwpr75715dRO36hOps80iQ2Jh
         gyYPxx3MSTSOns65tEwJapBJROPJI9XJFFT7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qguXqp2j+6VtyLB8eUBD1D9muuuDDTBR/GzC0b/pu1k=;
        b=NWPc3i8jp8rPAIznl+bmodefE15IC+2E1JNcpGdlRpKZALhRiR/n8norIQX7IlS6X8
         oiiEPtNjum3zzQIKVkM5UiuDCc8uWb5a3aFKC//t8urofp4HZIZIvtVpka5l1ZE4JTTl
         6n5pn6SiXVZeHWA+z6lq5GUlF9a1lI2dH1muIssrjMjf9tPl4QsVG5MdfJNiXnYxz9//
         AKQUJklOQxDalP2tO5+nCetjQqZG2TuXWyFJF6tC5TIJcY2T9Jty80SqTNYXibL9eAG0
         Dhwrd7np8Onw4GQuLL1evlXGGMtqcd66g+ATS+Co0hIa+hIiguFGuutZxU0QNRXAWx7f
         lCCw==
X-Gm-Message-State: AFqh2kpFj7omg5k4E81dCMknf/XRzo3QYvXiDAmETVCST6QgiQVNlDFQ
	sBkqBUn2ltu9piwkMREZh3DcaQ==
X-Google-Smtp-Source: AMrXdXu6YxWTPi3QdZRM5wHojbmkje75tyctzgPEzqVflCJ+t0XQiwVNcUG6Jy0bCImoz9tngbt5Sg==
X-Received: by 2002:a17:907:8b89:b0:7c9:6e0e:1428 with SMTP id tb9-20020a1709078b8900b007c96e0e1428mr20328765ejc.47.1671573965862;
        Tue, 20 Dec 2022 14:06:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:05 -0800 (PST)
Subject: [PATCH v3 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALYxomMC/43NQQqDMBAF0KtI1p3iJIraVe9RukjiaELVQKKhRb
 x7hy67KF0N/8N/s4tE0VMSl2IXkbJPPiwc1KkQ1ullJPA9ZyFLKRGxgt4nbSaCBz3JQqREK2BnGk
 JslGoHwUujE4GJerGOt8s2TVw6n9YQX59PGfncfqMZoYTB1NjL0g5tg1frYpj9Np9DHMWdySz/YC
 QztupahcqiMfUXcxzHGztA9xsFAQAA
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 20 Dec 2022 23:05:42 +0100
Message-Id: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Ross Zwisler <zwisler@kernel.org>,
 kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=oqqxwk7ur+7vMvrJ1y110OEyC4kpNJWaizp+/KtIfaM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojG4Me5Y6xAi+85V5xL3fNRPfkdN7GpnFJ5jXJXt
 3b8EXpGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxuAAKCRDRN9E+zzrEiGx/EA
 CHRNxJxeuVSxaapNclsd0IR2v561HSo/3zhW/RH7NG2VBrxbPwzBolyjgfbRMakKqbztlmWf7etZ/S
 Ep8ev+3WFlQsbehkKTh6z8lDHwTvFKMv0rTH2vOngOJA6pmqJht/zB4OPbSPyvOOkZNQ29mIp/liFj
 EKBwrxpy5Y7uvfuZ7Q1DDtI5rMrKl4AxGI3wrv/FS46xCOpiRfoNcxuH2fUR+ZzHW5aFmq7qw1LfQJ
 ZiH9lBk8S1JbySrhQGdPQ1HCWi78T3R9NRtUvTnW9LeUrqBTiRZuoYHucvGQS/uAsB1BinY3LCbGhs
 diuRkD2qfJU++eGUxoJjo2ZVOGkGTKm3HURUutGJlo7Yq488PpyKU7gyZSvSdhapopQGyFiepkRJus
 WrXhAwVwoL+wCnSWYiJvZz8CNZRsCM+fofRYyUWiujR1sdFWx0okvhcCcWSloR5/VkO+98PYy5h1sP
 L2P/mWyVFAR6C9hXQCKkq1TRuZCglgRtM2Etmuwa4ZfvrdmKdUzvaetSwU7GrCy7PHpq4oFRpj/eL/
 kRe+5rIF5PpKoHnOuhkTiPsSQntBm+wep0iu3tiZ1Phzj3c2MFkZfdY7NpethPomAo8bq3ygEFlWp8
 80QP1c/4+/QjU2g780bLf1Ux8QBvaOA0TokD2Y9MPRfDXTbLA9nAh1WKUHOg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_140609_406506_A39AA3CC 
X-CRM114-Status: UNSURE (   9.55  )
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
To: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
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
      kexec: Introduce parameters load_limit_reboot and load_limit_panic

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
