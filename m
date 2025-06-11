Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F8DC677C4
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P9oH1uonxI0Sglm5wymhiE86CF0kAPtwdmbbSnYdghw=; b=PMU9cv1//F6xvRLrquQhRwMrEN
	8q78fqnP+UDWPP7K/ZHv7Fa1U8e05TLk5L9empOMG4518jwCLvWU3upxWH+fs4tX/pq3zwcpSjHDb
	kdZTFFzfb+iwe3S7vWaG3220Frls1iX/dqBJhBKsO+LGmDRRq0BLy7CIwm+lrXBUrS/RxWLd61ZHm
	hOTYA41cXKc+AxyKWnnpHbTNw53wX2PoxHpyomiK6LTEf6mxflZ+cNfT1VKPz/vZmERYCDk19/mP1
	1fZeqyhoN72a2K16DorlxlIX01GTed9VDoUjaizlU5x6Z1euaJchrDtqBnVpaS55oOItF4be3Pp94
	BOtsspFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPBc1-00000008h8S-37i5;
	Wed, 11 Jun 2025 02:54:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPBD4-00000008enl-2Q7e
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 02:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749608941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9oH1uonxI0Sglm5wymhiE86CF0kAPtwdmbbSnYdghw=;
	b=WD8NP7VTAFwFpoiS41IMA87bcDYQFDEvD2MCLU6xmcsOIu7ZJ4pBAvM23fYddFGhUD22q4
	T0K2yYjP7rvY0qxf0wqebyY44R843NE1FECCvd0hW25lqh/5XIstJpDGULaSejRTNz05rd
	/QcCFCouyWjjcnFXF88px9O8cGgjtoE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-s--suC9ZMbGOjfaj68MQBA-1; Tue,
 10 Jun 2025 22:27:05 -0400
X-MC-Unique: s--suC9ZMbGOjfaj68MQBA-1
X-Mimecast-MFC-AGG-ID: s--suC9ZMbGOjfaj68MQBA_1749608824
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E8FC19560B7;
	Wed, 11 Jun 2025 02:27:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C032E19560A3;
	Wed, 11 Jun 2025 02:26:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] tools/kexec: Introduce utility to build zboot image with bpf section
Date: Wed, 11 Jun 2025 10:26:44 +0800
Message-ID: <20250611022646.7970-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_192902_736311_2C9E5500 
X-CRM114-Status: UNSURE (   8.99  )
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

The series '[PATCHv3 0/9] kexec: Use BPF lskel to enable kexec to load PE
format boot image' [1] makes the kernel ready to load PE files with .bpf
sections. These two patches integrate the zboot-bpf image builder into
the kernel source tree, so users can conveniently generate the final image
with the command:
    make -C tools/kexec zboot
Later, the infrastructure for UKI can also be organized here.

To facilitate the review, I have pushed the whole series, including the kernel part,
to GitHub [2]. There is a slight difference from [PATCHv3 8/9] 
"kexec: Integrate bpf light skeleton to load zboot image" in [1]. This
difference is made in the function get_symbol_from_elf() to accommodate
clang's behavior, which combines the section header string table and normal
string table into one.

[1]: https://lore.kernel.org/bpf/20250529041744.16458-1-piliu@redhat.com/
[2]: https://github.com/pfliu/linux/tree/kexec_bpf_v3%2B

Pingfan Liu (2):
  tools/kexec: Introduce a bpf-prog to parse zboot image format
  tools/kexec: Add a zboot image building tool

 tools/kexec/Makefile              |  89 ++++++++++
 tools/kexec/pe.h                  | 177 +++++++++++++++++++
 tools/kexec/zboot_image_builder.c | 279 ++++++++++++++++++++++++++++++
 tools/kexec/zboot_parser_bpf.c    | 157 +++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_image_builder.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

-- 
2.49.0


