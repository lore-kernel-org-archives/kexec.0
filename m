Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55434D1CA19
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 03:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U6rZWaOkGbax009JOK5BBheiloyfYvAs1KoPJ6xRFmw=; b=xs2esmr3XVed51
	4ehrSaTkCd8m3AU03EyvKgnSVXh8UezJ9kO8hDDWAcdu26kBc7bKT8w6zXNbnaH6/qcQzeEB0Ov3l
	BrDGEWRxwk3bGBs04dM691q+6r7k0fia6hL+0J9vui82Wk+a88jZbJ/wqC2OnMNnW24rC8bTu4j9/
	wTINd09+m3gulKpm/7BJ3+AhOU7NHrp+jpvMRL3/cuMNXV4ZJVEZuDDW7ACSGJoqQFKJ4TgQTH/td
	EkaIwFRQNkJOUEa87OVtwdQ5YH0rM10c2R3Lnx+yRtCmOC47phvfiYKMYpcHEZGie+UnpQuCm7pjq
	ovafNjp1RAg8Cxagkl7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhL-0000000Fond-0AkW;
	Tue, 05 Nov 2024 03:57:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhI-0000000Fome-0f8p
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 03:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730779059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COSOw0cKmjwV+t4teuLcxU9iXmYy4BU2oKr3zcoMn1E=;
	b=bqPLZcqeU6mF00i06nQZ70f5w2BguTld/dRP8CC4J/rREi1WZ3mCKwr0owHyfkuPzx0n5n
	Q5GMMQwVAVxMFk3eLhOUj65cbfMBVQ94YuC8Ffihjzz0co1YJCeJC3hIJYfG63+HuW5k95
	vJ/+fWq40RhZyhR6puKJd2hSRsIewH8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-0qEdVX--N4668EY5xPjmsQ-1; Mon,
 04 Nov 2024 22:57:36 -0500
X-MC-Unique: 0qEdVX--N4668EY5xPjmsQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9ED1955EAB;
	Tue,  5 Nov 2024 03:57:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9C6D19560A3;
	Tue,  5 Nov 2024 03:57:30 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 2/3] kexec: Create a temporary file to hold .linux section in uki_probe()
Date: Tue,  5 Nov 2024 11:57:06 +0800
Message-ID: <20241105035710.11384-3-piliu@redhat.com>
In-Reply-To: <20241105035710.11384-1-piliu@redhat.com>
References: <20241105035710.11384-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_195740_295073_87259EAE 
X-CRM114-Status: GOOD (  15.75  )
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

**Problem**
In the arm64 case, a temporary file for kernel is created in
pez_arm64_probe() and passed down to info.kernel_fd later.

However in the x86_64 case, nobody passes a temporary fd to info.kernel_fd,
so finally the fd of the UKI image is passed to syscall. That is not the
expected behavior.

**Situation**
The current framework of kexec-tools passes kernel fd to syscall.
Meanwhile info.kernel_fd presents each probe with an opportunity to
overwhelm the existing kernel fd.

**Solution**
In the UKI probe, a temporary file is created to hold the .linux
section. Later, if no other probe methods set info.kernel_fd, it will be
set in the UKI load method. This way, the correct fd can be passed to
the syscall.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-vmlinuz-arm64.c |  2 ++
 kexec/kexec-uki.c                      | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
index e291a34..e558296 100644
--- a/kexec/arch/arm64/kexec-vmlinuz-arm64.c
+++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
@@ -104,6 +104,8 @@ int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		off_t nread;
 		int fd;
 
+		if (info->kernel_fd > 0)
+			close(info->kernel_fd);
 		info->kernel_fd = kernel_fd;
 		fd = dup(kernel_fd);
 		if (fd < 0) {
diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
index 8a7d349..235f5a1 100644
--- a/kexec/kexec-uki.c
+++ b/kexec/kexec-uki.c
@@ -15,8 +15,10 @@
 #define UKI_DTB_SECTION ".dtb"
 
 #define FILENAME_UKI_INITRD          "/tmp/InitrdXXXXXX"
+#define FILENAME_UKI_KERNEL          "/tmp/KernelXXXXXX"
 
 static int embeded_linux_format_index = -1;
+static int kernel_fd = -1;
 
 /*
  * Return -1 if not PE, else offset of the PE header
@@ -98,6 +100,15 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 	if (linux_sz == -1) {
 		printf("ERR: can not find .linux section\n");
 		return -1;
+	} else {
+		int res;
+
+		res = create_tmpfd(FILENAME_UKI_KERNEL, linux_src, linux_sz,
+					&kernel_fd);
+		if (res < 0) {
+			printf("ERR: can not create tmp file to hold .linux section\n");
+			return -1;
+		}
 	}
 	/*
 	 * After stripping the UKI coat, the real kernel format can be handled now.
@@ -120,6 +131,9 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 int uki_image_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
+	/* In probe() chain, if nobody sets info->kernel_fd, set it now */
+	if (info->kernel_fd == -1)
+		info->kernel_fd = kernel_fd;
 	return file_type[embeded_linux_format_index].load(argc, argv, buf, len, info);
 }
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
