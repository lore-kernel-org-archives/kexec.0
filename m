Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1877C04A6A
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wyczqk0k8LRll8d48lNbSGABQwVvYVz9qk9ffZDEHGo=; b=lsVQ+4G6tBmudv
	BuyOAm2Uc7f5c2a/h6UvhR3G5FuC6egTviKty2Z4fEnTygUMH0JlI38aEgIcIGo+p0YrvAJtVXzdS
	RNf2NnW+XXpyfuzNMSOi/Bbh1CecAtczUAlSBGyYsMYpttqtyppw6eBZ9C1u+vw6Cf5DN+GhUOqHX
	7gi8aFXOgl727CCeEUpSVo1/6tquLjquZnkPt7P/hATwKDycZtw/2pYW3aDfoHmXaiPaNTgkp04J6
	rhj+EorA2EWPzBx8+EF+CeokYEkAsCsj8VILA8orzUniy15g77ZrU32I/dd4JzhN6U1EeUXzl5uqp
	KQRb6WiQNBxHht6FvuZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qROIE-006Tiw-1Z;
	Thu, 03 Aug 2023 02:42:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qROIC-006ThQ-1Z
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 02:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691030543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4psmgh4ex6V3FkN8RD5Kcen/KCBzTmiBxLP34mNVQNQ=;
	b=affbGSQV8PJUnypJVH6Rt2aIZzWQCJ3UAxneicbgj8Ka6m+ZVDKbbltG9SZC7RxN4io/fP
	XFEMx4JrpcVQvneAT64vowr2bjbF+GXoI2tivelAkHwIywSnTxdcMOA7WjdHwk3yT2z87K
	AT25ToNKHuELqgzn5bqhmvOSnySLQBY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-bLdi64ZFPRG3br8gwLue9A-1; Wed, 02 Aug 2023 22:42:19 -0400
X-MC-Unique: bLdi64ZFPRG3br8gwLue9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 613A4280BC44;
	Thu,  3 Aug 2023 02:42:19 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F886140E952;
	Thu,  3 Aug 2023 02:42:15 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv7 2/5] kexec: Introduce a member kernel_fd in kexec_info
Date: Thu,  3 Aug 2023 10:41:49 +0800
Message-Id: <20230803024152.11663-3-piliu@redhat.com>
In-Reply-To: <20230803024152.11663-1-piliu@redhat.com>
References: <20230803024152.11663-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_194224_594547_D9F14BD8 
X-CRM114-Status: GOOD (  15.59  )
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

Utilize the image load interface to export the kernel fd, which points
to the uncompressed kernel and will be passed to kexec_file_load.

The credit goes to the Dave Young, who contributes the original code.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Co-authored-by: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/kexec.c | 8 ++++++++
 kexec/kexec.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d132eb5..c3b182e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1292,6 +1292,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	info.kexec_flags = flags;
 
 	info.file_mode = 1;
+	info.kernel_fd = -1;
 	info.initrd_fd = -1;
 
 	if (!is_kexec_file_load_implemented())
@@ -1337,6 +1338,13 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 		return ret;
 	}
 
+       /*
+	* image type specific load functioin detect the capsule kernel type
+	* and create another fd for file load. For example the zboot kernel.
+	*/
+	if (info.kernel_fd != -1)
+		kernel_fd = info.kernel_fd;
+
 	/*
 	 * If there is no initramfs, set KEXEC_FILE_NO_INITRAMFS flag so that
 	 * kernel does not return error with negative initrd_fd.
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..ed3b499 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -164,6 +164,7 @@ struct kexec_info {
 	unsigned long file_mode :1;
 
 	/* Filled by kernel image processing code */
+	int kernel_fd;
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
