Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDCFC5DF81
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTu8rIIeaYeWexH+JKqzOvDmozZVoZIeVfoU7C4RXZA=; b=41WkcLXaPDSz4ll1lpJ8Nk2n3y
	ckZW4uJv6IByZqfMiNLwaLb1IsxslH/eh6diwPa5nRpOC3sPBATIuM07kdRvK8BU9NRQmUDpkNyZ6
	TC3B/qmnwo9775rT9sSVbiqyvo0LvTSwNJBiZ7zJ3vc7kGwv42XmAnwSC95HAv8Ou4XR+xWWXPhLW
	A0Y5tXbQUOT9r44Kn7ECvN435yORRHUrrrZiFxvVGZ5T/3+JmQx8HP693K99dJ1geJX+D8KuQ16jF
	csNj447Z8mKiJZV7cwWMxhGQBBR0o4EKNu4UX9ZKQtJsuoYDhjDpsdTTLAIrbjXDqBBN8SPwVpFcH
	gA9qbURQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMH4-00000008JXu-2ksO;
	Tue, 18 Aug 2026 16:02:50 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMGa-00000008JWY-049c
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:02:49 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cbedfa3898aso4762449a12.3
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787068938; x=1787673738; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTu8rIIeaYeWexH+JKqzOvDmozZVoZIeVfoU7C4RXZA=;
        b=GYbAytQtHoFYiRZfg/YgNNgVWx7DycktoYr2NlhzfBeI4GuPxwCh/AMBFF0ZHTtJHU
         wVUZJWeghX2PEWE5ZktZpp1YFSFyufcqbUfFn5rxrwgfWO6+/gWUVPMbtzQVjdD4Biev
         wwdEgWoHhJnNg8cUOeOMcrxRADK5P4M2it7q6Xe7ibYeMtvIx54oQSoqXxEIllDtQTKO
         L5A1TysXa4TWpyZglk/lXiNaANCMW7QhFcDjNrr71Ebd8orDdaF6mIYsBsdufBKNGH7M
         f5oDbkectzORkCo6mLE4MSceNAvsf+I/rLC2x7sQySC9y/NM5qMHMrvbtni3zb2zFHE8
         MFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068938; x=1787673738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTu8rIIeaYeWexH+JKqzOvDmozZVoZIeVfoU7C4RXZA=;
        b=gyHzae14gNhIDllqOknN1qC+Nvo98kZINWv6zjOze0Mz/GiRa9+j4Pj64V6nMPK7wg
         a0UJ/X3yzx9W/O6aGOrKPKNoUIKPmr+Oy35vAruc9mmt5d24iUp3NdTQyfzmwQDrMSsP
         BiNP0apaGs0YqLPo6MXPtWxN4f1JenVF4JJp9Qz5tN3HTSijJeQtaT8Hde7wmLkb4Icc
         8fYsZSC8BFsWWnK2tzPDTAZsvUqwccsiqlERp+Tq5Jx0C15ooCqDwwJh9SuPAzG6HsyK
         81gvtZ+/6O8yNNtxVYA3BT7y4KxfxpKcris0lOo13IdZosUhtYBhyu5tnZ0fwJrNtmZU
         I8yw==
X-Forwarded-Encrypted: i=1; AHgh+RoMsmd8ih+nwyWW1hi8ynyxiW5jojupc+EJD4TwB9YQJHl4iZH9Hfo8tBtIyJ+04o9yD3dReg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7IuidNkZvmmy99rj7Nn5/9MJnfhLdcx3YceRrRI77mMpNpGfx
	EjsHS2GmR9Sxz79QXJSMW7fIDj8wyYUkrq7rvpJ6o/g9QZuDUqn8T9xtSR0eTPCxBkWeSphKPpK
	pUfLAxQ==
X-Received: from pgvc22.prod.google.com ([2002:a65:6196:0:b0:cbf:d9a:2fcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f99:b0:3c3:9df0:2d66
 with SMTP id adf61e73a8af0-3cc719fe453mr37508125637.6.1787068937949; Tue, 18
 Aug 2026 09:02:17 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:02:17 -0700
In-Reply-To: <2vxzy0e3zgqz.fsf@kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-6-tarunsahu@google.com> <anphyjFv3FhF61iB@google.com>
 <2vxzpkzo51wg.fsf@kernel.org> <anssOQFNZ2LfihbU@google.com>
 <2vxzik5f311e.fsf@kernel.org> <anyObKiZIhfok5mk@google.com>
 <2vxzqzjz1x5f.fsf@kernel.org> <aoMcqp0gr06YXAPU@google.com> <2vxzy0e3zgqz.fsf@kernel.org>
Message-ID: <aoSCCTTBn9D5hqzk@google.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Sean Christopherson <seanjc@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>, ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_090220_064801_36B04508 
X-CRM114-Status: GOOD (  38.39  )
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

On Tue, Aug 18, 2026, Pratyush Yadav wrote:
> Hi Sean,
> 
> On Mon, Aug 17 2026, Sean Christopherson wrote:
> 
> > On Sat, Aug 15, 2026, Pratyush Yadav wrote:
> >> On Wed, Aug 12 2026, Sean Christopherson wrote:
> >> > On Wed, Aug 12, 2026, Pratyush Yadav wrote:
> >> So with live update, we don't need to keep backwards compatibility in
> >> the ABI forever. Of course, it is good to minimize changes, but we have
> >> more freedom to change it.
> >
> > Ah.  So this is the heart of the disconnect.  I very strongly disagree with the
> > statement that live update doesn't need to support backwards compatibility.  I
> > can totally believe that the folks working on live update are ok breaking backwards
> > compatibility because their use cases are "fine" with such breakage.  And I can
> > also believe live update as an upstream kernel feature being developed by those
> > same folks is also ok with breaking backwards compatibility.
> >
> > But with my upstream KVM maintainer hat on, I am not ok with that.  I did not agree
> > to support a world where KVM is allowed to break backwards compatibility, so long
> > as it's done "carefully" or whatever.  If y'all want to deal with the resulting
> > complexity, that's fine by me, but you'll be doing it without KVM.
> 
> Let's step back a bit. I don't think backwards compatibility in the
> _ABI_ is all that important in live update's context. What is important
> is that our users are able to live update from kernel version X to Y.
> The line format the kernel uses to describe its state is an
> implementation detail. Our users never see it.

The rule is thou shalt not break userspace.  Whether or not the breakage is the
result of an explicit ABI change is irrelevant.

> The high level idea is that when you need to make a change to the ABI so
> the kernel can better describe the objects/resources/files it is
> passing, you create a new version of the ABI and allow transitions from
> older versions.
> 
> Say you make some changes and need an ABI version v5. You don't get rid
> of v4. You keep it around. LUO core will facilitate picking the right
> version for the next kernel. So it will be possible to seamlessly
> upgrade your kernel that speaks v4 to a new kernel that speaks v4 and
> v5. Now this kernel can start speaking v5 if its successor speaks v5
> too. And so on for going to v6 and v7, etc.
> 
> After a "reasonable" time given for upgrades, you deprecate v4. v4 has
> been around long enough and our users have had a chance to go to kernels
> speaking newer versions. That's when you remove the code for v4 from the
> kernel.
> 
> We can argue what "reasonable" means, but the core idea stays. 
> 
> It will still be possible to go back to v4 or earlier, but you'd need an
> extra stop along the way. And of course, vendors can keep a wider
> support matrix downstream if they see the need for it.
> 
> Does this idea of "backwards compatibility" sound acceptable to you, at
> least at a high level?

No.

It's probably fine for Google and other large companies that tightly control their
kernels and use cases, and have the resources to juggle the resulting complexity,
e.g. have kernel engineers on staff to track feature and dependencies, coordinate
and plan kernel upgrades, etc.

It's not acceptable for upstream, where downstream consumers often run a distro
kernel, have much more varied use cases, and don't always have a horde of kernel
engineers on staff to help them thread the needle you describe above.  And if
supporting live update as a general feature for all users of the kernel isn't
being factored into design considerations, then that needs to change, otherwise
this is all dead in the water.

I also don't see the point.  Maintaining a rigid save/restore ABI is annoying,
but it's not _hard_ (or at least, not _that_ hard), especially if there's a set
of well-documented best known practices that subsystems can follow, e.g. so that
individual subsystems don't need to learn painful lessons first-hand.  I genuinely
believe that maintaining the version hell you describe above would be more costly
in the long run than simply committing to full backwards compatibility within a
given subsystem.  I can imagine that enumerating what subsystems' information is
in the payload will require a different scheme, but for a given subsystem, I don't
see any reason to aim for anything less than full backwards compatibility.

