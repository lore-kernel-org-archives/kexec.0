Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F54EB64DC
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t5vxlqG+mdQux5RJdxB2t9CjRC6dF5Ke/vbgzGCWk6Q=; b=uL5MujW1kIC5Se
	R53f8gfe46GwJ3xDpfzeC5RSlu+pHovr/DnxHhSEzAaMlhZJ3m6LnW60U6fqiw7/0xNhCaPCMxcHA
	xuHijXGBSZgQuMWJLSczrTb5q8lXPHCXU9J2cofqNbDBxo4vxFQfpA6ffXDzfNYMJ1KPIK/CbTqsg
	9fs3mcmszXCL7cK2jkTdDRR4GNT0EMtj2Sabnk6g8bqBbufZRjqqFk+noak5NaVlk290mQ6yyrZk/
	kroCvQT3ussY4hYqcSgHvpv0qN4vrkaD+eubyUyg6hLm/3I0uM/O68KHmlWMq/lYzY8bhwmLbwXke
	lbyiAKvZgNtdaMgFIh3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRY1-00BVys-1R;
	Mon, 03 Jul 2023 21:57:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXv-00BVvG-0S
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF96B208FFDD;
	Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF96B208FFDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421441;
	bh=IA4qVA7yS6tfVuU9PQyqSbjKk9N21XI0y5043nMYdXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGLrEABDXJHWi1bi5YE/9tRYciFa8BBH+oONcU85PCku4cyeQ0jqkVCY0h1wIVqcy
	 h/KyREwavxt4474a6GxwSENgRdxekCa24hShwYzfX3rdsKmmSLVjku82b3VG5bb+R1
	 zupINlJPJ/ih+YJwakHujz/W1kM+TvaSzdCeqgqY=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
Date: Mon,  3 Jul 2023 14:57:09 -0700
Message-Id: <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145723_199162_8FA83809 
X-CRM114-Status: GOOD (  14.50  )
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

The kexec_file_load syscall is used to load a new kernel for kexec.
The syscall needs to update its function to call ima_kexec_post_load, which
was implemented in a previous patch.  ima_kexec_post_load takes care of
mapping the measurement list for the next kernel and registering a reboot
notifier if it's not already registered.

Modify the kexec_file_load syscall to call ima_kexec_post_load after the
image has been loaded and prepared for kexec.  This ensures that the IMA
measurement list will be available to the next kernel after a kexec reboot.
This also ensures the measurements taken in the window between kexec load
and execute are captured and passed to the next kernel. 

Declare the kimage_file_post_load function in the kernel/kexec_internal.h, 
so it can be properly used in the syscall.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c     | 7 +++++++
 kernel/kexec_internal.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..efe28e77280c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..98dd5fcafaf0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
+void kimage_file_post_load(struct kimage *image);
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
