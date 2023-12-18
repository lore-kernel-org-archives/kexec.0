Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A417C35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rTyq5YZOPfznlroS0i9uPEUa7aF43L0RxGg14vuFL50=; b=AMD0/w0rfbId2J
	nBLh4Nxb4hOW8gRhFVtvBUBRgtkmJEQSqoZiPUNEmKSNiAkx75szxyqc2tQMcAZUVmiajB5DhJ+nl
	O2MGrljvuSegg6J8LwRUzZXPS4GWTS8rJHLjeqNSYAP2zJzd0xZCwrTcsPQQP7rKWyGaCpVkcJqAL
	sfb1h1lY0Un0JoU/Emg4PrI+5XB5AVGCLLEQ3JfSiJcDdtpleSwunM5XLFk0M5rpOZczFec5S/5Pz
	jeEwS3Yww1jyA2kzGb1JC6Vgr69tmOSg8nYI54fH0pygBAq8Xtr87T6AcXMyeRK/rfjP/pmMWEh9i
	sWZgR+tK4iUa7DkkbdTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8r9-009RtJ-2q;
	Mon, 18 Dec 2023 08:20:07 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8r6-009Rsx-1v
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 08:20:05 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d3ce28ace2so267075ad.3
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887603; x=1703492403; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YAACVwh6LABjx2cqfwoLGdttQf359RVTJ+eJIipT0M=;
        b=j8rAwPKMwNXRfjERakooIS8COLgmPWnPMEuKzYPG4e664wMqR4dXcOpb8KHwtpmxya
         10iauhzkYqS5ZimXhRkTTivn0xc8ThOLQHdEwXnw4c/LdIXwTHCNYrDaWj3BaRIVLuKf
         Ra5aW7UuYwZokh70lhPqpL1eUF2f8ffCAYGKmgsxhGHdlly0srd7LLIcD3p1T3hI2u3X
         MSB3Tryz8wPaHvxFgw26BHW8KRkWYls1oX8L173VbhLAFwubNOGXR8sG1WU++U/XbEut
         sKwqetVp9+T8DkzQjUX4P/IRgT75nQN6GEHyn5Ks9nIQwKIqZIcbtUiFR5VJy5JBk2+T
         IcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887603; x=1703492403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YAACVwh6LABjx2cqfwoLGdttQf359RVTJ+eJIipT0M=;
        b=myeq3gCwYvzPXQ4UrD8aO/Rlejc+KLgLJroMgOLfxlvC0G5oMiQ6bCOr6wH1EoR6GZ
         /G5qBkE7bM4pFGCwuZNoYBwXcL4k7qEhmAInIBVJar21RJzVEfx3F5EMDMwTB+javHwm
         coDy4GIYNWQ3tWt1BMr8EYccVJrgfE+wjbH8M0JmjPUu+U4kLnE3IHxsQ0Gboixz6pH4
         oodsUrxB6jUwRaL8n6LKv7VRGRm7tlxHQJeuHboOkO73XqTekkFNkTKv+Klqs9+l6GjS
         /D4ednSAjEz0F+LD03fEhYE7U2eCL/OvkkTKKsI96iAbyr4imTi5L1s5TVsDVS267rVy
         0W5Q==
X-Gm-Message-State: AOJu0Yyb/vCaOBdYRmAq/IoBcyhAFWIIoRsbpl/saB0R7JVr0+/kWf89
	yLjQCbbmWeSyE1IIJLFQzLw=
X-Google-Smtp-Source: AGHT+IFeEZ0CLf+tmohh8vFRK+lWimcFHZcpXRQDADFKOc/fvOLCMjwl0B5vCWo/kYvEqzDk0IxC+A==
X-Received: by 2002:a17:902:dac1:b0:1cf:a70b:39cd with SMTP id q1-20020a170902dac100b001cfa70b39cdmr20550839plx.39.1702887602965;
        Mon, 18 Dec 2023 00:20:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:02 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/2] crash: fix potential cmem->ranges array overflow
Date: Mon, 18 Dec 2023 16:19:13 +0800
Message-ID: <20231218081915.24120-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_002004_681189_9F3A6BAE 
X-CRM114-Status: UNSURE (   8.80  )
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

This series tries to fix the potential cmem->ranges array overflow.

Yuntao Wang (2):
  x86/crash: fix potential cmem->ranges array overflow
  crash_core: fix out-of-bounds access check in
    crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 9 +++++----
 kernel/crash_core.c     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
