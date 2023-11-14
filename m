Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BCC4167B
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4sbBaNeiLacWuRrywv4GA4ooKc2kH66Z4yKjUbRtVas=; b=pyu7S+4aGPfVdU
	9BnNYzeosuoy45lgeU7doDPhbZnlzr1twDf7/+8VCZyAIbWRpvL4h/CjwJkss9MWKC0+wSTbRhSLK
	TbKYwK81XV6phlSjFsj7OP/kensuK8fJgZX06el4vwzAk9wO/J5qujVp5C/Em3OoTpPqsAy4Dup72
	77eCYIoBT3drzXkHJTf3PKkhKy1974V6bBBAqSlg3MHTbEKNYil9GYhmdoFUCvEwNSPaC/CYedSs4
	MMNg4/R2xxUi0j08lkKCEyNKYvamfQcKAfePmrKqhzrgPt/bLNpoaD2J4aRXoQaU5HJhRt6z8bPWM
	J/27b9X4e69KJLUEnc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2pXw-00FUC6-0K;
	Tue, 14 Nov 2023 09:17:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2pXt-00FU9y-2R
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 09:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699953441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCQMK3tvMnlcAutGAmjADx8NXWTNg1Te+2YY/zMRKiU=;
	b=ASvAGGBIBLChAaacEpNrcRqLWQDFuG9HnrTIyXVBqkwYQp+DD1VHbd2IEGEJMlmI3+y/JB
	J62AqL6YBJ8KiiH/qDSZnAHeqL5VNq55NJBI80PaurQ0RAZxuZaQwEMV2WjaTxBkNfqzXm
	FS32sxxvtPJBNtjnMyQxQDXh4Mxp3yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-AtEvHmVsOLW5Ae-g10RPxA-1; Tue, 14 Nov 2023 04:17:15 -0500
X-MC-Unique: AtEvHmVsOLW5Ae-g10RPxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB275101A53B;
	Tue, 14 Nov 2023 09:17:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.231])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3A2D2166B26;
	Tue, 14 Nov 2023 09:17:10 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	takahiro.akashi@linaro.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] kexec_file: Load kernel at top of system RAM if required
Date: Tue, 14 Nov 2023 17:16:58 +0800
Message-ID: <20231114091658.228030-3-bhe@redhat.com>
In-Reply-To: <20231114091658.228030-1-bhe@redhat.com>
References: <20231114091658.228030-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_011721_864533_0793521C 
X-CRM114-Status: GOOD (  10.38  )
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

Kexec_load interface has been doing top down searching and loading
kernel/initrd/purgtory etc to prepare for kexec reboot. In that way,
the benefits are that it avoids to consume and fragment limited low
memory which satisfy DMA buffer allocation and big chunk of continuous
memory during system init; and avoids to stir with BIOS/FW reserved
or occupied areas, or corner case handling/work around/quirk occupied
areas when doing system init. By the way, the top-down searching and
loading of kexec-ed kernel is done in user space utility code.

For kexec_file loading, even if kexec_buf.top_down is 'true', it's simply
ignored. It calls walk_system_ram_res() directly to go through all
resources of System RAM bottom up, to find an available memory region,
then call locate_mem_hole_callback() to allocate memory in that found
memory region from top to down. This is not expected and inconsistent
with kexec_load.

Here check if kexec_buf.top_down is 'true' in kexec_walk_resources(),
if yes, call the newly added walk_system_ram_res_rev() to find memory
region of system RAM from top to down to load kernel/initrd etc.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..ba3ef30921b8 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -592,6 +592,8 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
 					   kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
 	else
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
