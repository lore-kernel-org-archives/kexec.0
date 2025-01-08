Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6CDE77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZORM63nhj4Db7gE3We258vVDV3pB9hu6RoF51BIGqQ=; b=FnIiKAspzQxRtxH4nJTof6D4zc
	iwkq+pI7Ilr6/Tapy6yjjq/ubHdP8C0hEEz/XDENE+7k9EYmStI/Sv/yQtfooDN2ushE1IABr9hvq
	7tQm3mBEJDAnelp2viM9GhM9s3wqtkRzpYnX2Er/XFuvzoj8UpbYqbqHpo9ne8/01PHZHd5CV23yh
	xO8gmkKL9mwyUIaZAIeJCJG+Mh6hLIxLE4LxWmVG+pzQHSOKmyNhlyQ6vAHfldA4k1Ts3b02DqUTf
	OaaxqzHsHknmlJWl4o9V9hvIKAa2NFM2TxE1HCKGsDhJeoKh3lmKQu1HW+sJ+8ZarKLrl7iSdhsqZ
	QpQRPp1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVU3S-00000008Az9-0azi;
	Wed, 08 Jan 2025 11:16:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVU3P-00000008Axf-0dVo
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 11:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736335008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZORM63nhj4Db7gE3We258vVDV3pB9hu6RoF51BIGqQ=;
	b=hFewiExMoxHcAy3p2TP3P4lSRvSG7mOVpfPfSWApa0C6iY+IiO6Vh5x/J9K7X/8ZlvCjQG
	oxesO5dApGM3W5pV92AWERN8JsDp5Oo9ghqmdVVuaf4b8rfxeFiA0ZubIxWIJCjDHgttAH
	Gf25PMI7o3X8StB/x5vdW4u8QUlkASo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-IXDOU70qOguI5eqrh8OtbA-1; Wed,
 08 Jan 2025 06:16:43 -0500
X-MC-Unique: IXDOU70qOguI5eqrh8OtbA-1
X-Mimecast-MFC-AGG-ID: IXDOU70qOguI5eqrh8OtbA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74A0119560B0;
	Wed,  8 Jan 2025 11:16:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A01F1956094;
	Wed,  8 Jan 2025 11:16:39 +0000 (UTC)
Date: Wed, 8 Jan 2025 19:16:29 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/5] crash: remove an unused argument from
 reserve_crashkernel_generic()
Message-ID: <Z35eja7aQdnY6ZPS@MiWiFi-R3L-srv>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108101458.406806-2-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_031651_261836_6E849FF0 
X-CRM114-Status: GOOD (  10.89  )
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

On 01/08/25 at 03:44pm, Sourabh Jain wrote:
> cmdline argument is not used in reserve_crashkernel_generic() so remove
> it. Correspondingly, all the callers have been updated as well.
> 
> No functional change intended.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/arm64/mm/init.c          |  6 ++----
>  arch/loongarch/kernel/setup.c |  5 ++---
>  arch/riscv/mm/init.c          |  6 ++----
>  arch/x86/kernel/setup.c       |  6 ++----
>  include/linux/crash_reserve.h | 11 +++++------
>  kernel/crash_reserve.c        |  9 ++++-----
>  6 files changed, 17 insertions(+), 26 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>


