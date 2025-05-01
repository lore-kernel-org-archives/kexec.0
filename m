Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE2FC369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yI2HlkyQFbJOtIn7U2Rd16qUG9dEmKYGc2pG99S8bb4=; b=TyWQnmr9IkTE8TToCn6+5MseWZ
	k9lpNsDBd02xMI8PTg55qbTdC4+749vLsNK6+Tdvd75uSKVUQNdNfcb5okv5WzDYCqbjm9n4rnZkM
	rqi4S60EUbDRdcuhjZXbjVM+uN+xXgwASmxu3wANbDwdkRbl5z3rF6NRRdHNtK6d1bNz4owK7HIN9
	9g6xYYFlC6u4S0BPeKYpybNvxGN3aP4OgXQePV7NGA0uN6xzGmIFK6R5awT5ZLY2dIlhla3R9/mrY
	+TzolqNIbNvsuS1K60R2Sg+r+mGq7ehV+adUBMga6gw7P2saxtDdJh4gw0Eo4dAqotGT4QwsoJnYH
	SmxBbrtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcxl-00000000BSx-1RHt;
	Thu, 01 May 2025 23:05:05 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcoL-000000007BF-3swQ
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:23 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-736b5f9279cso1280189b3a.2
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140120; x=1746744920; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yI2HlkyQFbJOtIn7U2Rd16qUG9dEmKYGc2pG99S8bb4=;
        b=FaruDjQN5FX5n8oejQ02iXosjRFtTh5WSOZd7wTN+HvTu1aLLxfwCQOkrz1sGy2vrv
         xvfsNa1Cz1LYh0O+PQd93KbQNyyb5FL7A15GAJGst2+WXXaKp8momnGiiepezDt4F7jM
         VDuEFWnd7M1PYFTTF+tipzpT6d0TR4pCHpVPWS8l39l/cDJWQadEP8QpZc+L05XbY/l7
         xLtcyBPXoqvA70wlbJiI99AOv6LP9Zad1BzFYOKKK8nZBhgFMo1eI/OJNLaitY3eVLRD
         nLsW1XLuX8g7qly3KTtO62tS2za3srUnTf5PULugulRg46/R2/fLgqlRxtEm1d74wWln
         sFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140120; x=1746744920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI2HlkyQFbJOtIn7U2Rd16qUG9dEmKYGc2pG99S8bb4=;
        b=aRcg/zQdRkjpYE8LY5LKYfk2fT+8QK7IIcsUSCzlCkHMtMa1lbZx/b467IPPYsFYXV
         ylaLFzWOd5iC29qcrg7q6bM1hX5Z0pKHjp9iiewarLKdMBX7DLgInXgBM1V/xX3ZK5CD
         fuvBx6l7qQmpDIQnV4x7ORqftG4KPcV++U32+eF4wp6+1H3z/O2WCeO7CjK5jGxc9hhX
         jIPgSRK3WkCVBYUbT+l3NGDM35aAPFbBttyAlOcWtumA9g/81ZMtDh+fA3a/WRld2dq3
         XASe22i9LOKFlMuazGzexV5mtyChZh0KvOguE6I7dvn3U7L/tPsetkxUqCeDU/9LeEy8
         95vA==
X-Forwarded-Encrypted: i=1; AJvYcCW/vKy/BwKcAFIE8+NfuPrxf4+voidqABBrXS9IRLZR/9mdkUXbySoYf1Zh+9Vw0YEZDlBq0w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx57J0p2wmNWouLBm0VOtkkdFrfzoT3l/znaO0bZwon+tjPyxq/
	SDbz7VvOV+qh1BvpHrbwkprimZRMe4clHpLXC1YNg6zfoiAVZUvxDAlNWSl6wK9ClIKLRzsjHGz
	I0GzcSq+hI7+ssoBJeA==
X-Google-Smtp-Source: AGHT+IGmpHhKcBDrERp6231eQ29+jikWpthUas+M8P/VxY8mf6RZUuVX69nZyHTF3KiG68E/Ho9kug3/UNXn0GYw
X-Received: from pfbfe8.prod.google.com ([2002:a05:6a00:2f08:b0:736:4ad6:1803])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9cca:b0:1f5:8cc8:9cbe with SMTP id adf61e73a8af0-20cde371e9emr787243637.5.1746140120540;
 Thu, 01 May 2025 15:55:20 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:13 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-7-changyuanl@google.com>
Subject: [PATCH v7 06/18] kexec: include asm/early_ioremap.h
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_155521_971511_04B4F914 
X-CRM114-Status: UNSURE (   9.88  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The early_memremap() function is decleared in a header that is only indirectly
included here:

kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1116 |         fdt = early_memremap(fdt_phys, fdt_len);
      |               ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 kernel/kexec_handover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index a1e1cd0330143..59f3cf9557f50 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -17,6 +17,9 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+
+#include <asm/early_ioremap.h>
+
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
-- 
2.49.0.906.g1f30a19c02-goog


