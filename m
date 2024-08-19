Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B12C52D6F
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s38Yt3gMos4hLW0olBfeDq9V0ebXsPfx8+Vbs7sWrSs=; b=RY0yHm9HPjcoTr
	V6fI97ArsLpaSeQoigzssb2LV7UkIuTJ6YsVPBaiTif+cdzF0UvwewoP6jEbxbkyGObju4lm7AdzA
	Ark/eODitbMQ4hyjxN4OohZPB1XP/hzSUzKPngWX82mkgJ0aatmn1kG+iZ1fRFwf/2okxdujmUoG0
	etfgzkc75f4OSi/BMAmjW8Xkk1nQC527Wn6fNRDkyBx+0tX81SwkR6Vvv33jrw9+u5+IkwNKY2iMc
	b5imzUOQw7mfnyn4hj+BPt4iEXLVY1l4jaYAxAby6WzriUzJumNmBry00vnoAuFNvfraCPrTIihFl
	C6HJVLK2Yd+utcLK8VbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3mw-00000001pwa-1pfz;
	Mon, 19 Aug 2024 14:55:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3mj-00000001psm-2HMl
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 14:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiBxTOGq9aVdhn1+CpbHzQqObWNoKSOYg9dxENZx8/E=;
	b=Wb4QFBCD0lp1/IRyr7/AmBrZkK+swEyBvi8HHeMlNJ1WjIQrvtvzB/ZezsvfNCluHdtrSM
	WMcTWVv42Ewhvuchr30Qu/QpKAUNVuyTVNdcWR4LuRno74FMkb5ZrJmMCh5i/FpqOSil8s
	V1oy7JvRrmH80gFxC/xj58q2rGbamJU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-Ue7ktWKDOO-5JaPjXde9nA-1; Mon,
 19 Aug 2024 10:55:00 -0400
X-MC-Unique: Ue7ktWKDOO-5JaPjXde9nA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 897141944D01;
	Mon, 19 Aug 2024 14:54:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E114C19560A3;
	Mon, 19 Aug 2024 14:54:49 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
Date: Mon, 19 Aug 2024 22:53:34 +0800
Message-ID: <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_075505_677387_437118E9 
X-CRM114-Status: GOOD (  10.68  )
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

efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
but the current implement can not ensure the selected target locates
inside free area, that is to exclude EFI_BOOT_SERVICES_*,
EFI_RUNTIME_SERVICES_* etc.

Fix the issue by checking md->type.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index c41e7b2091cdd..7304e767688f2 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
+		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
+			continue;
 		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
 					    alloc_max);
 		MD_NUM_SLOTS(md) = slots;
@@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_physical_addr_t target;
 		unsigned long pages;
 
+		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
+			continue;
+
 		if (total_mirrored_slots > 0 &&
 		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
 			continue;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
