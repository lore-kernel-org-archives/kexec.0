Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68B7CE79D0
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xdjg3+HK3S6L0i+U8C/Lrw+I84e3kiEv9awbO+N9MZg=; b=UINXmeEsXA4oYb
	ay6Tzfj3NxHq35va/RcW3nK3r4xt5vXW1kPcsQ7a7/GQxQsXsQzhbDaa702idke9bZH6bzZ0cxvsY
	505Et19RLQcgJl+ZknOOnpbuwzezY+e+gCmCs6cnWeNPfP6l2bUZmoP/Uof3dmNBPvGcHEKo87d84
	gR2NKuyACfd58zVbzQ+/Vtcq9qgkj/P0mvG22FTpP+TjhMoCGv9fW9e997pNnIpbFioyeywZrcw9s
	u+m/sje6urikP4VoysORHwv1TqVsr6Im4nGTV0ldgmO79vKCwZ0cbqKXyM1bJNaYnFa77J+0Z+sZK
	f6vIkiTayZev0XgZlT/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwS3-00330G-0g;
	Wed, 20 Sep 2023 12:37:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwS0-0032yj-17
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
	b=YLUYZKL1a/GCQeWmyP6lQkHfQSoQqcoo+fShY8IgKtOO6/DKY2EW9PCQ2+B0P2mkucllPK
	uHFIUR6coPduM4IDqTl8/G4KiNP4pK1cvU5LtjVqdynUpG9BHlR41IcpEURt75yPNP/gHX
	lxTvfQJ+4iFS/ood9VX0LSo+ZZGYISo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252--IRgNvrsMYC8mlB1ocDK5A-1; Wed, 20 Sep 2023 08:37:00 -0400
X-MC-Unique: -IRgNvrsMYC8mlB1ocDK5A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be48142a6cso15826081fa.1
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213418; x=1695818218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
        b=lMfcH/uBkdd3DUDODkWBHzia/2AJ3QzPRIA5TYmS7GCCnn5vVzqSVahn50cbhh2/Vu
         O4eKHIL1RNjAwwu9g2FKePVlRjpJiz++0hYbeNOTR7apBkSFCKecd6ilMUMId+ySo3k7
         RLlLVTfHK/pd4i1zEgRv8YA8D8SvMfDWcoaik1LAPf+uxHZq65PqDIkqqkDKTLmOnJml
         ELZ3UmSDNHoqglEOxuuWMPMwFT3W4eH1ZEcogEr9Kt312hctRDI/gmpV2MKVAzJ13Je+
         +CprHtj5tIV/90QSCRrp2bM5THqNvnQGBhX5ak64OFu1H6m94YF6H1/qLaOj9uQRuVRT
         kj/g==
X-Gm-Message-State: AOJu0YyapKmSqQw6rImplf1YJxg29RiKEgMAfd4giFOTdoSv2CCqLKDx
	rJYBDMFv1+nLqpuphznsmiqql4qlbBfRPJqaDh2fCQ5SUWJ9W4n0oAxS4NN98jgmZh6ONa/7mgh
	pMpRey+V+hWCcGOTRjwpm
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921133ljb.1.1695213418530;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGtYN79a4/Uyeq8meM3+9mCAQ2LGvBXOKnKduArpSa1zP3qsVYH9Wh1PFHrd4S88GImDITZQ==
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921120ljb.1.1695213418185;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id op15-20020a170906bcef00b009ae4ead6c01sm660073ejb.163.2023.09.20.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:55 -0700 (PDT)
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
Subject: [PATCH v3 3/5] kernel: watch_queue: copy user-array safely
Date: Wed, 20 Sep 2023 14:36:11 +0200
Message-ID: <20230920123612.16914-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053704_481684_882FF2EA 
X-CRM114-Status: GOOD (  12.09  )
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
