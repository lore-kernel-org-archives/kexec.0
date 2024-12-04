Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0281FE7716B
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=; b=zPQruYb4scvFEX55V9/4qhEkFf
	j/re79lrxXSYzs6qnLZxGzSLlL9qb+c2iPA7z2HS7ZmbS8G7feeu2PBfL9XY1po+RvcWSRmS6+og5
	qoBKUnCM8VfzFXym5H+XyhGkY0Z5WychLqrf/zLSKE6/0vi+CavtlEEzCS4qJVNkr+wE7E+OOhs+0
	5gP4RI+xfbcYwQ5WeNr8LSNpkLqVf1TBbwrYtAmff7r6qiKrUuVFVqsDt4UBse5FaMM4HXxFp0fDZ
	yzjcuY9bE2uEBB7+iOsiZxXjO8b0vzFQ+xgGhoPC6eOVr3N2wAFmVZXhK3rR3hENQ5HJue5Uoc47H
	rGDdIGeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxl-0000000Cbhz-1qIa;
	Wed, 04 Dec 2024 12:58:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouV-0000000CaEP-2y56
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
	b=SUrsgERqY9fyu6gaalnXVg6vtfK2e3nTFV1mtgH+aGoVDwfQUj2ycFCD15Zevd9L1rBUQS
	GSUJxvWS6qnzvo2A4qZIomzC+rI53B128diHOFJq3nGhkOLRZ2oBY5XOAiB6Extz5kAORm
	RR0aHzlZ43y4hbPqx56/UbRuToGoDB4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-BeAOqVpXMPaTScyznqZuVg-1; Wed, 04 Dec 2024 07:55:16 -0500
X-MC-Unique: BeAOqVpXMPaTScyznqZuVg-1
X-Mimecast-MFC-AGG-ID: BeAOqVpXMPaTScyznqZuVg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af7937so55219075e9.1
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316914; x=1733921714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
        b=mnIag9cR6Q6lgdbyJ3Wr3Vk47JWIcSgqHBUz1gwYwdsrgVJfkub10Lv0/uCffQFfdz
         S4AZanmWZEUZnY83uUEhkTm4V8A5vUYlE9269hkK5GcbmW5ZNNUU7Hh79CEZe3Lxt5I8
         SUM26K+gD4myS7o27q4jdt7LZK8G+ePPOY22T4WW5nN5qdgw1PNAHqcwi+CSihce7iLB
         VyP81q0HAXb7rxFy5QyxEHpjFs+K8CFcKJUMdMhEhCUgvTjzqyy93o80IQ5KRWUevBbj
         ebBGRZtU2t3ydNwnrKmsTz7sJ0KxW1O9/XDOgdROe7sgury+lNXM8UBY9uDMrfPDxsl5
         Kubg==
X-Forwarded-Encrypted: i=1; AJvYcCXdgFlJmqyYCDhIWT+a9xuxilXRFsGmp9tm9b6b4QClOUDurT8Vh8fH6zU/Btgy+054IZLMcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzicR4DcKpv49nI8MPqqDPCdaDHPQjddWEK+aa6++LcyPp7slzX
	aff5fC31/OZJE+p626zGXy2SvTlUdokpwE1K/dkeDmaxJh7dRASNdUPNTzu9raWJJPNAhxTerdT
	oZKtwCEnZbBQrn1VTuRtpYjgLNVDzgU6wqfxlMFGYTyfi13yKGKLv4RHTQA==
X-Gm-Gg: ASbGncsar6RAPV8jK4xYai/JUoZC79sZGSbJhIPi10yTrBSBlCr1DTIXZ60eMEjW8We
	38PZ04u8qx8/BZzoalebdtVzpxOZmw7Y/LjELBAe9zAZqH3rlVyOP7J7qAr44jWTdSsLXBno/Nd
	Ihvy/lxY+O2UNrSwIVjzfGr1xid6OX8Ovt+kmU1q3r/nF5LRyAU/xlbMp7BCUsZJDwDoRwWJ0T8
	KbswZfzpMTYpQpNYExaOVXKIcDSrGa3X1pIfNwRlbHwc1+xMhe1b0FDU3TlncobcIoWN/Hgknjf
	hZ19gKO9s++e2usp8zxzsUYKWF578dfd2Gc=
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62644175e9.30.1733316913733;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdVB6YFjtubaQuZKYqVl7K3swrZVKNM9mWRen9YVYSXicgBrRTJ3zdugRU4fK2CCWYQJl/Fg==
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62643915e9.30.1733316913375;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385df488559sm15210226f8f.63.2024.12.04.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:12 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 09/12] virtio-mem: mark device ready before registering callbacks in kdump mode
Date: Wed,  4 Dec 2024 13:54:40 +0100
Message-ID: <20241204125444.1734652-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nLlFhUJ_eVxlpRrLjBVbEq_E4v-bDaQT5ANkd0bE4m0_1733316914
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045519_812573_A9F13311 
X-CRM114-Status: GOOD (  13.52  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

After the callbacks are registered we may immediately get a callback. So
mark the device ready before registering the callbacks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b0b871441578..126f1d669bb0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2648,6 +2648,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	if (rc)
 		goto out_unreg_pm;
 
+	virtio_device_ready(vm->vdev);
 	return 0;
 out_unreg_pm:
 	unregister_pm_notifier(&vm->pm_notifier);
@@ -2729,6 +2730,8 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+	/* We must be prepared to receive a callback immediately. */
+	virtio_device_ready(vm->vdev);
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
@@ -2870,8 +2873,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
-	virtio_device_ready(vdev);
-
 	/* trigger a config update to start processing the requested_size */
 	if (!vm->in_kdump) {
 		atomic_set(&vm->config_changed, 1);
-- 
2.47.1


