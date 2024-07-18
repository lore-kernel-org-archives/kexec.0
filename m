Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E1FC3DA49
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QcABYxpwEfiH8ng4VRXchpw/DdZwtpwAh+XWCTY+Fd8=; b=LHPntM1opkSPcr
	DxCEwJKp25EenD/pSvEWNlc40iIJk90SG1177u8w8mj4k0GPbmJwaXPWpakVAMrPLVhGzgPdsvTiE
	ZNYj2FyBHT56EQUnD1FkTdM1esOiW5RnHqVQhZrd4W1Yt8HJPFNHFvwtmHyEQRoGK1ksRfFDzFyPp
	BJKm4ll0zyQZbBKJiwu2ezZYFFMgg5NDM/WCN+zpFrTeZJo9yNjZFkgunPsllvUwFRYXSygpGAqse
	vsTxMTUg9A/zWm7f9PD5YU6bkNOhzr3ZoZp7/whE5FHGXKgL8SORyzhVM+1Kh12cy+kK4f4HbGQbw
	vgmhqyPNUmw+IoL8nR8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUN01-0000000GVLj-2dOp;
	Thu, 18 Jul 2024 09:00:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUMzi-0000000GVFU-1HdC
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 09:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9TZSR+BUCVNWRBqfa4q3I7rRgSk04YNeRsJlv/xLrE=;
	b=NnYbO8blVzxlGH+6HJ5CWbAf/qmlDj7MO7++kAaPAGabX1NWSeaHZB8Qqzl0uefr/x4CvB
	OE0Nq8jpgonZO8eJi5vbWwzHPb0t9v8r9PXBt6v5NnIxJf5xTcCWI9dY7DKXgdugWRWLMr
	6fvbYlVjzzprwuXS/8DJXH6doTw8vXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-ygGD_SQxMmeyRCAbDROY2A-1; Thu,
 18 Jul 2024 04:58:37 -0400
X-MC-Unique: ygGD_SQxMmeyRCAbDROY2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA0631954225;
	Thu, 18 Jul 2024 08:58:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E5473000185;
	Thu, 18 Jul 2024 08:58:27 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 2/7] debug/libstub: cheats to step around some boot service
Date: Thu, 18 Jul 2024 16:57:52 +0800
Message-ID: <20240718085759.13247-3-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_020010_494574_8F7C02CC 
X-CRM114-Status: GOOD (  13.02  )
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

For POC, step around these four function, hence the corresponding boot services.
Later those services should be implemented and this patch should be
drop.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 +++
 drivers/firmware/efi/libstub/efi-stub.c        | 2 ++
 drivers/firmware/efi/libstub/random.c          | 2 ++
 drivers/firmware/efi/libstub/tpm.c             | 4 ++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815fd..19b31a4c7fcea 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -615,6 +615,9 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	efi_status_t status = EFI_SUCCESS;
 	struct linux_efi_initrd initrd, *tbl;
 
+	efi_info("cheat in efi_load_initrd()\n");
+	return EFI_SUCCESS;
+
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
 		return EFI_SUCCESS;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660d..190d280e634e9 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -59,6 +59,8 @@ static struct screen_info *setup_graphics(void)
 	void **gop_handle = NULL;
 	struct screen_info *si = NULL;
 
+	efi_info("cheat in setup_graphics\n");
+	return NULL;
 	size = 0;
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
 			     &gop_proto, NULL, &size, gop_handle);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 7109b8a2dcba8..3a647fea2fdd3 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -73,6 +73,8 @@ efi_status_t efi_random_get_seed(void)
 	efi_rng_protocol_t *rng = NULL;
 	efi_status_t status;
 
+	efi_info("cheat in efi_random_get_seed\n");
+	return EFI_UNSUPPORTED;
 	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 	if (status != EFI_SUCCESS)
 		seed_size = 0;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a5..0c585466c0b85 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -33,6 +33,8 @@ void efi_enable_reset_attack_mitigation(void)
 	efi_status_t status;
 	unsigned long datasize = 0;
 
+	efi_info("cheat in efi_enable_reset_attack_mitigation\n");
+	return;
 	status = get_efi_var(efi_MemoryOverWriteRequest_name, &var_guid,
 			     NULL, &datasize, NULL);
 
@@ -155,6 +157,8 @@ void efi_retrieve_eventlog(void)
 	efi_bool_t truncated;
 	efi_status_t status;
 
+	efi_info("cheat in efi_retrieve_eventlog\n");
+	return;
 	status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
 	if (status == EFI_SUCCESS) {
 		status = efi_call_proto(tpm2, get_event_log, version, &log_location,
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
