Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA30CD98F2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1bbfpOi76uZLkjjM5hdUbezqwfs0rnC6JfmnVvraEM=; b=TPCyEjbDs9y6YCwFc3exIThWFC
	i6a50VX1fTU2eDRbYwGi2tXQv1w7BpL6RbKXDNC89Eu4smS2Z/+8Qp9TBpQBGDOZT+cOWkkSZhux1
	pOImawx/JwG/CRwqnNvS8bbx1Zu+gAwZwXvwZBAwKW6Czc36A1A9/fWurk/rbzW5xjtOE5Krqx6Zb
	doHyuDwr+DrajFto9q2+bUh8Zm2FbLPliysVewg4Z0vGSftLCfwqMZ6OWQoMEcyb2Bmjo3BS5OqHd
	qB6/I9IJCgLFQlfrId00vEF73I+gw/tb8ApWwF+gx4k0qDoupiUNHAe5ytTnTp/fDtysInBGwfa27
	9Z9JggGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvPk-00000000Ddj-2QPl;
	Wed, 17 Jun 2026 18:55:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvPi-00000000DdX-2u10
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 18:55:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFE6F600AA;
	Wed, 17 Jun 2026 18:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320801F000E9;
	Wed, 17 Jun 2026 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722501;
	bh=U1bbfpOi76uZLkjjM5hdUbezqwfs0rnC6JfmnVvraEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AyZwN4PjHO+se1mFQ1BUiIgEFn4Fw3i71UjrEZmF5g+xuYvUV8KMJGNcIg4AIjfdF
	 gCiJum6xAHkK1lXj+PF56xwHtC5O01vr01A25mTC7ICMI9AHTWph6rtbF7cwNnJogv
	 yquIHwyfi+BrqRn2bLr/9n4I0Qz6hjaw/NVzPRlEYO47ehNZshag66NybsS1l8cf+Z
	 PxEF6sy7VnN8bg4G2L6M2ZZoewluoURU5q4aTKK9EeL7QhhCzj9aPcsCffJo8UmRWq
	 g1xUpOgmG6nFKeg25o+yUybrq4O30DLN/t7MOsOdDWCDq8jk+FrN4z99S+dXH9MG2W
	 47X+YX/wiYWsg==
Date: Wed, 17 Jun 2026 21:54:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, tarunsahu@google.com,
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make liveupdate selftests library
Message-ID: <ajLtfkuMP4DEGlqe@kernel.org>
References: <20260612214512.464146-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612214512.464146-1-vipinsh@google.com>
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

Hi Vipin,

On Fri, Jun 12, 2026 at 02:45:10PM -0700, Vipin Sharma wrote:
> Hello,
> 
> This is v3 series of refactoring liveupdate selftests as a library. It
> exposes common liveupdate ioctls as a library which can be used by other
> selftests like VFIO and IOMMU.

Let's revisit this after -rc1 is out.
I don't think there would a need to change anything, it's just the matter
of applying the patches to the right base :)
 
> Currently, there are no users of this change but it is being used in
> VFIO and iommu liveupdate series.

-- 
Sincerely yours,
Mike.

