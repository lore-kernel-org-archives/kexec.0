Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBB7C4167B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WqAdyRA0FWEDBYmso7zhTuyFEOHQs13Y3ntcVVDK95M=; b=Akxpz7Sbw0xJF5
	oMKHAQKI6AZVp0ZBfYCv1kCWqwLh95woVCyg6m/t8uIuSSC+bXkXdv8nrdFnVAJCL9RrPDL4EBhmY
	CAaoAb0foJNN0VVJ67DQ2lAYRUF3zyTXIeyn5cbQRqlY9Y/8A7GfWCx0/KTOar/7OIm4gK6JRNAYX
	QdHhsYOo0IUR2dU4qcqPt5AUYRYXKk8JzlH4oA3uDMHKIo5+efwh/gO62d1qnaQBH/jx8xyxv+EJV
	RFWVAjFX81g0jDmlrTv48mAGnFMX53GyIBtumTJrjVFpLRgLDh6RqrPhCy0eBKN9n2ECPKvpxYSAH
	SjPqBl5IfPnkvdwDpWuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7ycZ-00EqLq-Uj; Wed, 21 Dec 2022 12:54:56 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7yYF-00EoVH-5W
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 12:50:29 +0000
Received: by mail-ej1-x62f.google.com with SMTP id vv4so36617948ejc.2
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=WMiE0vd/yYBaXGsz07hU3FBQiAft2wmjzq4IoD9fajA=;
        b=FsDwchrubRoccRz16UU3/VfvJCLPLXjk9mbF3gAuquaoYgXTYXOxrdFCpS6vCpy75E
         98jX7Jg91/wbuAw2LVOYnSMwt9XdTJpru7YFRAagTsctrMCnq4nkKHOoviboa8xmKyYy
         qXFv71vL8uYh9dE5jZxt6PCYEu4NaMd2SXkmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMiE0vd/yYBaXGsz07hU3FBQiAft2wmjzq4IoD9fajA=;
        b=xZBxHf7eum5l2iKPlSHKMJjdOmUyHRZP0/3LI9LBjpIvnNlCU1FEwONyralJJcjVYN
         Aj6qPySd95DRYoP9VPAMWKoEbbb+9gGKsDNn9u9vgQ29/pvn1kk4x/HyDWwQkcoI01+F
         MxumoiiQZgXD1ojv2nh/so2gcWX9f9+6WZD2KfnTAqx14haX97DU+Bpv6GiNE1C2QsVd
         kXgRmi5JlTXBptGlysMIICnI7CINFW8UK3vsSsqmTFiFgwSWddRB+a/6e5s7ienv30u/
         Mjnob3huw/W6pd61v30YPx7BNu0cJ3smO3MQQGIVRn/JsjQTlae0MvlHXeMEaTRp7gne
         K/lQ==
X-Gm-Message-State: AFqh2koV7+U4G0yuM98PTDuFEjcSf3ApkUDPLrf+kTlnA0qjVgJPgtP2
	Rgra5zy+uoEHM2fys1iUnBxdey/wwybLN/fx6VI=
X-Google-Smtp-Source: AMrXdXuil/5SfXayT9oVY55/8d68hsnH602ZQHAwgj636BYZ+mDSkdlwA3kBxhfcmcYQOjM14us5Lg==
X-Received: by 2002:a17:906:6543:b0:81a:bebd:d4b0 with SMTP id u3-20020a170906654300b0081abebdd4b0mr1316054ejn.44.1671627015175;
        Wed, 21 Dec 2022 04:50:15 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:14 -0800 (PST)
Subject: [PATCH v4 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPgAo2MC/43NTQrCMBAF4KtI1kY6SWobV95DXCTppAn2B5K2KK
 V3d3ApIl0N78H7ZmUZU8TMLoeVJVxijuNAQR0PzAUztMhjQ5mJQggAULyJ2dgO+QOf6HjCjBMHbS
 sEqKSsPaOlNRm5TWZwgbbD3HVUhpinMb0+nxagc/uPLsAL7m0JjSicryu4upDGPs79aUwtuxO5iB
 2MIMYpXUuQDqwtfzByByOJUegVaqFN489fzLZtb9GhTkdMAQAA
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 13:50:00 +0100
Message-Id: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VBCVJ+aD/h3GyICYpp+9hUZz7wDvOWS2v3+hHEeVJG0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowD7/oKW4m0F/oh1hjb/+F27kY8sEEjovm4nldnc
 ++mdDAKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MA+wAKCRDRN9E+zzrEiCRiD/
 4v6YHmqUA36mCtnhhZgNBiEwdUEvmgxZ0WLQ4heB78T72NPYXMF09anLaJ0p7l9FdGBGNT8FA6eQX6
 GQ15UnOLfNCaGiI/XMktb6T29UUA0gIGq7ohW6vzrUJnHk90jo8cCv5cQGQFZFyHPQGZWE9CYBzkgB
 WsJEXQnvLfqGLfXW8XiBP2eWlUINVEyMsD60u/ZejcyICdnllmnY3gjCCg5wIRQQXDh4H1dT6MSMev
 4XFxYK25FDX3N5xFTmdynwhI2rhSfxrZuzUjOQg9g4sL6Bhi4jsZOwOLJKADo/maI/Fk7cjfbyKCOu
 r7ZsRslYNoVOvTkdqlaXW+OPbGDHWwboSFtoY2B0yKURuz1q476QsDy+2oqi4dwhlJLkKjNpjCK9Ur
 oRmVio+DnU1g5F3x8dcOMO4ig6LNM+i39llbr82wzYrmpbyH/8o84fmXXWVdcxTGSI3g3muSijaL5X
 3I1Gr7LRTn8ed42PY5sJy3FQp5EO0BpB7+zB3trHkYwieE3tgLvXEWR1oSl6NDVycl9AabG3Hdm1+I
 cYBCqGkabyDdzpOMzrARBMdldMekG2cOzqeznE1ru8e+Rz4N6VADI1cVvzpZ5Ku490beZmS64FgK+g
 wrPGrb0s45Ggx/t6+rvZdjIBLsohAJeqd4XK4fJdOXy/EUvBtgRxRf1V12Gw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_045027_306853_5D720B21 
X-CRM114-Status: GOOD (  10.14  )
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
 kernel/kexec_core.c                         | 96 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 129 insertions(+), 10 deletions(-)
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
