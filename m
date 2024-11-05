Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908D2D1CA19
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3KOMy/RpdjWXQm24z3Z1ZTl7k47fC1nvvz7g5KbQfP0=; b=0qr8l9eK8CkOHi
	p9HenjYIARCBsVAFHRsu5oj1HubKB2RHEr6bB3Az9sQpZQeL6PbZN0TzcwK9PRb/dV88ujAjdZB3h
	pSAv58YPFNPiENuFvmz1LrvswAp8lKElcKJBeqNQJZPR+pJDgXHdMZ/L+g+hbVTCgr7TX0NpVuC6m
	z26l4JV7Z9OcLY/4p9FOrVQ04pu+8A31PrzCZRAi/9PBkxUpvCxg0ib4GUvJ61uNJAoLxgImNlcuo
	f4khQz5IKAp0HfdBHgvY1WRoQNpglM3LM0iN/HFwzgBQACnTmg8GkgIcEajXlgOcRpYLvDzKKeca8
	cfbAV6y0Tyx5kOeloSRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhF-0000000Foly-0BRi;
	Tue, 05 Nov 2024 03:57:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhA-0000000FolK-3kHu
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 03:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730779051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1zKRnomNLdMRoMAvOfDjieXsVFISXmwN4f7MDdIaJYs=;
	b=hsTLd1vUm+WCItPll1XGTh/O2/RKgOa73FBAI417WehBmOo+qw4ZFa3np18zximXOECFSr
	cpwzUxg+54dKWxCVTqEHaAkZOzQYr77PZOXIEqtMEfYFUmPH3ecRP5OKV2i9KDmjP8xG4W
	stG37RGgL0268v7Egqn9PBf70/5z9gM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Pph9se-iNTq9eY-FAV7Clw-1; Mon,
 04 Nov 2024 22:57:28 -0500
X-MC-Unique: Pph9se-iNTq9eY-FAV7Clw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 566FC1955EAC;
	Tue,  5 Nov 2024 03:57:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B13BD1955F40;
	Tue,  5 Nov 2024 03:57:23 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 0/3] Enable UKI image load on x86_64
Date: Tue,  5 Nov 2024 11:57:04 +0800
Message-ID: <20241105035710.11384-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_195733_026808_AC7DE943 
X-CRM114-Status: UNSURE (   8.42  )
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

The correct kernel fd instead of UKI image fd should be
passed to the syscall. On arm64, it is not a problem, but on x86_64, it
is.(see commit log in 2/3)

This series aims to address the above problem.

Cc: Simon Horman <horms@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org

Pingfan Liu (3):
  UKI: Split out the routine to create temporary fd
  kexec: Create a temporary file to hold .linux section in uki_probe()
  x86_64: Support UKI image format

 kexec/arch/arm64/kexec-vmlinuz-arm64.c |  2 +
 kexec/arch/x86_64/kexec-x86_64.c       |  1 +
 kexec/kexec-uki.c                      | 67 +++++++++++++++++---------
 3 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
