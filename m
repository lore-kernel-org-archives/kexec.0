Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4B2C4332F
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 22:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRfCE5l5cYogFreAwW5rftvsMqbxFL9cqJy/bZ2Jo7E=; b=pA7s4mLL0bZdXM
	YwFNu9SVpsQxN7pJpa07/dty7NH2pe6QUDARNPaPABYkjgcIryxzaQwGgsUqwMCRUWT428faEQCb0
	9gvk/4ZONDHcBgmbJcGjEDQrBZnCINFF/XumLimqmEWqnMwgANJQfV+KzFY0NYTJONRqeyo7ew0Af
	DRRsqq64n+dDnrc0q/GGe9eDECiffCIoZTiilIWR0TXUW6ZnDITgfkDigBsYwj+0pvHwWs90MJtUt
	xAx6nzT6lghgNHJYz/YprrXxI0r/mtHA8QJcaXT6fMZCdnOfvagnhINbwpLAIJp22efI6ki7/d23K
	Dwh1+wT+wZWO1ceLrshw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkW-004qeL-8D; Tue, 20 Dec 2022 22:06:12 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkT-004qZK-7X
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 22:06:10 +0000
Received: by mail-ej1-x633.google.com with SMTP id tz12so32540845ejc.9
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=QZyYvSYS/5R/0vxSGWLo/6TrG71If7NC5DtCubDinMXdIvsAOTSsTYPjceSC5lhJec
         BXd6ndGzKfOPGsXk7IAnWkD2+Jg9cIRiiS2AMo0PWk/H6f73e5vb/qkVYFuzoPnK9/Es
         mlmynVTyGNzumcJRS3bL1ypHkrfyanKKrHzs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=bdrQzKOSGZm/4pEIKyLDB4XDwJV9+XxHRQ4r/bSYCeb+S6oVcnnvL5Jab+cEHP+yJm
         utJ1kBhbQMu+m3THbPgaT8UxUQFfe/Cmxur+viVprsCMb4obJRSeqxTByVbuIN12cwRO
         hZQ3AHqhzM8AVIGJA8t0aZgdK2As9eH249dVMTdpcb7lDtw6xK02emPyIEQe178oe1vC
         ey7tJMxPhreoW4MWoDwNhZX5No88GpXljG89qOna8hPlRf5scP7SVOONtGMPqe8YhVSt
         lhlskGL2VIItDYPffoGpGaFHIYJXYev0nGPGq11psyCkZb7tal6mdYpXdI79O8W4x3SR
         kjsA==
X-Gm-Message-State: ANoB5pmScvTYejwqfngpRkgs/gsNQzNbSHPsf8aZIeojsXkiMFdoXA9R
	GTpGZbUxVaNPsBdOgFrqkMGLiw==
X-Google-Smtp-Source: AA0mqf6zzWn0WikLfWEQwe6zkmxGlwUAYlamwtrtvXIvvVUd2sMlv7GgspWqSrhcUGkNHsLlZZPwFA==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr40561370ejb.74.1671573966509;
        Tue, 20 Dec 2022 14:06:06 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 20 Dec 2022 23:05:43 +0100
Subject: [PATCH v3 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v3-1-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Ross Zwisler <zwisler@kernel.org>,
 kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6cVA0f3MVv7jTHbprLKEENRfx9C5MeH7N8/eIFjhzo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojHIpdmcVeMVxZ7UQR/ZxrK0wjocsFOqbUXV1Pzf
 kKjKvmWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxyAAKCRDRN9E+zzrEiFfID/
 9z8ZdKo6lWAEJ3T0FZH9P5dUY7+G8f57r2NUYkbXfSZyBnKZrzNJO/zzg6qs0zVpVhq0Q6tya9Lr5n
 i9pKqqZzciEhZ5dxXjxdUSdA+bnNgCHYoV19PtdKclGJWT3ZlunTNW6b+m2ecsEEwry0nzYTY8tfmX
 0Z2upPGKphHkKHuehW+ZatYoiD9ryoeqcsUa/ISkFK3J2H5tlKeqTK2uJwxEAyYJewvSydZUCPvHAv
 8ZUh4us+RWedvK9hUg+79yijwSID58bKxu7aAsRdhMef+vRkERdD4hYDEHoCFVoO0BytlMagDtbC55
 7p2OA6GEjZ2rjT41K6fO1h9gZcScdk3oYi4mdeAFZz81BpO237UWXl3ONMimGUS8nOhYkULDJ/gL+i
 PRRgDg3X/pcbA/EwQCjr0sjvCIFH7+kUYsG5ugtmyoWYS3v6xyIsgwkcN1vapyrWDtiwqQvZgZAnO+
 zaiPo0WMlJ8U16DM2A0hxHsvqQVtUq4/3ZOti2PXiwSjbF9Hkcs+huWx6+r9ZIpDU4cS6DRcpi6JWj
 GXAjtzK3OYQmK4Tfy91pBoGNKL15xLeJ7zbR+t9Llz1b4P5Yr7pbW0Niku63bJ8EhyWZqUSwSEUey1
 Z8QP37ORLoJzuJVT/YNbvtLZOzvKP3bWpLxPZ6Ax6fx4bMYhgraJntD8MAJA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_140609_384386_C4895926 
X-CRM114-Status: UNSURE (   9.83  )
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
