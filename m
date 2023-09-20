Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B4CE79D1
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zkCtlSWPzeAluQHp+PXi+6eos2RtthNPbh0zX2pycVA=; b=E6q+rP4ppXT885
	vVQilD4ysv4jLTonviiYDeRTTsvIkHZhfdDnoSfnJI0J7RBeQ5KSRBRsbQQyN2AY7DumGxV4xJWoz
	Zck7T0HimIIyqpjSUhti8/HJS+mNts3e1xQrgWnc4lietjb17QNrd3i+uIcKtoDfQXOU8HcAbKCOJ
	k8uceUSCFYbbo+oo1O3hXWzShlGb4t2vNhPC8aXQKI0izVEBssaEcwm1Y8u9ipKmnGnPuSvzM6Y0k
	xS7ZAzdyqUKA5Qp4E4+BqaEXoO45Nm8D1QHHU3ouG9ApkoaDxQyhwiRneEPM3LCcPnWLi8lHjMxdl
	8f60r5Hm10RI2hTsE3qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwSB-00333D-2S;
	Wed, 20 Sep 2023 12:37:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwS9-00332B-1u
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
	b=GDssDO8BIGhK6TKMZh04cGJJnpoaaAjR4Dkx9sAIlFD1POzPVWi4Zot2wniwcVPb+TQMwX
	VkZNBuiV2wuvq60oXW+bmakbfa8VIYK3nwbn7CJfPH9+rGZKxxBbIbrAwkZTZ4dXlC5CPi
	n6nDeuOtyyiclJLWf7fxdpy5lAxOiB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SMZh7Uq9PWW8l9eViIb7GQ-1; Wed, 20 Sep 2023 08:37:10 -0400
X-MC-Unique: SMZh7Uq9PWW8l9eViIb7GQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-404fc59b8acso13443815e9.0
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213429; x=1695818229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
        b=CW7heDU+NIU98A9FRD8ax/IuUnT50hLamN2/omWl2ds5RB6vayol4yaTbIbhnpZzLj
         TI1fpj20uafgJsZxmIb6z8jjhNLXhnG767+yJnGkiuKZmsctgS/HZkfP915JprdhLEHl
         OX3EM5p/NP2ijSVctqyD4FEXeelswjS9DFW1JPau4r8mLervzvlbJ+K0vaMKitnq/J21
         ftOWFGpWMu9aSSEw3asNkroxOCXBqnoG/eddZAskpVBj82qdIkSxp4JMfPHn2iKV3SNF
         sy1HYv3Z4t58IghXbLqwB6iIQdxGz4ArnY5dZ9aruwXm5NHNQKtIaoLK1aOEIUP9sL4M
         rPUw==
X-Gm-Message-State: AOJu0YxSQNGMtvG9eaydGKxr3UnBD4xWVuhobWmUPhzKum3nxIfplKYc
	ZNYJ4C+lyeWsb2lKIsJHWm7IAAo0TQx67rhJnS76g+GcSn//2YSFJX80hQj0f1Fxfo1cgN9FHnz
	L4VFkfKpCayf0UQD+nZgQ
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031476wrn.2.1695213429374;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorWXFxi2CZ+i0Bq4z7I+sy7K13wS44rMjIuskory3+gtAyjUda2GeiUfH2k5vq773C10/rA==
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031462wrn.2.1695213429120;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170906f88d00b009ad88839665sm9297787ejb.70.2023.09.20.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:37:03 -0700 (PDT)
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
Subject: [PATCH v3 4/5] drm_lease.c: copy user-array safely
Date: Wed, 20 Sep 2023 14:36:12 +0200
Message-ID: <20230920123612.16914-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053713_749345_C4648141 
X-CRM114-Status: GOOD (  12.23  )
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
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
