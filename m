Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E72EE021A
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Bj55qBuQ0NeQgKWCOZ63FrVpHuutav8reLiTrRlg7qg=; b=lWDtDd1fAe1+Iw
	zjSYSkFr5HENGb7lrXxdLXIb9qJxvQEjYU7XgyyBQp3CbXBf54RZIN5dBdT9a5B5PPRhASitZg89F
	O2P6m7AJn3m5AzLcLXYEhO8PMjhdmd3DIgyVMP6qacS683KYbd3wkBuiNBFlDXgcqQcxzv6S6U9pO
	eKKtSfIFB+uI7FAI+hKnys2ogYOIax/VSEvQH2b+8WP20uJolKgJEx54LKpcsL4jzl9df64tGjEAU
	QzXduu+RdYcGEDl5TWtYHt6fh9NqG3HuHhOSSA+DM4egHg/92v2G5hlNccrLkwvIxwHD4xwT5BRnt
	ZYLulv7LpPuUSEdJ5tTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIcu-00000008cbL-2BfV;
	Wed, 11 Sep 2024 08:23:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIWb-00000008auE-2bnU
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 08:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726042588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S9gOHV2P6n1r9v/KacsRsytS/lNb4zOlPi+8XQnUG00=;
	b=Lzrx1mfLX/yHSBGvXVrJK6HrmHqfy+glN2kttj+KeW/3VBdJJ0iLEtPvl1ih8468weybO3
	Nz69MmMw70rfPJ/gh8obKP/OtPXmHeiGdcd/upD/JWsFbSnW5CD9n+ZgpJ+6dVyQyvBrz/
	yBp8f+xCU956scKXnzDGUVMd4lXVoUc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-1M_BptrPMby1ljoBlh4kPQ-1; Wed,
 11 Sep 2024 04:16:27 -0400
X-MC-Unique: 1M_BptrPMby1ljoBlh4kPQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 502DB19560AF;
	Wed, 11 Sep 2024 08:16:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0C3630001A1;
	Wed, 11 Sep 2024 08:16:19 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
Date: Wed, 11 Sep 2024 16:16:13 +0800
Message-ID: <20240911081615.262202-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_011629_761322_0E00E03A 
X-CRM114-Status: UNSURE (   8.61  )
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

Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
default. This makes kexec/kdump kernel always fail to boot up on SME
platform because of a code bug. By debugging, the root cause is found
out and bug is fixed with this patchset.

Changelog:
v2->v3:
=======
- Add how the miscaculation is caused into patch 2 log according to
  Tom's suggestion.
- Add Tom's tag.

v1->v2:
=======
- Add patch 1 to clean up the confusing local varibale naming because
  people may mix up the local variable 'size' with the passed in parameter
  in function early_memremap_is_setup_data(). Suggested by Dave and Tom
  during v1 patch reviewing.

Baoquan He (2):
  x86/mm: rename the confusing local variable in
    early_memremap_is_setup_data()
  x86/mm/sme: fix the kdump kernel breakage on SME system when
    CONFIG_IMA_KEXEC=y

 arch/x86/mm/ioremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
