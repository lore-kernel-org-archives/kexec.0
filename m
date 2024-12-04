Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977CE77177
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9g+9cVRXvhHLgxGSqrQTBE7Bw6RR/sxdLnnaInZE9Y8=; b=PK2VcUrx101KYywCeYxRiT4P1a
	RTPwtYVT9gPUQKJaipKRZkBfnWUrzyBl0k17XSGbE9nglq8zfbF+rhMT0XUp2d8tnzxBgFlUJLkXJ
	x+KmSX2fAaS1PPjEhlVw6ZZyu2r3WpnLGVchetCTu8THY9CT795s+8hFLkSpS7NHswM9xeijw0ABD
	zI4Zt+7l0J05+/LnIyT05ZF4CMvQ9P/UCe4EomcSNfNp7YKSl82x4IKq2qCaj/nhwmOACChLNBD/0
	K0U7SyuWYKlauqP9gyTp+I7VgMWq52kzbFLyIOencwgZNQ/Db8PBwzHRvGwFEuy4BlDPOdGpNV7Rx
	VTVi1I8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxf-0000000CbTF-3NSE;
	Wed, 04 Dec 2024 12:58:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouE-0000000Ca5o-1tkt
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g+9cVRXvhHLgxGSqrQTBE7Bw6RR/sxdLnnaInZE9Y8=;
	b=B+oZdiwb5JlndyQaQ9mUUlqUyKFLrgfc8DKFmCMX9ph4M4T21A0p0ie/ECoiljRwqOzGVW
	p4CO3Df+AVTiNzQ8CJRnDOzXu46eJIRsIAHGAIPGAT+D1p8EVM33YTmzCb/q2LH3LBRszj
	RYHpxwjhKbN/T37bYkQlk0gt+4T2ztw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-QltMoE4rMv6AmgyWmsW1KQ-1; Wed, 04 Dec 2024 07:55:00 -0500
X-MC-Unique: QltMoE4rMv6AmgyWmsW1KQ-1
X-Mimecast-MFC-AGG-ID: QltMoE4rMv6AmgyWmsW1KQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so38551225e9.3
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316899; x=1733921699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g+9cVRXvhHLgxGSqrQTBE7Bw6RR/sxdLnnaInZE9Y8=;
        b=Y4T0TGXGSu2mWzOuPYFIqw3JfhucrOJpPvQQ4saMB/P1K1kCZv05QWaYfiQE3yRMO3
         cOdyslxuF9rSwE+Xk3KeL4Qyipz9NuRNia/uY2Mb1AOg9qPOhmSCiGeCo0QuS01V3iPq
         glaSmytLcRNN/Zi4NqxHT7OSBnrZ6Iy7akWUtY23WGITkxKkYi7cNkSX2q3/bLH5vOrU
         suvQO3DXl4POwanHvm7QZeDKy4MtS9YPrJ8gWmt5tCjsBvmPq/yKq+/8VCiBwgrAbkVk
         XMu4mREtZeNz86E6dj8woHp+mXifG67mORJn3tJByC3bItG3/ruF6lccBJH/QPtIieuK
         Nbpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4U56AKKH+YSdCgtc+qliAxUae4pCstROQd7zxKmK6GMrmBG+Ey5Cgi1RDvC9v1qtP2IIbUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzrmWgDHM41PhcPM+d1DmC65cfcyyTnAs/G6WUwH/TIfNhXpFaz
	2qUvZn7LSQoMzIlUSvMMJSdyybLHpoEZdq9a4i4jKffhbiZ6nJMd/gFnOANIvTirlGZ9PxTT0pb
	V8cZjNzXol3SCe7P656tteDQnyuKrnG84idd55QrBSnq03RZMOaln0jbBbQ==
X-Gm-Gg: ASbGncsxUAjbD38Xr7dnpQPmDy6sUUYibqgrV6qsY/iGaJAfKySBC56Z1Ilc0DUsVuR
	lo8sM/7M9bCX6YItsuDRLUKWEbuqkbpOBk4aP2CRUfuhbJY7ZEOQNvSUWqWNAJ7iwwbd0JEFSS1
	GwGyzVaANIsSh8Ukc5RpsWhWoawYIP04IzA9jdbnQhzVoxG0Xt++rJKMY53FaEK983wJVeN6djk
	WiZLFxYfF2A0UOzkBzMHpT5+gtjkRN3ybNoNeHDv15jG77fE2/oRPrLpSyKfqSdx2kr4U4v+F82
	WB6BKEaaFG6yyYWiFEROkGliJuh+42j4o8w=
X-Received: by 2002:a05:600c:a46:b0:434:9e17:18e5 with SMTP id 5b1f17b1804b1-434d3f015c9mr39711635e9.0.1733316899002;
        Wed, 04 Dec 2024 04:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeFWcM8kn1L8FVMwX9bQLaSRcl3tsS9Ol6XIyBOc2az2VjBMSNXd7wAhtLStmYUmhz8yBnag==
X-Received: by 2002:a05:600c:a46:b0:434:9e17:18e5 with SMTP id 5b1f17b1804b1-434d3f015c9mr39710705e9.0.1733316897137;
        Wed, 04 Dec 2024 04:54:57 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0dc8sm23581375e9.27.2024.12.04.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:55 -0800 (PST)
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
Subject: [PATCH v2 03/12] fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
Date: Wed,  4 Dec 2024 13:54:34 +0100
Message-ID: <20241204125444.1734652-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P7zBkPrbW3fmdeD28p9eRnYQf4nfavaZvJvMLs0GNuc_1733316899
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045502_564359_ED8CC11B 
X-CRM114-Status: GOOD (  21.22  )
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

The vmcoredd_update_size() call and its effects (size/offset changes) are
currently completely unsynchronized, and will cause trouble when
performed concurrently, or when done while someone is already reading the
vmcore.

Let's protect all vmcore modifications by the vmcore_mutex, disallow vmcore
modifications while the vmcore is open, and warn on vmcore
modifications after the vmcore was already opened once: modifications
while the vmcore is open are unsafe, and modifications after the vmcore
was opened indicates trouble. Properly synchronize against concurrent
opening of the vmcore.

No need to grab the mutex during mmap()/read(): after we opened the
vmcore, modifications are impossible.

It's worth noting that modifications after the vmcore was opened are
completely unexpected, so failing if open, and warning if already opened
(+closed again) is good enough.

This change not only handles concurrent adding of device dumps +
concurrent reading of the vmcore properly, it also prepares for other
mechanisms that will modify the vmcore.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 57 +++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index e5a7e302f91f..16faabe5ea30 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -68,6 +68,8 @@ DEFINE_STATIC_SRCU(vmcore_cb_srcu);
 static LIST_HEAD(vmcore_cb_list);
 /* Whether the vmcore has been opened once. */
 static bool vmcore_opened;
+/* Whether the vmcore is currently open. */
+static unsigned int vmcore_open;
 
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
@@ -122,6 +124,20 @@ static int open_vmcore(struct inode *inode, struct file *file)
 {
 	mutex_lock(&vmcore_mutex);
 	vmcore_opened = true;
+	if (vmcore_open + 1 == 0) {
+		mutex_unlock(&vmcore_mutex);
+		return -EBUSY;
+	}
+	vmcore_open++;
+	mutex_unlock(&vmcore_mutex);
+
+	return 0;
+}
+
+static int release_vmcore(struct inode *inode, struct file *file)
+{
+	mutex_lock(&vmcore_mutex);
+	vmcore_open--;
 	mutex_unlock(&vmcore_mutex);
 
 	return 0;
@@ -243,33 +259,27 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
-	int ret = 0;
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to_iter(buf, tsz, iter) < tsz) {
-				ret = -EFAULT;
-				goto out_unlock;
-			}
+			if (copy_to_iter(buf, tsz, iter) < tsz)
+				return -EFAULT;
 
 			size -= tsz;
 			start += tsz;
 
 			/* Leave now if buffer filled already */
 			if (!size)
-				goto out_unlock;
+				return 0;
 		}
 		offset += dump->size;
 	}
 
-out_unlock:
-	mutex_unlock(&vmcore_mutex);
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_MMU
@@ -278,20 +288,16 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
-	int ret = 0;
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
 			if (remap_vmalloc_range_partial(vma, dst, buf, 0,
-							tsz)) {
-				ret = -EFAULT;
-				goto out_unlock;
-			}
+							tsz))
+				return -EFAULT;
 
 			size -= tsz;
 			start += tsz;
@@ -299,14 +305,12 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 
 			/* Leave now if buffer filled already */
 			if (!size)
-				goto out_unlock;
+				return 0;
 		}
 		offset += dump->size;
 	}
 
-out_unlock:
-	mutex_unlock(&vmcore_mutex);
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_MMU */
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
@@ -691,6 +695,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 static const struct proc_ops vmcore_proc_ops = {
 	.proc_open	= open_vmcore,
+	.proc_release	= release_vmcore,
 	.proc_read_iter	= read_vmcore,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
@@ -1516,12 +1521,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->buf = buf;
 	dump->size = data_size;
 
-	/* Add the dump to driver sysfs list */
+	/* Add the dump to driver sysfs list and update the elfcore hdr */
 	mutex_lock(&vmcore_mutex);
-	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcore_mutex);
+	if (vmcore_opened)
+		pr_warn_once("Unexpected adding of device dump\n");
+	if (vmcore_open) {
+		ret = -EBUSY;
+		goto out_err;
+	}
 
+	list_add_tail(&dump->list, &vmcoredd_list);
 	vmcoredd_update_size(data_size);
+	mutex_unlock(&vmcore_mutex);
 	return 0;
 
 out_err:
-- 
2.47.1


