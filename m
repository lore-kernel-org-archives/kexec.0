Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C726C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0QM2G8n14CuTKWRaEEUEONGPiLsf3vEvSdSRH7DDrug=; b=NG0MHSlU8+KLRm
	xxbt365q59HJFyPKVG5h6D/091CKDhkRf/Gahi9655ZIRe0otYXBdgloY7jENsWx0+GeZzMNL3k37
	CZUTx/1l34uXJ5fRSSiq+gCrZF5RKAdyWSGkMqpRTHsbZCs3bKvELxU9R00+ZxdZtCVR1ecH+8UEW
	IBekZDuTAyDs0SL12KRDHdfm5CqDXhtRXmSmcmHqVIoAXoGyD6voycws8uOeAfvS6D04QDT80CGMn
	CzGBtZ1YxVZYa1JmLtLeVAJMm15otf7806FkR6exXpyNEEcOPiXoK4tuh0yEP6tO5xYBZ2lx1H9Jg
	wefaVEAvpF4Xhaa9RRrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vDU-00GIKk-1x;
	Tue, 14 Nov 2023 15:20:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vDR-00GIKA-2x
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 15:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699975236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Bpq6LeMIeMT9qM3mxl19rNiEnE2GSJ0TlWszrYynB8=;
	b=TjmDCUacn9ahY4BuDebPSIYNL5lcAjjo3kr7HUKa3yS4UdeDmY7UkOdp6Ifa+vplmQzhFr
	Y4JglixBFSX5KO6unxW5msfHkD5/84yeDjHVBro9fmFie5e7KJ55iFxpoCiPJXTxBBkXEO
	PAvbfHsscz/ZWKFKGZ3vQb7zKv7akTw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-dYW5k8i7MYqFcRVhmtzA8w-1; Tue,
 14 Nov 2023 10:20:35 -0500
X-MC-Unique: dYW5k8i7MYqFcRVhmtzA8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3EC02806054;
	Tue, 14 Nov 2023 15:20:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.231])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19CE9C15983;
	Tue, 14 Nov 2023 15:20:32 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] kexec_file: add kexec_file flag to support debug printing
Date: Tue, 14 Nov 2023 23:20:30 +0800
Message-ID: <20231114152030.240945-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_072038_021351_33372D89 
X-CRM114-Status: GOOD (  10.62  )
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

This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
to kernel when '-d' is added with kexec_file_load interface. With that
flag enabled, kernel can enable the debugging message printing.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kexec/kexec-syscall.h | 1 +
 kexec/kexec.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 2559bffb93da..73e52543e1b0 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -119,6 +119,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_DEBUG	0x00000008
 
 /* These values match the ELF architecture values. 
  * Unless there is a good reason that should continue to be the case.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 08edfca2349a..b5393e3b20aa 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1477,6 +1477,7 @@ int main(int argc, char *argv[])
 			return 0;
 		case OPT_DEBUG:
 			kexec_debug = 1;
+			kexec_file_flags |= KEXEC_FILE_DEBUG;
 			break;
 		case OPT_NOIFDOWN:
 			skip_ifdown = 1;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
