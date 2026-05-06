Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DDCD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 04:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FySBmUFQUiatNJVHzTI9ybaQ2WEfq3D0Yr8fH3Kbiuo=; b=wSoa3Emqw1fp9t7y1hqNgK4Hd5
	ld1gjUV5EmBJfMFMiYTWoUCcSPoA11rwkwUem4iJAQVyJgNgUXMnawFlUbKMstutVZzUqzCskhgKw
	+Y8pd/X6l9PGbEKka8aJp+z1lZnoEgXD5urKforWRs80+uEfgVBtVq3UkbjHTSH5xRQfBLvGYXNId
	/0V9XW+/fGXEIb++dnXawMEYyKw2XZ/Xx6Y5Mw/pwuGEGcM+1eZuzysFlk/Hm4yzRe9LdOiq7VAmx
	aLIzJaI60tr9Ubke7cgo/enjj7L9DypF5N0mHwlwgEEgsmbryrl4iK7/Dgu3TIFB/P+XaO4K4eP4z
	Gz1G/9NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvo-00000000hwm-1p7w;
	Wed, 06 May 2026 04:32:20 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvk-00000000hue-3LMT
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 04:32:18 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-7bd810cdc5dso38919977b3.1
        for <kexec@lists.infradead.org>; Tue, 05 May 2026 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778041935; x=1778646735; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FySBmUFQUiatNJVHzTI9ybaQ2WEfq3D0Yr8fH3Kbiuo=;
        b=GADKxMc4jrQ3z8Y7A2RMz7yeKrqAHieel1RWWffFZgodO4IW5i8y51u3onKkGvJh1r
         u8n0TUNVm1kusAiCjPmeF8iQTZ9/f1v8soc1LjcYFR7wPq2Miz1q5+FzMQuyp+q3x13N
         zwGM5BA1l6IqWOePyvg49Qi30mJeoHsf4qlptEJza/4lqZuOjFfT2gKgNV8/48zkuHF2
         yfabm/QMyHsk4QQBi2onVsfgU1jcW48mpavFiiibLq+Cr0fzJb0AbsWd7atUpRLEEWXY
         Bm87E0iBumzSfl9Koo4ZCfX4WLahvyhw6XaJuvAcx3wv33h6v92tpMVlE20YlQ1trDiv
         PisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778041935; x=1778646735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FySBmUFQUiatNJVHzTI9ybaQ2WEfq3D0Yr8fH3Kbiuo=;
        b=O7k97xIxVgD7Cbx+KYyHmA6nvBXF8Hc7BHEjzroscEP3QN/pce4A4UY1ocbHPH2lH8
         yjL3Vz0aWgyt7R9DJgGBv36n7X329lFr5ZM8oX78/T6KmPmbzNdYpGS2rMnaxUS8UHOJ
         8HdlO403qCUy8bzc5Xj819v0tnw+WUhpgnn6Mwonk3tytJ7c/+hUB8/7uBE4/1I6OzCT
         TRB51/2vzc4HkWu+/85NOBalAf/TwokELSiTn40NHCwSEI17jMTSN60RvrCIEFg+5HEJ
         RqCqmYZ/LMvFGZtvoEYtBgzEkjHrVLipP9t2dz6Pb4fKkAhM3vbpqjag+KpwjjtwWq4q
         NX/g==
X-Forwarded-Encrypted: i=1; AFNElJ8gbNUKkhU8homEhDdCUv1ayCifIBC3xq3CSUAA0ebIzzS3f75MS4b0GeHpbOqwiJdWL/tuIA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPQ0Eh7U0Itpo/JtCrwRz9mEQSpjhwodNyT0tgrt7kW5hneIRD
	nQ11b8t39vmpGEPzkLv+aw+H0kDynxGHIqbbnk2BwdZ4mj5No2CodCp+pqzWAm6D8Ek=
X-Gm-Gg: AeBDieuNtJXR7knAYDxHzJ2Tt9jng9VMLAW+X7zyJc4/vcK/S4PMo+djKyJq6w4top1
	04yyOCHy8RrmFsqAI93+ta6HA9hvjQJCOTOVTRBRma4QLJnmdG5eGwZtcHRBNDTW1Hk7cfpMw1K
	kqOQH3I71f6MpvKvH/0MKEjJFxOw9fQfo8DtCrmyT+UXG1uFlbhvJvLMDnVaxOiHQ8Z7XkiDBeg
	QjdeomIHm+woo5qWBNp6T76lLrZaPv5JvAeLmRluUGL3dJ2dOONBgAGi4wi6DZL6KhrIKAqPeB7
	tW4WoU4jjNTlp9yIrFDR5QuhFgOREO8nyubJw4LpJI+OqeDMrKFFnEoWklBCKv1f7nB3Y2InL61
	yBbo5qS7KkWdSY5ZHLd/T1aMetzzCmMhY2B9Rz6JvSHMJP1+tFq+Ai4XkUBJf5mO1iccrtM63dP
	a8grPVfgeE/Pxh6Q3jYjH9wBXq2KP/IOsetkLZ6Gh3nADpMTUjhVVhffelpD8q4Pq3dGT1hXNz5
	l3ydBjKagDUGxMfRY/iAoNT1umUiUp1d/ySux19KN9grvvNEkoJgasPILe1
X-Received: by 2002:a05:690c:4481:b0:7bd:7039:f2e8 with SMTP id 00721157ae682-7bdf5ece5c7mr23917107b3.42.1778041935058;
        Tue, 05 May 2026 21:32:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm73436997b3.23.2026.05.05.21.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:32:14 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v1 1/3] liveupdate: skip serialization for context-preserving kexec
Date: Wed,  6 May 2026 00:32:02 -0400
Message-ID: <20260506043200.2025677-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=Ig3b6ApHyjKcgSwRW4zZUD79m8ad3QEyXLno+AsOJ08=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+sRCF1pdq1gFDZPkEGvvAeskFeVYoUE/Q4WrZ
 PyB3kKaDfuJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafrEQgAKCRC7dyhM23N6
 3ubeD/9Hz+RdPTeGlmA9KZ49hnSWoEtrawYss52P4vEvfyFRCX8MPLb2eHGK39xuKeEmGcGRWUT
 siS4z4LJhIKxkgUKCitBE/XgtOvmPvIVXM7w6SAiSpcKEdtckzhgBtRN+7glKK3epqQeRjRH0j7
 HQr59wG8dDI3ycZckRAtARme0YBgtJ/eXvf+j/LfIub7iQ81S/hQlM+Y/BgqTQnWKTHXOmt0T/8
 9L3Uki7/38VyPjqWozWKcmwdN3b2ycdqgLj8tP4XSPT8b9pnAKT+E2ksQdVidGuZgNInSwU3lsI
 Ya9bPeKPuM7Y4/3gwbpOuORfmmYDMEbO0bI/vwgRH2duMTIpn6N2nA/BMSM4OMPKNuZAFjPjn8t
 4P4+cgLF7Djwq1nr6XCgqf0CQXBreSYzLnRtrmcbA3ze9b1ZpW8veLgNicP6RWsZzdJ77UO7rUk
 VkjcEaKSa9e6dsNtP1iYipLYjn24I0jdhjkzKXKCYfqXIOQ77Aa7BzuoehLP81WBzy8eDkQhYcx
 7wNn39kFLKsXNvdz01i/KqZwfYn5nLT4hAAoEo8mc1EnVaMewPNhm48WZpyRw+etcJbIjqDGNDc
 b8KpFMtq6X3o9ffSyfoqqQ7r9MaDeYXA/2Dxg/KpckFNOkdwpF6JovK4Sxlkt5ZYdnOwclebK6n yM3XZc7k9veuBgw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_213216_851399_2B9BC4D7 
X-CRM114-Status: GOOD (  10.04  )
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

A preserve_context kexec returns to the current kernel, which
is unrelated to live update where the state is passed to the next
kernel. Skip liveupdate_reboot() in this case to avoid serialization
and prevent sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
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
2.54.0.545.g6539524ca2-goog


