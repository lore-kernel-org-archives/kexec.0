Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433ABC5DF74
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbnAp7y/AgCt9+7CBSjoILDuat4y2Kbyd9OVnJGDiZs=; b=OqkUXuReZuV9efVfOhkKwLpXfI
	ctkq+FXjRn7UfUbcGU0j9sy9i/qX3RcPoRNFrooD+h9kBXivrnJ+EBSytzM/L9NMJSidGhncxJus0
	7HUsX212JO5w9PGXWFZ9pwMCmM4d3c3PpvpwWv/N2nm4NDSgxmYIYhUlk9+615xp1QsMYON+N9Ibz
	rm2yQbIxcjIcBgVx41xS35VIUd/McBvFTvBaoLTUJqpoNryE2O3zpBi19hLUkMfK0P/SvV7wiO7lL
	pH4AK0Kr6H4XtQQOK49GsuvDzNO3fYX390mUU0r3KrjTG0wAVjy4YQivXSqhU1Rm0sff9CPAq5oG+
	fM1AwMrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyT1-00000006KGE-37hn;
	Mon, 17 Aug 2026 14:37:35 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvySy-00000006KEb-2sAZ
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 14:37:33 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cfc52ddc55so55348325ad.3
        for <kexec@lists.infradead.org>; Mon, 17 Aug 2026 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786977451; x=1787582251; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbnAp7y/AgCt9+7CBSjoILDuat4y2Kbyd9OVnJGDiZs=;
        b=jSascIImu0k2VsG5KzPClvKs2a/e7V/Rsg+s7e1POJ/6BaEA10t06QKi0bJi3QY1IE
         AHzC2XLtZtF/1YJJFSIDp4KxiIrbPMj5VMEd4JnWgfrRVgMG2azMhjiP1Sb04+wE7cei
         /V8i8+8XdWnMkRYlVgMuhtTNftP2vOqrds3WOolPqDosP0mdblHpfqPrewGgZR3Bqyf3
         ILkYlTBA7LfLyjar2cmPAzQ9Hn1JPc5G3wo64eHF1zutyOZrCPa4+4HAVmiFn68Gf2V9
         c000tRkWhoPC+RE8zD5Q+ke3luxNnKW9wpu0lKAFj9/mphxivTa79ZLpkuNsVun4WVmd
         7/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977451; x=1787582251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbnAp7y/AgCt9+7CBSjoILDuat4y2Kbyd9OVnJGDiZs=;
        b=KvWOIpoFgECn0s0T80JBFbNXnO2QcR5Z17EruKRNld46Umtp4HobXZMtqyTZ+DMFgJ
         TtTluFIwyk+Z5Ym4qcHyVOUpl5GLOyS+AoO4O1QhtGq762ioMHlA574Uf4c2z/a/c9DJ
         8x02kOc6E/Zt5CxctytFVc0WTZxwSoO8L2uMm310YdzgWik6XVRPR8y3y+e4s+OVzyxU
         U0yy+QCOP+WliWIydYtL8XmW6gJqttB2W4KFgUam2m/NF670zCQ5PWlUezob6rt6swYL
         rloySNRYPZyyRf4Lehu0OVEU7FkItt4VjA4JCLIJ0z4tEzgG7UlI483TnFksLzmJHjcp
         huvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmrCwALtsHCMHT34fGJdtV2NGGWvBY1dingmydEEWNVkCA229LU5r8TJLzzcPOrwFb95ojIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEBP1CYWvUsbGp8KQCqDFEppW8CEkA3ysoVmD9Bsvwjai2FmC3
	82hwFenvonQrUPayz9/rC6HvfB5/1e4s1RJ5qQLDwjFJlAOKnZWUxCT0yaxmwxC7rYIlzAqjPOi
	GXJ9DWA==
X-Received: from plbmo3.prod.google.com ([2002:a17:903:a83:b0:2c7:702a:36a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0b:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2d3b0c7ae46mr283430775ad.10.1786977451095; Mon, 17
 Aug 2026 07:37:31 -0700 (PDT)
Date: Mon, 17 Aug 2026 07:37:30 -0700
In-Reply-To: <2vxzqzjz1x5f.fsf@kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-6-tarunsahu@google.com> <anphyjFv3FhF61iB@google.com>
 <2vxzpkzo51wg.fsf@kernel.org> <anssOQFNZ2LfihbU@google.com>
 <2vxzik5f311e.fsf@kernel.org> <anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
Message-ID: <aoMcqp0gr06YXAPU@google.com>
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
X-CRM114-CacheID: sfid-20260817_073732_727453_74F3075B 
X-CRM114-Status: GOOD (  23.30  )
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

On Sat, Aug 15, 2026, Pratyush Yadav wrote:
> On Wed, Aug 12 2026, Sean Christopherson wrote:
> > On Wed, Aug 12, 2026, Pratyush Yadav wrote:
> >> This is ABI between kernels. It needs to be stable-ish so you can move
> >> from one kernel version to another. At the same time, unlike userspace
> >> ABI, it can change.
> >
> > Uh, yeah, so KVM has been managing such immutable ABI for practically its entire
> > existence.  KVM's save/restore uAPI has exactly what you're describing: serialization
> > ABI that needs to be backwards and forwards compatible between different kernels
> > in order to support both upgrade and rollback scenarios via live migration.
> 
> I think there is a slight difference between KVM's save/resture uAPI and
> live update's ABI. With KVM's uAPI, you need to maintain strict
> backwards compatibility because userspace reads what you output. So if
> you change the layout, userspace will interpret it wrong and might
> break.
> 
> With live update, the ABI never gets to userspace. It is used to talk
> between kernels directly. So if you do break that, your userspace keeps
> working fine, you just might not be able to live update to the
> incompatible kernel.
> 
> So with live update, we don't need to keep backwards compatibility in
> the ABI forever. Of course, it is good to minimize changes, but we have
> more freedom to change it.

Ah.  So this is the heart of the disconnect.  I very strongly disagree with the
statement that live update doesn't need to support backwards compatibility.  I
can totally believe that the folks working on live update are ok breaking backwards
compatibility because their use cases are "fine" with such breakage.  And I can
also believe live update as an upstream kernel feature being developed by those
same folks is also ok with breaking backwards compatibility.

But with my upstream KVM maintainer hat on, I am not ok with that.  I did not agree
to support a world where KVM is allowed to break backwards compatibility, so long
as it's done "carefully" or whatever.  If y'all want to deal with the resulting
complexity, that's fine by me, but you'll be doing it without KVM.

I totally understand that exploratory work and initial development is best done
in private and/or in a small working groups.  But decisions that will significantly
impact multiple subsystems need to be made *with* those subystems.  I mean,
obviously it's possible to make a decision in a small group and then "publish"
the result later, but then as is happening here, the community and subsystem
maintainers like me may refuse to play ball if they disagree.

To be very clear, for any KVM live update support that doesn't guarantee backwards
compatibility (allowing that bugs happen), a very firm:

NAK

