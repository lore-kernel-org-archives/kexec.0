Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7DC4167B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRfCE5l5cYogFreAwW5rftvsMqbxFL9cqJy/bZ2Jo7E=; b=2t55sILM6c3cMw
	PxfAuXYUiFa0cNmVIGjVO8onb40OjXqA3rXimCvJzt1oVj9x2VaDFys8S7Z6h6hzDNIrUPZQSFV5n
	PvrdHyIwXjGztJdukRJZhargPF4rjq+RSWucxOjWGGluKVR3WdJX2Gd2dlMyyNToP57ip7/3Yf6Nw
	+Wtg8JYSsGfWkArKd1fwA39MziHDvjtCZxoo85DLj4KXMxcUknvRae3P9isw/MNmqWhKcibSZCJsJ
	c5p2fqybm5P9pECKkZkNUUyykfyaWGCU8tTMVgXbA6LIfoGbMluSvLK1LhHUp/RNHEAZtAslQtAQT
	D3oUOHn4xqrTHBn4spYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852l-001Nnw-Ha; Wed, 21 Dec 2022 19:46:23 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852b-001NWN-JH
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 19:46:15 +0000
Received: by mail-ed1-x52f.google.com with SMTP id i15so27580edf.2
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=RQbFTmSpCufgNXH4cjE/NEaU/tEsNuzVOXIbI8CwMamw5qAWhVCN2G0OePZAGiA7kj
         1F+gYgX+YqQxgMX8QnWDLWOUT9frqU8rVVDlo2XOFQL2RcFmTwvlLp/ylO6/Ec1sZ1je
         yQOoeN3E69nDmdnkj/Bn6C32nSB4lRotDVDZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=EgFHL0c8BXtnEubFhAI76aj1r7+WIJAHOfzSnfz5FVoNH6VGgdQ0cd9S0oIA4kRGau
         td9CWwf/qfC+UTK+1VItAAcuROzmJg45q1KhhDDPobzHhzD1hW3xZ3mpGX3aam16d/P9
         vLrRpY1Fi+qFdaWROWJ8lH/e3+U5WjjmSLRgaGK9+dxxavmSzuj1MH/kEv0ZrUtYvY+x
         NOHDaHWMAwCDHAYOlVDoXjGzYK8D9kJdzkR5d0N8q35PPrDyEpg0xr+BmuVG0LmRI272
         GcIVqZ/wcelEvZ5UtKdKdBwFshUN4bdVTITfkdy5Ue5gb0gMrvalJFyebmNAoHvG8E1l
         uWMQ==
X-Gm-Message-State: AFqh2kpjILgF/3bQkFwRXbKrhWHqkobtfnQ9AoKmWe+sxJWXuhFx14z/
	OQh2zbU/8nJcfs13kYzo6efshg==
X-Google-Smtp-Source: AMrXdXsRzDD7P90Vqn5PD1Ce6iPmD51XQ9bLvdWSr569JN4lv564Sm7Wg5IUnhiukQhDGHLKUieQhg==
X-Received: by 2002:a50:fd10:0:b0:46d:aef2:3350 with SMTP id i16-20020a50fd10000000b0046daef23350mr3127946eds.26.1671651971256;
        Wed, 21 Dec 2022 11:46:11 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0046cbcc86bdesm7382008edu.7.2022.12.21.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:46:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 20:45:57 +0100
Subject: [PATCH v5 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v5-1-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6cVA0f3MVv7jTHbprLKEENRfx9C5MeH7N8/eIFjhzo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2J7s4JnwPmuL15uZ+xM4QsaksUW5vucOTw7PXPE
 fZ88t7CJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NiewAKCRDRN9E+zzrEiDaJD/
 0bTQsbJRZ8Zw4ky/CUdrnkq+0uRbLoHVXu1ml36UHUihbFPSWbVefZ5p1bYmwIZmSzSEOemUBtbWdT
 eCmm343+ZRdig25r3HYVQIPjfZmV3J4KTW1CW2kJ/RYT7TV+eqt/2WIoUfoJ+caPbmQMSk2sX9JKNe
 iijWrC7+ouZanLCd/BxoBeKuuYxs23zGypKigm9U8VNs+DkSs81Bzs3scnfDafdqogSPF8hXbIbarZ
 oYujynTcfBNl3PXB6y3B6cJqOY/XAekyQrlGk2qzoIdtLj1ehxmNAcSQb9+iFt5B1oCkklY6C/E2XX
 Nasw1eCd8feM4nAnrK7M5JGDx676PMd/68QY1M1yPkv4/4eQei8ivJydAsQTcda25vtz6qRzt3oziG
 5aPY9IuCSwEUB/A49HgpyPNeO3QQyjM/JRlwFsngYGpwhUoLjMHpkW2ic3AlmQyZz3dxm92CG0nH80
 9HJmFnuxPGB1Zps0f8nXKPz8DHobHLJPNu8nwBs6F2O2o5m6u0I3dlHrcwLEQS1eG7KZWLLfA93nPc
 BGj1rKeM5vda3r4fqTGmqxUFj5yoH5KqsYwSG8iPQfUQMSVO07eiyfXsDi2RZdrO8JPAG/120gdoY1
 Tqqx7ihn4UKRARwU+N4J0xr0tgvT6t1e8J1doKvNiEfsUHBHmrvedZ9miHuw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_114613_674426_07E3BD10 
X-CRM114-Status: UNSURE (   9.50  )
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
