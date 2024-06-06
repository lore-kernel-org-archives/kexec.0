Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3869DC25B75
	for <kexec@archiver.kernel.org>; Thu,  6 Jun 2024 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s5yM9pCpqDuQ00YxpiHr+KCfvlzHG3Ly5qfB/Oa0iTs=; b=X+/0UW6/NcZ5Tc
	JbMsaHkWbPZ9WvPeoGJJDOCH612B7NAXbaGIPr+QBrRCsWB1F81LQIX0EMlkF30anNxUALEYyHc6g
	otOnNdHNdsQ8SlWQzUPA4epSppSAJu78T/UyNd76E0IM8OiCsfpTaR/lmYyNacAEgLevmmTyKHGTH
	DGaflWhvntam8As9xwh2gYMA8/sicLnaS8qAqWmXRKOnQwzI9g3Z4pqX9aRffk1/WB8fFcbHnjHdD
	OzfkHlqwdSMEsJeKhSsatVIS6Me1/JwCpNJzW1kEld3Zj/OkzZod2PsY7FdCQ6UOzqA1hs0MR98hJ
	OAf2O4YoheuQxZh7i4mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF9Cl-000000094SC-0oeX;
	Thu, 06 Jun 2024 09:14:43 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF9Ci-000000094Qh-2OGq
	for kexec@lists.infradead.org;
	Thu, 06 Jun 2024 09:14:42 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1f480624d0fso6664165ad.1
        for <kexec@lists.infradead.org>; Thu, 06 Jun 2024 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717665279; x=1718270079; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fhIeaRcCMzGBPpV19PrfDc05zFokc/RSIlEBIMrrrQ=;
        b=Adukn8RqCek8cR+CRDhyn/K/LmBvdip4PpNgXpss5QT9h0FxiS8IZOwMLZHaWM0/W0
         CAGxLEDW2SjLB65k7N9MYTbnZODPYo9x6Qgd8hOA8AWfQcbLaFxH6160+vElhlePUWpy
         SYpZ/OacbEKYArLrHNNmKI9ZBMUfA4sBuE4an5yqJtzaSy3ZY7Yy5lTAoskBu7SV51Le
         wIEcEGlqnsmBCI7UsUOUl4jWzR1BPN18H3j6mkDvBj6ci9yB3ITCo73wvfzxaRLHMLn0
         F4dnwlidkdnnncH3iIbPvfGyaMDP5PgKQfpjS/fW26Hn7X0uguX3sBgKCZc38hCpGSHK
         MckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665279; x=1718270079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fhIeaRcCMzGBPpV19PrfDc05zFokc/RSIlEBIMrrrQ=;
        b=JnojVBtA3lmHn9vsomsdDvjisUx2ayjECbF5l3PPKSfewcNtanmPYXw0cFGOVkxj8P
         cBUr/ZCLTwgXS97I94XnOiS1OvIeeB9ZdLwtGnNTNsqJiFzon6/LMp9cYVAta39VKEfs
         v5z4hiZwf9X54KpaeuyA9pr8Q04400e0AJ6KnObncOVrG+9oPKZLn6xxQOgBfjukVpDe
         m16jPYJWqa6WGLorfapmxp7vhcwduUnEUihq46dv+t55zPXY47bmWZsj5h3dKguKqHSz
         1mT2/YJB7t3gzhhIWqbPAVTzamGVwwb577P9BmRMKwJJ+kwyxADCtJRMlXLojIaew6wa
         BPLA==
X-Forwarded-Encrypted: i=1; AJvYcCWJzionbBnfxs9dHdKnobL94wFn0OZY3ELgaz1VJb9j9fgj+DZsSAiP1UTd5NzJFSiN+ro7rC8wYdUjtTBaXT0Qlk5Q4YNixS8A
X-Gm-Message-State: AOJu0YygREGwhcatMJG6iC8n4G5aIPdAv8NxBh/mE7wCqyO7oF/GbOtE
	Rlt3Yix++rQ8osVhWEBH1L80oTiW9UwhYu4pNf8OHa37H91vUPEv
X-Google-Smtp-Source: AGHT+IF5k9Bai4WGe3KRzNcciXc4oO2u9bq1QeLo5v+D1JkD45EnEox6Het6L88N1X9bGqyVh8JoiQ==
X-Received: by 2002:a17:902:d4c2:b0:1f6:20f4:196a with SMTP id d9443c01a7336-1f6a5a161admr58883265ad.32.1717665278794;
        Thu, 06 Jun 2024 02:14:38 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f210sm9885505ad.48.2024.06.06.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:14:38 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] crash: Remove header files which are included more than once
Date: Thu,  6 Jun 2024 17:14:27 +0800
Message-Id: <20240606091427.3512314-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_021440_636847_3ACFA773 
X-CRM114-Status: UNSURE (   9.01  )
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

Following warning is reported, so remove these duplicated header
including:

./kernel/crash_reserve.c: linux/kexec.h is included more than once.

This is just a clean code, no logic changed.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
