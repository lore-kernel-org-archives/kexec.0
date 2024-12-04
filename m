Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F4E7716E
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=; b=3E3LbvT4y0HOVKWEijuPAGHkUz
	SzeGQrHZW39OQb6u4HPoOdWa5nDXjxwDFIqx9hlZiaZ7+4xqSimBZ/a3kl9Bs69nhw7ZCP/z7VmxH
	osCedhOznZmnsST1sx70TSQweJG7FHncqSdTFaTNTVG1/MGJznA9eqU/SR+ygrdPFgYB207ut+R77
	kejmnYBRnfwcspXTzhEbDJNbIyLlgWL/Hr0w7bOYKoWaTjHl3P5xrjiFmV+I2OEu1fDZQuuAImf6F
	rEM8sOp9nR9SyzGnNhHkqggaJmPWv/vevNmCdoWSQ8qLRKBqdViIIFTCIO73RvPu1V7ErcJGVWNIv
	FeC6oqQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxd-0000000CbNw-35fh;
	Wed, 04 Dec 2024 12:58:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIou8-0000000Ca3T-1f1i
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
	b=aIY6S0/pl2mAWKnk2YhdCjho6g5xm6MFB8zvXAQ7Ptn3s6S2aGka8EyXaMrOKnEmScgmqH
	EbTG89VwsF0xgjbITvKU+Zh0aXZaKpjPPr9Xu2MK3IfDX09QVo//KIcsQOPNZLlimxQ/Kj
	Yosthy0tJg7xCd+J521tOlIzGrVgjlQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-_1OjBS3lNj657iCfMi4sDg-1; Wed, 04 Dec 2024 07:54:52 -0500
X-MC-Unique: _1OjBS3lNj657iCfMi4sDg-1
X-Mimecast-MFC-AGG-ID: _1OjBS3lNj657iCfMi4sDg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e9c69929so1598852f8f.1
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316891; x=1733921691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
        b=uLx+44+9/PeBkQ6TmfQPI8soPNjtaoK4uSkeHxB3BZhhOrr5UhXxn4A9hUQfnxWn6Y
         xkUetBo+jTOVfZgWkOzLqz5Z051SLYeGwpSewWbrnwgv5hvy7A9KU49/64++BnjUQZN5
         D3JATPxgg58tGiHJ6rM8WRUUBB2FioZmng4JeU3LVoJbxP74lLNpnaRKWPfMhkZtX3Pg
         XTkDBsW+HqZoL8JdQvqISAcZDBEBSLUoQru+5YUhFkvmE9CDO/7buyA6sYwa7SwKKDGF
         BU2QDhdoQ1p2tSdW5nck58z+Y7dcTD4LawZ30jU2Fm8iZp3Sf0leLdzz/zbt1HogUCEy
         +9cg==
X-Forwarded-Encrypted: i=1; AJvYcCWycboesVRy5hWJg2sRsDLFugEtYlU4RckgegsmJmSuPNgdlvwR9LWU5YQ7Kjn7TifAzVOCaA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1wuo2xrMn3Xg3hDRv6rTEthjxmK6aoq3Ajlpowi8BL7PxB/sZ
	mrYmjTPw/vuA5eD2L49cup3FZtpSbmVE0WzgNkYseSDCN1Ka5aAXsvtqFzXC2uz8yJnB5orlVj1
	HOt0oHXlmajOOnzsF7f/JRI5gzkwCNFJ+HrpYp2zyOAmEqwjc6WGpHFYZOg==
X-Gm-Gg: ASbGnctJ6XEqqdHUwhXRUMnVQ3SO7VebIHrtTXdum6k6HTeOasZt+sdJFQ8FfzbJ9oo
	ZEvzT1jk9yxOmrVLlT/sB+k0y8oPcgO/IrjNmW937XZnPAG4wQCmDHsTqCqcAzCvPUMpRs093/g
	KEvghVkI2RziLIoRlMgyyg5VLQYUiGHoEmGFzK9e7Dp86gntSUk1i32MPWS3vOWQxDXJUXtD8Q6
	C8/MbnySli1zjqtAKIbgU9j27zp/5JILSWzHwpqAbo5O3gbds/wokujFiLv5Y5vty+ZON9IMfdX
	O6CsEIpnGvYNFKukNrogKMQl8kPU/8/Rlds=
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360099f8f.37.1733316890966;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGOcFoEjkEw+PoNC+LLaws3waLwovX9iW85k260HP1nxTmH4H7ZaUgV85wmWvqw6YlLZ08+Q==
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360063f8f.37.1733316890620;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ea9c5952sm11045422f8f.67.2024.12.04.04.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:49 -0800 (PST)
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
Subject: [PATCH v2 01/12] fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:32 +0100
Message-ID: <20241204125444.1734652-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mqYEPGZgUmMHMEXFj71ORIWbVFl6IVyYsTy_d3EWSiY_1733316891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045456_506732_BE06BBD3 
X-CRM114-Status: GOOD (  13.01  )
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

We want to protect vmcore modifications from concurrent opening of
the vmcore, and also serialize vmcore modification.

(a) We can currently modify the vmcore after it was opened. This can happen
    if a vmcoredd is added after the vmcore module was initialized and
    already opened by user space. We want to fix that and prepare for
    new code wanting to serialize against concurrent opening.

(b) To handle it cleanly we need to protect the modifications against
    concurrent opening. As the modifications end up allocating memory and
    can sleep, we cannot rely on the spinlock.

Let's convert the spinlock into a mutex to prepare for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b4521b096058..586f84677d2f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 /* Device Dump Size */
 static size_t vmcoredd_orig_sz;
 
-static DEFINE_SPINLOCK(vmcore_cb_lock);
+static DEFINE_MUTEX(vmcore_mutex);
+
 DEFINE_STATIC_SRCU(vmcore_cb_srcu);
 /* List of registered vmcore callbacks. */
 static LIST_HEAD(vmcore_cb_list);
@@ -72,7 +73,7 @@ static bool vmcore_opened;
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&cb->next, &vmcore_cb_list);
 	/*
 	 * Registering a vmcore callback after the vmcore was opened is
@@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
 
 void unregister_vmcore_cb(struct vmcore_cb *cb)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_del_rcu(&cb->next);
 	/*
 	 * Unregistering a vmcore callback after the vmcore was opened is
@@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback unregistration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	synchronize_srcu(&vmcore_cb_srcu);
 }
@@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
 
 static int open_vmcore(struct inode *inode, struct file *file)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	vmcore_opened = true;
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	return 0;
 }
-- 
2.47.1


