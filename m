Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86C4C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qbwW4IA9oF0vuYQbubMyDJ3LB3+22ybLDUB7+7C60jw=; b=12HQxVC5ytZzf2
	/xg2vn5eUnmLbPrWo/g2IzqZ+5BVnHiJT7JHnAXJ54YPZm4TNRSiy41P0TdnktAmBrrXwMR+VjnJg
	5b1gdH9K0sWRuqEQxaFpoGjXCn/3sl45MnaAZrJtyh5R8GYrLyhWHYNZDrxU3CNZRQXm+ty01sE7S
	cMV3KtEpLGWRcwTUj672cc5mJX02iKmg/ayRw5AwsX20LmRRHGGuyc1K5UgiBWdHOJPCijC2ygH6h
	/TI3hVSoB9glhno6+774hU/SD9VwFICzbfPFkKtIAyaRg4cH8OjouULtvkNeF46ahdNa3udHCdTbG
	AWx7b4qbw2sxKOE1t4Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8SfQ-009P2i-0u;
	Wed, 29 Nov 2023 22:04:24 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8SfM-009P24-1U
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 22:04:23 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9c1e39defso3966681fa.1
        for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 14:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701295457; x=1701900257; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKHPDx2HvAschhAT4t+Helg6cS13lBVJniqEfNCvja0=;
        b=G4f6ohiLYrJLGOTvATLgWgNCqyXy1UIBJeGWaRcEi77vnfTDyHbKtfhBATnVRHVhUW
         B49jNrKLKlPDBrIFEG41Ir+xf9OZa4dddi5AzGTtKRj4TH7rGDmEIuVSb9kKAqZDe1nc
         AznwW4lCcH/bIW8sUULMNoIsDaXcFzqZsyHn5C64nCSVfVH1k+cwHvSRhBxetQFFkci5
         axi1btAFk3D1puqd40a8tx1OP69t9y1kroGn6fgTBFw5R+HCMhJwP6zzqP6uoFrl1yBO
         vGb5O6FoezvXNL0bZa1N+ouHoGx9V4Sxt0nZE8IaVhQr4RhwS4U6Ga48LGtDU7TdiMJR
         QiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295457; x=1701900257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKHPDx2HvAschhAT4t+Helg6cS13lBVJniqEfNCvja0=;
        b=e8DK/e/haOmlHLa47o4Uzh3QYNlNoV4HdvL2S1/dDw9elYPERtBASYyrnMj/PYNryr
         osSSWq04y1wP2gPn6C67OEvrjAuaI5PxyQYLsG7jzU9XQSfQDk6QQNkTjB9SkDItua06
         zG4Nra34UCPQ0zFZh+nKYemdqjSxWfL8yAFUWgtZiyv44vs0TMJ566q3+ANjjRHjEPwD
         wLkmn/QHdzgZUgYp/9NlbWCIbcP9UBaliGVKf4AFi5jSWryWPlIxPEsp/cnnxt7NC5Wb
         YRjzEDEK6TlPkr5mtC82a9VF06GAdHMgxaXE12J/wqsy31NlvSwDKfsuGL+y81Mx6TK+
         l/wg==
X-Gm-Message-State: AOJu0Yx9bpfvaaGroOQ/nM/JawDv0BCBtis6ovGrhgq/B3OlUUR29/DI
	kTq2IGLvQVeo5SqkrNgBG9swPw==
X-Google-Smtp-Source: AGHT+IFWmrAg+Dmzq8QmUy4K/ehWB+QhXz+6IfdJ+KHqnDjELCrzZyOeBmO1dxt06NCK8MJSCiWOMQ==
X-Received: by 2002:a2e:b815:0:b0:2c9:95f3:d71f with SMTP id u21-20020a2eb815000000b002c995f3d71fmr8576365ljo.16.1701295457093;
        Wed, 29 Nov 2023 14:04:17 -0800 (PST)
Received: from localhost.localdomain ([87.74.204.186])
        by smtp.gmail.com with ESMTPSA id hg11-20020a05600c538b00b0040b48690c49sm3531673wmb.6.2023.11.29.14.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Nov 2023 14:04:16 -0800 (PST)
From: Ignat Korchagin <ignat@cloudflare.com>
To: linux-kernel@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org,
	eric_devolder@yahoo.com,
	agordeev@linux.ibm.com,
	bhe@redhat.com,
	kernel-team@cloudflare.com,
	stable@vger.kernel.org
Subject: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
Date: Wed, 29 Nov 2023 22:04:09 +0000
Message-Id: <20231129220409.55006-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_140420_509910_8389F314 
X-CRM114-Status: GOOD (  11.05  )
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

In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
required CONFIG_KEXEC.

However, it was not enough at least for arm64 platforms. While further testing
the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP is unavailable
in menuconfig. This is because CONFIG_CRASH_DUMP still depends on the new
CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit 91506f7e5d21 ("arm64/kexec:
refactor for kernel/Kconfig.kexec") and on arm64 CONFIG_ARCH_SUPPORTS_KEXEC
requires CONFIG_PM_SLEEP_SMP=y, which in turn requires either CONFIG_SUSPEND=y
or CONFIG_HIBERNATION=y neither of which are set in our config.

Given that we already established that CONFIG_KEXEC (which is a switch for kexec
system call itself) is not required for CONFIG_CRASH_DUMP drop
CONFIG_ARCH_SUPPORTS_KEXEC dependency as well. The arm64 kernel builds just fine
with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and CONFIG_KEXEC_FILE=n
after f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP")
and this patch are applied given that the necessary shared bits are included via
CONFIG_KEXEC_CORE dependency.

Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 kernel/Kconfig.kexec | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index fc38f1ae3a30..946dffa048b7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -96,7 +96,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
 	help
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
