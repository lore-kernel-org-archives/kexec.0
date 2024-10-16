Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD8D1AD48
	for <kexec@archiver.kernel.org>; Wed, 16 Oct 2024 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VrK1KuqaUDDJVAUX410qJoyOHC5wrWvmJGmHV7W6jmQ=; b=aV3n4R/ytQrKLw
	gcq/WSpiGPr/qo5ag6HuQlH03SDYcG+GO+HkvR5VmZ3BsTybtXIJh0sIadIorAuEQbeeJ37soU+Iw
	vqQTJ+WKVtWn2pbQBfyUYX9JwqgIoV/5hs0gdzCujGaOAeySkBui/ngbe0u3AA3luqfZFZKTsJniU
	o8+URLjKdmamVIVSWJtG9XOs3QXj/6xLIjZGRwOm3KgKbskgz4tF4/63bb7YP3/aiB/W1/CW5Mg21
	wjnnBRPh3GZiDjLRvtRJcRmQ/0Ft/IR6lz4czJhglF2l13CK/0vXOACEOaUuzQeCikxDqabAt+BCn
	I3fuPJke4bz2OSniLliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t12IZ-0000000BbCJ-1CJR;
	Wed, 16 Oct 2024 11:34:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t12IU-0000000BbBR-3zq5
	for kexec@lists.infradead.org;
	Wed, 16 Oct 2024 11:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729078472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8VvyFKbBCbb7yTbWcivz09X0AJuZhfY3MXR8ksOiWHg=;
	b=ftofwy23kKVNri+P4nHug/6RzT+8JFYzR0xay/7dxMKQ0jL1bTbhrcIDKyym0+zEt+XvEP
	4/2+5FjuOwV0Q30z3YHVJ39bMDoNWqe/hxuuwfob7RLvzQreWv5lUONvRRUN3tIG1rZrT6
	IEiwAm/KNvRWFN8+zWtPnYI4Styuf2Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-VWY2D0dJO6SaJfr2tNqqsw-1; Wed,
 16 Oct 2024 07:34:29 -0400
X-MC-Unique: VWY2D0dJO6SaJfr2tNqqsw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 255FD1955EE9;
	Wed, 16 Oct 2024 11:34:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.65])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54AC81956086;
	Wed, 16 Oct 2024 11:34:21 +0000 (UTC)
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
Subject: [PATCHv2 0/3] kexec: Add support for UKI format kernel
Date: Wed, 16 Oct 2024 19:34:12 +0800
Message-ID: <20241016113418.22568-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_043435_092482_B9FA7208 
X-CRM114-Status: GOOD (  11.76  )
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
---
v1 -> v2:
Add include/pe.h in makefile to fix 'make dist'
Rename default_initrd_fd to implicit_initrd_fd


Pingfan Liu (3):
  kexec: Introduce implicit_initrd_fd to pass internal initrd
    information
  kexec: Introduce UKI image parser
  arm64: Support UKI image format

 include/Makefile                     |   1 +
 include/pe.h                         | 104 +++++++++++++++++++++++
 kexec/Makefile                       |   1 +
 kexec/arch/arm64/kexec-arm64.c       |   1 +
 kexec/arch/arm64/kexec-image-arm64.c |   3 +-
 kexec/arch/x86_64/kexec-bzImage64.c  |   3 +-
 kexec/kexec-uki.c                    | 122 +++++++++++++++++++++++++++
 kexec/kexec.c                        |   2 +
 kexec/kexec.h                        |   5 ++
 9 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 include/pe.h
 create mode 100644 kexec/kexec-uki.c

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
