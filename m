Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B2C369B1
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 01:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EPo4fDzBPzZ0SF46iJaXS2cUYofLRWgUanU/uI3JO8M=; b=mUJxPj7cAYQBqe3vsBwCsy5Vq2
	Gc9wSpj8zV/j4UeFnHjxmTAlrC1aGUsmnquskguxM/z5jMoK6tM7YtVKZ3a3KJepDLWyGY0XG5H1T
	ZSJHvT/uHVubhurjlvaBDX2akdKTvi+a1m/PIKDjerwp1X6j8+47jRJcRGKPUdGiU72dTaIdVIi1C
	WermmaiWbi0m/7MFP42JVxJ0+kVtONq4W8xL76t+udvl5ZBoXo+n+/+/0MkouTya95MypvYWcD2qN
	dyajrKHuYuG5SglxEDiM3lHjDPONhbP0lRusMbOeDjlC36N6Zy9cUwqsKZWr0ruuZuVmGi6gv6nyV
	4A8TXKGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4957-00000000SgU-3WqM;
	Mon, 14 Apr 2025 01:57:53 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4953-00000000Sg1-0DRc
	for kexec@lists.infradead.org;
	Mon, 14 Apr 2025 01:57:50 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2242ac37caeso250795ad.1
        for <kexec@lists.infradead.org>; Sun, 13 Apr 2025 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744595868; x=1745200668; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPo4fDzBPzZ0SF46iJaXS2cUYofLRWgUanU/uI3JO8M=;
        b=vXDrAOPEx1T7nPviWS7bE9hfU3dPIqxtLiYU/jV7B/+NUNiy+8AG++AxepERlLEzKJ
         LXF6y6AEuUwo2m2jhm4D3Ae8zq83NHDlKUkd0Zf9fSjfgvDNLKPctXBf0lRwSpVv0Rbn
         1q7OXai637M/vM4mgr/qyr1EBcv7QEMY5FUKSAfd9DG1/0fkq22ajhKKooozzc0D2fvQ
         BUaTCCv/lq+RPVpsZbi+OpzmEf84h0oLMrfOvQg97TnvabUjnMnHyh3ubFAMh2uOBdg3
         TTWIOHWhXtECui/MotEPesYp3cf4ZGnn9AAy1YKJ8xduCBBU38T9RF5UrDE4eH4hZozm
         G5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744595868; x=1745200668;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPo4fDzBPzZ0SF46iJaXS2cUYofLRWgUanU/uI3JO8M=;
        b=heh0WVucWFgIqK1KMAO/XiuUTSrnl74b9KYDOfvvYlcGCeXwNwaoksAZmUAClgZvAM
         w+wAK+4EMp2HL2704um89bOiYGaOnnMe/G2JFJu7V8mLLcOcDh1ZU8u5VHdVqKMzAqPd
         sgIHlnjD3MAn8LvgWpn5kptsMfN15F7bkpnFPh3xkyVnuzeqjNfWWaiNA6zSt2N8bfFo
         SouGNj882TTZTX/gnAYSAX2QGC0JtycIo2mW1qQUHAeFUE36Xjy4Dj4Ywqnj2PkTU2JI
         98JCH4u1thcp23W65roMKFN235/sIwZM/wNfhystJUFL1x+kdjjigUai42BoqSfZYLRZ
         0K0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbwcv0fGIJeLacNLNkN+1+T8n+YhHv65+LVCxi4YER4S2XPXJcGmVJQIH7L41d0FLaslY+Lw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwLnpwYz5PjH8ikqFcY7CUOwrA/TFsdFZxDeskslthaIjS0Cnl
	MB7POy1QTARPhdRbdt5BvnHsv4KOeHq6FMnfdNbAPlfsoDX8IwuqoeLbFKJr5g==
X-Gm-Gg: ASbGnctvyWOI1kYGo2Exfroc7pEzBk92OVFLSPGsFqh0hV/PhajglazmLbzFrinOh51
	d92byBwr9nxt1eIDRPy1ajB6mwFM5J3kVTesbNB7iHgoBpGZhSpU66Gh/Tu04hyuiCraqDklvRb
	QiztcxIqOw1f5A/Jkq1ysDcrwIIysQJXqPWVEsBnjNoNW+vtGHW1ISYIlxxaAA7UyxRHE/r7rCz
	piBaKHAPOtl6MCZ3KHgUCD+oYcBn+AwdQTDKJkQQ2rmIHIi8X9I1H0l/2qQSa4Mvet/hvTUXUUr
	LgcAXmziknRmAcajjARAaCsEUVF/AhvDv8ZWm6Alh+c81mrqOljcyhuq6GcQ0VxAcnTug3O0Mtz
	Wh7j46G6WmK/MGDBXHfOUk1y5V6X3Ae4y3L4knMPKhU8ohw==
X-Google-Smtp-Source: AGHT+IEtYqIuSLz/eBi+PVCcNBkAcKBhv+SmCO2Ibb03MJgmk6fUjpgMLtQ4dk/XA3mvLQhAtdSY9Q==
X-Received: by 2002:a17:902:ebc7:b0:223:3b76:4e25 with SMTP id d9443c01a7336-22bf52ca7e7mr2623495ad.17.1744595867709;
        Sun, 13 Apr 2025 18:57:47 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:f229:adb7:460c:4b5e] ([2a00:79e0:2eb0:8:f229:adb7:460c:4b5e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c97298sm89234135ad.138.2025.04.13.18.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 18:57:47 -0700 (PDT)
Date: Sun, 13 Apr 2025 18:57:46 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from April 7, 2025
Message-ID: <963ddf5b-81ed-7be2-3fcd-0eec7fafa132@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_185749_111065_E826DABA 
X-CRM114-Status: GOOD (  31.39  )
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

Here are the notes from the last Hypervisor Live Update call that happened 
on Monday, April 7.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We debriefed the discussions at LSF/MM/BPF.  The general understanding
was that the core MM community didn't have any major concerns or feedback
for the approach discussed, as long as there would not be intrusive
changes made.  This would likely only start to become a concern when
extensions would be made for preserving hugetlbfs or tmpfs.

----->o-----
LUO and fdbox were discussed at LSF/MM/BPF.  Jason suggested having
everything preserved using fds, including a single char device interface.
This could require some significant changes to VMM: Pasha noted we'd have
a VM suspended to memory but some KVM specific state would need to be
preserved for Confidential VM use cases.  The VMM would still do the same
call pattern as today (open /dev/kvm, lots of ioctls) but would also note
to the kernel that some specific state would need be restored for the VM,
rather than retrieving the full fd for /dev/kvm that is preserved.

Jason said the VFIO and IOMMU need the /dev/kvm fd so there is no option
other than to preserve the full KVM as well -- otherwise we cannot
restore the full iommufd.  Pasha noted an alternative would be to
preserve memory using the fd and the IOMMU is recreated with the memory
that was preserved.  Jason noted KVM would have to be involved when we
started to preserve vIOMMU and for Confidential Computing.  Pasha was
concerned with the amount of code changes that would be required for qemu
and other VMMs.

Jason stressed that starting up a VM in this case will inevitably be
different from starting up a clean VM.  This will especially be required
for vIOMMU, but not necessarily only for vIOMMU; for example, the VMID
must be the same as KVM uses on the IOMMU and CPU side for ARM and this
can't be disrupted during the KHO.  James Gowans asked if this state
could all be serialized to/from userspace which would not be transparent.

There was general debate about preserving all fds; Jason argued that it
will be complex but likely there is not an alternative.  The underlying
hardware state would be destroyed when attempting to restore the IOMMUFD.
We have to preserve the hardware state, which is different than the
challenges that KVM has to face because it does not have the underlying
hardware state.  He offered an example of preserving eight VMs with
corresponding IOMMU hardware state and how to map this to the correct VM
on the other side of the kexec.  He was also concerned about what
permissions would be required to open an fd and take over a KHO; in this
case, a security token would be needed.

Jason noted the only thing VFIO needs to preserve is the fact that it
does not need to FLR the device and which iommufd is controlling the
translation.  Preferably, there would be a consistent way of doing this
throughout the kernel, such as preserving fds, rather than anything
hacky; for this, we have freedom to determine what is supported with KHO
and what is not.

----->o-----
We discussed open questions for KHO, fdbox, and LUO after LSF/MM/BPF.
Pratyush wanted a feel for where this goes so that the next version of
fdbox could be worked on; clarity was needed in establishing fdbox's role
and where it overlaps with KHO.  Pasha noted LUO was handling the state
machine and the dependency chain for devices -- this starts to fully
overlap fdbox.  Pratyush noted it would be fine for fdbox to be part of
LUO and he would follow-up by looking at the latest LUO series.

----->o-----
Changyuan Lyu discussed what should be saved in the KHO FDT.  Alex's
original patches allowed for copying smaller amounts of memory, or it's
possible to specify a pointer to save larger chunks of memory that the
new kernel would fetch from the FDT.  He suggested only allowing KHO
users to save pointers to memory into the FDT and leave it to the users
to interpret the preserved data.  Jason noted that this made sense with
the simplest example of just using a u64.

James noted that one very attractive feature of storing everything
directly in the FDT, while acknowledging the size limitation, was that
the state can be dumped for debugging purposes.  The ability to dump this
state would still be possible, but with more complex parsing.

There was not full alignment, so James suggested following up with Mike
and Alex Graf on this topic on the mailing list.  Jason suggested
separating this topic entirely from KHO.

----->o-----
Jason suggested if VFIO or iommufd were users of LUO then the case for
upstreaming, as well as addressing many of the questions in the
discussions about it, would be much more clear.

----->o-----
Next meeting will be on Monday, April 21 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics I think we should cover in the next meeting:

 - finalize decision on everything being preserving by fds (complex
   solution) or recreating state on the other side of kexec
   + discuss Live Update Orchestrater (LUO) based on RFC patches to
     define the state machine
 - update on next steps for fdbox
   + is this going to be pursued separately or as part of LUO
     * does this support obsolete the need for guestmemfd in the long
       term
   + allocating swiotlb in low memory and any other device requirements
 - finalize decision on storing u64 in the KHO FDT to point to memory
   without storing all state directly in the FDT itself
 - alignment on memblock as the first use case for KHO to justify
   upstreaming, including ftrace use cases
   + update on Mike's patch series for memory reservation
 - discuss how KSTATE plays into KHO upstreaming and complementary or
   overlapping goals
 - decoupling 1GB pages for hugetlb, guest_memfd, and memfds and how fds
   can be added to an fdbox
 - iommufd patch series (as well as qemu) from James
 - establishing an API for callbacks into drivers to serialize state
   during brownout
 - reducing blackout window during live update
 - testing methodology for these components, including selftests

Please let me know if you'd like to propose additional topics for
discussion, thank you!

