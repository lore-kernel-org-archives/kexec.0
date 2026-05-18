Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655C9CD4F52
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=; b=JWFmMrVQsuMUC/kW3a6H+lsujK
	LiKU/sDqcf1VOqMoQ5k2PE5votNt2wAdrdlVzV5Wm4pGuAXnr2oTzI88twgfQeDJkKzU7JJJ4HHFm
	ahHQC3AP4S4DBV5t6+GYhdU/HuY64lQL3iUdeQ6PIxkKMlf4HCFvENRUWXLE7HcuS01+ENKkrgis6
	e2ru8aBquOn3NfaJdy0NnwXej9WfenqeC22J7SZty5dwvywQjndonmHcHzDXzU+o0BjXF6OuMFdG7
	RrKi3uOfeWP8UwCOEYHOFcBQvtS8ij+gNQ3FbhJgFOz4TyMJgR7Tttj3NlJHj36ExHVz5nWck4wgZ
	NAAlGszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUy-0000000FiIk-1g3E;
	Mon, 18 May 2026 12:55:08 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUu-0000000FiFG-02cN
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:05 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-8b4298d271fso54073766d6.3
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108903; x=1779713703; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=;
        b=kMoNBpraxnOciM9Z9oObNx2eyjeEN1Dk3LEW2/e+PMgYegCAgttFsVvacsCdByt7Je
         kJbD/1eoe/XuquZNQjsNRQp0hi93cVIDr/5QFo2wLFHxzNwsPOzxXmS+EdTdZkm/Zn+p
         cgEPIvV1pXMITuipE2OX2uC0U7jGL3j7lIb9vtAJSKUytX4O3aKwbDLB46LxD9z94W8k
         rQaBTr+Uakn1k7JtBzZ+fpUJPIV9xCqE1MXWznuK+E7EXv0jVZDg+325kPuFwtQ7+dwi
         tg0H+RLcz7BVnXaXW7rSrCisLCCM7LCd3NcA9L6pa3Jj7EtpTwlaEVoZf1DqO+rpN+i+
         m1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108903; x=1779713703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=;
        b=I4bX2Co45eBpnbmMurBL2jO3LmuRKvrc6m5IoV4D5ntIZdtKkV9KvmDFz7daKf2TLL
         4g3lnzy1lzKyGs8IJ3ZIFVr3tnDS1NC1BN9X8qaJYJfJTgIpth8g3PTr52cSqQjKIevd
         wcEq9XeV4J9MgkjIjcIfB1lKx42NBPvAIksdj3PcAQfUVJVcA1PYw7WbYA9e5agtO1//
         NavyG4rukO1NS92t+vGt+9jpVvvVBv1fSmE8m9ODQa31Hh5ROrNrKUHZfoRjcGFhygrS
         E3mft22zLQ9taMs/M4cs+JwzTRoT+I10hi8aBBIQcPkrCB+BsTvwhzaRifoi/072+A4J
         fOTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZrLyUcUOkoAZycnJ4zzYvaEql1S8GOf9PhVxpkCu30TJ0iHt03FuO5ECI3gSupgsdsnfcPw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0bAtXB4l5YK0XU8ppIdkkIo27NYmHVYYVBi1X9n+0si94JmRO
	aT5n8ILhpnwi5kX0K7YG17PiVOvzJu7Hg7FsKiTWoHC+bSPZDGiVoXHDnm5jmjcfvWY=
X-Gm-Gg: Acq92OHYF10swtawfHZVEC5ots1jzzYOzi7HwychRN5YuLipzLuGq+78StqfyDhmAKq
	JNKlTb14ORSmxGOKALuP8TBrlyu3jiJBBNvQc5cOdpk2juQqauGCI8oQWGvvVZxogM8Vr+kq/KX
	HEPNhzwQsZjRxi1WhqYoGLUpgUEw8Fo5mv+wuvrNhVt/V0FIx+vfTv79kYutkTYtygr4VWJTuQT
	qg4x5VT3TfFWSr5ulCWeSIQA6NuIxAJCegVT0N5uO9v+SCukwOAUz9m/VdNxCFDnU698Rs2PvCX
	RmuC6R9/tPk9gg3J4RoKyiYPpc7nN5LYEKxauuAcgMZBpXj1CGTylc3R0DuBeVJ/vAYd1WCwx5R
	HSrC6QXOZRRAUT4ncIQN+cP/rE9TTAvj+PPro3WHd6TKeTOJ0gOMR54idKdfMNVrK93Ma40lUjV
	Vp2+XGHG6p6A/+KeMeraT/E+m5QcjDhcBdOERYjnXWEHkOtd/zio1THiIEoHoDEA==
X-Received: by 2002:a05:6214:5406:b0:8ca:2a4f:7364 with SMTP id 6a1803df08f44-8ca2a4f74c4mr147898426d6.29.1779108902898;
        Mon, 18 May 2026 05:55:02 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:02 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 1/5] liveupdate: skip serialization for context-preserving kexec
Date: Mon, 18 May 2026 12:54:55 +0000
Message-ID: <20260518125459.1092373-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055504_049744_705EF3C3 
X-CRM114-Status: GOOD (  10.02  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A preserve_context kexec returns to the current kernel, which is
unrelated to live update where the state is passed to the next kernel.
Skip liveupdate_reboot() in this case to avoid serialization and prevent
sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..dc770b9a6d05 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,9 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	error = liveupdate_reboot();
-	if (error)
-		goto Unlock;
+	if (!kexec_image->preserve_context) {
+		error = liveupdate_reboot();
+		if (error)
+			goto Unlock;
+	}
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-- 
2.53.0


