Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138BBCCFA13
	for <kexec@archiver.kernel.org>; Mon, 10 Nov 2025 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qL9D4+vuZNdcA1n/TETU1FBv3lcXALq5Yj616FCh89Y=; b=S9xr+7dBdxxhl5l1nDXRGlBPCl
	ETPxrnp5o34P948k0lp4QsGeI8uSA673GJMU0usZ3hqiAkSZKCWI5lNZg0GkhhRKoFNN+erddii7r
	B92ryadXYZnUGjc0mgR+WLBw2+QbcYE2Z1pjea7BcPSLZKZ0hsumj4apcDiNA5WW9kjMbjTbSnZPg
	1HhOSTgIlWP7Ylok9PKHv1piaO9sQn/X15uLC/7/mJWaP1i8FbaubzaKoUctxCpvJvZomvoogpnRL
	qiAN7rZ4UEvM8AbKtQjB0T9H/97gcBeTYt81TeqdDwisbmDB+kKwC8u7PhRdMohLFTg6Eq7Ma7LjI
	iTmfrb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIWIX-00000005xDd-2LsI;
	Mon, 10 Nov 2025 18:07:25 +0000
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIWIV-00000005xCV-23eS
	for kexec@lists.infradead.org;
	Mon, 10 Nov 2025 18:07:24 +0000
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-63f9beb27b9so2930769d50.1
        for <kexec@lists.infradead.org>; Mon, 10 Nov 2025 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762798041; x=1763402841; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9D4+vuZNdcA1n/TETU1FBv3lcXALq5Yj616FCh89Y=;
        b=GVZpnWUqDqWZkGpBf2i+ILgDx/oI1az6ELd19QvrAAR2n5bIQYEskid7McvwiBjRUT
         gradvSJo1gpPDRL/Qgb34vmt9BngB1xywvzdwVo1NE7mIKmQgRCQ/sKaPJBGKxCRAehJ
         PEprD1sXwZiHv8o4UfRkiEgihb1FAfGrdqvKzF1oJRckKldhLZb7JvoMQr2LLSYwVCMo
         Rl/Ft1itanukYCBVfZeyhb0+9SI0h2C4S9M6D+Ry+Ud9fZg3cB/xbG799ayum7hix2AR
         bbA1JAoXnGnZvqAMEW48uiojEWeoulh46eRcm7g75qcEAVc/5ZRvcV27d7e337mDkhkZ
         1K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798041; x=1763402841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL9D4+vuZNdcA1n/TETU1FBv3lcXALq5Yj616FCh89Y=;
        b=djznYGx4orJZGj87584LANvJlwJ+QwEQ9uxepw6pLGmu3lfUHq8ASDs5BGhMI9YLqi
         JS9CW8Wmi/s9mn8hlyaYBeNFyjDlx04pI7f881m3tvbS5t9aR4U0ciiOmu6xOTyuO9q0
         RRUA8THC6i5AoTilUffPTl/d54aYaJ1Zownfo3CGoQmDydEuxxD6qnKm8WmseMyx8VkZ
         7/x1xusIBV/g4b1uxeW5ovRqKDPJbWyNRjXvRlU6vbOtmpM74LbXul7YPBNChrj8tx6q
         mnSV0qi4rW0xgX31rq8UhqFkTnZnbfaWbBuzPrZQFXpR0c20kkYxOH5vXoP6AOJSN5pL
         UXHA==
X-Forwarded-Encrypted: i=1; AJvYcCWxSvIQdIOzXYzP2LIYYBt20gzeulT7J46GvSG9CWQQWYjl9aGJwn0hmVEDnlqmqTEoX2IPeg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEi0LWbzLRmjZD8dRue8QB8fgfyhjsHa4DrXKGxTJY4tBqzmDw
	n5QkxS91f6iHPX83wLVOXwEWtZvCJyfPQyJeCWU2d9rWzIgYhvD5OSZDT5SQTnJl5dM=
X-Gm-Gg: ASbGncujFXMVnKh41CWPF/l7AA/mFat+cRt/fZHt9c3GBDyl/1mdoi+0PsGRnimqIl3
	mIgFRFe7UHP51ttkVRA0cJt7RPpXpzZ2RF+yI1uxyehWKL9LfV88uydT+fwIYHEUePAcX0YDF0z
	8//MnjMPCLp/78Clonri6C1L/ad6BQEmfwO8JiRqmRdeTbhVHfPlNdQhoCgBr6OASUZK/3Apov2
	0jbLW1A5R5z5Y0/alXy+kVmfKU5u0tA6pX505X2GDC5CywwC1iUtF5a2jcIBOlI5Vl/Kpc2BTIm
	Ke29Q4yJFUUPqsyLlDhMp5Ev5UlQSqKrLs7Y99PKPJPA8es07nvrqjvs8LQl9JB5oN6LJMmFzAq
	ik4ebMlkWIh1S+QHRwuhTJ5213RaSvF/iRq5SGIdpESKpJ82AetquOpfSyu53cZQGBgNhtRmxkx
	VmHkCkdniNBQtK2sHeuh9G/7gVs7n5pM31giW5L/G/A2311sQvfFeVZrKDors/NrP2YuCinyXa4
	HlsumM=
X-Google-Smtp-Source: AGHT+IFI8k9m6fstEvlSakNx4eRqRGXfQ5gFh54/EdAevddbPRJpRnpFRHjsRRXHMaEqb+vKcs/2pw==
X-Received: by 2002:a05:690c:3505:b0:787:cad1:bdac with SMTP id 00721157ae682-787d5473912mr97384637b3.65.1762798041432;
        Mon, 10 Nov 2025 10:07:21 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a3f334sm25489757b3.60.2025.11.10.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:07:20 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	graf@amazon.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] liveupdate: kho: Enable KHO by default
Date: Mon, 10 Nov 2025 13:07:15 -0500
Message-ID: <20251110180715.602807-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_100723_530693_34CEF39E 
X-CRM114-Status: UNSURE (   8.37  )
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

Upcoming LUO requires KHO for its operations, the requirement to place
both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
by default.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b54ca665e005..568cd9fe9aca 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -51,7 +51,7 @@ union kho_page_info {
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
-static bool kho_enable __ro_after_init;
+static bool kho_enable __ro_after_init = true;
 
 bool kho_is_enabled(void)
 {

base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
-- 
2.51.2.1041.gc1ab5b90ca-goog


