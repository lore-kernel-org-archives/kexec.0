Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C7CE79D3
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vItGW3ZpmQ8+KE2ySYmwxDsfXtOr7Q3j+gz9tZiTXVs=; b=krvRL3vtgkJ7sm
	PyANsCvMVhXzDVlo0LrfcCRoeSNNi2zwxllybw09z/v9jjZ84AsnUC4p0A5BV8sfCEf4j+xhupAEA
	Yg52H6Iv4H/JW7RWev6WmElWpMVMPbGiBfnunLcH2ezKPtyjvaYvVxOBSn4r2YMeoxTlak3Ip7xk4
	F3Bb9GRfpp748iUARkEUgWrpbPbOxhdLKfXzzko3Lng7hc2q6KxCE/+wL3EuFP9nn2kLZPgoVQyS0
	0vrkP4vgMzBAwGnpbJz1dVT7xGGE8FUWZ5IVjQIw3M1OiXKZ3MGV4kj1M8me5M25VGVQjApY6AGif
	6vuJAKFHE1uDFcqaCvkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwSS-00338y-2S;
	Wed, 20 Sep 2023 12:37:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwSQ-003371-0k
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/re3vPWoYJ/6xHLpunyVTZgfJ3oWhQoot3M15Xf93m8=;
	b=E1XNzTq5jZEOUGaaR3ttES3cRn4WUa2R0BBvoHb61mYmC23weUJlw53sA8f7+z8sj4jqzK
	in6fIyCHAsEyUzmr18UWlNrjwEfgXFPXYftmssznOijETbbK13AGhgVvYCvU6U37t6z8lE
	tellavmQ8fHPJRXq7tTxatkHx8Zqwpw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-NyrxCooWPtulDvVZcLI5YQ-1; Wed, 20 Sep 2023 08:37:25 -0400
X-MC-Unique: NyrxCooWPtulDvVZcLI5YQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9aa1e8d983aso156336466b.0
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213444; x=1695818244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/re3vPWoYJ/6xHLpunyVTZgfJ3oWhQoot3M15Xf93m8=;
        b=bKAc0zSOuLCAkMecPZHAG5Zs4zCYiOwIKxISySv05kHUTRZwA/eZouua9NTiEodNlo
         ZatCA5am8xuEx7w9UqvkInTa5AIqEJe4N6F/nhn5G/nU4f0OhPHPBolttEsOBmYIKPv6
         PRmDHQX5RpgAwKrJs8MNtKBAuEjlYqNMx/eOomdihpLswM62tRWw6hi82IvIwPGg/eDi
         4g3AXG1K1NoxeZuVCjJREifQp/w4CZEUL6lKBRcdad2MOD8RqxbFY88nrHVbJM11rCig
         pWYmqn45HsfsEzmgBd3T5b4kl1SjdPTT+03U/w0tI0dbzzmRo2lMO1TYVXhJbQwR/azy
         RJZQ==
X-Gm-Message-State: AOJu0Yx+BLIgai59Qnf+ovZzjSHyliOse31acLI58GyGAm9iyILI+BjM
	oamBVyGGos97usg032tcV/Mr7jCt2unMoxUKfDxrAGH2rV4DLFluarxKVNCVrrbZk2NqhOQPhX8
	9kfLTWKZQ0OYDuRBL5xYI
X-Received: by 2002:a17:906:1d4:b0:9ad:f4d9:f6f2 with SMTP id 20-20020a17090601d400b009adf4d9f6f2mr1978094ejj.5.1695213444577;
        Wed, 20 Sep 2023 05:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjndQs4UNSwfullLxNR+tIZdKn1iy3aRr+eKNx4dO54tFLsdtNfZQxNfsH7DoGs3jy6KzlA==
X-Received: by 2002:a17:906:1d4:b0:9ad:f4d9:f6f2 with SMTP id 20-20020a17090601d400b009adf4d9f6f2mr1978090ejj.5.1695213444350;
        Wed, 20 Sep 2023 05:37:24 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099ccee57ac2sm9233184ejy.194.2023.09.20.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:37:19 -0700 (PDT)
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
Subject: [PATCH v3 5/5] drm: vmgfx_surface.c: copy user-array safely
Date: Wed, 20 Sep 2023 14:36:13 +0200
Message-ID: <20230920123612.16914-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053730_349670_EF6E5D83 
X-CRM114-Status: GOOD (  11.57  )
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
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..9be185b094cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -777,9 +777,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	       sizeof(metadata->mip_levels));
 	metadata->num_sizes = num_sizes;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
