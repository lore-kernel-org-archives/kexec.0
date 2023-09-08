Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13700EEB569
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=veKE9kV1m8lHv6mDfqy18qaKhA0a1NgkBH3AS9LJVWQ=; b=PoOi3m7smRb76S
	wyTWAaujIinu8KWDDZr7dk72SqhvAqlD/kRAvYYIDGpagugm4WygHadlqv6HmFQmGn0tGOXZlpTmb
	3NfeeaKY4JYv9H+8OAhRWXlGChjXPs1RwPF+q4+hwRSmxjpksnT408Ky73Y4zDJStJtnAYjLsBthB
	a2CF8jGZVPIgzd4Fnju/ilE//lDIdY9KZm87tr/EUfmKHCu4L/eP+3psexe1CIh5tvb+SfG/Tq0yI
	yhsTR6gfwyz3HdTerOlxvu9z7SBFff87q61pXLQoM6Nmy4712vMIhFLh8oYVa0oWy5mBZRvvhTm+P
	EPz7ZVMUM7yM73DoExsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhN-00EQYk-0S;
	Fri, 08 Sep 2023 20:03:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhK-00EQXk-1c
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
	b=JeZWNB/PTm3V0minbjvOeDVEGigvVR1ApdNIqB9z+g57ubzApFZnxrQvQgsmoqg1Cqgvcd
	4/FOz1jir7zn8AbY+3uemiFbAv/wxgE33uZQn0Khtb6nfR0vOIwTd0n1OQdephhSxtp63a
	/LV43YjDqi/VCaLJbNWz6QN8o1lffgY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-vdkyJnc2MOagNxahx4JCcA-1; Fri, 08 Sep 2023 16:03:20 -0400
X-MC-Unique: vdkyJnc2MOagNxahx4JCcA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4122119722eso4981711cf.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203399; x=1694808199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=Pn/OBHfJG7A5Pi2+D1J2cIec4rRda6kudc/ZRw5XRL/KXSUTfcuafVT5EDXdELEsWl
         AoJVmJxS6qhATMUTIkwhgYBScdhZp/GN4LJ81vFOf2OfiNsTV6NnXrIFgV012jbMToEP
         3ulpui8kdOL9hlw5DeyI1g+zmT1HuOAXgV+gofGcwCONLEHHDDku1TzJWMPzKXq1OEvk
         ZAJawe6iNVQgUx0XJFwBXL0LAOuzLMy72HhaKkunrSpaaYGY9+VTsD4u+iv/D3T7Aw8z
         Xxv/1wRQfRW+TUio5bEkxajfMRCZFRF+GOr82sKLfOxrEwJ9vJoNYMDdh0gFKJvqNuYA
         dVAA==
X-Gm-Message-State: AOJu0YzbdPMbxl2RIYMJ8/t2jlLeY59Cx8rKtX0uhmIZEdTReirRThVo
	xbyY6lNuhtckuZSK/yU8lPe3rwKsXuqL83PnGXbPl+KUBz9ta1yN2l666J24RFepcyPeXJtVBHk
	87ellytrkQCrS3kO8O176
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683945qtj.1.1694203399546;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAKN1YnAkZtTcGtA674mV4f8NT9irZONaAKXTHG61Fqfz6xPH+/e15CARdB3FRUjLa10PQWg==
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683913qtj.1.1694203399274;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id bb37-20020a05622a1b2500b004116b082feesm843284qtb.75.2023.09.08.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
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
Subject: [PATCH v2 4/5] drm_lease.c: copy user-array safely
Date: Fri,  8 Sep 2023 21:59:43 +0200
Message-ID: <bca4966d616f417267ba02f66ff9891fceffd7f0.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130322_608239_106C9911 
X-CRM114-Status: GOOD (  11.75  )
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
