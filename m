Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D503C4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRfCE5l5cYogFreAwW5rftvsMqbxFL9cqJy/bZ2Jo7E=; b=pMKOh+FnO6o6hG
	iLrEaJCxKcMEeTZ4HFRJMrpxzB3mZncyCAJt7QcJ0nyZBh6JpwbtC9kRZtNbTnAFiabH5W7Ialejf
	zviO878NUMAFTf6UcUTCKPkd/uqV7jqB2OzRFZxBV+6PvRoiWqWu4se2uzIiHUF5nmM0xkBLF4tve
	uTPBqZJ2BhbOx5CCqlNHLx+ZNomIgW4BuxFyZPheqc5gO38jBOygUiFP8uNwHmackOf70EcVVAc8B
	oQH34JozwzfDStQgnABTqwD+MBaGpEUGtjvB5bbGyX1lsBB9aJAhK0nmSt0NQ/7iPj++U1mejEHRW
	vxGnv3cekvqFZKcVgloQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7ycW-00EqJA-Ji; Wed, 21 Dec 2022 12:54:52 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7yYE-00EoVP-9N
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 12:50:28 +0000
Received: by mail-ej1-x62c.google.com with SMTP id x22so36498367ejs.11
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=Yqff2tBr9mLzDgQy6wO8YkbyyU+hHsOTHxduzuz6EKnfOR0lu8sqfmQfLshamlMj55
         iVAA8EaJYdBcbzRiPidRkXcu9oG8mq3AKJFuILif+Qw5A9t1mVC0Io31aqbNxssySPHC
         RX9QCUpEarJByBTn6wamfkTD4mjw446EQSC80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=KX1V35dU02/RljuE2CA1Bb8wLpTfQQ8qQUXintlgl8FLxYPqP00q231OEjgRXLrqL4
         cbx99yGaoS4DOeRdTgLx/NRFiwYXdiR/3OuSmb7+IBhslYfT9yQLBZBd3l6V21PMf+vD
         lU6yyfP/q1Q95gScQC2ELsBpH8aMRN5FH4LrdPE2k+QFHuAHXeK4FCYh+ZxptD8uY8g9
         kWSUmUpL//OpEWNX/jpxkrka5p7bcgrxip037QbKjrvcpOGzF8ZWjQc7Lvx+5mkOXUW0
         XxEARjyjiJ/4/0Z84cSJafNcbetkCSsdMjjFC9sIoz+DyupylvU7TsTbTYkkVf1mMpxX
         sm7g==
X-Gm-Message-State: AFqh2kqsNmrMxMOnkzo6Ax7Pd2BMSsVH39WQ0GKEPbGnc0K6FPrCn+k/
	MMk+sG9Y0Mtgf+eQ3NLgx7WthbvdqAu2R73mJgU=
X-Google-Smtp-Source: AMrXdXsoMK6w2l5XN1avwOjEmhnplp1Jk46bR5QKm4EGxI7p2LaGCMUWabvtaWyPLZsobJ5r5vfl+Q==
X-Received: by 2002:a17:907:a784:b0:78d:f454:ba4c with SMTP id vx4-20020a170907a78400b0078df454ba4cmr1126807ejc.75.1671627016899;
        Wed, 21 Dec 2022 04:50:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:16 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 13:50:01 +0100
Subject: [PATCH v4 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v4-1-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6cVA0f3MVv7jTHbprLKEENRfx9C5MeH7N8/eIFjhzo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowEB2GKKde5eall1LO2Pukz0oHPGS78uqBtODlWc
 0ycx3AKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MBAQAKCRDRN9E+zzrEiNpsD/
 4/Jd6hh8jIzj6DeUtxGlMzPF8D5zTmDrn/O1OymQxG1FrMk5siVZtOH5aFCarWFYcAhrpdhW4IyzQG
 x0LSbJOT9jtwz5WKENrU42nTbpshboubcK+byC6h9iFYohm+qqWd0DVMtYej85mKcLmBHuT4dp4MoI
 LPkqfifmzf9blmrz2nDD2uArhMxRsApVCT68UqoZcDIALczol/keRjGKk9vZd8N12QMeUEfCZ+uMs3
 dT+AIpxtpZ1NWQpzgdypP9qzvi5ORxV+fA/DkV2ebJ42YUgHdi2NXRE8m7srVCBOLaHJfRSWo0zkGK
 DCjmmjzjvEjbxg2w0zqkQrQXtKge17NMqdFNrorlc3zOootGjCl32IWvL8oLVI4h6GCBzcDSasVvNT
 S2D1C3y/IMgOq+cxa3gwXY9Iq0QKA3eSKGvF211pYJYSXSRfjyx72V2VldqDwD/4XS+8lpJ90Ilwn3
 txPAfh70ipePz0zVIlvic1kAGXOhxdsXlGVQ+azTd6eBL0e40YuhKA6xogOKxMcMsFD5CZNwZdhGQ1
 JkYCGDuyvx5Abq4eX6KsYYAjWrWQ/vOurA90O4gF7DngsY7OB0vWT2T5FJbneNNtj9Nsg/b2HtjoTP
 PpkbxvNdPTJleHpZEy3DIrOPpkM8bU2jp5zQi/q/mxk7hruVcHMZhsZd/x/Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_045026_396356_1B28DAB8 
X-CRM114-Status: UNSURE (   9.46  )
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

kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
syscalls. Make it explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..97394bd9d065 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -450,9 +450,10 @@ this allows system administrators to override the
 kexec_load_disabled
 ===================
 
-A toggle indicating if the ``kexec_load`` syscall has been disabled.
-This value defaults to 0 (false: ``kexec_load`` enabled), but can be
-set to 1 (true: ``kexec_load`` disabled).
+A toggle indicating if the syscalls ``kexec_load`` and
+``kexec_file_load`` have been disabled.
+This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
+set to 1 (true: ``kexec_*load`` disabled).
 Once true, kexec can no longer be used, and the toggle cannot be set
 back to false.
 This allows a kexec image to be loaded before disabling the syscall,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
