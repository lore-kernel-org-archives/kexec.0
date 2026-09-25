Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72893C98321
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CSR1dNFry5HDkFro5l0N2s8MlUG7mEY2ilKQL+nMXFI=; b=qzLgWOuP3K+ulYgjpGfr70MK9a
	FmIfeT3b5g42YUOwmK3XbEnkB48nYfYyPfZN/D17M34/BOgk3Uac7X2nHfTV3OwFVbhjfZplFRVj/
	/WemApcAvaqbJ8xoiVPYoAQvknaIjoGFA0L87UFuTUUmX+sAnvFO6sGYjp/1qTqujoTMqXwQivat/
	AR2KrNWWeK0WCi6CKtUTJr12Uc6ta/M66I1KWRzuVZYZhB6At2p0WnEY+kRbZbwjzn7yfh2Pf8/5c
	WRV98I3GkozCzyiFb4JoDmtks2f1DfggeXHAvuN7kF4yjGgOUqsz5+K96c4QQwEui5Tz0dpnmdEZO
	SuvWVAYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA97Q-0000000E0N1-2FZi;
	Fri, 25 Sep 2026 16:49:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA97P-0000000E0Mi-2ZYA
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 16:49:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6DD76022F;
	Fri, 25 Sep 2026 16:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E011F000FF;
	Fri, 25 Sep 2026 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354990;
	bh=CSR1dNFry5HDkFro5l0N2s8MlUG7mEY2ilKQL+nMXFI=;
	h=From:To:Cc:Subject:Date;
	b=kKLJaR34fiSv4I8ZiYf0KIoc1sSfB8yRBfZ77A7iY1Xqt8dQgJlahhcMG8TFwk8vC
	 1O1gVaTlFYe8qOxhhM+Uu9d6IuI24WG9m0Hc8qm/vdKaZXP55Ygy+wS9Q2PYUUrORl
	 iHoHhr4an3SFYZY+NtwK6gJAR5BzzG4A4lyXrE9bxNurAaT3uw+OhvUbZtw4i0iEn9
	 A+dMer/I0ACsdlVWYDP2Pw0Aw+VBzDS17CRXm3EiaTxQnVRI8B75KorS14GiR48Yn6
	 qW/qfUxd903nkiMbsSSP0cPP4hdXGSRpXj5EDnObyWzrQHOncPqlNpMSIQ63H6JEBT
	 9HAWT4uH4rCQg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Logan Odell <loganodell@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Tarun Sahu <tarunsahu@google.com>
Cc: kexec@lists.infradead.org, kvm@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>
Subject: LPC 2026: Live update BoF?
Date: Fri, 25 Sep 2026 18:49:46 +0200
Message-ID: <2vxzse2x46ol.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi all,

We have had some discussions recently about the scope of the KHO/LUO ABI
and what kind of backwards and forwards compatibility we should support.
The two main threads that I have seen are [0] and [1]. I have also been
in various 1:1 discussions about this with many people, and I have seen
all sorts of varying opinions.

While Logan has a talk about live update versioning on the Live Update
MC [2], it is a 20 minute slot and I am not sure we will have enough
time to fully flesh out the discussion. I am also not sure what exactly
Logan plans to talk about, but from reading the abstract, it seems to be
around the mechanics of handling multiple versions. So perhaps we should
keep Logan's talk about the mechanics, and we can discuss the policy
around ABI stability separately?

So I propose that we schedule a Live Update BoF. The main topic will be
around ABI stability, but if time permits, we can have secondary topics
too.

I see two open BoF slots:

  1. Monday between 12:00 and 13:30. This overlaps eBPF, Refereed,
     Toolchains, Device and Specific Purpose Memory, Safe Systems MC,
     Android MC, Monitoring and Observability MC, and DRM Rust Workshop.

     I think this slot is great because I think none of the overlaps are
     major conflicts with this interest group.

  2. Wednesday between 15:00 and 15:45. This overlaps with Networking,
     Live Patching MC, Confidential Computing MC, sched_ext MC, and Driver
     Core MC.

     This slot is not as good I think because I reckon KVM folks might
     be interested in the Confidential Compute MC.

So I propose we have the Live Update BoF on Monday between 12:00 and
13:00. The BoF slots are first-come-first-serve, so I'd like to book it
soon-ish.

Thoughts?

[0] https://lore.kernel.org/kexec/2vxzik5f311e.fsf@kernel.org/#r
[1] https://lore.kernel.org/kexec/20260904160009.GV4157646@nvidia.com/#r
[2] https://lpc.events/event/20/contributions/2613/

-- 
Regards,
Pratyush Yadav

