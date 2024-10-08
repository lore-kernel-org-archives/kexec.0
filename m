Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2C4CEF15C
	for <kexec@archiver.kernel.org>; Tue,  8 Oct 2024 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=96VX6Glghsi5+6o9b9Otg+FQS5734X7ehbuwXxmNEWk=; b=TTPsVJJtLrggL0
	VSU7Ksn03PFcbQ8aXV4K6T942WmQrkuZFp6YoMGkoeAIrQDSxCQOR9z44CP5JpxI5v0qS5HcrRX1Z
	lXMzEjsatvmVB79E769IDils7yQqR8DHNA4757Kjctl4jz5F4jFfnjXjxTuutCUVb+wyvisEfc+o+
	4mEoiRFWKp5+3t3GuMlFzmzDN3XIIMYKPJIFEPejg3qelzbT1eqONclDCYggdGKJlsYhjrCBrnouj
	D52rwhYoHOhRFoXfLCM95NsMu8CQzKvNbssYoKgPiQnLgTruHJJ9wuqd3O1gPfd0mHfF7tuT/JMJO
	jm+xIxw2vQOkHd6IrxbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8rG-00000005isa-1Egj;
	Tue, 08 Oct 2024 11:58:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8nM-00000005iHC-0zaP
	for kexec@lists.infradead.org;
	Tue, 08 Oct 2024 11:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728388465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JTS6I00rUMvKL3lJtUFvwqS3wGRkVZD4AR+JuGlVOlo=;
	b=dEYjXp/S+g1k3R1XWQCq1SDzqCgQHSghE4vEyuOSRPlAfb++w1vkOdymQOd25RoTtmNxQS
	CodVMnmrFEFfqZiLo2QvkBJOIT4ztXkeMDCgkqNTP+2m2liop+Lk7zcBJOTsuIPR5IsUz/
	rGwCcUdb0whX9btYQd/ztPdnbqPYQpA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-eC5wAq9QOgyJPeNfPMw1Aw-1; Tue,
 08 Oct 2024 07:54:22 -0400
X-MC-Unique: eC5wAq9QOgyJPeNfPMw1Aw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF74019560B6;
	Tue,  8 Oct 2024 11:54:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7CAE300018D;
	Tue,  8 Oct 2024 11:54:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: [PATCH 0/3] kexec: Add support for UKI format kernel
Date: Tue,  8 Oct 2024 19:54:00 +0800
Message-ID: <20241008115408.21944-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_045428_364951_AC987ECB 
X-CRM114-Status: GOOD (  11.93  )
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

As a UEFI PE format kernel image becomes more popular, there is a need
for kexec to reboot those kinds of images.

After the introduction of the UKI (another PE), at present, there are
three competitive methods to support that goal, but all of them have
pros and cons.[1] It seems that none of them can be accepted in the near
future.  Therefore, we are resorting to the user space kexec-tools to
parse the UKI format for the time being.

By parsing the UKI, systemd-stub is stepped around and PCM will not affect
the boot up of the second system.

[1]: https://github.com/rhkdump/kexec_uefi/blob/main/overview.md#the-competitive-solutions

Cc: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>

Cc: kexec@lists.infradead.org

Pingfan Liu (3):
  kexec: Introduce default_initrd_fd to pass internal initrd information
  kexec: Introduce UKI image parser
  arm64: Support UKI image format

 include/pe.h                         | 104 +++++++++++++++++++++++
 kexec/Makefile                       |   1 +
 kexec/arch/arm64/kexec-arm64.c       |   1 +
 kexec/arch/arm64/kexec-image-arm64.c |   3 +-
 kexec/arch/x86_64/kexec-bzImage64.c  |   3 +-
 kexec/kexec-uki.c                    | 122 +++++++++++++++++++++++++++
 kexec/kexec.c                        |   2 +
 kexec/kexec.h                        |   5 ++
 8 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 include/pe.h
 create mode 100644 kexec/kexec-uki.c

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
