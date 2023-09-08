Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E58EEB569
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jjW/UbKiZpjpt7JXwtsC94ll8bu2BEkYOhN95rJf+0=; b=GuYk+l2a+jF/dw
	e5nYooUmd+RxxiRkQyk8aZgqHIhscVFmtq8MF//A1a22M6P2TSUTp0wqzHzrWeTkyQbL6GrG7Cc0+
	uY6gP53qKvTB9yYYB3j74y/HnZku0qZi+xFZIemTSIQI/OZ1J1DSZ25lUXrAgovBkThujR04DMXjt
	JsWmEFcDco19Rx1jDOHFvisSdLqjk/CObod4U4vVvVtMA2G8HdeYDejCyYVO3QMVvNgkdciLEN5q5
	mqb3UsIpao6c9dV8qEEkI4Q04Dxl2+b6ZPj8Ym/Yp51e/pyq3F42abeme/3uzMFktGvPpBy+qiaOl
	toHLMpWCksMkAcpvijsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhF-00EQVr-0E;
	Fri, 08 Sep 2023 20:03:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehhC-00EQUy-0c
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
	b=KCRLv7MUEt6Q0udobb7lP1jekmzhVia2f/RZ4M5uqfLqVYA+7MDEupYLccbWaAQXwetsyj
	e/7eDyGSGd1KvoRizwWL7CWOjdvkKMET2uf4cNXM5VlrvtVaN/7SyS8+DTbR5uOwlRd7pY
	vuv4sljZSwe5mYLb4yOe9+xlBkMFP6g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-GyLEwb-yPEmDoezMcorpRw-1; Fri, 08 Sep 2023 16:03:11 -0400
X-MC-Unique: GyLEwb-yPEmDoezMcorpRw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76f191e26f5so58808985a.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203391; x=1694808191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=LyYLv6V6/4cOJ62xPE3c0NsPSO0qtHKMvFhQR1xNi2XmAkm6EkLkvOCDYEHHcCOYEN
         hsAgL4TyFuPdCIo25w/HvyFl1EUWQltJA0MqiRHZ8wg26PfC+ywS2Xs95h85k53aQsYr
         2+bLAMzkQqcwOse+HM6JVS2JsvHlEKajJ+QgVz4Yj6mQ68qk7Si76dtGu+/XqlawssyS
         I4amsxb+YorlDyHsjQr0tZaDYt8XRgEAeVJebgrkoIp92pv2pf5fiScGE22Fb+wjfJBK
         oy7CzZDXclGbuxXnO/JAyqKyapH+k1hRyv6BLuzbVyzNCMTA4yw0Tdw8jqHSfrnGJtk8
         g0EQ==
X-Gm-Message-State: AOJu0YwW9jSuP20uANvJVoyvcj/3C2GydxKW34Lt1P+fkXOTcBlK0F2F
	uVyv1jO+AeFh1KplaJGMsNclVPR3y7w1BKFbivfUXRA0APt0sak8aTursMLA8zM27zqb+eZYfrP
	RKhAf3Nl2un6yK8Mgk5oo
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480496qkb.5.1694203391524;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuCpViWH7IrGzpUqlTBi1h+iY/5ABj5ubmz/i5MJtwSQDaqOps3aQUe1r5isWfpnPKjPasBg==
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480460qkb.5.1694203391259;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id c17-20020ae9e211000000b0076f15f2918fsm825920qkc.63.2023.09.08.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:10 -0700 (PDT)
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
Subject: [PATCH v2 3/5] kernel: watch_queue: copy user-array safely
Date: Fri,  8 Sep 2023 21:59:42 +0200
Message-ID: <b333514f0be426385b5215b47d24062b4f551584.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130314_296577_74D26FE0 
X-CRM114-Status: GOOD (  11.44  )
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
