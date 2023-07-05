Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5BC001B0
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 02:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=87pDxCBbIt/KvEYNksAJw7bugcbR6ZI8gR0h2l969k4=; b=3WIgWu8OsUHXR2
	LFqua43OtVDGV/uWa6EoxdcxdNRdMn/dByG2J4ZjKpLfkD2Tt0ie11znfxX/i145IXk35kzTxCNrC
	bcGCQbBXgZ/Ge5kSucCvyEtwZBqJmUJYaWImjCt0QzcyYVGUb3S9DkY5aXG237GTzq827YbcVNqOG
	L9mBk+f83QEgJcfa0zzMF6GrsZ4ZPzlQOQDzkUQ4R8rS26HC4oQaxxMFsfpPhEeJSSuf4px9rCGOg
	B5r6ReQ6gt7Or+NMmkvWQ2t2bUG3l5STNPrhWh4KXg5lj6tanG7wNz9ZNpmYVl0Tu9CagPn672rc7
	tGfkInFMR60voYAV+Qeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYi-00Edsq-1H;
	Wed, 05 Jul 2023 02:48:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYf-00EdrX-1d
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 02:47:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688525276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN6A3V6Gy/L9hvxZcBdVQUa5oCMWeoxENZV2G7HOMc4=;
	b=A81vZ3D1orjSlBg9c3Wg84RbS37WLlDISSpLlJCIpX8xyBZCiLQE+sUJw/Soq1TrmkKzNm
	U0nEMSeDCrqPaYV6kWny9/pMQ6cLFuPXW6eNFimx6VxeyDMDvDbhnxFYW2vy6cec+MI8gl
	7Gfdn+n4paVNMCIuH4h97Mp7TzOp7U8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-iJvo5a5LO3OlKtc2sehDqw-1; Tue, 04 Jul 2023 22:47:55 -0400
X-MC-Unique: iJvo5a5LO3OlKtc2sehDqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE6B51C04B59;
	Wed,  5 Jul 2023 02:47:54 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECA51121314;
	Wed,  5 Jul 2023 02:47:51 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv4 5/8] kexec: Drop condition macro for aarch64
Date: Wed,  5 Jul 2023 10:47:22 +0800
Message-Id: <20230705024725.11741-6-piliu@redhat.com>
In-Reply-To: <20230705024725.11741-1-piliu@redhat.com>
References: <20230705024725.11741-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_194757_618832_B7855D27 
X-CRM114-Status: GOOD (  10.66  )
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

Since all arm64 images have transfer from the interface probe() to
probe2(), the snippet dedicated for aarch64 to call probe() can be
dropped now.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/kexec.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 5f75179..3238c19 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -730,17 +730,7 @@ static int probe(struct file_type *ft, const char *kern_fname,
 
 	ret = initialze_probe(kern_fname, kernel_buf, kernel_size, kernel_fd);
 	if (ret == 0) {
-#ifdef __aarch64__
-		/* handle Image.gz like cases */
-		if (is_zlib_file(kern_fname, &kernel_size)) {
-			if ((ret = ft->probe(kern_fname, *kernel_size)) >= 0)
-				*kernel_fd = ret;
-		} else {
-			ret = ft->probe(*kernel_buf, *kernel_size);
-		}
-#else
 		ret = ft->probe(*kernel_buf, *kernel_size);
-#endif
 	} else if (ret == 1) {
 		ret = ft->probe2(kern_fname, &info);
 		*kernel_buf = info.kernel_buf;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
