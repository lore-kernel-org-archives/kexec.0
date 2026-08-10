Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E887FC5AD7B
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lgf1v7ZyMRecW6GzYu5RKpdf3OAqJ1cTW2eoW0KSWKY=; b=STnjRWCFYNn2tJSR2PLNA+ld9i
	85aL0rhIa4tHgZ7VdxLwUOb5LAOsJaSqbMwUv5a431gAOyUyClgOUEyDEomJNYIGttZMCEqp7SDCp
	J7sDw3G1W+Ni5dMtxcigq+gPrX6m2ntxcPzwTk7FxhDEBWocvVelGllOFst09vvN3o920vBzBKSmC
	q6FP6+19KuQEwPshnEsprFVHEcxTT+IaBL0kfgIqqJA3KiRJ6lzvMt9D4NKbZHulBdTupE9N/AZ52
	wQng2xNIMs90HbDhswvO5OTrGmj1ErebWb9Q7M4TL69kNzVd48XtW7htq78+jNFTXeOQtzzd2qdgf
	J8xcdYSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZhN-0000000D2yb-3pfL;
	Mon, 10 Aug 2026 23:46:29 +0000
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZfx-0000000D2xx-07ue
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 23:45:02 +0000
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso214639b3a.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786405499; x=1787010299; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lgf1v7ZyMRecW6GzYu5RKpdf3OAqJ1cTW2eoW0KSWKY=;
        b=VEv2jLTfxIU8ZJLAz0C2RsgS/koOp5BfkWnji5dxm80QVxeQMmbnwswMkpEDfdQdz4
         dxr6j+JfWbx0yONaFjIaa0QIx8hY0R1YLYGLlV7jP/OYkPJYW8CSigkEk/YzpzwD6c7r
         RbRGthD+omAHlRRz8CaMc9V0H25TszGRkjl347IsckL5i0H3nsss0c4IRkzZ3Czk4uWg
         l9We25W+HK5zApWCgM4igYguYNVAAjstl0UUSvla2D4CcTg2c0ZrE1GOiY9qq/IZTRgc
         jRPapUzBoEi6xwfXSFCfiocMk+tbmzlYC1x+D25UAUMH222D4nhSHCkUMW2MByq4R3VG
         Llrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786405499; x=1787010299;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lgf1v7ZyMRecW6GzYu5RKpdf3OAqJ1cTW2eoW0KSWKY=;
        b=oCMB6tfurj3UefGIM4jkJvJtB22uhDWfLVfgItUlGbdoiIg38wy6jxcZyXmTdEC7kc
         itov3ZJgNSLPUnwjfx6h5xX+aCIDQCZR2rAf1tgdOPpb3pzwsiwcc6dhCaC6seEqXgZw
         La687UF2DeBC942dbpovjtXy6qSd2tbUA9SzhcycHtpdNiTcDF5KH6OepvRS1lKTYd9C
         fJJUChfNS1URhyN5RMjehqEc5iqMd0k8xGVWqxVEOgh/c7lLXLFLxr/ugZtKnx8Uejn6
         o6EETqHJ7QgR3fvx0NCZ52PpGzwYlWPdtgv8c8gD39zfF1jco+YnnLJQcNHFJk7G1+a+
         Z0VQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4prGL3U2SCQgBF9YDFuGmwB9S86GeKlXw7Wqi7xyLraxG0DEagIjltLbz5JxInU399meUIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrkSjufoi+FZRgIlAf3m38YiXGDJcgSyryhcZBtFqYRhNOPDgP
	13GY+R+/lCcvbM/KztMKxZV99sHM1cYXOqAKbVsUEPU15v9UENnrsKu2QTarl99myW6ytYfPlXx
	nD5dCqQ==
X-Received: from pggg21.prod.google.com ([2002:a63:2015:0:b0:c9b:bdf2:2507])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178a:b0:845:e97d:447e
 with SMTP id d2e1a72fcca58-84f2e040170mr49815116b3a.26.1786405499340; Mon, 10
 Aug 2026 16:44:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:44:58 -0700
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
Message-ID: <anpieno-RyRl54fp@google.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: Sean Christopherson <seanjc@google.com>
To: Tarun Sahu <tarunsahu@google.com>
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
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_164501_072871_F225692E 
X-CRM114-Status: GOOD (  12.39  )
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

On Tue, Jul 28, 2026, Tarun Sahu wrote:
> +/**
> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
> + * @inode: The guest_memfd inode.
> + * @freeze: True to freeze, false to unfreeze.
> + *
> + * This API is used strictly during the live update / preservation transition
> + * window to prevent host userspace and guest-side faults from making any
> + * mapping modifications (such as fallocate or page fault allocation)
> + * to the guest_memfd page cache.
> + *
> + * Synchronization Strategy (Sleepable RCU):
> + * To avoid high-contention VFS locks (like inode_lock or
> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
> + * (`kvm_gmem_freeze_srcu`):
> + *
> + * Global vs. Per-Inode SRCU
> + * ======================
> + * A single system-wide global static `srcu_struct` is used instead of a
> + * per-inode SRCU structure to completely prevent unprivileged users from
> + * exhausting the host's per-CPU memory allocator. 

This argument doesn't hold up given that each kvm structure has two SRCU structs.

