Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229CC61D97
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CcGHFkfu6LfWDZwFpv5poMbA0nsTainPr33F22nyPV0=; b=d63rDOWsY5zW/x
	vXbEDNMH5N3ygZevTKkT2bp/GXIt0yqQH77MWUALw5YX5lbiKNJRkroLNcCfdYlHlvVkWiyUhVw4O
	7uzTo2x9rKtw7kEHsbl6y9GqUJCnNrP1N8T7yptcSJSgv9t+NbyVMjWTMSWacpeS1Di6dDgROLRDU
	P5EcGo1GmpRD95InUWvWHBY8vC+p8emKKWZtvu0mADPpubK95Qw5n3oGVgNRBF8gDROQ229/nih6f
	5d9qslTEKz3iXEghJuUZI/3ZBu3km9syqvkzizQUvb1FNelqeMsurTQ5iJKV/nJ0YDe6ce/racshN
	3oR9VYxxrmIBEuabn4Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6N06-0062mY-2i;
	Fri, 24 Nov 2023 03:37:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6N03-0062l0-0y
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 03:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700797022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRhf6yjEl6SoYtlH901fGSdzPcu9Tm5iYJM9D+81Yic=;
	b=bE1iW0CoQoXLEpIxnEw6fGYXjD/3l1mKRQvwInihctZp6mQBvH/boo0TCDQoc+jjEuUa9H
	l8Au5TxTwInBhPa811lx+VWgJ9fI3j+X7iZ3IgivFQnNzA34srNKoMM06BUm23QI6Izgor
	whC2sEe0CsaanH3SVe0BPsHuuIEvIGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-54TtSm-JM8ed2wqZkmazOg-1; Thu, 23 Nov 2023 22:36:55 -0500
X-MC-Unique: 54TtSm-JM8ed2wqZkmazOg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCD1B811E7D;
	Fri, 24 Nov 2023 03:36:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46FE5492BE7;
	Fri, 24 Nov 2023 03:36:49 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	akpm@linux-foundation.org,
	joe@perches.com,
	nathan@kernel.org,
	yujie.liu@intel.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/7] kexec_file: add kexec_file flag to control debug printing
Date: Fri, 24 Nov 2023 11:36:36 +0800
Message-ID: <20231124033642.520686-2-bhe@redhat.com>
In-Reply-To: <20231124033642.520686-1-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_193703_411438_977003CC 
X-CRM114-Status: GOOD (  15.53  )
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

When specifying 'kexec -c -d', kexec_load interface will print loading
information, e.g the regions where kernel/initrd/purgatory/cmdline
are put, the memmap passed to 2nd kernel taken as system RAM ranges,
and printing all contents of struct kexec_segment, etc. These are
very helpful for analyzing or positioning what's happening when
kexec/kdump itself failed. The debugging printing for kexec_load
interface is made in user space utility kexec-tools.

Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
Because kexec_file code is mostly implemented in kernel space, and the
debugging printing functionality is missed. It's not convenient when
debugging kexec/kdump loading and jumping with kexec_file_load
interface.

Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
message printing. And add global variable kexec_file_dbg_print and
macro kexec_dprintk() to facilitate the printing.

This is a preparation, later kexec_dprintk() will be used to replace the
existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
kexec/kdump loading information. If '-d' is not specified, it regresses
to pr_debug().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h      | 10 +++++++++-
 include/uapi/linux/kexec.h |  1 +
 kernel/kexec_file.c        |  5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..66997efe36f1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -264,6 +264,14 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 	return -ENOEXEC;
 }
 #endif
+
+extern bool kexec_file_dbg_print;
+
+#define kexec_dprintk(fmt, ...)					\
+	printk("%s" fmt,					\
+	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
+	       ##__VA_ARGS__)
+
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -403,7 +411,7 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 01766dd839b0..c17bb096ea68 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -25,6 +25,7 @@
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_DEBUG	0x00000008
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..4c35500ae40a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,8 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+bool kexec_file_dbg_print;
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -123,6 +125,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
+
+	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -278,6 +282,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 	if (kexec_on_panic) {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
