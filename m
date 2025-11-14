Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669A8CE8D50
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTGqBwhVIw9stl5AxN+42Iq44gONjHHbYM4Z4BBnC/g=; b=JT5WKFQldTBnO71vj/keYHh6TK
	nzdEY/51HWj6FiTbpfQZUCI7gDsPpLjVXzblW1AXMp1mLgENr92DNGFrgSY1ohULXgicI2uPH/sjl
	Li2ykUXdLChNAnICtxR48zTFyRGnVIpHWKZMyJSbwzdmVuyopjdcdeyD401tk/EVvZIw0AC+0L3Ze
	IsBovN9FEymTNKLG1IopgtguVO2pHb+hP2OAs296tlRMHEUdXf1RUr9xwBGEnsBX3V45zfdMdpXxa
	OhF+ES9DLniS0YC4rd8tlfgZTHI4vr8xFX4GSG8j9+issWpze+nJushRIWQS3V8l5dcFvyTjmRVK1
	vg6jbcfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7x-0000000CcwK-3Mdy;
	Fri, 14 Nov 2025 15:54:21 +0000
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7s-0000000Ccpt-0hx6
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:19 +0000
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-63f97c4eccaso2111054d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135655; x=1763740455; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTGqBwhVIw9stl5AxN+42Iq44gONjHHbYM4Z4BBnC/g=;
        b=bRMdoUpPrOWKe+TAwB14r8hAzw0Twq+so2YKT+E3XGrHO/Z6pRB9BgPYXAxGLCSlnl
         1vzmQIo+beMbYN5FNk5nEbwaen3eqGMl3JPts9qzGSNVYreUFGkHZ4ktur3DnMnF3pTk
         ewhCP2Ib9gGRok5yqqk1mBlIYDQJs2eJ75qcNqdX6Wy9ddrQu8xS8Wqbc5dkKX2xMx6h
         heXE/AK7388hkBuu66ttzpMdGJ8ZPdAuo9M1FGY8bIuEjrzhYy1QlOVYs4AYNpUtAQHp
         pClvRBp9KiUuWZpZp3hk4Oa42ICEoC7Ln+uJvvBhNwx1HckRrVMB9JDA3Y02fHHbXgJr
         JMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135655; x=1763740455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTGqBwhVIw9stl5AxN+42Iq44gONjHHbYM4Z4BBnC/g=;
        b=dfcfA3gjymPlYpszeK8a7OR1IAsd9OUVK0t9ZJWb0Cr6ags19+TRIm2uFjPeycDJK0
         kRbXlj56i8AtHg/W4Oc5FhkF1wIu8kEQaCbJdR/HKe7ytIg7n87ILMJ5dA1FSQDmbC7v
         SZ5flJ/KfBWT3LWMuWHz3MUUFmuRnUO20imfzti9K+sW0U9YuShGRbFz9oBgGUVCVQrx
         4geaZUaFma4BzP50B2M8ZoFv8Eqbdk0qmTZIG8w2tGuOoaOl2WqUm+y8kyVgeg/wNyJY
         bUYpKISfaQjv6ez1oTA33ffQ4zTWzHvbviayoTxGjFFJA/YXh+5PkZkcRwOE/CnB3o+8
         Iw1A==
X-Forwarded-Encrypted: i=1; AJvYcCVip44SuebJoT9SNF8c6ZpntFIaCwW6hCGCWRUNQaAWI4zfwpMb+tlDvC/bXt29biKKuWhO+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZDLHoIzN4CjxwDDMeNQuqHuCEB4EU7BFbTZv8D/yTypsDud2F
	udPgoBlHifPe9lL5KfUJVl2OGxS1/QhtwX0A+s3vcphrDN7aIBPrrjG+q0eTRFlElw4=
X-Gm-Gg: ASbGnctlLm3fzwmTkYLy6l2rpRBUVWy5/xHx/P+gHefPcgQC0ouuA63yzLrsHJd5DEs
	8wsJYfSNSUQ8GbcOHyoUxzb6VronrD6F0df9eapTTq3iJ95zRKxpJLp9/HiKjanGk//w4TJyjW/
	FWDQMrxbYjObyQ/Tfx0ZvRTNQlr3fWiC5uujoBHYvnBOGHxiXwYtUPBupVvnEufGvKX84C4XPEX
	On0rowp6fbWSyvksoQP/+XEDpidJJmO7JsOC0bflxk4snkR+B/H4gBOZYIS/6bUlWtu3IzxZXRi
	qI++zfDQRlRobkxXy+DG0aewmpR8IBPFq+8kEQNgvUyF2A0hOSN4FWQ3TCRGnPQNhXrr+jgUnEU
	rxcXV0sARwA2qGJxzDfky4+oP8pjff5j8W0ZLQsfx2jl3hLEjuG2F6R/sU2lPj25X6VWGm3Pukz
	eC/d6omN1EQ34MsM88y0JIDeYYM8gQhAEn6NxRpsYCqqzrR6VoVzSLQ7DpEVWACPwZmzDxY6LKc
	sufhLM=
X-Google-Smtp-Source: AGHT+IG4mQw8nEL1m3idlNaAXf7Kc5783jAJw1K5t9cvJ10mUhr5v9D0Cg51BzHrwu9IlD9mh5aUEA==
X-Received: by 2002:a53:d058:0:20b0:640:db91:33d6 with SMTP id 956f58d0204a3-641e74dc5d1mr2579255d50.8.1763135655068;
        Fri, 14 Nov 2025 07:54:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:14 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 12/13] kho: Add Kconfig option to enable KHO by default
Date: Fri, 14 Nov 2025 10:53:57 -0500
Message-ID: <20251114155358.2884014-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075416_214184_E9AF8BAC 
X-CRM114-Status: GOOD (  10.72  )
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

Currently, Kexec Handover must be explicitly enabled via the kernel
command line parameter `kho=on`.

For workloads that rely on KHO as a foundational requirement (such as
the upcoming Live Update Orchestrator), requiring an explicit boot
parameter adds redundant configuration steps.

Introduce CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT. When selected, KHO
defaults to enabled. This is equivalent to passing kho=on at boot.
The behavior can still be disabled at runtime by passing kho=off.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig          | 14 ++++++++++++++
 kernel/liveupdate/kexec_handover.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index eae428309332..a973a54447de 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -37,4 +37,18 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_ENABLE_DEFAULT
+	bool "Enable kexec handover by default"
+	depends on KEXEC_HANDOVER
+	help
+	  Enable Kexec Handover by default. This avoids the need to
+	  explicitly pass 'kho=on' on the kernel command line.
+
+	  This is useful for systems where KHO is a prerequisite for other
+	  features, such as Live Update, ensuring the mechanism is always
+	  active.
+
+	  The default behavior can still be overridden at boot time by
+	  passing 'kho=off'.
+
 endmenu
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 87e9b488237d..a905bccf5f65 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -50,7 +50,7 @@ union kho_page_info {
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
-static bool kho_enable __ro_after_init;
+static bool kho_enable __ro_after_init = IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
 
 bool kho_is_enabled(void)
 {
-- 
2.52.0.rc1.455.g30608eb744-goog


