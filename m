Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D1DCCFA00
	for <kexec@archiver.kernel.org>; Fri, 31 Oct 2025 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DCpBMK/CVYvWwXkCeSJHMCwNNqeKlHlSBvLEzOXoHA=; b=RzkYoef0Z6Ma6LDZtpF7peJku5
	Jxtyh1ADM26OifnM7LnzI9v7gSC22rZICcKcVFJQdEWLN/xL1ZE9t2NpC22eOSIsLyD0Mbyll2O2V
	s4VMByPOZhn1L/aLPYNKXglhe849SybhR3mDoYIYj67x+sQxjyYcbqNv1NASYMiC9xTl2lVIhUFQP
	EzlVNPsILGrU3oCEFJPWEy74E1+pCKTprAPFHDC0XwvEgRDJPNDtiBNfu9Tpy0NOXLv6tLPxxlIW2
	c1glzV0k9kSSVkmMBfOhmxy9RBzaz+KYDCjuiZXgVvnabNREX6g18nIak/WccLsTdLmlk84h9jotr
	2MisXETg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkHH-00000005cSl-0Uzu;
	Fri, 31 Oct 2025 08:14:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkHB-00000005cRi-40SX
	for kexec@lists.infradead.org;
	Fri, 31 Oct 2025 08:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761898464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DCpBMK/CVYvWwXkCeSJHMCwNNqeKlHlSBvLEzOXoHA=;
	b=KF3TfGip4xSa5auoJod+E6LNJmzkoH1WFWQzo5Qwizxcf6yCxOVLZYHFTIfyBtyAKs1Cas
	ZVn+GpD88Ba1BOI7one9vXaLHnLkOUStBkx0yqLqB2uPSErNRUPhUTpdpG/TU8qxgIGgPh
	+vWEHBJVlPrhJqZ1W1/6OuqxqP8xTOs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-pnSbGfjMNuG9Ehjx6rmGCQ-1; Fri,
 31 Oct 2025 04:14:22 -0400
X-MC-Unique: pnSbGfjMNuG9Ehjx6rmGCQ-1
X-Mimecast-MFC-AGG-ID: pnSbGfjMNuG9Ehjx6rmGCQ_1761898461
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDDA1195D02A;
	Fri, 31 Oct 2025 08:14:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF9FE30001A1;
	Fri, 31 Oct 2025 08:14:17 +0000 (UTC)
Date: Fri, 31 Oct 2025 16:14:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <aQRv1JCoeYY4u7OX@MiWiFi-R3L-srv>
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
 <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
 <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_011426_176873_DC565117 
X-CRM114-Status: GOOD (  26.84  )
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

On 10/31/25 at 10:40am, Qiang Ma wrote:
> 
> 在 2025/10/30 21:58, Baoquan He 写道:
> > On 10/30/25 at 07:41pm, Qiang Ma wrote:
> > > 在 2025/10/30 17:42, Baoquan He 写道:
> > > > On 10/30/25 at 03:33pm, Qiang Ma wrote:
> > > > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > > > if required") has added general code printing in kexec_file_load(),
> > > > > but not in kexec_load().
> > > > > 
> > > > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > > > message if required")). As a result, when using '-d' for the kexec_load
> > > > > interface, print nothing in the kernel space. This might be helpful for
> > > > > verifying the accuracy of the data passed to the kernel. Therefore, refer to
> > > > > this commit a85ee18c7900 ("kexec_file: print out debugging message
> > > > > if required"), debug print information has been added.
> > > > kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
> > > > doesn't work when you unset CONFIG_KEXEC_FILE.
> > > Yes, I just actually tested it and it really doesn't work when unset
> > > CONFIG_KEXEC_FILE.
> > > 
> > > In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.
> > Hold on please, it may not need that highweight change. I will reply to
> > you tomorrow if I have other idea.
> Ok. My current idea is to refer to kexec_file, define a kexec_dbg_print,
> initialize it in the kimage_alloc_init(), modify KEXEC_FLAGS and
> kexec_dprintk,
> and add the judgment of kexec_debug.

Maybe we can unify it because kexec_file_dbg_print is declared and
defined in CONFIG_KEXEC_CORE scope. Rename it to kexec_core_dbg_print
and initialize it in do_kimage_alloc_init() for both, or in
kimage_alloc_init() for kexec, and kimage_file_alloc_init() for
kexec_file. It needs a new flag for kexec. What do you think?

Please feel free to take it as reference, or you can go in other ways
you have better one.

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..df33a0dd5780 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -525,10 +525,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern bool kexec_file_dbg_print;
+extern bool kexec_core_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
+        do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..570adb845662 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
 	image->start = entry;
 	image->nr_segments = nr_segments;
 	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..3af3ba77a3bd 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -619,6 +619,7 @@ void kimage_free(struct kimage *image)
 	if (image->file_mode)
 		kimage_file_post_load_cleanup(image);
 
+	kexec_core_dbg_print = false;
 	kfree(image);
 }
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a9794242..4a24aadbad02 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
-
-	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
-	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
+	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 #ifdef CONFIG_CRASH_DUMP


