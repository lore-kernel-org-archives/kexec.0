Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53CCEEB566
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyYF8GYZjPso2xXXVlLLIw507mh/sw1u+nOuB/L+iQo=; b=q6AJcWZV4RQFpq
	hYC3+bOc7ndjK9jTrieq0a9yp6ogMF3AFpl4hncTz2W/VvuC1hYbni2ffw36xpLqkH2aunGD8aDJa
	9QC/Dh+RSjSruOveOem0qiGP0zXGunMLC9MYnMXH4xpT9Kh4/9gXyyp7v+T4xmXPGdNDxluobIP/Z
	e4524dmm1sYkGL3s3R6EhKw5TfJ9DDGrH/7avJNApN7bdGCoNcjHmjM9hfLqMxTox83MK36HRacRQ
	bmRe5rWm6WFRWB2d0NvEOavWxeMSx8i1ASO7jwXruTb1EjDyzI0/bB3q+LI1NAI/rF0qIRfG0pv63
	qPhkITtob9K1VCNJZq4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhX-00EQch-30;
	Fri, 08 Sep 2023 20:03:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhV-00EQat-1f
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
	b=c3h7XPFbBHsHy20pb8A3s365xSIrpDGHGQciJWa3bskMFGRnfvKGufr+/ulkkc+tay8S2q
	eVxu1st2JmHOf7wMMzLfeoUdKIdHVFJfc9HPiuEm2EQxj9D7b0SN/5jnTgt46BGETjkl3a
	kIRcVzIeyNNw+cvbbzkXwmSF1Wberu8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-ejtRI8dBMsiBzAz3r_4F-Q-1; Fri, 08 Sep 2023 16:03:28 -0400
X-MC-Unique: ejtRI8dBMsiBzAz3r_4F-Q-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5733de62ca4so409755eaf.1
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203408; x=1694808208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=vFE2Txr5FgpguuekdsUUAItBm5hLlNhIQVYf2n+kh+X/pDP2Bom1CM6u46HUe103im
         wTK3NyPluZAFygI8be94pc+JyjZfp55Ncuq/ePz34zfOKYCqdLee0HbI3B7zm4QI0RZm
         xHLif0BmaY+fvamgVAFGHwd8lrhXzzMuSJZ7i56Dw+MFmiqaDH5OCVpUIAQfUW05e6NR
         /0gdOBSBXTkbgA5zJ9KlK5m0nSY8oWL6/Q10Jh9ZjNFmdi6g3FbKZG4XQDsdopVSeFOG
         OoKxcPVk5HCnqpUrk9EDb1dvkxS4vaxnDqXTN0jtlvtKhozwC9sUjU/UJpaEfs1oxQpZ
         u1dg==
X-Gm-Message-State: AOJu0YwnvBofzsD7tqP7+OPX5QM0GVcvvKW3Allqgl7Imb8h9W6gjvSw
	vQHciRCMsJvDJC5K88aTO9uA4/dhMGqj3e7vJXYae9566mXXwfDBbZRJ7LXu9BqVTGgrsnagEHe
	hk26tiqHBpgUUF1WGcJ4Y
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557586rwg.1.1694203408126;
        Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gCAzKUix7oIOcBNdjPHJEb7aCyOwwUAu2PzcC43CT3hwK4BjknICUG8MLI4Ii5zItWgaJg==
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557556rwg.1.1694203407699;
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x29-20020a0cb21d000000b0064f53943626sm971150qvd.89.2023.09.08.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm: vmgfx_surface.c: copy user-array safely
Date: Fri,  8 Sep 2023 21:59:44 +0200
Message-ID: <3d2b36a2cf7bbff1b036f474eb805e19be3c57f5.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130333_660457_5CD8F904 
X-CRM114-Status: GOOD (  11.02  )
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
