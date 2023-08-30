Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF4DC83F01
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3o/YpEkuX2neLYKREecJkLj6UK79uDrCaBmOo26DY5s=; b=AXPF0ZfwCZiGQe
	Kb8XnbPSh6F7X/mj/D9nxooe8QRfXigBYRPmuaBUf1+MXZfifSJfoUWrC85IKeCjezaIRI1eGCENC
	98d7UCyKplA6IKMfc0zLOrlncfCLkjcq7M09ehX2JPF550XxnRH9rqbCoO+7OhpPylBMkHy9FOLbH
	X3c4WdWjKGUpk3LKFj1MVyy9zPkCWes/ZTLu41fQaCjHkybVxrGJ0R5PbvGS8wegHrqLVJjq9qRwy
	b7IFYwCeZ1/2cIhLs2FKCrvLYLC2E+q/+jkM506/IBsrFXcCZIBfeLR0jOZMUof26LdFN7B35vABe
	LYd0MsUafrtJcRfxk/nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWl-00DboV-09;
	Wed, 30 Aug 2023 13:46:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWj-00Dbl2-09
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
	b=DN1Tqt3clHoxo73R7PnSFAqo34lXpu9aMaVFTHaXY+k8j/7veF9a9AoZ7DRb76NbhZ6lMe
	3qJ8eetD6X5J52uXnz2OtdzJLmi3D7Qc8aQ7W8+ykB3RN5zkrHyA8aYY4Z1HGTvF7iw5D7
	/2lMY1nmDC4Z0S9lnxE60m1ksFaBv6s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uRce3C8TNQyzfnVmA0MZYQ-1; Wed, 30 Aug 2023 09:46:23 -0400
X-MC-Unique: uRce3C8TNQyzfnVmA0MZYQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so19428211fa.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403181; x=1694007981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
        b=deGqmCkCpFvi98eE/skBoG5xI6RSNWQhepmFnR7SO7g8zcantJ4x7Rpr8u8URSs7Lj
         LUa3vS1LVl0WDJdHRWcujdXGbSdoIi0YiYAV3fFrhTQxVxjbrLiMbFmegKjCpAfFBW7t
         3jM+RvkzbzyKtBQBaXbVVxkpWENUEs8H8Lom2huy9JCpFuuMb0TxeBJv0lJDZKuyDJSg
         dulW+5JylKZsIKl0Hqeiu+L1gryQi7VS5/u9C7HtZoZeiW1hd+xgzwzNAUdlJSOU/0Zl
         IHQwPdBLGwWJ2SKss1vatwuDcFSHMkGtrbbu77B2f3BOHShAsvt4Cp3jqdfELNgvCZw+
         r7BA==
X-Gm-Message-State: AOJu0Yx9HV9D/Ye7km0QM/i9ZvCyxwmHArGjV9Vcp05Rq7onsoUwnPLD
	pQ+5j+bEV5pqD3twGTcaUe9cbjWVLPqA2Kd+zoYYc/yn23DPTNjMLg2VGgytYP9AyQUfLOe/hYs
	K60uCanYvxUiAWaVyUaa6
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564051ljo.2.1693403181697;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj7gH1IKBMS0NWbE4Xd4vUNDX4WI+F2xE2mn0UylTciMqkBXPKro8KLHlIW5rak33HRcstNQ==
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564026ljo.2.1693403181300;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174346eji.111.2023.08.30.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:20 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 0/5] Introduce new wrappers to copy user-arrays
Date: Wed, 30 Aug 2023 15:45:51 +0200
Message-ID: <cover.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064633_156380_B7B41312 
X-CRM114-Status: GOOD (  11.14  )
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

Hi!

David Airlie suggested that we could implement new wrappers around
(v)memdup_user() for duplicating user arrays.

This small patch series first implements the two new wrapper functions
memdup_array_user() and vmemdup_array_user(). They calculate the
array-sizes safely, i.e., they return an error in case of an overflow.

It then implements the new wrappers in two components in kernel/ and two
in the drm-subsystem.

In total, there are 18 files in the kernel that use (v)memdup_user() to
duplicate arrays. My plan is to provide patches for the other 14
successively once this series has been merged.

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 42 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
