Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40039C5CFC1
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4h7/hkwvCsY0fI00T2PR/Y4OZG0mhUElOQ2zn4pF7HM=; b=NUl7MhW+vhFUoRoRcmNnzxCaPX
	plW3OGQ0XoOJi9e9lMLtuIXzFr0bYFqS4rHd208NlTyhCm2wCDiq2/G9vlcNUa8s11BnIdANtxtve
	MiCu6Ts7QqmLkvigkteVJTl64fHovg7cwgUoX9PWI+NCQCKV3HC20fvT/e8oQ1/dOGWXxCT0sXXTg
	k21BiRx/QBmgB27pE77QM9YbvrgQWRm48WKlRY4o+hK73oS37qBHD6sAQcTjZRraI3CDrsYoGBHfS
	BRNgcGyBh5512FrKJmdy9aA/lJLTpMnm95Z4LpIj9HK+NjQ9R2s6XFn57kok+AkVeJ9xSkbx8FocF
	zHy0ad/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtki0-0000000Dw5N-1g9L;
	Tue, 11 Aug 2026 11:31:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkhz-0000000Dw5H-34t8
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 11:31:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C38CD600AD;
	Tue, 11 Aug 2026 11:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A141F000E9;
	Tue, 11 Aug 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447910;
	bh=4h7/hkwvCsY0fI00T2PR/Y4OZG0mhUElOQ2zn4pF7HM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=om8xJIfjsRUCvKibHk4AB92a86v/0sm2xMl+BtSmgoyg7QzhmHmd3v9z3YvwkioCW
	 9u/nZK6wJXKOBRJSadI/b5pqpyXdCXcN7dsJ9BaeaAZz90F1BIBA4twS1gV3wuBHJO
	 mJtZngYdB7FxDju+zrnYNhjNPFjwE8vD9dfqPU/3VUsDjvBzcsgX4U7GyWO21QietQ
	 +uDGaQz1ywUPS27qK7TYb35Ab1PJEijr+OqHQQPgoG/BBG0vdmmBqVwPLY/LGZtoQR
	 7NrPUAPpNv5bhHusvIMbXZwA2gJ2vJg4PJ/zmo8j6qYfhy4KZUMw6mp3S6iqu2krU4
	 1EuINsbUcsIhg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>,  ackerleytng@google.com,
  fuad.tabba@linux.dev,  Andrew Morton <akpm@linux-foundation.org>,
  dmatlack@google.com,  Shuah Khan <skhan@linuxfoundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  david@redhat.com,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
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
In-Reply-To: <anphyjFv3FhF61iB@google.com> (Sean Christopherson's message of
	"Mon, 10 Aug 2026 16:42:02 -0700")
References: <20260728121138.1103610-1-tarunsahu@google.com>
	<20260728121138.1103610-6-tarunsahu@google.com>
	<anphyjFv3FhF61iB@google.com>
Date: Tue, 11 Aug 2026 13:31:43 +0200
Message-ID: <2vxzpkzo51wg.fsf@kernel.org>
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

On Mon, Aug 10 2026, Sean Christopherson wrote:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> Register a Live Update Orchestrator (LUO) file handler for KVM VM files
>> to serialize and deserialize VM state across kexec live updates.
>> 
>> Currently, Only VM type (e.g. arch.vm_type on x86) is preserved as part
>> of VM preservation.
>
> Why?
>
>> On retrieval, kvm_luo_retrieve() recreates the KVM VM file via
>> kvm_create_vm_file() and use an atomically incremented ID for the internal
>> fdname, as the final fdname assigned by userspace is not yet known during
>> retrieval. As this fdname is only used in debugfs infra, This will not break
>> any UAPI.
>> 
>> This infrastructure establishes the foundation for preserving guest_memfd
>> instances across live updates, and can be expanded in the future to
>> preserve additional VM state.
>
> Uh, why guest_memfd?  As much as I want to push guest_memfd adoption, it seems
> guest_memfd should be the _last_ thing we support, not the first.  As evidenced
> by the last two decades, it's very doable to have KVM VMs without guest_memfd,
> but it's rather hard to have VMs without vCPUs.

You _can_ preserve vCPUs today using KVM_{GET,SET}_REGS, they just won't
run in the background during the reboot. This series can save you from
dumping VM memory to disk if it is backed by guest_memfd.

>
>> Also updates MAINTAINERS to include virt/kvm/kvm_luo.c and
>> include/linux/kho/abi/kvm.h.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  MAINTAINERS                 |  11 ++
>>  include/linux/kho/abi/kvm.h |  39 ++++++++
>>  virt/kvm/Makefile.kvm       |   1 +
>>  virt/kvm/kvm_luo.c          | 195 ++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c         |   8 ++
>>  virt/kvm/kvm_mm.h           |   8 ++
>>  6 files changed, 262 insertions(+)
>>  create mode 100644 include/linux/kho/abi/kvm.h
>>  create mode 100644 virt/kvm/kvm_luo.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a3ed337e827d..0283f0fd6ef4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14539,6 +14539,17 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
>>  F:	drivers/video/backlight/ktz8866.c
>>  
>> +KVM LIVE UPDATE
>> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>> +M:	Mike Rapoport <rppt@kernel.org>
>> +M:	Pratyush Yadav <pratyush@kernel.org>
>> +R:	Tarun Sahu <tarunsahu@google.com>
>> +L:	kexec@lists.infradead.org
>> +L:	kvm@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>
> NAK on taking changes through a different tree.  This is KVM code, period.
>
> In general, I'm skeptical of the dedicated MAINTAINERS entry.  It's extremely
> difficult to tell since this series is little more than a skeleton (either that
> or liveupdate is way simpler that I was expecting), but I suspect that maintaining

It's a bit of both. This series of course doesn't support everything
that guest_memfd can. At the same time, I also keep being (pleasantly)
surprised at preservation being relatively simple. For example, the code
to preserve a shmem file (via memfd) is roughly 600 lines, a big chunk
of which is comments. The code of course has some limitations, but it is
good enough for use in production.

> liveupdate for KVM (or for any subsystem) will require more subsystem-specific
> knowledge than liveupdate knowledge.
>
> E.g. the LUO APIs seem pretty straightforward; I assume the bulk of the complexity
> is going to be in knowing what to save/restore, and how, which is much more about
> KVM than it is about liveupdate.

I think it is fine if you want to take these changes through the KVM
tree, but I would like live update maintainers to be listed as reviewers
at least.

For one, we care about ABI breakages and versioning. The serialized
state is a part of live update ABI and changes to it should be ACKed by
us. For another, how the file handlers interact with their dependencies
can affect the behaviour that VMMs observe. Those changes should also
pass by some live update eyes.

So I think we should have a separate entry for KVM LIVE UPDATE that
lists the live update maintainers (or perhaps only kexec@) as a
reviewer. The patches can still flow through KVM tree but we'd get a
chance to ACK/NACK them.

Of course this all can evolve later as we see fit but I think this is a
good starting point.

>
>> +F:	virt/kvm/kvm_luo.c
>> +
>>  KVM PARAVIRT (KVM/paravirt)
>>  M:	Paolo Bonzini <pbonzini@redhat.com>
>>  R:	Vitaly Kuznetsov <vkuznets@redhat.com>
[...]

-- 
Regards,
Pratyush Yadav

