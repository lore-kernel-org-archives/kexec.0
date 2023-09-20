Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B3CE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XwLL3JUiAAEjHHOIUzm2UscAxsFfMPxn2J7pq5mpgx0=; b=p2MSGo7oAOE+DM
	uHpESM2hHO3soLmkDvLWe1RvpGfg2WJ+8oW/F0yi562UVTurEqCKUyJfXdWIdlInXpU75iMMNX7Rm
	K9H/+YCVuhpwklJ4QSykcCwJbBKBn8dzoRayhKs5ZFqLOjXu9uLk0nyLdFaL8oiqQsXMc6MVSdJw9
	WGqXwJZ+0v4ArVq1juAWg/CzWS/1jdGRPawoLi9RnILq9SM6/aYiQWHB7yB3hhmY+0o3dRtfzMrw7
	NiLqwNfw5nAq4/D2U72TQQDjNMIJMtk+iQO4eq69MHwXOqSyC7+cAcRK3YGqs6gXhBUQyBuFfcC0j
	AilO/wLT9GjiSrCMCSsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRr-0032vq-1A;
	Wed, 20 Sep 2023 12:36:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRp-0032un-10
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
	b=aVTm2Eq/CNWAL+srfl8Rb5N7tIwzgxY9BYkDYSTp39AbkkLpN9e/eqo/aktrH6oYrdUk5t
	qzU628mVzhxwA5tuG4SESmm9YQKiPsuTa2HxNYFsF2cCX2bpdfqBy4UXTHDCMwgMepg43J
	WpYCAqAhZlV/hLH92F1eJW1oil9Jc4s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-QRK6OB9VOEq1lPGRrMLlPg-1; Wed, 20 Sep 2023 08:36:50 -0400
X-MC-Unique: QRK6OB9VOEq1lPGRrMLlPg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9aa1e8d983aso156321966b.0
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213409; x=1695818209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
        b=ixzA0mM9DtDc4RsjHXpsm2a7mGwKIPCQphPkLQE4au1jBGGCyh2hFgp5luHlRoHwsa
         SFajOqAoa/bK/0QE9llkq0tvDAs3aogh+YNnMSNEINAsz/CmtYgA+kBW+DjZtfNEToHN
         T5m/9jNVneloUXvJUDJccqDbBQo2EJgZf/RryBaF2ywHEi1zEU+hh1ivxduKYx1odyx/
         BV2hrziCdFRodt/5e1DTzY70bkexUpvx41ETA8enW4dkRrUKPAc2dHr7Cum3AecN33my
         LB5ZhIFvrsHRAS3y2OpFomaj9sRtvPsfl3UhbpccINKBEfGtRv9ENqaFPWNCqDcfvxjJ
         yvCA==
X-Gm-Message-State: AOJu0YwOFm6n3LDFXEB/W8JyVHSSDLF4VjP+ZyDrWGywo5p7YzvyU8Id
	99cJkIXId0G2DlqAEkBmvsyTm6UHoVRGQxpvn94kDwGRmHnm6S40T4PpBddphYhxgmSb3D8Qd39
	p7c2+2eYOqrIE6gdpvNoY
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444619ejc.6.1695213409773;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmJTym5YvZ4MH52qjmmgnlm70HGxEIyE84IZpdWdDkioxeqQ+sBFeg2a5b+qpjuhd9RNuOjA==
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444608ejc.6.1695213409547;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b0098ce63e36e9sm9447247ejt.16.2023.09.20.05.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:47 -0700 (PDT)
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
	David Airlie <airlied@redhat.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/5] kernel: kexec: copy user-array safely
Date: Wed, 20 Sep 2023 14:36:10 +0200
Message-ID: <20230920123612.16914-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053653_454928_0CD0144A 
X-CRM114-Status: GOOD (  11.98  )
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
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
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
