Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F7C83F18
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jkGo6WOmMbVZ+44m6JfXKX+ly0hItXs2Bg61Z1JK7d8=; b=Q8qEw2iqbBpEfu
	TpzcvO9kpuGAAT1IYxpaNTTXhnOIo6vJ0H1oknRmpJmnNORYd8G/RirQr8lyIZjKGkZqZtF3q9JV1
	7YD41jc3X5RUxs9zSzyqj1oibybY2Y61VaLAYMgjWs6K+4L0N7BigO+1pfhDqXGPASo0NDMDjvq71
	QyR6z7KO1+GBmdkmVJyiKh/pHlNVvYX0292I6vpmcwDMF+m0iqaJsucAyuSXgWRDSR64AYu6bfZMe
	Ot/JtcAOycQAEsu7KbWtinzU1D2b5mKbgFG+MRAlEYPiqRtkEb6oNWxmslRQlpXtTF6a3PymuvKP6
	FLTuZ4MKz5tH/rpU8BGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWo-00Dbqr-1n;
	Wed, 30 Aug 2023 13:46:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWl-00Dbmi-2d
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
	b=BY7VJof0QjqigpStiZgPE008ec1Pwqd9JQBEpTmWasug6HnaNMxnmp2zpkQJfXw+kSJEfy
	mQWmwsuxYvZpW0cqozp8NxQjQC1vn3B1r1k1Gbl6oeF8oRIyRbIQPsdzVoW6NICsktgtTt
	iRn1r2aMXZcX3f4PQdUOQP+2jfVuMt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-kp31feiNNdqk-6eU7MiAXQ-1; Wed, 30 Aug 2023 09:46:30 -0400
X-MC-Unique: kp31feiNNdqk-6eU7MiAXQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5219df4e8c4so757497a12.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403189; x=1694007989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
        b=HkVPNyTR9GGzFFh6UIeIGcAlnPZ8aDM5dRen6tx2MX6khh4iqpKKMezVUuqU0WtlLT
         Y5wgarq0q5lhJZxuzPJEojXhTvHarZ06rxTbLvxydhlsKmuANGuLyCA+vckHK+7NU0cw
         627AllmgnmpddGLXaYIWIOceZPkwEV6f8Fg0SIzE4DyygjgNrkK9gTs1kFr+5NPLrB+2
         FwoTMwRO3Rw2A9wVBA7MUZk7zctwbxCUV3jWfDJXyFxZNbjs/UbIV6Yzf2uP7SKOkznP
         YHFWxm0S0DFgFDY9kL4SxwK9vjbbEC4vr7O8sK4myGrniuxhYIRK+KaJBb5JDOAnC9sA
         GKvw==
X-Gm-Message-State: AOJu0YzKoJvOqUQLX963+qf5ZPEiEp2qcQ/TWpV3CNYI0YyPShwJXlX8
	7ptGaY1d5P6tvJmz5+32nXdKRtqr5HW7APH1eIr+aPva/Ufw9i0JWBmoXLOX4XHLRV7zsciuZ4k
	5Yxk5oeShwGDTqwCJyE7c
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964363edb.4.1693403189073;
        Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpKYbKxrilyWwmvyGSQuR3YdE5ziBNReJitKpOxi4O0anKghb3+MxxX32nil6cbORrhxRuFQ==
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964344edb.4.1693403188914;
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7d297000000b0052595b17fd4sm6683260edq.26.2023.08.30.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
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
Subject: [PATCH 2/5] kernel: kexec: copy user-array safely
Date: Wed, 30 Aug 2023 15:45:53 +0200
Message-ID: <0a3f1bca273792edbdc41b64c454a6f7f499c9a8.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064635_928155_ADED9E53 
X-CRM114-Status: GOOD (  11.15  )
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
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..f6067c1bb089 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
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
