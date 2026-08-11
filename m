Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93600C5B572
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W70NQ8qweOhk0vfOOOPEvDwhbPTM+yme1ctvOdIAjTY=; b=acGE3+E3m7A5ZZcOSDA0Tf0/ls
	3AMuZNUaoDblIUbcTHx+mdjIh+NGhMA7hWwCHtyDIDqn7DDwtvI7XGbKwEfvSewXvnmmJjJYBFLSt
	HxX2CFwY/3gEBiTQie5jBYuoMp2OEk7wern6fp0ob2d59RP40fV7QFvz/S0VNqdzAlwOjUefbYd3Y
	9LMUdW20RFJgmKUdTy4wDQ1SMumV4LehfTJd13e1ZfnxtYZDTi3uKDL/x1/7d4mpN70IE7Rbh1efP
	Ieb5N6Nm14b35UivE5nBFj80M0du+dX5PK+HgZ3/zsw9YcezWMS6scaT+Pa06m/NE0tDXOU9xI53W
	i0FEJemw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmUf-0000000E6OE-1fLt;
	Tue, 11 Aug 2026 13:26:13 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmUc-0000000E6Np-0SrN
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 13:26:11 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c160b9c0676so198298166b.0
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786454766; x=1787059566; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W70NQ8qweOhk0vfOOOPEvDwhbPTM+yme1ctvOdIAjTY=;
        b=ojNpEutAgiqMx9CZfYp26cXQV14XHdpdqnLx6i/ZZdLQaqdUcQfu2ki5q2eOtg9NDW
         SMuqY07vu7JhU46KdO3q5nvZua45IlXtZSM16ClPXFvsZ040afu0NMTGXaAR+3O9ydiO
         DDbbzzrS06JGSoEMLzPbSa//cW7IAAOakBGEHPHjilxCg19R/sKD4tSoj2Z7NABmChmr
         lE3BDJrWe7X1OtY4UZYY8i20qo+rePruKL5kTaYAYMaPLmLC6XlS9AOfQ/XmZc1jtQlc
         0Y9Nv1QR774thtHjoeI/y52iLrK5m/k+zW0ziOQrOWIhRFXmVOlHS4zstCFuOtFo5z3b
         WffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454766; x=1787059566;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W70NQ8qweOhk0vfOOOPEvDwhbPTM+yme1ctvOdIAjTY=;
        b=aMKCoidaQQ+O4Yx3VZpgVXpKyD+rW4LB2qwTjOBOIBoEFhcI8s1o4LGQnhlNULxVse
         5zbDMfXK5+6dt98xbYR7doWQgQg5lIP7q1uB+yes01TIVFdswb9nLiTcVhdlJpGIdVWp
         uGPrYbPN5xZ/Bsw/mHiDbPpeSLfaihPjkx3iC9bRl5uNYWZu3qtSiibHrXDoH1ozqB5V
         UmgYBHooyIL5/197f6928VD2YlczlgLtUllmHJqj9AFobWH6r7RYbe739zRHTmhpT/Rd
         T6XoClsjGdR4+LDj8wzEpnvi7tqm5yDl07Ans15ifu4Tuya6UheiYR3ndzlOV5TRWoUP
         ZUUw==
X-Forwarded-Encrypted: i=1; AHgh+RrYgUCYrrGrXo4LJCa/39Qd83CguPtQ0NW05Nb7Spfqs2dK4RBowk/M0WzjIGtRzkO9sWiFGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyrcbvPCu1HfxruQqxBKws+/JbMqVkXH9VUsSy4nBLcmxnv90Ri
	tcazo5rU43XCHV9I+Q1mpFfRH1kf0I5fMf71L//xItjTVw8nR7pB95Om0rXZlv4wWxhZsJep1Ct
	D3oAwgSmm1GA2YnfOug==
X-Received: from edqs15.prod.google.com ([2002:aa7:d78f:0:b0:698:b78e:8827])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:158b:b0:6a1:e59c:62c6 with SMTP id 4fb4d7f45d1cf-6a364525fe5mr1952585a12.18.1786454765239;
 Tue, 11 Aug 2026 06:26:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:26:04 +0000
In-Reply-To: <anpXjM_lg_UTpl0q@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-2-tarunsahu@google.com> <anpXjM_lg_UTpl0q@google.com>
Message-ID: <9huzqzk4zt3n.fsf@tarunix.c.googlers.com>
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
X-CRM114-CacheID: sfid-20260811_062610_157466_1D56D22C 
X-CRM114-Status: GOOD (  11.41  )
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
>> Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
>> enables live update support for KVM guest_memfd files, enabling
>> guest_memfd-backed memory preservation across kernel upgrades.
>> 
>> Currently this support only guest_memfd files that are full-shared
>> (INIT_SHARED and no support for private_mem).
>
> Why?  Specifically, why do we need/want a separate Kconfig for guest_memfd
> liveupdate versus KVM liveupdate?  I can _maybe_ see a KVM-wide Kconfig, but
> even that seems like a stretch given that (AFAIK) hypervisors are the one and
> only use-case for liveupdate.

LIVEUPDATE is used in many subsystem. It is possible to enable
liveupdate and kvm without enabling KVM_GUEST_MEMFD. So GUEST_MEMFD
preservation must depend on CONFIG_LIVEUPDATE and KVM_GUEST_MEMFD both.
LIVEUPDATE_GUEST_MEMFD Kconfig is wrapper on both of them. It need not
to be visible in menu, So I can make it hidden. WDYT?

Also, KVM VM_FILE preservation and GUEST_MEMFD preservation both depends
on LIVEUPDATE_GUEST_MEMFD in this patch series. [PATCH 05/11]*
Which is wrong. So I will update KVM VM_FILE preservation to depend only
on CONFIG_LIVEUPDATE.

*https://lore.kernel.org/all/20260728121138.1103610-6-tarunsahu@google.com/#Z31virt:kvm:Makefile.kvm

~Tarun

