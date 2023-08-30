Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB143C83F01
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyYF8GYZjPso2xXXVlLLIw507mh/sw1u+nOuB/L+iQo=; b=XpjhNMCc4TrglO
	QVu3m1ikQHMsNZTgFjBQKZxnPFZ86dhepxGaH2G9FMTg+TbISZ64dxJ6dtseiuETKKsa1zi//gCSs
	QP/2qkZTeWBXwSDHCFlZul722XK8/jNGxMKv3G/GOqQmKdIvSj0V608F20tP6GvNc0jROpuXyw+la
	030TmzNU2cmFyKfLwcgnylZ1WPiabUYErlHJnIa+E5X3DaxpV+ucxMToG2NNrWQU8Omf5l0PIrB/q
	U2LKrZNQujuYFAEYnVa7h9PuVypKIkY0ISR81y4MpybIrlv5tfAuPK3tUy7nrk/xKxv800AvFhK3W
	mW547nzN77IyrhXSz/zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWw-00Dbwo-17;
	Wed, 30 Aug 2023 13:46:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWt-00DbuO-2t
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
	b=YkMcg0qKAZmEEfDMi44h3xAsrFu8AH6DiusKV7zSAF0tI3JGYUWWYqQCt4UGN8EW3+Q82F
	V9sPjnH1Hkf93G0uIW/9Nio9WAOVO/q9r39CaicSSdQazMLIjA4yIbSGPVqtpszQcyOzf7
	4VGzc9QdQVvQhaXmNcZQrKk62HXTPNg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-a-TiSxnIP6GqhEM6ijgaDA-1; Wed, 30 Aug 2023 09:46:41 -0400
X-MC-Unique: a-TiSxnIP6GqhEM6ijgaDA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a342f1703so87949466b.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403200; x=1694008000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=WgA4ZCACwD4UgwV8lJlxMujHgiF+Ht7Om81yIeWNSstW01l5QBbJfokfpD41jCuBuZ
         GILYQU0jp4Xduu5Y43Utz//Mobk/deHcg/i8Luo6Xy7JUyCOtXnK6g/J/h0lkxzKftqa
         l6oIBOH0VHbQzfztC36vgl1BAoScatGlzEpRNqVs60oQcz3IXK9lEMmQR7bm1Sbb+S+Y
         m2KBZ0YsH7VRH2V6+m5aK2HoeVw4ml/ZP09vDITaXPLC2YwjA+KFFXRwk4Xdc72Ccfup
         8V9JtygKWfsbfx+E9WJBhs7hjMNHYp5Py39BXD6L/jLxEYrpuaAgH/l63F+ZaaB7JuFk
         RVug==
X-Gm-Message-State: AOJu0YyzgmiSz+ODBXvSVCucUzcXkbJhgKeoOn3OtkM0S1cNE83JaMVG
	zEJj1TUintLHy5CIbAk/iNCWhoyNYMI5P0SGp+T5u4OvJWiwTGImA+H9/KEv39OSBpl+yqq5itX
	9bKuCGkMnxk5Sa9Bt8bKp
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574496ejm.1.1693403200683;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFovveJ1gRkNa/hbpuOdO660EpmuFNfSfZvj7MduSJ07LTCEG5M6k7oeDfsA0MPBedrGa9vw==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574480ejm.1.1693403200487;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b0098951bb4dc3sm7218566ejb.184.2023.08.30.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
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
Subject: [PATCH 5/5] drm: vmgfx_surface.c: copy user-array safely
Date: Wed, 30 Aug 2023 15:45:56 +0200
Message-ID: <6f9397d6af919b7e8325c2945385c13aaa3dc5f1.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064644_018780_54FFDF47 
X-CRM114-Status: GOOD (  10.63  )
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
