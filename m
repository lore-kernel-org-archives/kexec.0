Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3321BC5DF86
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYCxMBx4BOPF4yBl5aKpfQIqd2cMC8x5BNz4F0URw58=; b=EfZ/3+wgncBH7wspQcpYj3Ttqn
	XrPRZq0/04+7Orl5wna8C7GvZChDCLGQT2dTL87A0l2DczEKZJLrOF/i2x3+SIECqwUhyx03FmfEa
	Vsuyr+4isMUTzJRkim+oEB/L4tV8K1Q1CQasBdgx/OLZPytzhwx1NsAE4KkXmX/+0pKf3V9uOT4ZD
	pQQmqpAxvPCnc8+ErifAyZ5zfCSGKa91UiWSWkuFhWKAA3qgm9XN1ssEnrf6pfDJQdGoaOMLIxwob
	GV3jWJ39yp1Bg++ztuxGijyfN0xeLxBXOGty5bnnXUrsL50tY8V+jcmVp1UvhRgdH9SdsMFMn1FdK
	sKDvkIFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMkg-00000008MJj-3yAx;
	Tue, 18 Aug 2026 16:33:26 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMke-00000008MIY-3nap
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:33:26 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c1c25c44d15so77765366b.1
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070802; x=1787675602; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYCxMBx4BOPF4yBl5aKpfQIqd2cMC8x5BNz4F0URw58=;
        b=fGkdyljMh4MqudWVWk3GaNena3RiQ8mTivDulO2doqH8VB4Tw+dtJxbD0VmvPfxiY/
         Qc9XeI5IXfVtCxpTm7UxP/bzaBQBASg8Uw/Dx7hEBU+9vN8JBB556WHuHF7+pMhQOO6t
         k+vj1d2zEIZJm99BK7YTRUzyetZbFGywyQhHaNAEDnmFmcxdAx/ZPcY2D+P9R1fRKO6I
         lwsB9aHdyS6HicgUpIIEjMsqXTXOntf5y+k2betCq0019dMqN816k7cR724zXJIbDhbd
         bDj7qL6VJOxFb0ftG3Mc7Ru7NF3CsrR9iuiQK4QyQvnODSgkwr3SP5VVwjsggQOs8VpV
         VX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070802; x=1787675602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYCxMBx4BOPF4yBl5aKpfQIqd2cMC8x5BNz4F0URw58=;
        b=jTYIqa9lx242R2gbLoXt3DsF9gfsjxrsvvkK7ne4xwnx0oCLPEfliDA7krUKHwKduv
         iOBM6tyNat4LgIa1fiXm6eGlAWQer4og84A2d74ruIF+ZYa7GX3boyN/vRNY3CutHeSx
         OZYxVihxsd7eIz7KajrtHrXMCt1RkjZ1n515gLkf0Koq3Wxr5q3qxkL89iZZjBWHKQ8s
         kql3t5fPTYtRoGaBpjSDQqg5dW2eWOvAwuXz4h3cUN1ht1ZaNyz9UpEQL1yUoZqn/TTc
         5IvsksVfj6yC+F24UOuRp+UvZ1OxvgRTAFVSm3vcxb/4Tq9Q8AzCFQNSdHKKyExIsy7k
         4OXg==
X-Forwarded-Encrypted: i=1; AHgh+RobV1US7sZVz5JcfFURgQhWRjn0Nzsnf7ZURofyzkqxFI8kgwGtODBCZp2aW+05l8MceKq+fw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmkX8HcaRtQtuRkfVmT8wyfXdXDffQ4AEmewSEqc4c6k1aTTG1
	0IM/rnk7rSMQ0GbWcOTlT6lR0YwMK7GoMTNUh9FnW2FAV4+kQkCBcIUbUStOq9SWgm/zOcy+Ez0
	i0vn0I59yKo1B758v2A==
X-Received: from edea16.prod.google.com ([2002:a05:6402:a190:b0:697:8356:d9d6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6938:a091:10b0:c15:a487:3482 with SMTP id a640c23a62f3a-c2188a9df89mr438613166b.21.1787070802257;
 Tue, 18 Aug 2026 09:33:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:33:21 +0000
In-Reply-To: <anpieno-RyRl54fp@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <anpieno-RyRl54fp@google.com>
Message-ID: <9huzfr0bv166.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
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
X-CRM114-CacheID: sfid-20260818_093324_964936_5664CFAE 
X-CRM114-Status: GOOD (  12.05  )
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
>> +/**
>> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
>> + * @inode: The guest_memfd inode.
>> + * @freeze: True to freeze, false to unfreeze.
>> + *
>> + * This API is used strictly during the live update / preservation transition
>> + * window to prevent host userspace and guest-side faults from making any
>> + * mapping modifications (such as fallocate or page fault allocation)
>> + * to the guest_memfd page cache.
>> + *
>> + * Synchronization Strategy (Sleepable RCU):
>> + * To avoid high-contention VFS locks (like inode_lock or
>> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
>> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
>> + * (`kvm_gmem_freeze_srcu`):
>> + *
>> + * Global vs. Per-Inode SRCU
>> + * ======================
>> + * A single system-wide global static `srcu_struct` is used instead of a
>> + * per-inode SRCU structure to completely prevent unprivileged users from
>> + * exhausting the host's per-CPU memory allocator. 
>
> This argument doesn't hold up given that each kvm structure has two SRCU structs.

Ohh okay. I was very skeptic that per-cpu structure are not counted in
cgroups and liveupdate is once in a while usecase So avoided making it
per-cpu. But otherwise I am fine with going with per-cpu. Will take care
of it in next revision.

Thanks
~Tarun


