Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F1CC6FD1F
	for <kexec@archiver.kernel.org>; Fri, 29 Mar 2024 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TJ9V9v9LOkBdYcVFVx+SSHBepx9F7xdTJnlBz22tWHw=; b=NFxGEIuyuBQh8E
	eqaikqa0dnRT8JaP6/MFuscSVQD6GD24/0MaDpe9swm3i/2ifUu9WWmLRuIELy24lWuBZ8pOkNJkd
	piRe7sV/IdSoOjMVJtLuTOVSVf+iBsnlt7j2J2bOB31prYsXaDrQCerCuEh/CF1gkOUDgGxcKSC59
	On/KlCzS9qMAFgbT+44Bu//QLCkfsJrBI5mYzaH3GU33QoNGcNhVy5hgQi0kA3KyF3A3kYQOpG4uZ
	GhhOYldII8ID7EZRpj7fdPTXb5KmIvSiJyGCMRh6MTRPnCVjXx74rhiSFoEyn0VEb4x1all08mTkW
	q9NAGlWKA4B96xQsrqaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHl-00000000erb-0kct;
	Fri, 29 Mar 2024 13:28:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHh-00000000eqq-08HA
	for kexec@lists.infradead.org;
	Fri, 29 Mar 2024 13:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e71DQq7shK3QOiz5qaoMC5NLntmm0X5Sb9Wn1F+/pnk=;
	b=Eld7gr0lHuQNB4f+ShzRI8EdxHMs7Kh0lW6n5yZ8kDQM0kejkZ41KHLKPehLsK+2vg4hj3
	DW+QfXrX8UHdOr+C3180Za5JXO97R9zOVrXCLHolwpQSHWTYepdgd2WChEKDKQe/osWL23
	upHj80Q0sT9rr4DiEC5yqOXVZMbrqIg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-FcsFZefLNMSab58I9jI-lw-1; Fri,
 29 Mar 2024 09:28:35 -0400
X-MC-Unique: FcsFZefLNMSab58I9jI-lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FA153C0BE46;
	Fri, 29 Mar 2024 13:28:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2916D1C060D4;
	Fri, 29 Mar 2024 13:28:31 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: akpm@linux-foundation.org,
	geert@linux-m68k.org,
	chenhuacai@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] crash: clean up outdated codes and doc related to CRASH_CORE
Date: Fri, 29 Mar 2024 21:28:23 +0800
Message-ID: <20240329132825.1102459-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_062841_161914_0627EBBD 
X-CRM114-Status: UNSURE (   7.40  )
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

As Geert pointed out that there are still left codes and doc related to
CRASH_CORE in arch/loongarch and Documentation. So make these two
patches to clean them up. Thanks to Geert.

Baoquan He (2):
  arch/loongarch: clean up the left code and Kconfig item related to
    CRASH_CORE
  Documentation: kdump: clean up the outdated description

 Documentation/admin-guide/kdump/kdump.rst                 | 8 ++++----
 arch/loongarch/Kconfig                                    | 2 +-
 .../include/asm/{crash_core.h => crash_reserve.h}         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/loongarch/include/asm/{crash_core.h => crash_reserve.h} (75%)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
