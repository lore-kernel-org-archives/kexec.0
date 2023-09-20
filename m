Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDD2CE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4bk/6b45bQXjlnegqdt0lDVicCv/kVdS2pJuFsr1H2w=; b=QDHLSeszjadjWq
	2y89bEh5mcMPleHAJfiTX15WPBBg95rG1+QksD3gHr9CfJjWxUq6jla9v6Sw3koNYIwF7Y3yBHZM8
	bMFuzHhWwB4O8xmT0bzf34iyVpw2IaWwkK7fzMfQ7pjiqHXpVxlqyptZs8QKhpP1tMOf3MGWGqT6J
	6R9hVxDigmkly9YP62yzzaAepoOO8K7zuCyONcBSZSVtDbN8R/S9LjI6TxxPudlS5uwpzD15IAVJc
	NKP1ba703EnXtehf0t4yQSd0gwq1UHGpUurkkjLgHJlcfmLG1uekSF7FQ837DTTBHmcjVftwq/QtC
	5XSEHOKJzzGBf2bvLUlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRa-0032rZ-2c;
	Wed, 20 Sep 2023 12:36:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRY-0032pw-1P
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dpwuQg4DW9CQa6W2DXgKa+/2xEjZS0PSQLwcoRBZU2A=;
	b=HM2CQ8xX2jhE5L0zfn0Ixayf5VX5vqkk7xcbK/QCf1fBA34J+duHG9yeNO+3DU6H1GYXbz
	I4M4HIXvzJJn4RWYMoliYO2e+X1Su73KfXUpmitvEe11YOmwfG8VdJtjaPzwne+fSjlwUo
	lGKKFsgKtRkoS1mMegH43vh9au8nuZM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-xxL-X12qNMG5UIx7aVX1Jw-1; Wed, 20 Sep 2023 08:36:29 -0400
X-MC-Unique: xxL-X12qNMG5UIx7aVX1Jw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae4b211f43so17284666b.0
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213388; x=1695818188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpwuQg4DW9CQa6W2DXgKa+/2xEjZS0PSQLwcoRBZU2A=;
        b=km/ghr83jl/Oswiy7IrvZDwkKCh/6bO5o6DEK4GlhPtKRoasvEq2VXEubEsWciZThE
         rmV1vr5OU1z9N9hZv20EhX18C4i6ORW4yFTmeb6jj5rfH742nOOigdZaLZSN7yyXCgSX
         aH0WOqgZZjzHv29whootB6dacksPdxmoV/jRwglJQER1BJ5yVGBccz1eRAtpzb8d5rzo
         mNQ8hfNwZx++JP+NzuJeFrTG96ypH8qSyTrlx9aHnN79AhYg1LxB/q3h7W9DvQE9QDU6
         EDWKRcaJO5/s8MkJ37lZjt/tReGM4CyQDJ00mkwomsm8gRQViH8g8y7wNhZVjZb04NKd
         /vjw==
X-Gm-Message-State: AOJu0Yw64ogIjXym9QypdYtBKUd1VRm+L1mCFaRpgO0xC2DoGBpqS27K
	EwOzIrdFuCUEjDqmyYDE3GdKYvccFr/TMXCXh33HfoEtu2Lry6fo9lB2skccjZ+druPFdtMZWIC
	xvPAYZl4EmDcNNej4vutK
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr1853792eji.4.1695213388735;
        Wed, 20 Sep 2023 05:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWfVGOFs1cXim3gTD9PAzh0cZ1ptQJMSfTtIDViZU2bgVjNf9KAP/OZ/dlJHXc8IFPusAbnQ==
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr1853784eji.4.1695213388364;
        Wed, 20 Sep 2023 05:36:28 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id ld3-20020a1709079c0300b009adc81bb544sm8137735ejc.106.2023.09.20.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:24 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Introduce new wrappers to copy user-arrays
Date: Wed, 20 Sep 2023 14:36:08 +0200
Message-ID: <20230920123612.16914-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053636_603642_00929EC7 
X-CRM114-Status: GOOD (  13.37  )
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


Changes since v2:
- Remove the unlikely() from the overflow-check, since the latter
  already implements one (Dan Carpenter)
- Add the Reviewd-bys for the changes already reviewed in v2

Changes since v1:
- Insert new headers alphabetically ordered
- Remove empty lines in functions' docstrings
- Return -EOVERFLOW instead of -EINVAL from wrapper functions

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 40 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
