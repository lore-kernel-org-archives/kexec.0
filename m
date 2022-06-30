Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4910C43334
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NEqw6qM++H7z90D6zykc9eb2TAipU7vhOjXA/DUbSd8=; b=FEOpWExKEZEfYH
	NZ1+3KZTkJVhIVBTOE9uzl5xCp4F4Qod3EsekorB5TS42ApcUeK3OmQyRr74oeYIF+kSLfvvj1gel
	nUYPUDUG/2vN+AhpocoFC1NXig79VgWYYHXV6wUnyfA8MoPPO3plEGH8qb44e7NTEChU39zfK8oSQ
	zHN5iBHTDHhqiAbK8Q8WA1poYOT+BsUBCJEjKs93uELFfZdtNzH77dgEM/Px23IJOtM+OzNfwcvIO
	WtcoUaBPeZqL3ik3nsyp2vTep0FaqPVrSYqGGqYeCfUzXMjNNdaqxgfDwuPuvoKZnhkTsTjpgC8Ci
	qqpiiR2PmIAK5q0o0rHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xr2-000nY4-MA; Thu, 30 Jun 2022 17:21:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xqz-000nVY-He
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 17:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656609677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
	b=aVSwNcANXhWyQ19tFKBvRM1QWggqOZYJUwHXuE7sIyvMGoyFR55VhsTAOD7yvGgEmV/ax/
	YHNC8fW0gzmE8CsQFPnsTrOCJFGs53CUszJXGF8HEJt/mT+jL9QlwvrYJivD+HjvbEy4Sa
	8s+2cUrfMgx406OhYxOxQa7JyXDsurs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-pF1T6f33NI6OJUmbyRHPxQ-1; Thu, 30 Jun 2022 13:21:16 -0400
X-MC-Unique: pF1T6f33NI6OJUmbyRHPxQ-1
Received: by mail-wm1-f70.google.com with SMTP id i5-20020a1c3b05000000b003a02b027e53so1682939wma.7
        for <kexec@lists.infradead.org>; Thu, 30 Jun 2022 10:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
        b=Smv+WFKSy/qp9S3EtCoGfAdWqcfQmbip3K8HnjNBqlLxtVuphrE0AGfEETMUEHa5H7
         DhRxPjZZ8txSja38CcMyQ0XF34lQM4ZwdAftVKTip4n2cOfkFmDjwvH0lvEswEpnqBfZ
         pWMznLDvU+qyznrD5HB0bjVwJPbRg1zObQI27wx7c8znfV8ui2TkVQYkjI6/hKztbRbA
         4EgMVUfR0AzognsKJ49XcwMXpKAMNyDBqgbuh4JZiWOaiT+678wRW8AGHfEjIPEgwU4l
         8mmlbSH0WmvQH1wcFN5LAOfsVXFwxEVPvVOozUvgPjicLhcCCCOkIKfaW1sa6zKRV8Ji
         eb7w==
X-Gm-Message-State: AJIora+ZD9U3BICBnaADOARZUe9LE4INYNtLCl57IX6SKRXu2gg2fkJ4
	IHlZJRPevXyHcNz4UNeQinZgGFdT3Ja/8E9R7u9xA2DptSOfUbzJGIhZGWdzNSwmPQxEvecE9r6
	QHpXPbhu8OfvF1ZsRO7Dl7/j6BPkn6Z5tjYJ91cT4l21XXLtXWnXirHO9FSlYvy0oxIVPsRh3
X-Received: by 2002:a5d:5d89:0:b0:21d:407a:d8d3 with SMTP id ci9-20020a5d5d89000000b0021d407ad8d3mr2670467wrb.369.1656609674494;
        Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uokbBJS0X9zNHyARJlxgnxT5Y/QOC+ZqoAr8T+We19KOdP9D4fgQBmv32oBqxEO1suOpVFfg==
X-Received: by 2002:a5d:5d89:0:b0:21d:407a:d8d3 with SMTP id ci9-20020a5d5d89000000b0021d407ad8d3mr2670436wrb.369.1656609674232;
        Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm4065122wmg.17.2022.06.30.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:21:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v3 1/2] kexec: Turn all kexec_mutex acquisitions into trylocks
Date: Thu, 30 Jun 2022 18:20:40 +0100
Message-Id: <20220630172041.4100123-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220630172041.4100123-1-vschneid@redhat.com>
References: <20220630172041.4100123-1-vschneid@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_102121_717196_3CC90980 
X-CRM114-Status: GOOD (  15.97  )
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

Most acquistions of kexec_mutex are done via mutex_trylock() - those were a
direct "translation" from:

  8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()")

there has however been two additions since then that use mutex_lock():
crash_get_memory_size() and crash_shrink_memory().

A later commit will replace said mutex with an atomic variable, and locking
operations will become atomic_cmpxchg(). Rather than having those
mutex_lock() become while (atomic_cmpxchg(&lock, 0, 1)), turn them into
trylocks that can return -EBUSY on acquisition failure.

This does halve the printable size of the crash kernel, but that's still
neighbouring 2G for 32bit kernels which should be ample enough.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/kexec.h |  2 +-
 kernel/kexec_core.c   | 12 ++++++++----
 kernel/ksysfs.c       |  7 ++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..54d7030d3c41 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -390,7 +390,7 @@ extern int kexec_load_disabled;
 extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
-size_t crash_get_memory_size(void);
+ssize_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
 void arch_kexec_protect_crashkres(void);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..16370926b21a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1009,13 +1009,16 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
-size_t crash_get_memory_size(void)
+ssize_t crash_get_memory_size(void)
 {
-	size_t size = 0;
+	ssize_t size = 0;
+
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
-	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
@@ -1036,7 +1039,8 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	mutex_lock(&kexec_mutex);
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
 	if (kexec_crash_image) {
 		ret = -ENOENT;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index b1292a57c2a5..65dba9076f31 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -105,7 +105,12 @@ KERNEL_ATTR_RO(kexec_crash_loaded);
 static ssize_t kexec_crash_size_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%zu\n", crash_get_memory_size());
+	ssize_t size = crash_get_memory_size();
+
+	if (size < 0)
+		return size;
+
+	return sprintf(buf, "%zd\n", size);
 }
 static ssize_t kexec_crash_size_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
