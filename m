Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2740E77170
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVSVbg92vBS9ECQ/qpyBYmAQmSQp+EsDoLv4fB2tW0Q=; b=fAd/ybrR6LqCmxVt82p24PPmsM
	4y+LuuJoYxSleui15sHmD1BoC0Zx0zgnSzjJS2rafJRPLRMg1CMdlDgUBe2/CcqIOS6w+R66vwOEN
	HlnBBXxsNK+xlOvoXQd4arsmP4wNRaVObTW7olSWz+i6NDu/N9ZIbuGp3eMANpTuD4sQdjGT7X8zF
	zUqECY/EhR2mpT243W9rB0g5Dc1llSKck8Clt30LTLck5hlGI3fFYvKFQXE+2yFJ6o6GSnAAeu+ib
	stDyVK0+wCiQgtbHWEvVQmrDWPFkOnClfERh5nMf1urdpu61kfdfUkdjTrqVuv9oW162RT4lbMLLO
	TD7wdgKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxh-0000000CbXT-1Auc;
	Wed, 04 Dec 2024 12:58:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouJ-0000000Ca8Z-1kTN
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVSVbg92vBS9ECQ/qpyBYmAQmSQp+EsDoLv4fB2tW0Q=;
	b=dhDYX9yu3TDYq4KYGDXG+DYAuSCNuabLgdEZOocFaMMM3bFTl0J58nYQqTCrjiSLsXjTGp
	edqyBQkkSgQAAtvyfigoe9QFymPWXf/cw9JEmH33YEKPr5bkm3SKMB5NyGTMq97PbMbK5f
	x70Znfu7oksw/x1Ahne4x0ihMG6BYmc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-52ycNpZDOQigd_VB5f1psg-1; Wed, 04 Dec 2024 07:55:04 -0500
X-MC-Unique: 52ycNpZDOQigd_VB5f1psg-1
X-Mimecast-MFC-AGG-ID: 52ycNpZDOQigd_VB5f1psg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a90febb8so38584405e9.1
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316904; x=1733921704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVSVbg92vBS9ECQ/qpyBYmAQmSQp+EsDoLv4fB2tW0Q=;
        b=H+jQFSDX2GNo6TRMghI4LT5KLS530pe7sNMMDaSoTAWd4evmabxqzajeL7WRQqqVaY
         0KkVXrOf/+YFRj+ndLAEdPbE7a1dbRFdHM6s2ETGkgKOw/wUUPQggl3QaRBgKLFPIuHU
         Ku5LbFbv+sXH+scnw2OuIlzTxCTaEYaLznm1Mk6NyCA552gg23udNiCRUFWq/7RSX9D3
         aGQ3Iu9KVLBubwuRYfd+MHcP/lI8NkPA/qaBqsAlX4N92wOIl4abQuBnRVpeD4kkOtGp
         GiCVkkb9i8Q8X+l8lQvBIWh9YZY1gKBXAY/G41wBdDw7qxUszfnzkc49jwbfcA+cOtEb
         hZrA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfNZ9Q3ogb5ZHpX3rTxaftEcuf4DlNrngsfFQhpb1DI/1Pa0xP3sNAZVcBzKWzi/D2g1ijA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1IYu6mISpiI4FxsFkAQjr5fEUXG2b4rWxC/hGJzmuMXLNGaV6
	1DC0QH+KZP4YtMb8sWoCnuJAD+1pYR+zDXJsfrubfeQt2Ck9HnPlhKN3idvhRQ9gT7fVPRuPT4a
	ePxlJBUM//5xSv2mnIBO5FWdFS+WiFZjTrqGwx0iYnsEX1pLeBnoW+ppN/w==
X-Gm-Gg: ASbGncspvIXlDAbhKrloy4usxR+MzYZxEoSJijFJ5wbXAoO30QYfpYLpuicLWRS2gwz
	e4uaGlksNYowzyMRW7KchDUNOZe97w4Cx79PYHDhXblU4XMHlWFaz8nVcMLQBEahG00cfc0o2qE
	JD7rX/GahFaBzu0FfjiIt0XDwFSxw8+7uFVwTt7wl/MtMK+9qYsUey5cyBNpK0L6THBUVT/rknB
	L+QximItNCakQ5Ltl0ShhT0LWiCRzTQEsXowv9iqUap+TBFi1msgVoMBQbXw0AYefDcoax+mdoV
	sYgyYF21VIuCz4G8/KFJpfkzZjytxlIGros=
X-Received: by 2002:a05:600c:1906:b0:434:942c:1466 with SMTP id 5b1f17b1804b1-434d3fe3665mr34090115e9.29.1733316903715;
        Wed, 04 Dec 2024 04:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp2zQuzmhokkabZpnrzoR4CmRg7d0WsOdBj322Nwyq7pIMtC1YAe5DPX1PH/Wsn3EpBmq5yA==
X-Received: by 2002:a05:600c:1906:b0:434:942c:1466 with SMTP id 5b1f17b1804b1-434d3fe3665mr34089715e9.29.1733316903376;
        Wed, 04 Dec 2024 04:55:03 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52b66ecsm23469265e9.39.2024.12.04.04.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:02 -0800 (PST)
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
Subject: [PATCH v2 05/12] fs/proc/vmcore: move vmcore definitions out of kcore.h
Date: Wed,  4 Dec 2024 13:54:36 +0100
Message-ID: <20241204125444.1734652-6-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b-8xKvFLh3xQxwENBy5-CSbRGFyAN2W6dl-X0dzmIYc_1733316904
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045507_554675_650EDEA7 
X-CRM114-Status: GOOD (  20.48  )
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

These vmcore defines are not related to /proc/kcore, move them out.

We'll move "struct vmcoredd_node" to vmcore.c, because it is only used
internally. While "struct vmcore" is only used internally for now,
we're planning on using it from inline functions in crash_dump.h next,
so move it to crash_dump.h.

While at it, rename "struct vmcore" to "struct vmcore_range", which is a
more suitable name and will make the usage of it outside of vmcore.c
clearer.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 26 ++++++++++++++++----------
 include/linux/crash_dump.h |  7 +++++++
 include/linux/kcore.h      | 13 -------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 13dfc128d07e..8d262017ca11 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,6 +53,12 @@ static u64 vmcore_size;
 static struct proc_dir_entry *proc_vmcore;
 
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
+struct vmcoredd_node {
+	struct list_head list;	/* List of dumps */
+	void *buf;		/* Buffer containing device's dump */
+	unsigned int size;	/* Size of the buffer */
+};
+
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
 
@@ -322,10 +328,10 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
  */
 static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 {
+	struct vmcore_range *m = NULL;
 	ssize_t acc = 0, tmp;
 	size_t tsz;
 	u64 start;
-	struct vmcore *m = NULL;
 
 	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
 		return 0;
@@ -580,7 +586,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 	u64 start, end, len, tsz;
-	struct vmcore *m;
+	struct vmcore_range *m;
 
 	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	end = start + size;
@@ -703,16 +709,16 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore* __init get_new_element(void)
+static struct vmcore_range * __init get_new_element(void)
 {
-	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
+	return kzalloc(sizeof(struct vmcore_range), GFP_KERNEL);
 }
 
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
+	struct vmcore_range *m;
 	u64 size;
-	struct vmcore *m;
 
 	size = elfsz + elfnotesegsz;
 	list_for_each_entry(m, vc_list, list) {
@@ -1110,11 +1116,11 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
+	struct vmcore_range *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
@@ -1153,11 +1159,11 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
+	struct vmcore_range *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
@@ -1195,8 +1201,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 static void set_vmcore_list_offsets(size_t elfsz, size_t elfnotes_sz,
 				    struct list_head *vc_list)
 {
+	struct vmcore_range *m;
 	loff_t vmcore_off;
-	struct vmcore *m;
 
 	/* Skip ELF header, program headers and ELF note segment. */
 	vmcore_off = elfsz + elfnotes_sz;
@@ -1605,9 +1611,9 @@ void vmcore_cleanup(void)
 
 	/* clear the vmcore list. */
 	while (!list_empty(&vmcore_list)) {
-		struct vmcore *m;
+		struct vmcore_range *m;
 
-		m = list_first_entry(&vmcore_list, struct vmcore, list);
+		m = list_first_entry(&vmcore_list, struct vmcore_range, list);
 		list_del(&m->list);
 		kfree(m);
 	}
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..788a45061f35 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -114,6 +114,13 @@ struct vmcore_cb {
 extern void register_vmcore_cb(struct vmcore_cb *cb);
 extern void unregister_vmcore_cb(struct vmcore_cb *cb);
 
+struct vmcore_range {
+	struct list_head list;
+	unsigned long long paddr;
+	unsigned long long size;
+	loff_t offset;
+};
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 86c0f1d18998..9a2fa013c91d 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -20,19 +20,6 @@ struct kcore_list {
 	int type;
 };
 
-struct vmcore {
-	struct list_head list;
-	unsigned long long paddr;
-	unsigned long long size;
-	loff_t offset;
-};
-
-struct vmcoredd_node {
-	struct list_head list;	/* List of dumps */
-	void *buf;		/* Buffer containing device's dump */
-	unsigned int size;	/* Size of the buffer */
-};
-
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
 
-- 
2.47.1


