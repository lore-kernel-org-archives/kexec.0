Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571D3C5DF7D
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gq4c916t8aM4R9/gOTYj07vE672c6Dn+UdOcLkpJL3k=; b=J97yVNAG5lNscE7+ayOMl1h9Ph
	fZTX938VIe+8RP+f/BWMHUZWAKCU1c4MQztsVDiWo8O7jO/Zzxo+jq3TL3IKLunMZ6TYKcksR+URH
	qRee/l5kwWCvdjm0MuOjgoOe13i/2pt/RoRKT7S8LJCswSgCWyspufjPdRJiD443375CgwFePl7o9
	gZk0y7WDGkKdeyNpY8IaBdeEdH+N3N4a3HwDBA5GIr6IE1182LweTF53CJSz4eeV4klVOdBM5jxk2
	QEMACk6BSvBFDRk9poYRskvYwseMzDnn6ZNxUKFY0QwG7UAZ6YPV2srVH4GcdkroEddFY+x4L15Zy
	Dol/9HUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMPH-00000008KDE-0TST;
	Tue, 18 Aug 2026 16:11:19 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMPF-00000008KCh-0mTL
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:11:18 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c15d4224f9dso284488266b.3
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787069475; x=1787674275; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gq4c916t8aM4R9/gOTYj07vE672c6Dn+UdOcLkpJL3k=;
        b=I0bl4N/h5utsWK4dy07Sn5bEzgGJCdEDKxjaXWA+odFMqjjLNoSpaktrNYe4XVZDir
         O45+CxPhrzUrveLGFciwlPtB3erazvUhNY1H0G0rSiAzvn55hcxKdKl4Xqz9KcTeQuQi
         GaajbA4A8t3BWyQ07lW2rw+dMWfGUkwIYREjvvqwS3d3E9UEHpEF/6EdNJzBuMhbS0GY
         qFvAz3fHZNXdUQFNllrlGm+0s68V6QGSx+sAzaRo6L5K2PB2rCJ9Mcy1OWg+HKtmAlb+
         DXXtaGR9g0/vJgkJGFXkybbBnFWjLzPxftylSiyABBkjEZU9HOp1v7HnCfIe+NaN2zMl
         /mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069475; x=1787674275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gq4c916t8aM4R9/gOTYj07vE672c6Dn+UdOcLkpJL3k=;
        b=Q9aC9PUUXTkG7rqdVj/vql+d55JlW/jHp1vF+gf0NYTEBswtKmjXDkWcF1zIox4blf
         nXUzmaqYsyyL64jvA/y704hZFoZbWNWMlgLeBJOm4RmT6nsE2Jfr4Beo4EJYweb3y9nt
         7sYPUk0uS8XmHXr6tDXDcjyZTYsylXZt7f0k0sZiPdVOyNbasvY/3UwXZ6EDa9U/ys0O
         UOYeB9j+dPk4VQ6ts0bthidD2X0wvtQCEYktnSj8TdAEVP9VRducunYB+nWlUYj5Ix2S
         BnhWTmR6bBXSKNQ+6a82coMigTU8dfxT/ubMA0Gw0gJ3D25odsJcGVkrlpJ+hfwkmeLQ
         O6ew==
X-Forwarded-Encrypted: i=1; AHgh+RrAjLsoFMl/BErfOv+seLhVKexGNEa8d1QL0gfCJTAHrC19dGE0zce014lqjSWSe82XFDxknw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNzWHMYUJ2KEdm69BB8W0gAVSZeo/gkIeJzlugq3LUamoYSebf
	IMJMhjg4rKo75D00lAup81l+vteOwtmsJpAxR/OoxXghgrgbBvSoglop5iyLuaSWnkxLma5h6Gh
	XOc7VkFE8xJwu/y3IOA==
X-Received: from edrs9.prod.google.com ([2002:aa7:c549:0:b0:6a3:6b8a:8011])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:434c:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a38a8dbbefmr17632626a12.1.1787069474414;
 Tue, 18 Aug 2026 09:11:14 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:11:13 +0000
In-Reply-To: <ans2Qvo0453cc_DD@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-2-tarunsahu@google.com> <anpXjM_lg_UTpl0q@google.com>
 <9huzqzk4zt3n.fsf@tarunix.c.googlers.com> <ans2Qvo0453cc_DD@google.com>
Message-ID: <9huzlda3v272.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
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
X-CRM114-CacheID: sfid-20260818_091117_245692_0D97197B 
X-CRM114-Status: GOOD (  17.82  )
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

> On Tue, Aug 11, 2026, tarunsahu@google.com wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> >> Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
>> >> enables live update support for KVM guest_memfd files, enabling
>> >> guest_memfd-backed memory preservation across kernel upgrades.
>> >> 
>> >> Currently this support only guest_memfd files that are full-shared
>> >> (INIT_SHARED and no support for private_mem).
>> >
>> > Why?  Specifically, why do we need/want a separate Kconfig for guest_memfd
>> > liveupdate versus KVM liveupdate?  I can _maybe_ see a KVM-wide Kconfig, but
>> > even that seems like a stretch given that (AFAIK) hypervisors are the one and
>> > only use-case for liveupdate.
>> 
>> LIVEUPDATE is used in many subsystem. It is possible to enable
>> liveupdate and kvm without enabling KVM_GUEST_MEMFD. So GUEST_MEMFD
>> preservation must depend on CONFIG_LIVEUPDATE and KVM_GUEST_MEMFD both.
>> LIVEUPDATE_GUEST_MEMFD Kconfig is wrapper on both of them. It need not
>> to be visible in menu, So I can make it hidden. WDYT?
>> 
>> Also, KVM VM_FILE preservation and GUEST_MEMFD preservation both depends
>> on LIVEUPDATE_GUEST_MEMFD in this patch series. [PATCH 05/11]*
>> Which is wrong. So I will update KVM VM_FILE preservation to depend only
>> on CONFIG_LIVEUPDATE.
>
> Or just handle it all in the makefile?  E.g.
>
> diff --git virt/kvm/Makefile.kvm virt/kvm/Makefile.kvm
> index d047d4cf58c9..e6f098498795 100644
> --- virt/kvm/Makefile.kvm
> +++ virt/kvm/Makefile.kvm
> @@ -13,3 +13,8 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
>  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
>  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
>  kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
> +
> +ifdef CONFIG_LIVEUPDATE
> +kvm-y += $(KVM)/kvm_luo.o
> +kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o
> +endif

Sounds Good to me. Will take care of it. Thanks.


