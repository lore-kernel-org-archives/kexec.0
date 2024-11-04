Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D4D132C0
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R2wlWgiMDVFBlwTTi+EdH82QqQahEs8rKf6p//SUT0c=; b=kowtVhsEMSo17o
	99YDiN3QKYWZpNdB0wXNUXeKYuGdHg9uglcx+ijgBXCl+JBtU7akxACjABLswYHXSCdnIQridk1YL
	qw/+8MyHbDO126jTdKoR47AnwHSiqQFIQ8CWcDzpsWxqDBjkmZbX7ZwdLQ6lIzlW4YJqvCsHrfUmK
	64QQ4iLA9SkIVpKxaDsM5Qdi48gSywfH0Ac+ghuzdooZMHbpv2LmQXJBkrS3o5rky8O6lixoINJVz
	h5Q15bvKHiZpdOR7dSvWuI3db154Spl4q+6nY5qOVrUQ56oO7mpGShMGT9MBcMWCC3OosPxtq7/lB
	7Pra9V3KK8D6xpldJMuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wqN-0000000DnH0-3Nrj;
	Mon, 04 Nov 2024 13:10:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7woN-0000000Dn2m-1ytW
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 13:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730725681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qu3C5RU6HmhXRgWWzU1uFVw1ObR9GzRv6/WMnLFCQu8=;
	b=TrHkYsegvmjuCl2/BjcCNBG1/H6e58YQitDadWOJWMguE3xdRQCVPWhBf8rfscFg2gg0qQ
	yKsJ6r8KZosrMFnaBl6AgFJi50cxcfbxwK84hZ7AuTW3Do2q/NybxFjntA8dBfzo+Wqv6a
	JhFMlzCZI6A8I760vu4xrZQwHXumjwc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-v-iFztfNO02kvC2gIdeGYw-1; Mon,
 04 Nov 2024 08:07:58 -0500
X-MC-Unique: v-iFztfNO02kvC2gIdeGYw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 545F61955D9D;
	Mon,  4 Nov 2024 13:07:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B585196BB7E;
	Mon,  4 Nov 2024 13:07:54 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] Fix fd leakage in uki_image_probe()
Date: Mon,  4 Nov 2024 21:07:44 +0800
Message-ID: <20241104130745.18224-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_050803_601480_FB0F1B52 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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

There is a fd leakage in the fail path when writing to initrd fd in
uki_image_probe(). Fix it by this patch.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 kexec/kexec-uki.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
index 202fd89..210ebb6 100644
--- a/kexec/kexec-uki.c
+++ b/kexec/kexec-uki.c
@@ -77,6 +77,7 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 					sect_hdr->raw_data_size) != sect_hdr->raw_data_size) {
 				dbgprintf("%s: Can't write the compressed file %s\n",
 						__func__, initrd_fname);
+				close(initrd_fd);
 				goto next;
 			} else {
 				implicit_initrd_fd = open(initrd_fname, O_RDONLY);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
