Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E3EC5DF81
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eyzaZNjJLEyd0fKbeRAuoUQBuqF6sdPIInoyVaJmj0=; b=d5vtZ887bjvwcSUTBt514YRpAA
	6SbnTn9yA1c8c2BfmKtXIf6H/zoMOa9rEho0FZF1I1DF5z21ED2phQTPkR7mvYwQFcmBhnEMxNcsV
	RaeeiC0+muW1Kvp3urEjmj6BD+2Sj6WmxllEU4jli/8nseXHTPu7m02JPYAHxBKEgFPOTWMobFz9L
	+SEr5T72DVe6RAAYrenlWg9gngMTm1pRosWkOPikmb24GKfd4a+2Vas56FWeLVH6R8beDnWt0kfFa
	uO0nBREu/t18PJQD3hDMPaXntk9Gso2FhBFhGDrB16LIk5jshZeG0HhQNGYqlxHqf8j/n8MhE/RKx
	HY5Q1+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMhG-00000008Lef-3Ul0;
	Tue, 18 Aug 2026 16:29:54 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMhE-00000008LeG-1l5r
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:29:53 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a3f8cbd9feso21680a12.2
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070590; x=1787675390; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eyzaZNjJLEyd0fKbeRAuoUQBuqF6sdPIInoyVaJmj0=;
        b=TBMbl0atR8lzs8TXidgg/h07KILqkY9bEUrLAqrcp7dxD5EpF6lkRL9arTNMj1QL8u
         E9ufaRZUq9qnTDmbf4NPc7nOY/FW3N45gpe+0k1/I/N/FW8R6D8Vh7UNwYwY0uB/Rv8k
         wpSTcpkqI4hpXpi3KrMG3CQOCMxPbP2+SCrnB6Tn3coF+CcPi9H7EeZQ9FYEONbxwZzH
         UmZgRE0hC85ByFUEi7ZIN+XYAtc8s0BrnneGisbNPWsq6ddcHQWOkHMSjYf4gLOZc2On
         q8TMCPNfhWnUwQUj7HroFhNtdePItZ7+EYSHFSWo84J3u2pdQqMJ1rLYI/hIVDSkEahq
         yS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070590; x=1787675390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eyzaZNjJLEyd0fKbeRAuoUQBuqF6sdPIInoyVaJmj0=;
        b=UdWcKC8J9sSPuV4RhFuG/WvBIlWfiIkEZwpK+krvoI9Oh8C8pYvJZohw/ykjaHVUSR
         fQgutbMnxHONDefa3tKRmX4sVJoDSpugjBYrBbXxDEsANKyC/fMRDNMeo5XCAExifqmh
         NAM0LGioF/Hge9hTUMsNnXEoa56LJ5buYhJNQtfwCVVlch/LuWHIv3XjEIXEMtOKsdaq
         F/GnsMPNcyjcWKP3rvOISwvNO1odS9us/CNkIvbmXKlkSblXk5ixW/scP5JTQqQNcjx7
         75j/pR7J+Y5hR2vuAneNobBmw4UvTo6JlUYcN3DJtF23PolJdLQ8OnKmqFjB4mYsY71Q
         TjPw==
X-Forwarded-Encrypted: i=1; AHgh+RpKfRTcb592sIWjTmFTPx4u6amY/J1nX7pEMnAcwAvHwHZYTYL4diJ57V/0kvQdeKR/QX4JlQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YymlxwQvOTRVpE6Ix4JxBo4n6AwbylC6AF575BYHixTAxyzO5x8
	r5rYZd24oLGrxcbgKLpu5dLj4qeCebJMwJmSsrBj/pjjUCJ9OJxC07EfCNMzNSEDISwRzJOBvt8
	oZpjpNAatNS3jjKt//Q==
X-Received: from edts26.prod.google.com ([2002:aa7:cb1a:0:b0:6a1:f410:2ec5])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:e85:b0:6a3:edb6:2228 with SMTP id 4fb4d7f45d1cf-6a3edb6285cmr3681617a12.17.1787070589499;
 Tue, 18 Aug 2026 09:29:49 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:29:48 +0000
In-Reply-To: <anpdYD1UaO0ffQgi@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-5-tarunsahu@google.com> <anpdYD1UaO0ffQgi@google.com>
Message-ID: <9huzik57v1c3.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 04/11] KVM: Track weak reference to vm_file in struct kvm
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_092952_475495_46765931 
X-CRM114-Status: GOOD (  14.50  )
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

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> - Add a weak reference 'vm_file' in struct kvm under
>
> "vm_file" is effectively already claimed by vm_area_struct.vm_file.  *If* we go
> this route, I would very strongly prefer to take a dependency on "vfio: Use
> file-based reference counting for KVM"[*].  I'll poke that thread, we really
> should land that one particular patch long before the s390-is-arm64
> insanity.

[*] Seem interesting way to solve this. So we will also have vm_file
directly in guest_memfd instead of struct kvm and refcounting on vm_file
instead struct kvm?

struct gmem_file {
-	struct kvm *kvm;
+	struct file *vm_file;
	struct xarray bindings;
	struct list_head entry;
};

>
> Empashish on "if" because this all feels backwards.

> It's not at all clear to
> me why liveupdate goes directly to guest_memfd, but then requires a token associated
> with the VM.

guest_memfd can be recreated without having the struct kvm, Which there
is no way to pass it on retrieval path. So the function
kvm_gmem_luo_retrieve() gets this VM token, find the vm_file (hence
struct kvm) associated with the preserved guest_memfd. Now it create a
fresh guest_memfd by calling kvm_gmem_create(..., kvm). And populate
preserved flags and folios to this guest_memfd.

>
> https://lore.kernel.org/all/20260731130902.654679-2-seiden@linux.ibm.com

