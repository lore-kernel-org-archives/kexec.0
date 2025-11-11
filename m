Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA59CCFA18
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0dpb4tvrW3qTRQlqryb0Y1hbD51O72N8+Mufx2g4gtQ=; b=0O22X6/ew2svyrwxYnZbpWJakc
	uCvOCxZvRqseokvtl6ZC/4UdUdYOJGAppqVlKJENU9UsRpJJMzZ4g0Mb37Oz4kmD2qTftAf+YLIBZ
	LtRwhybd6CyG0kbeHQIBI5rylyG7nqH69pb396gbWwFCzjIQaIwEivM0k6PSz052UKu972l8vX3Rq
	z/GrEcd6bz0q70Rvf3YUusqFcuU2B6kzBxE2lSs3IZD6S1RABj7YsajILEXCogVuRI7iv4pTBoiE4
	SFwer0orlkxaeBU5KBTrYAGLGC2mlQRZJtjFChPRVTybnKUh5XrNzY8QedmCJRCHPZvxJcWdGmxH/
	b0OGppLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoZy-00000007Fha-42wN;
	Tue, 11 Nov 2025 13:38:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoZx-00000007FhU-2eZi
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:38:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BA18460216;
	Tue, 11 Nov 2025 13:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B88C113D0;
	Tue, 11 Nov 2025 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762868316;
	bh=lQP+bOmGeGCCWBjET4LAtV+4tKuHgbehZHXLyEbfMl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6H1eGrJGH9GYpcxKUxAF7HQOjcJ6VrLx087P6GCxWw0G5Djup26D28NxFCGFA/ec
	 EY6gjU38ZWzRwGinhSBm5gtLNEWlPAN8VsoUIlDiFeGvkknLN12v4H2t9jHIqhfCUu
	 2Ewkqb2NJvwi1TWXVJ2PfeGeR2KSw4+f6q+0VWZOH6SWwFescC929bLzrlIaKnlGKt
	 kpInwm3kQdg0MTS3Q9xxBUbR0k0T2+8TXJaCH3tMAO72Fw+sTKcvmTy/VeKh5woXnb
	 MRwSsS2Er3Wj8eFwEO58hDMBypAgHK3+mW6rLDGNFMBV9K6671r91CIGVTFOq1iC7R
	 UWZJKdeUdszFg==
Date: Tue, 11 Nov 2025 13:38:33 +0000
From: Simon Horman <horms@kernel.org>
To: Mason Rocha <mrocha@turretllc.us>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools 0/2] kexec/ifdown.c: minimise errors printed
Message-ID: <aRM8WbG6l625aYXp@horms.kernel.org>
References: <20251022020703.14200-2-mrocha@turretllc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022020703.14200-2-mrocha@turretllc.us>
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

On Tue, Oct 21, 2025 at 09:07:02PM -0500, Mason Rocha wrote:
> On some embedded configurations, kexec generates messages when rebooting
> to the new kernel.  This patch line helps eliminate these messages in
> the event certain kernel options are set.  I'm not too worried about the
> second patch, but it is along the same line as the first patch and I
> thought that it should included.  Thanks!

Thanks, applied.

- kexec/ifdown.c: Hide error if sockets are disabled
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=86c3d1f7b646
- kexec/ifdown.c: Use AF_NETLINK instead of AF_INET
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=eb8609a29363

