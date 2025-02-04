Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2555AC02197
	for <kexec@archiver.kernel.org>; Tue,  4 Feb 2025 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GFdQhGirlKFkv6SspInQshhQMw1bVlSUURS7hK7cLdE=; b=D4vAOShoIng8YRAW0k8/UfcoK9
	UcRIIpYMYL9Z6XwOzUiC07tKYz7zoCivfTIaWWTwUTXuVG7QjSSYunLWLbqKSIsHFDOpO8b2QAYsG
	btQgHWCKCQGmjzxOnZBhY/AmfPOlq7l3sZ4I5YualjewEBz/+SGoKZZQst2BKBc44M47ZD+QiX1Bo
	jsR654te7ys8pm/9G8+tYJnk03r0JpzRTH/NdBNcNM/qTyUA990Te4PfAaIdn2IdgYpFElZUHvwwz
	t7qPuwJ79cC0a3tZDeR/e+3Tr11+bCZZhkuUxABlHONeT8IXOND6Zq4HkiqEMvVJyv76UXX+VOfBd
	QbDuUjtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfA6i-0000000HCvh-1ny3;
	Tue, 04 Feb 2025 04:00:16 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfA6f-0000000HCv4-3auG
	for kexec@lists.infradead.org;
	Tue, 04 Feb 2025 04:00:15 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2163affd184so39935ad.1
        for <kexec@lists.infradead.org>; Mon, 03 Feb 2025 20:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738641613; x=1739246413; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFdQhGirlKFkv6SspInQshhQMw1bVlSUURS7hK7cLdE=;
        b=BtL8n0s1LYZD57D9T8yta0o/7dHRoGbLpPx4ZFFHpR+b1tdLoBmuUQe4F2SFB1Xiye
         Fq/hVOiob9ocPqp0n4B9yNXitPDxKCIFG10Ja9K2RI9hx19QdYW1hBgflW6ZNUn0pQzq
         iJjHchPixeqxxGsDTRx64e2MU6RpRM5cvxKhxDabLv43kaDjJEfHSpv6GPpejRbwOCUD
         Ru15FLj94azVKqBxXRMv4IkubpaaCRlE6r8+cS30NV5Q+qaw9geSisNplgy3sJpJMj3j
         Tt/KSUounFjwgHvaVpB7c1W5TVASqPuWhFfhavL6CtKXHQ3xRLvhK2UKCg/iaIVwTk/N
         c5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641613; x=1739246413;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFdQhGirlKFkv6SspInQshhQMw1bVlSUURS7hK7cLdE=;
        b=LG7smPn4zyNH/E+8TZt678WVq5ng04LmEnE1vEKYInDJ3EXikfZ0BYodfJp0OWEnIy
         UBRlyZ2WxyMLkBalC9SxZTkrd1jXZRSMiwdYi98YTMKnaDo+PfPTVRHp79dJ157BdUXl
         t0k1j6Fx6wCGxgQVvuoBjaBco8k9zmQs8b3bg36/CmUyR5LoAVbbvR3fhlMJAuWUW3xS
         h+jQumeZcC7sS/UhOwVWB5dh4Ngtu+WDhHjKBW6WzXFDm3KzRtWH0aaNNkcU69vJkHXO
         lmoEWMjrT8G8sXdL/SRLvv4MGBiRr73e1RccSVrtc5Ok1eyhLhyG1grjHjUccb29DKsL
         scoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv8bNQKWCe7o98VfB/UUJaig68P3PJrORIBpXtN1c7LILX30kvB/NLMUDgZ2+NnkdflN4uvw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzbWZCGb/5o9YJlEevVAmfmDdEOJ9XzrGlMABqsr2zwi+1tZyz
	nx2CpZ8+VKjg7bVHNFiv4SXOqhFh3BFxyj4KSTWu30wPdwgCHMO2b19Ehfih7w==
X-Gm-Gg: ASbGnctFKt4mjoX2vEJyvebQWnUuOq3IzDvOEZrzH289YMkelufH92Cy5J+xvjuO9ES
	yDH3Z4X6U5Wnd0sxEX8EILsV4nCvu4NfT+s5qKpnY4Kz9AM4vTlTLCapL9r9rBpyrZdLtH++JtN
	fahLY7+BeYVbMKfS1UJ9ZGRqCBbcVBPnxtDxmXw7XQytWFygVoiw+YD6Q84kLOdHX666JCJ+PRO
	Jbnz7ttc6Q+zPgsrPC4uBLJskdpPbi+XacDHwDAmoca1jWTWG7O3U9hasVa65NUVNA8d9AKcZHN
	Bs5BCLMrkF84EvkUlD02vW5u97nk0u8Z+9SuZ7IUlqbjZCv23J3JWwK26nIdYgBjbOaNj+LETaB
	ZIo4DobFODw==
X-Google-Smtp-Source: AGHT+IHS9Kq2kj1R8wYY+KP/a5zdghZPF6LytpK2VuTrqxReA4Envd5jDikCxeZV1geusqrivtuEvQ==
X-Received: by 2002:a17:902:eb83:b0:215:aca2:dc04 with SMTP id d9443c01a7336-21f005bbe49mr1613695ad.26.1738641612613;
        Mon, 03 Feb 2025 20:00:12 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:62bb:5433:88e3:2227] ([2a00:79e0:2eb0:8:62bb:5433:88e3:2227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cf042sm9282202b3a.152.2025.02.03.20.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:00:11 -0800 (PST)
Date: Mon, 3 Feb 2025 20:00:10 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from January 27, 2025
Message-ID: <26a4b7ca-93a6-30e2-923b-f551ced03d62@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_200013_923187_30E08C49 
X-CRM114-Status: GOOD (  30.19  )
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

Hi everybody,

Here are the notes from the inaugural Hypervisor Live Update call that
happened on Monday, January 27.  Thanks for everybody who was involved!

----->o-----
I talked about the logistics and goals of the biweekly.  If you would
like to be added to the calendar invite, please email me privately.  I
can also share our cover letter and shared drive with you that contains
recordings and slides (if any) if you provide an email address associated
with a Google account.

We also discussed the scope of the biweekly series to include:
 - KHO
   + Including potential early adopters (hugetlbfs, tmpfs)
 - Persistence of PCIe devices
   + IOMMU(fd) persistence
 - Guest memory
   + Including Confidential Computing use cases
 - Reboot optimizations

----->o-----
Mike is planning on sending out another KHO patch series, likely this
week (v4).

----->o-----
James discussed work last year on iommufd persistence and hooking iommu
drivers into KHO to persistent their state into kexec.  Feedback
suggested setting up new page tables and then transferring over after the
kexec is completed.  James will start implementing this on top of his
existing patch series and include qemu changes as well.  To minimize
downtime, the plan was to resume the VM with the old page tables.  He
suggested userspace would initiate the switch to the new page tables.

Jason noted KHO has been too focused on preserving memory and needs to
preserve file descriptors, we need to take iommufd, freeze it, give it to
KHO, and then pick it back up after kexec.  When you're done with it
after the hand over, like an atomic attach, then it gets destroyed.
Jason also noted we'll have to consider preserving vIOMMU state to
support latest NV hardware, which is highly complex.

Alexander Graf previously developed a concept called fdbox that turned
out to be very intrusive in the kernel.  Jason noted that all of this
work will be invasive, but we should prefer to compartmentalize it as
much as possible (like for iommufd stuff, a kho.c).

----->o-----
Pasha suggested KHO should be kept as a mechanism to preserve kernel
memory across kexec, the serialization requires different mechanisms.  He
plans to propose separate an API for callbacks into drivers.

Jason noted it was going to be critical to provide a state machine that
we all agree on, including for definitions.  One aspect he would like to
align on is whether you could put a guest_memfd into an fdbox or even a
tmpfs into an fdbox.  Mike Rapoport noted there are multiple layers here,
where KHO is very lower level and fdbox is built on top of it.  Mike
emphasized it will be critical to establish a format between multiple
kernel versions that will be standardized.

----->o-----
There was lots of discussion on stable ABIs for allowing continuous
upgrading of kernels without requiring a reboot.  Jason suggested
upstream can provide a mechanism for upgrading from 6.12 -> 6.13 but not
6.16 as an example.  Doing any version -> any version is much harder and
likely cannot be supported, at least in the short term, because it's so
invasive.  A good example would be for the mlx driver.

James and Alexander noted that we must be able to rollback and this can
be enabled by the downstream customer, it may not be a burden on the
upstream kernel.  There was a general acknowledgment that upstream pairs
must be supported, but much of this could become the responsibility of
the downstream user.  (Alexander noted some users may care about mlx,
others may not, for example.)

David Woodhouse inquired about rollback functionality and how we would
support a VM that has deserialized after kexec using a new feature and
then still support a downgrade afterwards.  Alexander said it was
important that the user of KHO supports very controlled A->B environments
for this to work properly, and, if provided, they can control downgrade
paths as well.

Dave Hansen noted this was similar to discussions about checkpoint
restart and CRIU.  The burden in this case may be very similar, that it
is taken upon by those who care about upgrading from one version to
another and that it is not a general upstream requirement.  It was
acknowledged that this will be a ton of work to maintain reliably,
however.  Dave noted it will be important to socialize the work that
needs to be done with upstream developers, but that the work will be
taken on those who care to use KHO.

It was agreed on that once you roll out, you enable new features only
when you are confident there will not be a rollback, and then once the
feature is enabled you've passed the point of no return.

----->o-----
Jason provided a nice early milestone for KHO work: demonstrate a kexec
while the VM survives and the VFIO attached to it survives.  Pasha noted
this has been done before with PKRAM, but needs to now be done in a way
that KHO would support.

----->o-----
Next meeting is scheduled for Monday, February 10 at 8am PST (UTC-8).
I'll send a reminder on this mailing list.

Topics I think we should cover in the next meeting:

 - LSF/MM/BPF topics of interest for the group
 - v4 of the KHO patch series sent out by Mike Rapoport
 - iommufd patch series (as well as qemu) sent out (hopefully) by James
   Gowans this week, otherwise a week or two from now
 - establishing an API for callbacks into drivers to serialize state
 - establishing an FSM for all of the various states that are agreed upon
   with common language
 - finalizing the decision on upstream support for minor version upgrades
   across KHO and the burden of downstream users to define what versions
   can be upgraded
 - topics proposed by Pasha: reducing blackout window, relaxed
   serialization, KHO activation requirements, and decoupling KHO from
   kexec
 - implications of preserving vIOMMU state

Please let me know if you'd like to propose additional topics for
discussion, thank you!

