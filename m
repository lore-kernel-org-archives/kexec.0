Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26555EEB566
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EWh+EzTwremimRGBVRwUpCogdDBsJNW/aHeNueKEX84=; b=4S1tkDqO2CHFBc
	5l2IqZj4j094GdESROcSPRs0cwSleeEZQwozCEaOoBDpmQ7N4IlW39a4AnFNIp6nkjQvnHBTC+JWb
	UpXDk9KcXnxhsz/W49/n39WUPzbXHRf+imTiD4pgjarmEkmRYjeiEBCIeT/FUhyGYIoLxGcsmQk2k
	kRsuTrKtFon4catnLFONMZuVMohvaq/09GT+0GsbGsE87mXbyPxTui3GhIqUIFEIh7++eJ0SPqQAF
	3XlSYW5aLWY7bj2n/1d4Z/RUKkDbobrpSKvp2BNLI+fB742DKHXoOarvnTlGuvR2H5/DPP/rlXZPG
	PrZx2QbcOQNmERdbjEBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhB-00EQUp-1c;
	Fri, 08 Sep 2023 20:03:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehh8-00EQT8-1N
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:03:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
	b=jMsXr4fCY2mTJNN0+K8vCQR8Ssl/227kiazFF8ikkfHYXzrzXsDI6EW+bpCPoQz2PkHOYe
	dWIfu/IGQb4l4sEda3XV9yCIXH8/NyymcX+kwFNg69j28zvH0B6o8mydIAFpT2yvYkCBBr
	N6sD0OkUgLD+0u59KHDQXRNPdkFVRTg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Zhr6_kCMMCaWEIjwd-evyA-1; Fri, 08 Sep 2023 16:03:05 -0400
X-MC-Unique: Zhr6_kCMMCaWEIjwd-evyA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-637948b24bdso5999116d6.1
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203385; x=1694808185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
        b=wZigdpb5Y6i6EU9Z+Gm+yqsWYddT1r/1a6a9B9GLxNXpVyKB15gEOM1nFE1isbRJon
         Jk1MSBfFM9ucCA0AiT4+eitpbUXGCInqXPOMn1OthaX4OONBNfhAP6RoJuF5ST0bmwXT
         ysVvHl4PuraxLE+I+SiV+karkANeosXVN4PvXaC5xp2oslSO8fYLbHqerPLOooM/TneO
         R/KtstR3KXLKLiDNFmT/qIsTDCgj0rYhn5o+8dRrBW/rbau9SnFyaGncfDZEJxMhDkvr
         YpkokudAImxxK1dScyCjHe6JxXZ6TsMC3hFAGHBPwD74i7O3Dp2EhNrlt4V5jYTsG8AP
         eudQ==
X-Gm-Message-State: AOJu0YwvLzR3lWBIpb87cdkILqphDc7Z76/PKrbu6eBJCEzUcvWEievU
	FElILkbJEMhYNXqNgZxzD113SPHNYZUwKEc/ykEiyQ8a+g57Oq/6h6/xHMvjFaABBgiSk59QYvy
	8LqB8gUKuGsNxoMVXQ6Gn
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403889qvb.4.1694203385316;
        Fri, 08 Sep 2023 13:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkpjEpC3M4jl16uIjnS3PMQJTudw+DmAKJXO1LGuAkwNI/2h/IQUepIX3UGSH4cUrAf1SALA==
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403702qvb.4.1694203382095;
        Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id r19-20020a0ccc13000000b0064f523836fdsm959242qvk.123.2023.09.08.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	David Airlie <airlied@redhat.com>
Subject: [PATCH v2 2/5] kernel: kexec: copy user-array safely
Date: Fri,  8 Sep 2023 21:59:41 +0200
Message-ID: <31313a8a1dd1baf9dd3c21fbe8dd46b9e111f20c.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130310_534371_1ECE6559 
X-CRM114-Status: GOOD (  11.34  )
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

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..8f35a5a42af8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
