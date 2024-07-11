Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778BC3DA47
	for <kexec@archiver.kernel.org>; Thu, 11 Jul 2024 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=g1NxGDKthJxQuzr4fA4dfnWMXAyzvko/i9QwW5C+ZAk=; b=FpX6t4gkPlRtCS
	h57WHtQCvHsqIXFcvzChhGHOyhxrFgKXCY14mHIGXrkdlNbOG0zxIiYucbwdyvGkCOcFB4X4+xB8v
	1Tb1FyZAdGMUP0SRiBPaCKTXhxKRzpg4terSpbnUEXXJDm6mcf2Py+DyjVz7CsDTbzzz8FXCJwk+1
	t6i8xoHOvm8VHNMe4Dy2s+DOENjlZGR3mu6PsIpHAsCYYykoWJCPTPwaXigeQNFKbgdXcXhzMOdBt
	9c4ZkoIho3TasJthAHT1qO7pczaTK3eq7I2s6UJgr20/ma2tco/utJVcPFeGJKQIppL93ZRb+RnFo
	vFvj0pVdOgBxRNCVNHzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRr8Y-0000000DZba-1FEX;
	Thu, 11 Jul 2024 10:34:54 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRr7t-0000000DZIk-2ZXK
	for kexec@lists.infradead.org;
	Thu, 11 Jul 2024 10:34:15 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so778308a12.1
        for <kexec@lists.infradead.org>; Thu, 11 Jul 2024 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720694051; x=1721298851; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1Web6fOpG4PfW7GgX8Z5K27/fHkBluZOacmcz2i6E=;
        b=Hi2+9YTGKbyh4U4ETXg9iR8ZSAGAsYXonlIon+JFu056u91jREAlSwdRdLGF4U4oew
         hyuL5jn/u7A+SrK2k0rdiBfzxC/yZd6jsN4dYS/YMcHAkuA3Cmk9DjWpAUHTGAR2xaiv
         qqap8Zm+40HqkldnzHe3fjltmrCe5j6KxBmtq0qSSEY8/iH85Iaqu4nAAA6njxhYt+tM
         UG96c6oZuMPleB1DNsfrGoPwgUdtMuDFsJzvw+1TYFFyu30jPOpKtoLQ+St1siTYzfUC
         NPJIBJRx/ydlMspsy69RzfpF7i6XZHvCzn0iXCqGqX3yZJEk2wJy+ThN6qVI7/NKO5Zb
         s0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720694051; x=1721298851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR1Web6fOpG4PfW7GgX8Z5K27/fHkBluZOacmcz2i6E=;
        b=J05bjK/9GFAfMFBQLbjjHlZfs1vEXT055EtobCaAFKQwTkUPpLXeOAWkjX0d5sfV+J
         MNuz4RF7BCFLpwdvhUBtiOrE0CvPMEJBQ9/NI1H6Y6I78e9xehH2IhquYCUx7VrLyzF3
         N44lMh8oz7jXVKo3cdJUZlaw95eie4Us7e2/4BhlEFbGXK+dWU4+27O3kWR5VE8OzuKf
         hBYJhXfpXC4JOw8H9X0FZVIVFKNRWZ7T7L3wGlP4SpvNb+WpZfV34xpV+6DjA6Ha7uxi
         YZd+Xgwey6wuxxLVYolyAPAY2BRo5cSc3T2CrItbKpSiTMqS+iun400XcTii9coG9DqD
         vq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWYJmF1GZCcgj6cJnkcqkhqhoUKNxLXXF7vfHoPZCIrVhMV82FSSwijYLFnXjiAlpWdf554q7Mkz7POHUld+F5vE9KBPCRhIqhu
X-Gm-Message-State: AOJu0Yz5pS8Th8Py27eGCeCwGwgtFIf3j26EKJD1qXxQrVSIUV4A7nk0
	n+tbYXGEEGAnoU14QYTVr9xAzWvhuDeju4OcXFJtrRP3nIbO1f9cf8vHb/qAzkU=
X-Google-Smtp-Source: AGHT+IESzBPL1aKKBD56be1MULJXc15BES/x9i+LATELu4LzxdGOdNbDaV9C405YEadlCd/JoNnfNw==
X-Received: by 2002:a05:6402:4316:b0:57c:a77d:a61e with SMTP id 4fb4d7f45d1cf-594bab80111mr6037655a12.7.1720694050942;
        Thu, 11 Jul 2024 03:34:10 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cf60sm3296192a12.26.2024.07.11.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:34:10 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Petr Tesarik <petr@tesarici.cz>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Date: Thu, 11 Jul 2024 12:34:09 +0200
Message-ID: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_033413_682354_A5B63307 
X-CRM114-Status: GOOD (  11.60  )
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

From: Petr Tesarik <ptesarik@suse.com>

There is no reason to restrict access to this attribute, as it merely
reports whether crash elfcorehdr is automatically updated on CPU hot
plug/unplug and/or online/offline events.

Note that since commit 79365026f8694 ("crash: add a new kexec flag for
hotplug support"), this maps to the same flag which is world-accessible
through /sys/devices/system/memory/crash_hotplug.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c61ecb0c2ae2..73d69791d0d3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
 {
 	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
 }
-static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+static DEVICE_ATTR_RO(crash_hotplug);
 #endif
 
 static void cpu_device_release(struct device *dev)
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
