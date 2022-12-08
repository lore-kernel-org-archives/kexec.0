Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2787DC4332F
	for <kexec@archiver.kernel.org>; Thu,  8 Dec 2022 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yZAqphq7VN5akuiZbyBnGbf88khGv5WR3r+vLLysOd8=; b=1x2ibAGml+hDbA
	KkaK/bnyrhbFPkpNxY7lsob8c+Ux19xA4ihn9w3qNbilVu/8W0X7A8+HMLW7yXjTtkfyfXWkepkyE
	ytQgptbdO64nepgt9Wd6tzghiiLfrqauNMSeopEOLNw6BTyyoXX4O3wcZCAYD7olmeUqmailiyVfQ
	9KdqG43v2+khU/iM4p2/vAHvzzALvzypZR7hwOH8Y2YoJCgK98Ob938TdH+QUbMhuH9NZRK5f9y+M
	p10KuhTLhE3X3DHAb9NHxz8TTHDti18icZSJT5ZI6UtswS/8G2FJmyCzRdjRBjYc3Dq/QEpzlMGAW
	pUGvZWbUKHSgyiKMMtrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Jul-005NI2-5B; Thu, 08 Dec 2022 16:38:27 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Juf-005N7S-1O
	for kexec@lists.infradead.org; Thu, 08 Dec 2022 16:38:23 +0000
Received: by mail-ed1-x531.google.com with SMTP id z92so2568419ede.1
        for <kexec@lists.infradead.org>; Thu, 08 Dec 2022 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhaF9GqJ13TY0Hg27yR5BzoVfdO8sTpyXYMoNgjajPA=;
        b=i9c67mj+9AQi4YP+ksbG4h840ith9rqM0BG3ZURvebcEwPzRnnOXDmFZLMiElsFjQd
         hExkE7m+ye6SWjL5pY6ftcA7YtxZGrd67eYNQnwmU3dQ9EZTxTbhTpgVZUHfydcZ2R8K
         caTkIQ9eViZXa53Dni5MTjKQFgCubYVYWAQ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhaF9GqJ13TY0Hg27yR5BzoVfdO8sTpyXYMoNgjajPA=;
        b=6ydqx9HHqLn5xjV1SEHTGVClBOi9jad1x6lVU7wnJpYiMP1ZzGkbP98PdpiG89sk4+
         beAMla0/fnQa9LANeX2CGDErGjszlnn9f4yHdAEaeLdps7a/6uyZURkZ87u2jqZYSrhv
         WAWX7cfZ09NfZRgvtx1ZZv8mnlotXCBlvij1cbMGX33w3nwnCGxjVjDqacaAfZLWWLJw
         TEk02EFbPU/gpsxtD2YGyCIy5B+sekZPnaptbzkj+6Sk5NI3Jdlwst1kaYJXKlZUcJVF
         SNYVcNzjoCA/6kwyyIicmMmpcWu1AqBaumfRdUUK1wdpPbWqQTL8md+fte/gA9OqH7TA
         RhtA==
X-Gm-Message-State: ANoB5pm6MC4nB+sVyDI89y/qFRG7naz3tFo/qQGkiodHYodJHWAmNHky
	OjEBiHH7BTY1vbkhhLL8ykwSlQ==
X-Google-Smtp-Source: AA0mqf6oXuPF2FcEbhr6O6icyt4v9LFB17BogW5u30C9Y2tcx020bg4gsZKP4A6NujqN7niMt7+jTw==
X-Received: by 2002:a05:6402:3908:b0:462:8a68:139f with SMTP id fe8-20020a056402390800b004628a68139fmr2240885edb.3.1670517497880;
        Thu, 08 Dec 2022 08:38:17 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 08 Dec 2022 17:38:00 +0100
Subject: [PATCH v2 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v2-1-c498313c1bb5@chromium.org>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>, kexec@lists.infradead.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=B8aDh7OSN02BJ2pf/rcRX//p3+ltOWRPCwelS9y3Ngw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLy7d+A9Xd6db3iX02SAJV6vvpdaEGh+vrOfiGj
 6tTf/XCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS8gAKCRDRN9E+zzrEiA2dD/
 947qf3hcL5NPrOsphwYmep1sKdvBXyfRYLZc4ZAVhbXaUa1/MgZ+9DemziS4H4PuHf4HRniwQR1flY
 nPiupdyswzRyxyjw0zA0B+MP8qC5kt2csBlxYZeQkFsYP6MXmG9YJk3gxNCfGM+zoQoQuoUVuNJQ4/
 hOVs97S9gWlCLnswwemGdrLrwW7sZR7ct69r6RSnIghYgrwnMgwbeqvj+YWn5ph/mwsVNpoRn24tUl
 BZj547MmwJ46BVtmhdf329NS4uJTGRVFU5+kQEe5813/6DYloTvzW/ZDgpG1lreh6tqLdGrn2xouWu
 M/UOrJ3hqHWe8dJh5nRP7DRiDvBusEP24kLBnK9VFvM4extNvGElx6zp8EiOuLm8zumWZDuLcg1EHw
 K4236OoivuGmnO29pu07/YFV28QyVXFpPPr6rxEM9CCSBjw+NCN4lajOpa6ZX1NzEAU1oyazGV96kN
 GZ6MQRE3VS4UHc8T9mnpmM6yLjcBEuGPCXa7UKhdFckX3P5xSCKoRudBQSKxMLSlA27gkVHQb3SXDS
 WW9Ub0jfHM/wB1mC4pKeFMKsmuqoNZZdPJb/u8sfyRvTIpynWuTubGb9QhGV7m8OMVvyWnZTgTHN31
 +JVvGqQ2OhdJRm/K3bhBuajW85vpI7xTXUnb31Y95M2ZWLMoAEiSQrbKhpJg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_083821_133799_69B1870A 
X-CRM114-Status: UNSURE (   9.49  )
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
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
