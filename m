Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62888CD6E61
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57XHE07VPesg/638uO62i0q1esIWZpU9ZAzOqv5wFOw=; b=d3dzm55hdkIUJzivyTGa3EXy0+
	dNTVZODKwau8qe1H0bBC37ABiYMa+ubtXpn4C+PRVcnshqnAJtlWn6gySKAVAJNKxr14LgPkJSnxp
	GnSoJJqueWCeaSRx4Jha36aPx/b4HN57AfouOj9z2fQiURzz/QZJ2HuesDzhN4CnrwmrGo+VJNTeO
	0DolDG+COhZf/Sm6HmqEcYp03Tg4WBwwj8E6dCrWLkRyqY7fyZB0+YZW9s9J1NuFf4Y9h18Ail9lp
	GhUycgvGVzBMqOHDCSvmKthpAtim8wVX11RZc9HT37tW2xhAv3R8W6MDxA0+qOkFB3JVpN82L0yhx
	oy7RpFpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd7-0000000CDBA-03RF;
	Tue, 02 Jun 2026 03:17:25 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd3-0000000CD9w-3R01
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:23 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-5176b9c476aso1447291cf.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370240; x=1780975040; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57XHE07VPesg/638uO62i0q1esIWZpU9ZAzOqv5wFOw=;
        b=N/momn+JcLUMokulyP8ThOZhpJVecf2P9nutCiMH/pvcb6AvOQ+9amgjN6BkEFGtTC
         iMSSn2LK9hw+e8fKbUwZ5qqsxtF581fa/8HqBEbUsU/k8pVkbqH6obyv83phGEaPOZxt
         YOfc/OuG6UO9sEs/hLxq6fJwoCOHhIK4gyPFEJjIDfpbetvOdGDpzsdrsx7Xy/hGhHXv
         ijqOW9vVXDsGlYZETH1vXVVVshXI/h3LGquOdFhDiJF9UULVq0O5M300X0KtpRVGFX4z
         QUWUGb4/30M7cLNM4IyVBmVdI4defO3VUXiwjAQRzT/8CfjHPiWG6SjuJdTE0EqkIx+y
         ib0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370240; x=1780975040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57XHE07VPesg/638uO62i0q1esIWZpU9ZAzOqv5wFOw=;
        b=s7mGt4lpFGFmwPFhdnqhAAcB3s2ucpJkVpXAGfye4xHFsRTMmh0tCRypx0OARwZotQ
         jUYc8gvT8D+74HvqkykVF3xs2tNq9nDsey8Vo80jFIbLUVWUtCYB1MhiQCWrWFekqudq
         I03sMuskkCS3qWewIcxPljf7KrMXjkWGkLC0qeolEkX5RddrszN+m3ORmt7sk5qYKzKe
         JNtMvjTbPy4pYETt5Nu496Rv4LJSmpPe39J+1DqMpDxKflp95QldEduzAaLTs0CJFxio
         TEw6rHJ70gt+c2GWRW7cTA7b1d59jxA6AymwmM1CO3j45377BCZseGB0jsEXkz66SPt9
         Xcyw==
X-Forwarded-Encrypted: i=1; AFNElJ9lMV5s6dH5RiRtl2ZAYyLqKKhusJq5WnsZNpkNODayh0QkUvoixipAk7oKWLdv/RbnfVAJJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMDX9hx8jvOrVhz9PE7iqfn+V8kDyRKK0mVIqyavJwW+th7T7m
	94G3rQzM3IzE6NxTRiJT5RYLk98Kxz57V0BxH4WUhDI1Es79PBvA0bsjuO5I2feEy+A=
X-Gm-Gg: Acq92OHZWTMi2p6CmmJ6g1F2ZvPvR1cXJomUk2pObqi4hIarmBQwt5C5ocZQ/pEjeNr
	mmNiflTWKJMvuGWo6u64FcXCEC3TQ79yTtwzlnDVFQzWBCUYjgud5q3Eovo++ME9pNaeyW0SdC3
	iJd2tX4qrjriGTluJWB/6KfYmimhMjI1DRdh60HOggUxBsnVAbzquruGH790+e1G7uST12WxSpL
	CyHJXfJpVeXCqy5B8cerMqymNR9X5oHDQF4ijscebwuuaM3A9CpJOpNIgxjc00NKF33ojRhaZc9
	HhsqnGPcB7k6e5XISZB0c37gV9RNMRMpGUc24Uq+9rM5goKPK9kxydHcAzqziTOuZ8LIICiwYyC
	3NOGAymIf7YRjYwSCcqjf+lRgrnFMusLnf/DhT79xLHRQxIHdB2/f9nvSx8yPXfkXPcMgxubRai
	GQNCcA7+Kj3HdznXPJQ8zQ+C9pYYH3sa/LraCLEEs2pYhBVECo3iIo4tv5ZNa9rA==
X-Received: by 2002:ac8:5dd1:0:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-5173a97fdd5mr181349891cf.49.1780370240533;
        Mon, 01 Jun 2026 20:17:20 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:20 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v5 01/13] liveupdate: change file_set->count type to u64 for type safety
Date: Tue,  2 Jun 2026 03:17:05 +0000
Message-ID: <20260602031717.197696-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201721_878245_27D0AD3B 
X-CRM114-Status: UNSURE (   9.38  )
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

This improves type safety and aligns the in-memory file_set->count with
the serialized count type. It avoids potential truncation or sign
conversion mismatch issues.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dd53d4a7277e..ae58206f14ac 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -52,7 +52,7 @@ static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
 struct luo_file_set {
 	struct list_head files_list;
 	struct luo_file_ser *files;
-	long count;
+	u64 count;
 };
 
 /**
-- 
2.53.0


