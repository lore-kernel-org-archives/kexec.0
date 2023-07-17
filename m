Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028ADEB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=87pDxCBbIt/KvEYNksAJw7bugcbR6ZI8gR0h2l969k4=; b=Dhl48yKiBTeCid
	KHKBS+msFRhD8GVF/m8uh07e5Pzu5YsUYtddr1hONYGSOp/P4xTmO9dpAfzDca+uYCeJC/RBigSuV
	1CrQ2AsVio9HozvVFixcFVJcXJ6PIK8vv6cyPD1y98tbmiiUwl04Nriz+IW1+7j3jHIJgGTAMYbHS
	7w7TUJwv4B24gBuZ1+s97VHAjEaX7a9ANvbPMXJqLQGcr7zbCo3t1/HbWPP17bhhI90HGAKRKynNz
	Thh788+eLm7edZHVJD3ycGvIA7iJP+Ah+pyCvsKseHcPZ/ZBX7fZ72QH3LMCbVyIw+yhyddPseshs
	5z8N0fqN74RdTvIVFqdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyI-004460-1T;
	Mon, 17 Jul 2023 13:09:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNy9-00442x-1X
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN6A3V6Gy/L9hvxZcBdVQUa5oCMWeoxENZV2G7HOMc4=;
	b=Tas1ne4B6VzNBMdVPhjEaGK1ZhlZmkDenJwF/Uid5OhtL//tlZO7hgISxF2pjM8lwT9YBt
	uQCy2RHQLm1N8lyngJpAGT3lq8HVMDkxBbPT7XDpqU6S+FZwI0I36rA5IxLt5DQr5/Ko/M
	9fHrsQelZjazq2dD1spxmovICJVs7F8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-0q8uJx1aM1q-XDawwzAoGg-1; Mon, 17 Jul 2023 09:08:51 -0400
X-MC-Unique: 0q8uJx1aM1q-XDawwzAoGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FA912A5957A;
	Mon, 17 Jul 2023 13:08:51 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0502C1121314;
	Mon, 17 Jul 2023 13:08:47 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv5 5/8] kexec: Drop condition macro for aarch64
Date: Mon, 17 Jul 2023 21:07:29 +0800
Message-Id: <20230717130732.22710-6-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060853_592508_A65473E1 
X-CRM114-Status: GOOD (  10.24  )
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
