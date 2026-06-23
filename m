Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FEBCDB46F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pndzfg2mCWavHm/LZE4HxmOjSPKqkdyz2Mxcm9023NE=; b=hScL9eZU0ZiL4/dr3Bl+OFSbPf
	a6RwBHhouz+GUZEoFeJhvxyhD+S1dSmrgA3CAcmwwCs5/sJPDeWKpav9tUUfQ6sZYuMyPdgedO3TR
	i/BzqEwiol3XrzMX88Mi9Q7MR8X7tnnFql1SROHW0TBshN1oKSaGFlRAJbMCXF6cz5qKPESkYV/kV
	+CEFyDrnSMjEUx0f3xH5JxyTYV+v6XajiZ1xQcTWLf6y8Xjdwmh7sz5SNmuPrhgduzHHfRO+kAXb4
	8S6VGTiNVdjA+oOdeu7GMk/QhhtUa/0I1BQzIOpV0U5eCufycIWNvBDBveTdMYl1W4EjUpda2+roQ
	ZlwKgEjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1j2-00000006On5-3OLa;
	Tue, 23 Jun 2026 14:03:40 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1j0-00000006Oma-3iPg
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 14:03:39 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-49221de4ed4so37960455e9.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782223416; x=1782828216; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pndzfg2mCWavHm/LZE4HxmOjSPKqkdyz2Mxcm9023NE=;
        b=srUslxiOgEgRnfDCYRDjPdmWEqHfs9liWG0HEsa2dkQXdCTUyhMDWQhjGzt/ybi2Ld
         k4GIOUctS94wHj4QVMmBbboEcl50CBYwz2AKxBVSm0iZTlx3CdOnJzFd5QpSDKwl9TCU
         1CHUn8LbURWVhx0iJrrKftzxgeJ8QcNhDBGqq7t4YGAm2QTGfhtFRfjHg1MF3uOMAPKX
         UvueFJNp7Nz3fOQ/ZglVz+0aaD2WonDiYSE9sOwSPoFnLgHx5vMUNEWABAjDp+9IX7Z0
         78nl/EweMRbv3og3tYhRQh+lcD/4tUKK0J+O7cM8JvqU5QF7LoV5FYicub0yUGgWlMqk
         xsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223416; x=1782828216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pndzfg2mCWavHm/LZE4HxmOjSPKqkdyz2Mxcm9023NE=;
        b=Q1H9MbFAn/i7cA65ze6tQYnbJwIE/5nnC+OxkPnoIH4v15Kxj3bLCjjUYXBPpGu6fJ
         qU8ZtLEiyMgsJizISL8as3VMLq0/Hdf4KcNgGJ8s3BZzus04Ki85fmW2fiS1UNF202j2
         WvI3swirlGiZ+1nCbvEFFpG81vCNUhqsN9vLhSg50L17PMQyb20wVR5FQklziEtcu15P
         jQTGwLqeY3kyZZhTLWQpooBlIc9jVyzld+Kixmkb0ibPeMdzicS+3ZnDvnaEEFc48fhB
         yfJvrWtvmv5XJEkRS1gjAYrNUSp/BeucTeShrYWYGcwYEbI+ckmK9Z3a0ouFyh+MiG7Z
         ZeDg==
X-Forwarded-Encrypted: i=1; AFNElJ/GJHnEW+pFUBotsRsdV23sfPwvjUfF6qUrcVs/nlDibv5mnZb03HHC7pcqMLb9gaXcGjVAMw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGmsLbiRQjNXKlC//W+8oka6ehC2hHmcPOz7wzp+kkiM4IT/Pz
	s2duPzs0ZOg8qHk7qApoGWXO1o7B+FQ1bAw4mP7E3Da1akJdGt+hL/TSnOEvI0Xv/uxzaqYw4nf
	bxaeM8J6KgSkPs8LXhA==
X-Received: from wmo12.prod.google.com ([2002:a05:600c:230c:b0:492:346d:8d96])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f0f:b0:492:3214:cbe6 with SMTP id 5b1f17b1804b1-49240e7f6f2mr330026535e9.23.1782223415994;
 Tue, 23 Jun 2026 07:03:35 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:03:35 +0000
In-Reply-To: <ajnOnzdknfwbuJ9g@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com> <ajnOnzdknfwbuJ9g@google.com>
Message-ID: <9huzwlvpmk08.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, dmatlack@google.com, 
	mark.rutland@arm.com, Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, axelrasmussen@google.com, linux-kselftest@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_070338_942759_72039390 
X-CRM114-Status: GOOD (  11.18  )
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

> On Mon, Jun 22, 2026, Ackerley Tng wrote:
>> Tarun Sahu <tarunsahu@google.com> writes:
>> 
>> > This patch introduces the freeze on gmem_inode which prevents
>> 
>> Can't find the reference now, but commit messages should take the
>> imperative mood and avoid "this patch" [*]
>
> From Documentation/process/submitting-patches.rst:
>
>   Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour.
>
> Documentation/process/maintainer-tip.rst and Documentation/process/maintainer-kvm-x86.rst
> elaborate more on the preferred style (I do most of the guest_memfd maintenance,
> and so for all intents and purpose it's bound by KVM x86 "rules").


Thanks!. Will take care of that.

