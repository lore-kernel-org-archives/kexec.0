Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDB1C83F18
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jjW/UbKiZpjpt7JXwtsC94ll8bu2BEkYOhN95rJf+0=; b=kMeiVuK8vuEOIA
	PYmcLCeeZqco8EnBZVeyAvrAAE2uQnW+ktEeCmgckAXGtlb22rv9p0u72NHetWJNUY3MR2voK/OZ5
	4oJA0qf/pScImsAuXgPVYITaAOhp0pV6W7LeXcZutKAl+I8vmo8yPOoI19yabdtVxcTS1hgmqtMUp
	Mr71wgnlsBgEzhftotAyQhDTdcAf3ZQdUgjWbJ3ZB8OqUdbwYmJn+qTtLTObSRDZ7001NNSWu9+xI
	ywYgJV57uSuJIXr6Ap+xCB2IKEGtVZSJi7DPQ2mg2AP41WLTGDWlcX6KN6his8WJUIHWp9jBAd3wp
	Wc3jhtxdRu36JqWlvXZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWr-00Dbsw-0T;
	Wed, 30 Aug 2023 13:46:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWm-00Dbpg-35
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
	b=VBafd5+o1BPasgg3fepmn+pHFg9tfaRqiRoKKiE9l9T2E7RMw1qv4xHyTPt0ekn0jCi9/N
	7XWEFXW7pjfnYufLxmnG7EKyeEZC9KJy7i36g9LajCQJMNCMuW0EPiDU1AXC9uaLhL6vd7
	97T94ul4akjY5DV4rSGaDoc7zb+Kt/A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zC0U31S_OMWfzQ5Z_IZeYQ-1; Wed, 30 Aug 2023 09:46:35 -0400
X-MC-Unique: zC0U31S_OMWfzQ5Z_IZeYQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a21e030751so61301166b.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403193; x=1694007993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=PHalR3Zg5wtXCzuldICPugbnHzd2KnWduUwGXYY9q38dRNmHHuuUUJPfExGL3Xq/xU
         PSb5BRRy0DxoT3gWmC683sY5yOysIbF2KbgTIfyeDX7xpCssUH98NjaZHDUzOJldQaOS
         SI2QHJY+byzBod+/JYR4uMjjLxgDaub/NDXnLiDahWL/kT6lj4td0ibsjA1uusRz2o9R
         oOiJ3cxCUDYUucBpZcaaTwlUvByl+m/4S8Tba6PmuGla2Ol+ReaQi6SSUokON7zTSSFs
         GTHDX+f93FVm4e79a7fgXjq/gOQwxjwn5lLPEAraxa/ZUbDZTyWuiDe1+jK2WVmwQNrn
         Jhfw==
X-Gm-Message-State: AOJu0YwiZEhX0IGn1pmaZOgD9/9V6oSdGO7NAmSxhth6rzcY39CXGJjN
	ez7adGkjp8jZxS6oucdEnw+/Nm9oPZhMA5vuPkQsiOE0aP+lj5BghUXqvu2g67mDYj9hKJWQsZ7
	Fq0guUZWZWBUuI7xDokmY
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737290edd.3.1693403193066;
        Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9jsdBfXtDK6B3l1XAhb6uC/SE7H2eq+xyXHHwbpGSepkZ7/eGDvrY6bR1kwu2ebD+wsHwg==
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737265edd.3.1693403192770;
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d4c7000000b00529fa63ef6fsm6811782edr.57.2023.08.30.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
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
Subject: [PATCH 3/5] kernel: watch_queue: copy user-array safely
Date: Wed, 30 Aug 2023 15:45:54 +0200
Message-ID: <4168bc2d9313d5d1a1a2b9ca0b9fc2990d499506.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064637_066441_181D2C67 
X-CRM114-Status: GOOD (  11.37  )
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
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d0b6b390ee42..778b4056700f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -331,7 +331,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
