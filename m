Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB1FE7716E
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=; b=OYGU+L1yJzNJDCfVnMqLMUnnDG
	4jYcK4jbTsUlVitcdYCnF/NKVK2S8pyvo5afmfL245LJZ9tMB5Mvj1LMOFjZ+9hKqHNlltaGhuunF
	tXbVRO6I5//xVeDV4hjIqYWXkreFe2Lrk1GBJc1PxlO1b1QvRdo5iFBcMaZsX7LR/fo2oDhO5YfTn
	dNhOcYPRmaR5DKWylh7e1KD44hb/kXry1hUaNinDYRNgBpdWe1jLGBE07P56flDrJ0q/sGAZL/2cY
	qCoNTd5vtNfwVV8RAiN6kEa0RcsvAHSzxVbaNbhP6hX6gr+dzSL6AxIzCTPwGiXVgQYFkfN+U4RJD
	FIwlw4Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxm-0000000CblG-1U8B;
	Wed, 04 Dec 2024 12:58:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouX-0000000CaEu-1ydh
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
	b=Ev0msI2/1xKiqR0Qvg2LLwuFn/3Da2fR1/x+quZTxdgUwaZLX7GZ0rIlrJZJzDU0PMe3j9
	LsmFVZsaxLwDxru1TJu3JAgOxeQIMEN9vOIx6YPD+KcBlBq0QxZVGYJHkKC1/mORtNoEMc
	tfqe01et3HH5/NlOhLG6IyqvB1aq778=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-AoZOEvWONTWY8gwInWdIgg-1; Wed, 04 Dec 2024 07:55:17 -0500
X-MC-Unique: AoZOEvWONTWY8gwInWdIgg-1
X-Mimecast-MFC-AGG-ID: AoZOEvWONTWY8gwInWdIgg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso62449995e9.1
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316916; x=1733921716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
        b=FOy4CMxOOeIHQovIos2Us7lJ4NirEckKieJZqXmNzpHaMKgWxcXa40pRwbuC+6F16E
         FwOSb88pmy6ELrT0NQmW5yGLLDMgZ7u9FFgZJcAb8wFsaTPQZwSiC1F7SDw4lwOh/bgq
         fDWKg/sm2b0KTe/9vLwW+D5KL3WdDErfDtpmQZSEombRkvxXTCG/PgkcKJwdoSi4saO5
         KFmHgTKWEyOPvo1KQqC3JI4nHDXN7l5Kr9TuRNAJORuybGKGjBehJCjSylDl3T6dUvVD
         yk0uYTAPl8r6IMsKoMGIqB2jAEeC1SEClewVjpXP3Rb0W9FV7pHJQ5dvAOKaYTSFEjb/
         ah2g==
X-Forwarded-Encrypted: i=1; AJvYcCWlXrvRPbHw9PY+7EHqiPErvfYchMJA+ldv2QumWg238vqAYLkqc/WyThD5g1wuhK/P67L3iA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk8QJcgpwv6zPIUi8yYPUWaKnLgFQfwTsDDoFEOh3DYcGQeRUL
	vkjwHfS+tZWjLDXN+0avXR6OL9Lkro3z1IvTgBWUOshgLliCS1Pa46OhqNnFKKZKU57tm5MIwJH
	jjwEHEOjC9829A3OiOncwv93vRA1nfQXBosl1d3ppag6Is03jozxXEJSGag==
X-Gm-Gg: ASbGncsHqgVw+2+j4DAeV8ynRCnCURkem4nDR+13aMYdAt8kkgfrqMKTbtTnggMZFyx
	DXchfGhO9XXNnm39cRT2Imd2MVF9noqYlalefLdnJFYk1AZw5GWIacp5BUxusdbSC+1OVA0L78h
	8xD9ebDIMW5ilZi1ZWhBVcfT6OPapW6ztQM5kmtZB0GIPbDYpdqx1cb/Q5CHjV2zyOIOtrn8cO2
	4N+Pv6uC/LqQgRKQNFCcRdKM8QV6NttofdykKUXsqczouxuyYl182k7ES/F9NCsREhm18iffnhW
	rXUIIcxNyZswxImEMmMz+fxyVIrUvhP9A7I=
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58499865e9.8.1733316916545;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Ukl1ZPphCA+wOQqYI2PG+9UegKLtZCsee5cNCt9biGs2cCCF0gJFsDeKmcsipWxLJl404A==
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58499655e9.8.1733316916209;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52a3139sm24274545e9.28.2024.12.04.04.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:14 -0800 (PST)
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
Subject: [PATCH v2 10/12] virtio-mem: remember usable region size
Date: Wed,  4 Dec 2024 13:54:41 +0100
Message-ID: <20241204125444.1734652-11-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xA5tv-EL-GHXde1tvdUAxuH4XRhELZsOonIJ68180U0_1733316916
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045521_637392_9E3AB594 
X-CRM114-Status: GOOD (  13.98  )
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

Let's remember the usable region size, which will be helpful in kdump
mode next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 126f1d669bb0..73477d5b79cf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -133,6 +133,8 @@ struct virtio_mem {
 	uint64_t addr;
 	/* Maximum region size in bytes. */
 	uint64_t region_size;
+	/* Usable region size in bytes. */
+	uint64_t usable_region_size;
 
 	/* The parent resource for all memory added via this device. */
 	struct resource *parent_resource;
@@ -2368,7 +2370,7 @@ static int virtio_mem_cleanup_pending_mb(struct virtio_mem *vm)
 static void virtio_mem_refresh_config(struct virtio_mem *vm)
 {
 	const struct range pluggable_range = mhp_get_pluggable_range(true);
-	uint64_t new_plugged_size, usable_region_size, end_addr;
+	uint64_t new_plugged_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
@@ -2378,8 +2380,8 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 
 	/* calculate the last usable memory block id */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config,
-			usable_region_size, &usable_region_size);
-	end_addr = min(vm->addr + usable_region_size - 1,
+			usable_region_size, &vm->usable_region_size);
+	end_addr = min(vm->addr + vm->usable_region_size - 1,
 		       pluggable_range.end);
 
 	if (vm->in_sbm) {
@@ -2763,6 +2765,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
 			&vm->region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, usable_region_size,
+			&vm->usable_region_size);
 
 	/* Determine the nid for the device based on the lowest address. */
 	if (vm->nid == NUMA_NO_NODE)
-- 
2.47.1


