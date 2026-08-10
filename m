Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5021C5B56C
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=; b=RGohSXIWsDC34pYKyuJhBRoevi
	YWRkubn5dj8GsVr4aje/h2KnDIgGV8MPrBRIMYsb+LFsbswh2PST/eMgk/Dpwo9wC1LuIIcC8T18k
	18lAUWpB2NT62M3fq/8WlZ8KyqSmTqav/cQJA3WInCij+iIuesX6oh4VkMMQnYyXNTwbKao8qvJTe
	qkIUyFdUGgNPYFbThjPk9hhbKbQWbCya7MdPdh8A5RfZBqInaYz+mRfkE3ffHLquMsbhY4XRaCh7K
	a+DOgaf45ukyy0i6y21FjXT6oTu8PRpOIGkLHV3A8aKHHfrvyaE5Crfz3kd5i4HNedK3n0T7POvB9
	xV73pLBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPrH-0000000Bszt-3TDX;
	Mon, 10 Aug 2026 13:16:03 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPrE-0000000BszG-39Xu
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:16:01 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c1f74261f67so172260766b.2
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367758; x=1786972558; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=;
        b=D+ZEF9liBw/PoV6JIbBM91Y5hg27XcKvS3yRvq0fHne4h64C4/cgiB/rYXBd4nZSOv
         8PyhTTKl3FeucxmvGG/thZqb3v//LckwDXMMYymo78/+1wkDwXZdPUq54Jln17r3Bf4D
         wQxamKhDfSJtizv82edNkWOz81Z3w/CL9cxQG6Pb+EZjSq1zJ0ouGAHm/QZU4ZxmhcO3
         nH5+SJPNhEzJ6iVwit0viHekxDrw8IwfwL71+cGbPu534CfIrZ+mNuYYbEOojL2NQGoR
         kjJpFXfVSwkYxuFTRA4ts2gTXkx+l6w5avCl3LEzIv3ePXUPp0wfqKL8b6LtlD8VwuSO
         XbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367758; x=1786972558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=;
        b=WqHisLAl3cUL+y6WYMNDq3dhJZncQZbEEExYWgYBv/qZcqYB9djRBbxKWLpOcRrV0o
         SlyRXoyLLnceI2cWpeKS8Wjoa8FI6Pp9fAUKYW6TQOWOd0xrXXg9dXAdjGLQTlu9TpMy
         i1po06mMUTWluoQxnKSYuA7CpxMiynx0MaFVguQHz80R/3pzZvCStdfNCVZPkhWFPqfY
         IeXuHvfG7zOPuZV5nKF5ylrSoGAVf7oNgMAZkDrJ9rIFibKLbIojkJpLsqzzBsPAJzMj
         mTojPmIo3NP/3uiK+zzMbtSsiUY4Y9YTI2qXLVPGdGEWXpn4ShGygVFjAXLjmJubhK/j
         9e5A==
X-Forwarded-Encrypted: i=1; AHgh+RoExp/YZeYB8JG11PayGPLrhy9tE+xALQYr8HUKedipSL8NxLzDDnHsUmE51hlH2bDBMEptog==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxuyb3rpjXFdZcnNxWlOLscNoOp2ror6EV8r0Ofoh/tKgyM6nqC
	ejjUpeMnRYyG4IYxcscKFkMTVyS2d6i+bpffR8zO0IVbB/8QWzcZPUD5a8Msv66w2mcPBHNxEV8
	Dj5jzMhn+aCBgtTtUFg==
X-Received: from ejcww4.prod.google.com ([2002:a17:907:a904:b0:c19:52d4:dc8f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7955:b0:c1f:5f64:1912 with SMTP id a640c23a62f3a-c20c68b9233mr86192466b.7.1786367757496;
 Mon, 10 Aug 2026 06:15:57 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:15:56 +0000
In-Reply-To: <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
Message-ID: <9huz4ih286b7.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_061600_805919_2C91814A 
X-CRM114-Status: GOOD (  11.57  )
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

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Introduce kvm_gmem_freeze() to freeze a guest_memfd inode's mapping,
>> which prevents fallocate() operations and new page fault allocations
>> during preservation.
>>
>> Use a global SRCU (`kvm_gmem_freeze_srcu`) to synchronize freeze state
>> checkers without incurring per-fault locking overhead or risking per-CPU
>> memory exhaustion (as per-CPU structure not counted in cgroup) from
>> per-inode SRCU structures by faulty/compromised VMM.
>>
>
> I wonder if everything to do with freezing should be gated behind
> CONFIG_LIVEUPDATE_GUEST_MEMFD. What do people think?

Right now, Only liveupdate is the usecase. There was a discussion
around the future usecase when IOMMU FD can use few pages from
guest_memfd and will have to prevent punch_hole operation. But
that will also avoid new faults. So freezing is not the solution here.

A SEAL type solution like in memfd can be explored later. But this
is very far in future so Plenty of time to discuss more ideas.

On gating the freeze across CONFIG_LIVEUPDATE_GUEST_MEMFD sounds good
 Idea. As in future, there is a plan to remove the freeze at all from
the preservation path. Before LIVEUPDATE, there was no usecase and in
future, that usecase will also be gone. So gating it against the config
makes sense.

Would love to know what do people think?

~Tarun

>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> [...snip...]
>>

