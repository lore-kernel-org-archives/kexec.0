Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53ECC83F16
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=veKE9kV1m8lHv6mDfqy18qaKhA0a1NgkBH3AS9LJVWQ=; b=dobIjGH5Iivv+A
	mUtpby6ZFaj6ElHIPvPh0d4xHGtGNdpPq39pH+NHuhh2jiVV6NYyvuKtNXCoZo8jdeG4aVvX4aQPz
	0QX5V4/r1bvK4Ywuv9GK6sASfJNyIYvspMDSBeFC6WiHi1SCUF7XVYZYr0YC8L9HGoAVy0hVUBcV3
	XhkvOgpEBcKfVZgfuQqFxMvOIfquYp9/nirtIGYbYtG8BgRfqp9hh7jw7St31YcvfGF4WOOEVJcmO
	a2HAm166aC4DzX9x2R1YiprPrcMBCAHmpbGp631tFoSrzMK9F0mTLJUCGU/U88t8xxnGydt/nP5fU
	czybS71vs+lJjUrLbw6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWs-00DbtY-27;
	Wed, 30 Aug 2023 13:46:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWq-00Dbrl-13
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
	b=M2J2AOzajbWxpOSlsTFsRiEYVhKK2zgfd14zlINFE9jhrRj0GKtWG4NxtPTI3Z6VJ3ioPn
	zHVYB+tdXs7gHK3ew+iH0TwicSodRc6z1earMnab8o9nLhRj3erHw5U0FY5KcwzJcRXZCc
	Yzhugu6EgC3zekLIfIVYbhl9ZeBAStg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-pyjmCeLEP0mLksJCtJhlsw-1; Wed, 30 Aug 2023 09:46:38 -0400
X-MC-Unique: pyjmCeLEP0mLksJCtJhlsw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so19428631fa.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403197; x=1694007997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=Q6e+F3FdzQ0hCCzafrUojzvkQ012h/Alk1e6JsJgSaImC6Y5+Ki+fgLZLCrVQQgIgt
         5lL9AxVGeR45hwhn6KgKgxkAOxUcFkhIkoYj0S68Qha6JyWS80ZYoa1V05KXwaqHiCH+
         uH6wxbLVIDvgEFdb81U6WACCOdRMCScRMiAuzv2GF0AyHIlrbAC+/3r3+U3lNe+Xs92U
         bVBihDQW9doQYFVP32azk93195U7dVwnGTZog6KqXu8pv7iEMWF6QrbgH5+hgB2WvrsD
         HoLlhQTaVpDV6WCU2c4OGVlRXFNRM4UiR3fOTiiwMI/zNcW5tm9Jj3ZcrZ2sqfNuuR3W
         oeEg==
X-Gm-Message-State: AOJu0YzXqqtmJhczDEkW1cLgrw+4xLk+Dughw0tt0p0bjGSMn0V4qtOg
	Qj1WxCXCBu8umBe/FCnlwRE+4mkvzen3uSAyBY7M1SNm/gYuCiVy4NjnQ5w2jdidzZq8/hNrJi5
	/JrGy/f7H0qLVQlOFrHWF
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857334ljo.3.1693403196828;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBSsy/iFndvURQgQS9ZCnlQ9lW+9HBjOb1QIZNMn1l3Gt7cB24Ma8x0ITyx+CEVBlGHtj+A==
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857319ljo.3.1693403196642;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id li22-20020a170906f99600b009a198078c53sm7167678ejb.214.2023.08.30.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
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
Subject: [PATCH 4/5] drm_lease.c: copy user-array safely
Date: Wed, 30 Aug 2023 15:45:55 +0200
Message-ID: <34e14523c9cea13e2f63afabf2938c89d2e84776.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064640_445754_8C30709E 
X-CRM114-Status: GOOD (  11.58  )
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
 drivers/gpu/drm/drm_lease.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 150fe1555068..94375c6a5425 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -510,8 +510,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Handle leased objects, if any */
 	idr_init(&leases);
 	if (object_count != 0) {
-		object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
-					 array_size(object_count, sizeof(__u32)));
+		object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
+					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
 			idr_destroy(&leases);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
