Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B3E77174
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=; b=wz3LYZ+X9vYA/fY3UOE3xgllTE
	45E49YZMX5WEgcsptsqtGWT+CJN1N3KntZwBNewOSpA5iVBZgDXcm+Tgr4DYwPLt4V0YnVVXmyOT2
	FCxqTyQILH1Ao05MY8GvZW9WGBlQnsz0bqECKw/N9jnKzUjeflKLze0Si6JoR8C7R6iUoAduaaGe8
	O6uYPrIgUZQvsu/1ONLosA/VIp/5SU4BEapL2nHXF5CJfe3YP0Pk+ka3kZGIVMWVffH1gSzgZ7IQg
	2YdraEMfG9Q85xHsvY8rFdvzLjL6wJ7iAUr6U50fvIxwUvQY14MI904ntzfEqB9APfZKjBouszrj5
	j0cdrcmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxe-0000000CbQg-3BrZ;
	Wed, 04 Dec 2024 12:58:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIou9-0000000Ca3r-139n
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
	b=GunmxSy90/g6QePWMgtggml73as1tWEu180Cbn8AQmHvZ6Rz1eCZ6Oq2R9fGFcbgf2Swe1
	t+sQFoCP9O27BX5VgG5LyQNjsOVN6bmfLHjv2VjWyQd47WWPqz6SPaE9YK62Au29s9nbyA
	6cewNXD9bJ+wDleyZPwpITZc2Y3Wmaw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-vcHi1sgjN7CZy_AnnEKKmw-1; Wed, 04 Dec 2024 07:54:55 -0500
X-MC-Unique: vcHi1sgjN7CZy_AnnEKKmw-1
X-Mimecast-MFC-AGG-ID: vcHi1sgjN7CZy_AnnEKKmw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e1fd40acso2622521f8f.3
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316894; x=1733921694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
        b=LA4vOePN4YnroWTw0BrPntgtil4qtm+Fu95hGDMcT16+/bnUhszuqb5wWfOgZemT1Q
         ROgxslhNQ30sUcX3oRA+C4JAHMffT4ZQ/Rsx4vTfw/4Ag8OMPQ6e4+7GN/zVAiZ0192y
         9LnYMHdlgDYlA6aS4t+TRe6xQyrbEpneNi0w9pborwMamLM81zt14KQ9wOqNkKZm+0H3
         scytJLJgeigb5vpRN8ZioEmdRZHZEzFlqLUAjcYOsXuArKt/c1kbYwCru41Yzw64yMej
         nDUxZsZIu/KpDABinPlzZwKnAXQmj/lJVibcjrOlDqMkzwIpxRjPmZ2X97bea5vGguZp
         nsiA==
X-Forwarded-Encrypted: i=1; AJvYcCV58QKDgPxapuchTSdPsAMmzV3bmIuKUEHecNQkvN0QNso0A+fkYG3SFfKKzVOHnksSpDZR+g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSQTzcjX1ES194L7iBjRPBh/p3ZYlHpNa12ed3KKJJ4Z8sk95m
	N64+f4f97XF4uj9vvQDurQILRWFSsfKHTrSYFvgVNJhAXHtlRn4VddsqACctncwS8ChO7YXBmVw
	RsyH/t6D6gcD9Qf6vMiqRP7OmAZn5gtAWXMuv3xIz3lgp1GiDA5Dc2ZzljQ==
X-Gm-Gg: ASbGncvhZTuBczYgMn3wG7okdAPUNJlvgTTv1ihNH+Xd4H5gBcURdNgnTwqbhxF2MIr
	jCJVOR/lmsTcT929iDmE/oq6oEtTkCCG79VkMgC5511xuItfc+7wMYn8bjGqggGAHuPQPTHc/U0
	oL2lu3FUF90pE0ayVhB4+HVAwpKBkBBDqmwVQ5yxCrMoDNRhJwgMhI/dYAHIWmQQsCGqgr1gD20
	JRZ3b+uqsFRQ800Pc7zmagBe9wpvCNXvtKFXjuyn0n6Z21AaEvK4wjoV4wQcZye0pLfbT2/2RQF
	d8C3W/DNvfOsZbhyrEc82k1wuO9AukWL+/g=
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400372f8f.33.1733316893947;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvdtkWkEwxi8mpcTLDx5Tk+eqhyWjoc+BX5ypLCUE7CH8mOKCeowIphEqt4hXFtq1npl/2WQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400356f8f.33.1733316893544;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c12a4sm23880495e9.30.2024.12.04.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:52 -0800 (PST)
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
Subject: [PATCH v2 02/12] fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:33 +0100
Message-ID: <20241204125444.1734652-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ek_xqgqpIfdDO-MckKOceVXOsgIvIEGCQ27J-YuuSIs_1733316894
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045457_355219_B33D4115 
X-CRM114-Status: GOOD (  15.14  )
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

Now that we have a mutex that synchronizes against opening of the vmcore,
let's use that one to replace vmcoredd_mutex: there is no need to have
two separate ones.

This is a preparation for properly preventing vmcore modifications
after the vmcore was opened.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 586f84677d2f..e5a7e302f91f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
-static DEFINE_MUTEX(vmcoredd_mutex);
 
 static bool vmcoredd_disabled;
 core_param(novmcoredd, vmcoredd_disabled, bool, 0);
@@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 
@@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 #endif /* CONFIG_MMU */
@@ -1518,9 +1517,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list */
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 
 	vmcoredd_update_size(data_size);
 	return 0;
@@ -1538,7 +1537,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
 static void vmcore_free_device_dumps(void)
 {
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	while (!list_empty(&vmcoredd_list)) {
 		struct vmcoredd_node *dump;
 
@@ -1548,7 +1547,7 @@ static void vmcore_free_device_dumps(void)
 		vfree(dump->buf);
 		vfree(dump);
 	}
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
-- 
2.47.1


