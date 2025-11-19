Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB35CF3943
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6uecwSwGFFbXl1qPuexBXFyChv3MWiyVof996dOVmk=; b=Ze6IaDSRkvjw5RKae0hCQxBIeE
	LqbsNyYXjpBrEcbOC5RwJi5ONSqTt6NKP3YXdPX2Ws33YDC08YKzbfTOqEDLCaad0SSLV+S6wiW+E
	owkR4gnXBifI/qFTe2FP7AMdEKyuJnga1lZI8MW33GtETNG6ORLnTi97h38SvjRdBGOeqd7s4A/b9
	Hc5dPJHVTikLTRF5jLnqUjmM/FVSqxS1+N/8rIq95zOTBzeDuzVl4bLDY76oHa+TZKfLSgntgYYRa
	yvMdEZ8GqDH0deppfZ6SCnoq/uWkqSGOrCEjFlaEWaYRQ7v49s1pMFiIV3G2Zm7A7eiWKTwnSus/D
	tamUmgEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkdy-00000003d92-2ZuM;
	Wed, 19 Nov 2025 16:02:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkdx-00000003d8Y-1IOD
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 16:02:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ACDFA60172;
	Wed, 19 Nov 2025 16:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CB8C116B1;
	Wed, 19 Nov 2025 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763568172;
	bh=FFzMom7BsypiO6WAJXDo5CLw9r6cCiHmGONxZukFeVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5tBSw7zSc8oLVvRFqNW6gJ49iCAgkMwgQSn9wBOIQm8ouy5frc7i8HoGMS2NW9mJ
	 eJ7Ui70VVxCypKXXXDnUsbIaa0RAGBBCo65wD50kopyTmEL5NrBhMV+da7pWwIwZIw
	 Jb1Z4RXCInwdmtw4sUYT01n8lP7aecoY/jcBashc=
Date: Wed, 19 Nov 2025 17:02:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <2025111944-bullpen-slinging-dcdc@gregkh>
References: <20251118182416.70660-1-pratyush@kernel.org>
 <2025111944-tracing-unwieldy-1769@gregkh>
 <mafs0wm3m2f1h.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0wm3m2f1h.fsf@kernel.org>
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

On Wed, Nov 19, 2025 at 04:55:06PM +0100, Pratyush Yadav wrote:
> On Wed, Nov 19 2025, Greg KH wrote:
> 
> > On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> >> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> >> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> >> KHO maintainers can get patches for its test.
> >> 
> >> Cc: stable@vger.kernel.org
> >
> > Why is this a patch for stable trees?
> 
> If someone finds a problem with this test in a stable kernel, they will
> know who to contact.

Contacting developers/maintainers should always be done on the latest
kernel release, not on older stable kernels as fixes need to ALWAYS be
done on Linus's tree first.

Please don't force us to attempt to keep MAINTAINERS changes in sync in
stable kernel trees, that way lies madness and even more patches that
you would be forcing me to handle :)

thanks,

greg k-h

