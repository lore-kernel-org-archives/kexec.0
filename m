Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BCAE7716E
	for <kexec@archiver.kernel.org>; Fri,  6 Dec 2024 02:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N/YXaoLfwVt/YNB4rm+LaU/0leZ3LLmHo5RMMlqAd68=; b=kJFqQDRslDxZAN3tLm68GxIjCB
	RMPQGmqh7OXAuIWWGaaENLte2gg2JXbzegD7S4yMBvYCvohdArk43tyTPLifTHVe2FX8TT3n9PK40
	cY6FJPrrWKvLloxvoD6p/98PmE5BZcbZAGPba5bAUI5spGvZenCbB28hed2my8QNzbvcExWmgD+29
	r0j59uwG0FaKIUAa3KB2qvW2w1yKu/ItvnSSR3+TtCGFs+7Cca6M/SZ+FtFPlZzxsXmpDWLI8tZjL
	xBGcuKSgu56pzdqZOexM/HszmdPMsCER7ee9563JWS5M22xFfzzkJJa48mrmxlB5gcHEYxT3DbJTZ
	rs2Kllxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOLC-00000000MJb-39mO;
	Fri, 06 Dec 2024 02:45:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOL8-00000000MI3-1nCY
	for kexec@lists.infradead.org;
	Fri, 06 Dec 2024 02:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733453108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/YXaoLfwVt/YNB4rm+LaU/0leZ3LLmHo5RMMlqAd68=;
	b=Lkg9OQGD9XgwfOYf9IYr9R5A520qrVS49z7tPHrH3B0YX1Q4fHh847KB676qaCvXmpxNr2
	siZw/S/VrWJbnqhVFFXn2VQRxfNGr51dzejlgMIPO1jWGbWv1SPkkCDFIXmXe9maY9V6cP
	Nf7SHj09Qp0aO+nVFByOXndC3Ea+5jg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-kAOQHox0NVSHQHMFdKgXuw-1; Thu,
 05 Dec 2024 21:45:02 -0500
X-MC-Unique: kAOQHox0NVSHQHMFdKgXuw-1
X-Mimecast-MFC-AGG-ID: kAOQHox0NVSHQHMFdKgXuw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D29FD1956087;
	Fri,  6 Dec 2024 02:45:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B229619560A2;
	Fri,  6 Dec 2024 02:44:58 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 0/2] kexec-tools: Truncate PE file if it is signed
Date: Fri,  6 Dec 2024 10:44:41 +0800
Message-ID: <20241206024445.10442-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XuIiFlm8US5F--796If6V_Vrw0Zc2S1-04GCoTwcVTg_1733453101
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_184510_595771_93926D93 
X-CRM114-Status: UNSURE (   8.98  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Note: This series is compatible with the ongoing kernel patches '[PATCH
0/2] Kexec: Sign Image before packing into EFI STUB' [1]. It ensures
functionality when kexec_file_load enforces signature verification on
arm64, LoongArch, and RISC-V.


*** Issue ***
In the linux kernel drivers/firmware/efi/libstub/Makefile.zboot, the
original Image is padded with zero, using the following instruction:
        truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@

Hence pe-zboot.c decomopresses and gets Image plus trailing zeroes.

These trailing zeroes don't affect loading the original PE file. But
they do raise an issue during the signature verfication. The root cause is
that the kernel function:
        static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
                                             struct pefile_context *ctx,
                                             struct shash_desc *desc)
treats [pebuf, pebuf+pelen] as valid payload, which includes the
trailing zeroes. But that is not the truth.

*** Solution ***
In pratice, the table of attribute certificates come at the end of a
PE file. This patch utilizes that fact and truncates at the boundary of the
certificate table to get the original Image.

[1]: https://lore.kernel.org/linux-efi/20241206021000.8953-1-piliu@redhat.com/T/#t

Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org

Pingfan Liu (2):
  PE: Extract get_pehdr_offset() for reuse
  pe-zboot: Truncate the trailing zero if Image is signed

 include/pe.h           | 47 ++++++++++++++++++++++++++++++++++++++++++
 kexec/kexec-pe-zboot.c | 25 +++++++++++++++++++---
 kexec/kexec-uki.c      | 17 ---------------
 3 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.41.0


