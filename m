Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5262C5DF7D
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCaPyvw2iFSAtJp+/S0lPXfdeu+F7EyJ6au4lKiWYEc=; b=knR2XgfJez4FDdMSUNGRityGzR
	HuqKcLy5/plFJpbyldi4Do47pByLW/PiYlNKvTDt9JR0YoMIkiu+U0jVmxDG3llv0ZmyDcMxQfZPg
	sJHI7PvsYTnmjJTGmX2eQLhQbIRiB56lQzaDNWsL5KAtvjnhSnmnACQmJ2K4FnLPng1h4Bj6R7oZm
	3jaFIRuQXf+7tJCgb2KKO+DWDTpAn3MQXIs5ADryxEFZC2rukM5GWlRB/fbQAbpffShlu2l9ZmrNu
	0Iwm4GLrd4/evHaSQiftM+dCKUApdwNglBwb0IrqkELRPgurTpYN+ljJk4eaxzCKdTdVxsGQqiN0J
	7j9PiwWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwK69-000000084Ca-41Ia;
	Tue, 18 Aug 2026 13:43:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwK69-000000084CP-0E2g
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 13:43:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 58DE6436AF;
	Tue, 18 Aug 2026 13:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0CB1F000E9;
	Tue, 18 Aug 2026 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787060604;
	bh=nCaPyvw2iFSAtJp+/S0lPXfdeu+F7EyJ6au4lKiWYEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CNqkvMTJLXNXiEeYKsDcJ5vMCl9APuMbVQIu0B3nogx96ycdVcxhEfA8Y935rOFQB
	 DwbNjFOYTMnBcvSeBREzeVOMYq7oUx9+JWYNVQm4Q0PKS+TKPkUhGIwiw2tE5w+5Ve
	 LAEdg6oApkQLyaWE+1c4QN377ZwYbBFYC0UH/Ok81z64U3FaYuILqh5ogSr2NI8qW5
	 Ege/V5Ma8jQasI6rRqF3rtGgJBIUlCgSKy5x8PZPaKbx9kzGG3jWEalwW+u9kH3QZa
	 hA+6ZSEFatqG59DQNkEy9P9hX2+kEigKQsIcMrgm1kYnd9bXj74pxxwXASSs+5JduV
	 qiO3xv/HZavsA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tarun Sahu
 <tarunsahu@google.com>,  ackerleytng@google.com,  fuad.tabba@linux.dev,
  Andrew Morton <akpm@linux-foundation.org>,  dmatlack@google.com,  Shuah
 Khan <skhan@linuxfoundation.org>,  Jonathan Corbet <corbet@lwn.net>,
  david@redhat.com,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  sagis@google.com,  Paolo Bonzini <pbonzini@redhat.com>,  Mike Rapoport
 <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  linux-kselftest@vger.kernel.org,  andre.przywara@arm.com,
  michael.roth@amd.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  will@kernel.org,  vannapurve@google.com,  maz@kernel.org,
  fvdl@google.com,  kvm@vger.kernel.org,  oliver.upton@linux.dev,
  kvmarm@lists.linux.dev,  alexandru.elisei@arm.com,  skhawaja@google.com,
  aneesh.kumar@kernel.org,  linux-doc@vger.kernel.org,  David Hildenbrand
 <david@kernel.org>,  yan.y.zhao@intel.com,  kexec@lists.infradead.org,
  suzuki.poulose@arm.com
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live
 updates
In-Reply-To: <aoMcqp0gr06YXAPU@google.com> (Sean Christopherson's message of
	"Mon, 17 Aug 2026 07:37:30 -0700")
References: <20260728121138.1103610-1-tarunsahu@google.com>
	<20260728121138.1103610-6-tarunsahu@google.com>
	<anphyjFv3FhF61iB@google.com> <2vxzpkzo51wg.fsf@kernel.org>
	<anssOQFNZ2LfihbU@google.com> <2vxzik5f311e.fsf@kernel.org>
	<anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
	<aoMcqp0gr06YXAPU@google.com>
Date: Tue, 18 Aug 2026 15:43:16 +0200
Message-ID: <2vxzy0e3zgqz.fsf@kernel.org>
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

Hi Sean,

On Mon, Aug 17 2026, Sean Christopherson wrote:

> On Sat, Aug 15, 2026, Pratyush Yadav wrote:
>> On Wed, Aug 12 2026, Sean Christopherson wrote:
>> > On Wed, Aug 12, 2026, Pratyush Yadav wrote:
>> >> This is ABI between kernels. It needs to be stable-ish so you can move
>> >> from one kernel version to another. At the same time, unlike userspace
>> >> ABI, it can change.
>> >
>> > Uh, yeah, so KVM has been managing such immutable ABI for practically its entire
>> > existence.  KVM's save/restore uAPI has exactly what you're describing: serialization
>> > ABI that needs to be backwards and forwards compatible between different kernels
>> > in order to support both upgrade and rollback scenarios via live migration.
>> 
>> I think there is a slight difference between KVM's save/resture uAPI and
>> live update's ABI. With KVM's uAPI, you need to maintain strict
>> backwards compatibility because userspace reads what you output. So if
>> you change the layout, userspace will interpret it wrong and might
>> break.
>> 
>> With live update, the ABI never gets to userspace. It is used to talk
>> between kernels directly. So if you do break that, your userspace keeps
>> working fine, you just might not be able to live update to the
>> incompatible kernel.
>> 
>> So with live update, we don't need to keep backwards compatibility in
>> the ABI forever. Of course, it is good to minimize changes, but we have
>> more freedom to change it.
>
> Ah.  So this is the heart of the disconnect.  I very strongly disagree with the
> statement that live update doesn't need to support backwards compatibility.  I
> can totally believe that the folks working on live update are ok breaking backwards
> compatibility because their use cases are "fine" with such breakage.  And I can
> also believe live update as an upstream kernel feature being developed by those
> same folks is also ok with breaking backwards compatibility.
>
> But with my upstream KVM maintainer hat on, I am not ok with that.  I did not agree
> to support a world where KVM is allowed to break backwards compatibility, so long
> as it's done "carefully" or whatever.  If y'all want to deal with the resulting
> complexity, that's fine by me, but you'll be doing it without KVM.

Let's step back a bit. I don't think backwards compatibility in the
_ABI_ is all that important in live update's context. What is important
is that our users are able to live update from kernel version X to Y.
The line format the kernel uses to describe its state is an
implementation detail. Our users never see it.

The high level idea is that when you need to make a change to the ABI so
the kernel can better describe the objects/resources/files it is
passing, you create a new version of the ABI and allow transitions from
older versions.

Say you make some changes and need an ABI version v5. You don't get rid
of v4. You keep it around. LUO core will facilitate picking the right
version for the next kernel. So it will be possible to seamlessly
upgrade your kernel that speaks v4 to a new kernel that speaks v4 and
v5. Now this kernel can start speaking v5 if its successor speaks v5
too. And so on for going to v6 and v7, etc.

After a "reasonable" time given for upgrades, you deprecate v4. v4 has
been around long enough and our users have had a chance to go to kernels
speaking newer versions. That's when you remove the code for v4 from the
kernel.

We can argue what "reasonable" means, but the core idea stays. 

It will still be possible to go back to v4 or earlier, but you'd need an
extra stop along the way. And of course, vendors can keep a wider
support matrix downstream if they see the need for it.

Does this idea of "backwards compatibility" sound acceptable to you, at
least at a high level?

Now coming back to today's reality. We don't yet support this version
transition. I proposed the idea at LPC 2025 [0]. Logan Odell has taken
over the work since I have other things on my plate, but it is something
being actively developed. Logan recently sent some RFCs [1] for this
too, though TBH I haven't yet gotten to those patches. We also have
proposed a talk about this at LPC 2026, it would be great if you could
attend (if the talk gets accepted).

If you say that we should figure this version transition out and land it
upstream before we land the KVM code, I think that's a fair ask. I can
work with that.

But I think we first need to agree on the principles of the
compatibility model I described above.

[0] https://lpc.events/event/19/contributions/2049/
[1] https://lore.kernel.org/kexec/20260731215224.831696-1-loganodell@google.com/T/#u

>
> I totally understand that exploratory work and initial development is best done
> in private and/or in a small working groups.  But decisions that will significantly
> impact multiple subsystems need to be made *with* those subystems.  I mean,
> obviously it's possible to make a decision in a small group and then "publish"
> the result later, but then as is happening here, the community and subsystem
> maintainers like me may refuse to play ball if they disagree.

The design of live update was discussed and agreed upon in the open.
David Rientjes (and now Pasha) has been hosting the live update
biweeklies [2] from the very start of the project. The series is open to
everyone and notes shared for those who couldn't join. This meeting was
attended by a lot of people from different companies and different
subsystem backgrounds.

There have also been a microconference at LPC 2025 where topics around
live update in PCI, MM, VFIO, IOMMU, etc. were discussed, along with
presentations at subsystem tracks in other conferences.

Of course, it is impossible to get all maintainers of all subsystems to
attend these sessions or conferences. That's fine.

But I think it is quite unfair to say that live update is developed in
private or in small groups.

[2] https://lore.kernel.org/all/?q=s%3A%22%5BHypervisor+Live+Update%5D%22

-- 
Regards,
Pratyush Yadav

