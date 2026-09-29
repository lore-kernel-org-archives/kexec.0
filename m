Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0CBCA5FA5
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CMqmTdvAS89k83oYXVNW5NcZm+vCN1W6BXXzB1vwMug=; b=3+SFncNghGdd4xENWv3kfR5Y9B
	miUU7LhNUf8vIXF+URd3Jed291PyJ6xqYkeXoidYbC6Btdmb/vF2VISMvWOKlXmtAGebmgU438m9J
	mpZ3A3uzjYKDJk07oB3KaXmlG/Tet2Lm4WqE7QQ1+d3bqsMxUXDFxwQjBRFDsBhMHgSzvqjgj1YSk
	TVY5saFqtTdFt3F2KgcUwvZImqk/PXC/jIPCkNEM1XGw3x5zzV7KYndmXqei7Rj7/98gQdyVlf0/S
	VJRvu0/wix5Hort47xwbeAZfNOqgHbQE3MgRnsGZQSzS2rES4ZBZcGtTRtquDhxA558zefV2OxF/O
	1aux9RtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBXzC-00000003gT8-3uxa;
	Tue, 29 Sep 2026 13:35:10 +0000
Received: from mail-yx2-x27.google.com ([2607:f8b0:4864:41::27])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBXz7-00000003gS0-1GW3
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 13:35:06 +0000
Received: by mail-yx2-x27.google.com with SMTP id 956f58d0204a3-6756f62025aso300852d50.3
        for <kexec@lists.infradead.org>; Tue, 29 Sep 2026 06:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688902; cv=none;
        d=google.com; s=arc-20260327;
        b=GQnL1ANF9z9i9sM9+D2e6GcQeY5WeDFZLsZta+Kke6moimul+KIPpfHwaSD8bMrKOt
         9Q/tyxNhzDHOUkqj5v2TRG382FMpkd1EMqcDGBhTwGzgaNsN43Vc1qVOcvFoHWKOcybs
         qHogSXP0mPd/UekRJvb8QQmv6ZFhTV+A2efDBmQmKRI9qOKvXCudvbHmJatQXTXUTiKx
         g9gDTCCNUR8VfeN0BdxfxvBA24zvWbg8ll1Lfo54/W1hOTjFQi1+wVxM2YY6fuUwaMdo
         Wfdibj/jHgCmUg1eUvyALvPgeWBqqPgK4YX8E2+71T0GBJ6jFpEAAxLYtY4vtv4xzCfx
         nI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMqmTdvAS89k83oYXVNW5NcZm+vCN1W6BXXzB1vwMug=;
        fh=7R1N+ZpoCj8OdUpvG82gGEJral6xq7/5FVzv0IEjDJ4=;
        b=b+3Vefbrf1/a6I/RDm7NpYo3B6gi+oKc1EW/OxIvsCVQ/Pg9+6xkF7bgfFvNuk/G1E
         pspSsv6L87TEigB3Kwmtxtev8orKfgqEQyEUbyQpLi4rhNK8+d+HnQg6Vd2/nuZ/OJDQ
         ntfIzGgWA7tbEzezeieguM+r+HA8hnYlMkpMTUbww94pGrnWY6vqKqfR8kBDy4W+iVOt
         ToUxwYtF7KM6s1CgSM8C3Cd6OnyN+PC5OU/m/Y2rVUU05aMlkf4Ube8xDSb5Am5FN/s1
         uG6ttgKDhmvot9I8OZohxAxB08Pg5/JUakoIR+Sw0UKHzXZQ1WrrFbWhIH+65pgAWf5a
         EFGQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790688902; x=1791293702; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMqmTdvAS89k83oYXVNW5NcZm+vCN1W6BXXzB1vwMug=;
        b=jljjd13TxUAdOZFSE+6yjDbaIOV+f/m09Z7msVVJ7klHAp3NM3rsISdn9bSFaS5d8e
         O+2HHQT6+geYDBfzR2QMT9P7XWzr9c6h2zPogY3d+HhxmSb720/Z4LceyyadjZJ5ft5b
         V9jqH/5cBhyMV7JBVS29Ka+e0MqXiDis/vwBJcuHp2/UDBNSYZlCGDjR9+VP3kyMUvU4
         hovCxJO/RdsN3XO8pdbD2xxRvpC0HdzK8hn8ws3at41TZOTgxYDm6O+rxXrBV4v+ZieI
         Tk7mz971g3rbFDKhS21bx1ixS0wymIk3r29vlOG11YG4Ztq5h7ECFFVVDwf1RD8Fm8A+
         vuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688902; x=1791293702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMqmTdvAS89k83oYXVNW5NcZm+vCN1W6BXXzB1vwMug=;
        b=rqNI37b+5QmmliewsTZOmJnwX8Zv7J3nJjdmhoa1wp3nNTStxq1PISSaWVif4AYh9B
         oeWqPM+Yv5gKS/jbBquUx9agGTZk6Iu4FFlcABOxKaZS9rhjKJGkWBPYsCSWx5iSFV+z
         tUNYTkz2rTSOtLurZXn86+/AdAzOGUY1rUHqcl6h3zaqSOfzYnL1nqoQ3qjRSxRWD+SF
         nsieEto96eSycWi3tlBXoleSkDJdeYW8SfXK1Wmvm2yIjv5jvGr3sgu3Dm9jzq5p7/jR
         G71En1W5ayoI+pU2Z6GqMLAM3BzASXf5J3i9uZ3xe7MZt/3ynoUTmyLzGw927EEUXjqL
         Lkhg==
X-Forwarded-Encrypted: i=1; AKwUvBz89DjGFXu5A2x18C3D1PuqvcL+JCDRH5TJIkjZyJBM/vJCZstZ8/p3CwVrxMKECMBUPtHrxA==@lists.infradead.org
X-Gm-Message-State: AFq9FYL5J7enpC5TepNygsO9aPiWxtaPQFnVCrJVumP7HgC0OObIWjd5
	MkOgalzrHQzIKGEDcRr3vdDbUJftfUp0hsdWA99sBFsIrXvNQwMuv0kCLB72HHKXJXqhYcf8A7N
	18DfY+uAyIM6E7uJvwmUzYPwvD+AuADJ+fl4fJd0+
X-Gm-Gg: AYBFou32n6yFdF6YS/qI672WlATjDAin7EvQHTQEJSHp6p0PL4yuPy8HdZo3Tb/8BwY
	Yt+KBbUqCRJntuUXeAdJz01ml13Yr8+RTmf6JG+pE/FJJNZeIyjIcdaiW9xeNtFIdQtl/vDU+Ck
	Bt6JmlbYDkIdcnf0hzIQMQ2WKtZysYuFit077neDK7D3WMJMkLJEQgtMVh1Z1d5nXjuZ9YH2sNW
	ghfcTwQbF8dtViBwwBrusH6GNfrx/TeY1HYv9FB18Yx5CM12G6Ck6JqmT5M+GQNpiTQe3DXkYDN
	3408cz+1MLb/tPUXVsKhb80wpLBqe5pLKP9q/ICQVNQLpy/WiaZ0ciagSLAKOnSue+Z7dwYZqYP
	Auf2wIQ7wjk4ptXV4rFHzfRFoBKX6iM1HtxqPhLtB2pxXvH2VwOrPWMDKfcTRydfCUnW+qWSwbr
	1lMYnf89hz9Q==
X-Received: by 2002:a05:690e:806:10b0:671:8e1:2386 with SMTP id
 956f58d0204a3-672ed2d1ef2mr4268077d50.44.1790688901718; Tue, 29 Sep 2026
 06:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
From: Tarun Sahu <tarunsahu@google.com>
Date: Tue, 29 Sep 2026 15:34:49 +0200
X-Gm-Features: AclHuK-iNXjjkSWmw5QuOGuFFhmaybIp8bRIbWdcOO220zD0oN-VSK2-cXwF8Q0
Message-ID: <CALe+6DyB-6ShgC3GFA7Htw6YOyke6jC5iQd_a+PH83M85Y=gkQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] liveupdate: kvm: Guest_memfd preservation
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com, 
	Logan Odell <loganodell@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_063505_464478_03F1FAD5 
X-CRM114-Status: GOOD (  32.29  )
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

Hello,

As per the discussion on the series, I will try to layout the future
plan of guest_memfd preservation and VM preservation via LUO. Though
guest_memfd itself is in development phase, Deducing the exact plan and
ABI beforehand is quite impossible. So I will propose tentative plan as
per my current understanding.

Introduction:
        Guest_memfd was developed only for CocoVM use-case, But now its
        target is to unify guest memory for cocoVM and non-cocoVM.
        Though not all user will be onboarded on using guest_memfd with
        non-CocoVM, I see current development in guest_memfd for e.g
        multiple backends will provide its usefulness for non-CocoVM
        (Maybe get rid of hugetlbfs - traditional PITA).

        This preservation series and future development targets the
        preservation for both cocoVM and non-cocoVM.

Tentative Plan (Overview):
        I plan on supporting the guest_memfd preservation on incremental
        steps. This series builds the foundation for it and only support
        fully shared guest_memfd backed by PAGE_SIZE pages. Currently,
        For this base series, Only potential user would be non-CocoVM.
        But due to performance reasons, at this stage it can not be used
        (as it is backed by PAGE_SIZE).

        Incremental Steps:
                    A. This base foundation series (Fully shared backed
                    by PAGE_SIZE pages) also require VM preservation
                    [1]. but currently preserving single field
                    only (VM_TYPE).
                    This sets the foundation for VM preservation via
                    LUO as well. Present KVM uAPIs can support
                    preservation for non-CocoVM backed by
                    non-guest_memfd memory. But they are not sufficient to
                    preserve the cocoVM [2].

                    B. Next Step, Private guest_memfd preservation on top o=
f
                    in-place conversion series (merged in KVM x86
                    cocoVM tree) again backed by PAGE_SIZE pages. This
                    will also include VM preservation, for example the
                    data structures that are TDX protected can not be
                    preserved with current KVM uAPIs [2].

                    C. Parallel to B, guest_memfd preservation for
                    non-CocoVM backed by hugetlb. This work will be on
                    top of guest_memfd support for hugetlb backend [3][4].
                    Currently, How this support will be developed is in
                    upstream discussion. But The work on preservation
                    will pick it as soon as hugetlb support is integrated.

                    D. On Top of C, Extends guest_memfd preservation for hu=
getlb
                    backend for cocoVM (Integrating private guest_memfd sup=
port)

                    E. Preservation for any other backend that will be
                    supported in future.

VM Preservation:
        Guest_memfd preservation can not be supported alone, it needs VM
        preservation as well [1][2]. Even though there are no current
        user, But there are users who want guest_memfd preservation for
        non-cocoVM and cocoVM both. And that opens the door for VM
        preservation as well because present KVM uAPIs are not
        sufficient (for cocoVM case [2]). This will unify preservation
        mechanism for VM (and its memory) in linux.

        Presently, for non-CocoVM, KVM provides uAPIs to preserve the
        state of the VM for e.g. vCPU + device state through the
        (KVM_GET/SET_REGS, SREGS2, XSAVE, MSRS, LAPIC,
        VCPU_EVENTS, MP_STATE, NESTED_STATE, CLOCK, ...))

        Now, for cocoVM, we need to preserve the TD state of the VM and
        global TDX module state. For which preservation of the following
        will be needed (Not everything included, it is as much I could
        think at this time, Also I am not expert on TDX, I will try)

        **Global State (Will use LUO FLB objects)**:
        1. TDMRs + PAMT locations
        2. In-use HKID bitmap

        **Per-TD/VM (part of per-VM preservation, It can open door to unify
        the place of preservation for other fields as well. But again
        open for discussion)**
        3. VM_TYPE (already preserved)
        4. TDR Page
        5. TDCS Page
        6. HKID
        7. S-EPT non-leaf pages
        8. S-EPT leaf maps
        9. per VM memory attributes (unrelated to TDX)

        **per-vCPUs (preserved via vCPU fd)**
        10. vCPU ID
        11. TDVPR page
        12. TDCX page
        etc.
        Note: Also, why not extends
        the support for full preservation of vCPUs ignoring existing KVM
        uAPIs to unify everything at one place: Open to discussion and
        can be discussed thoroughly once RFC for TDX preservation will be
        sent.

Guest_memfd Preservation:
        1. per gmem memory attributes
        2. folios preservation (size/number of pages per folio, index etc)
        3. State of hugetlb preservation (again LUO FLB object will be
        needed to preserve system shared pool information)
        4. SPLIT information for hugetlb for shared pages
        5. backing type of guest_memfd
        6. gmem related flags
        7. mem policy
        etc.

The above plan is currently based on my current understanding which can
be changed as guest_memfd evolve and new findings come to the light while
during the work/review of RFC of individual features.

[1]: https://lore.kernel.org/all/9huzo6ezv288.fsf@tarunix.c.googlers.com/#:=
~:text=3DGuest_memfd%20can%27t%20be,KVM%20side%20preservation.
[2]
KVM uAPI fetch data to userspace and restore it back in new kernel. for
TDX case, that is not possible becuase of 2 major reasons:
    A. all control data structures are protected and encrypted,
       Host cannot access them if they do not belong to host.
       While LUO just have to handover the PFN to new kernel,
       So LUO does not access the underlying data.
    B. TDX module can not be freshly initialized, it will lose
       the state of the protected VMs and their relation data.
       So preserving using KVM uAPIs and reinitializing it and
       populating it via userspace is not an option. It has to be
       done from kernel. and kexec handover/LUO can handle it very
       well by updating TDX initializing sequence in kernel (This
       is one of the Idea currently in my mind, topic is open for
       exploration).

[3]: https://lore.kernel.org/all/20260720111259.122911-1-dwmw2@infradead.or=
g/
[4]: https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822=
d18@google.com/

I wanted to send this before LPC so that we can pick up this for
discussion on Tues in either KVM MC (13:00 KVM and Live Update) Slot [5]
or Live Update (16:10 Guest_Memfd Preservation For Live Update) Slot [6]
or for general discussion on liveupdate ABI (15:50 Live Update
Compatibility) Slot [7].


[5]: https://lpc.events/event/20/contributions/2632/
[6]: https://lpc.events/event/20/contributions/2610/
[7]: https://lpc.events/event/20/contributions/2613/

[5] is before [6] & [7], So, We can also have any other slots as per [8]
on wed.

[8]: https://lore.kernel.org/all/2vxzse2x46ol.fsf@kernel.org/#r

~Tarun


On Tue, Jul 28, 2026 at 2:11=E2=80=AFPM Tarun Sahu <tarunsahu@google.com> w=
rote:
>
> Hello,
>
> This is v4 of guest_memfd preservation during liveupdate. As per
> the discussion from bi-weekly guest-memfd meeting, This series
> will be go to linux via kvm tree. And Planning to get it merged
> in upcoming merge window. (7.2-rc1 for release in 7.3)
>
> The changes are rebased on:
>         kvm/next + liveupdate/next (merge) + [4] + [5]
>         Where,
>         [4]: luo: APIs to retrieve file internally from session
>         [5]: selftests: liveupdate sefltests library
> Here is the github repo:
>         https://github.com/tar-unix/linux/tree/gmem-pre
>
> Patches [4] and [5] are prequisite of this series and they are
> rebased/merged on liveupdate/next. kvm/next is behind few patches
> from liveupdate/next, hence direct cherry-pick of [4] and [5] is
> not possible. On Linux 7.2 they will be aligned. If we
> succeed in merging it before I can request liveupdate maintainer
> to provide the tag.
>
> Steps to test:
> 1. Compile Kernel with CONFIG_LIVEUPDATE_GUEST_MEMFD=3Dy
> 2. boot kernel with command line: kho=3Don liveupdate=3Don
> 3. run the following kselftest
>         $ .selftests/kvm/guest_memfd_preservation_test --s 1
>         $ <kexec> --reuse-cmdline
>         $ .selftests/kvm/guest_memfd_preservation_test --s 2
>
> NOTE: Assert the following:
>         $ ls /dev/liveupdate
>         $ ls /dev/kvm
>         $ dmesg | grep liveupdate # (should have kvm_vm_luo &&
>                 # guest_memfd_luo handler registered)
>
> V4 <- V3
> 1. Split the refactoring patch into multiple patches [2, 3, 4]
> 2. Updated commits msg as per the kvm documentation and suggestions
> 3. Removed KHOSER_PTR and using raw pointer, as series [3] not yet
>    decided to go in the next cycle
> 4. Implemented more tests in guest_memfd_preservation_test
>    allocation during frozen gmem_inode, non-guest_memfd preservation
> 5. Moved the vm_create_from_fd to kvm_util.c from the
>    guest_memfd_preservation_test.c
> 5. Minor updates as per the suggestions
>
> V3 <- RFC V2 [2]
> 1. Finalize the design
> 2. resolve sashiko reported bugs
> 3. Use of KHOSER_PTR instead of raw serialized_data as per [3]
>
> RFC V2 [2] <- RFC V1 [1]
> 1. Removed mem_attr_array as it is not needed for fully-shared
> 2. Removed pre-faulted condition
> 3. Added vm_type preservation for ARM64.
> 4. Removed liveupdate_get_file_incoming api patch as it is sent
>    separately [4] by Samiullah.
>
>
> **GUEST MEMFD PRESERVATION**
> Below is the cover letter of the series which explains the design.
>
> SCOPE:
> 1. Fully Shared Guest_memfd
> 2. Guest_memfd backed by PAGE_SIZE pages
>
> Any VM whose memory is backed by such guest_memfd and satisfy the
> above conditions can be preserved across liveupdate.
>
> To Add support for liveupdate of any subsystem, we need to implement
> the following calls: (e.g: subsystem: guest_memfd)
>
> guest_memfd_luo_can_preserve: used by luo subsystem to filter the
>                               guest_memfd files
> guest_memfd_luo_preserve: triggered from userspace by PRESERVE ioctl
>                           If can_preserve says the file is preservable
>                           by guest_memfd_luo_preserve
> guest_memfd_luo_retrieve: triggered from userspace by RETRIEVE ioctl,
>                           recognised by the passed token from userspace.
>                           Used in new kernel after kexec.
> guest_memfd_luo_unpreserve: triggered from userspace when a session is
>                             closed, which inherently calls unpreserve of
>                             all preserved files.
> guest_memfd_luo_freeze: triggered just before kexec automatically in
>                         kernel. no userspace involvement.
> guest_memfd_luo_finish: triggered by userspace when all files are
>                         retrieved and want to finish the session
>                         retrieval.
>
> *PART A: KVM VM preservation*
> Introdcued the kvm_luo.c to preserve the vm_file during liveupdate.
> Currently it only preserve vm_type. This can be expanded to preserve
> more details in future as need arises for example data related to
> cocoVM (SEPT etc.).
>
>         int kvm_fd =3D open("/dev/kvm", O_RDWR);
>         int vm_fd =3D ioctl(kvm_fd, KVM_CREATE_VM, 0);
>         preserve_arg =3D {
>         .size =3D sizeof(preserve_arg),
>             .fd =3D vm_fd,
>             .token =3D VM_TOKEN,
>         };
>         ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &preserve_arg);
>
> This VM_TOKEN is used by guest_memfd preservation. guest_memfd
> preservation save this token (fetched internally by luo apis [4]) to
> associates the guest_memfd with its vm_file. On retrieval, guest_memfd
> retrieves the vm_file using this token and use its struct kvm to
> retrieve itself.
>
> PART B: Guest_memfd preservation
> Introduce guest_memfd_luo.c to preserve the guest_memfd file during
> liveupdate. Currently it only preserve guest_memfd files that have:
>
> 1. INIT_SHARED flag ensures intially all the memory is shared
> 2. !kvm_arch_has_private_mem() which ensures no shared pages can be
>    converted to private after [6] lands.
>
> Preservation first freezes the gmem_inode introduced in PATCH [07/11]
> and preserve each allocated folios from guest_memfd page_cache using
> KHO.
>
> luo_freeze (not the gmem_inode freeze PATCH[07/11]) call update the
> vm_token which is preserved across kexec.
>
> Retrieval retrieves the vm_file using vm_token and create the
> guest_memfd with vm_file->kvm and populate the preserved folios
> to guest_memfd page_cache.
>
> Added the Documentation for VMM on guest_memfd preservation guidelines
> To know more about, PATCH[10/11] can be referred which has the more
> detailed documentation.
>
> Future Plan:
>         1. Make preservation immune to new allocation and fallocate
>         calls so that we can remove freeze call
>         2. In future, When IOMMU will use guest_memfd and can allocate
>         page tables for DMA in that area, Later it will be a problem if
>         other user of guest_memfd do punch hole before preservation,
>         that will make the pages to be lost after preservation. This
>         will be taken care of when IOMMU will add support for
>         guest_memfd.
>         3. guest_memfd preservation for private pages + in-place
>         conversion.
>         4. In future, when guest_memfd will have hugetlb page support,
>         add support its preservation.
>
> [1]: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.co=
m/
> [2]: https://lore.kernel.org/all/cover.1780667929.git.tarunsahu@google.co=
m/
>      https://lore.kernel.org/all/c054ba0fb2639932bbe354420d3f4f84cce84905=
.1780676742.git.tarunsahu@google.com/
> [3]: https://lore.kernel.org/all/20260622184851.2309827-1-tarunsahu@googl=
e.com/
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git=
/commit/?h=3Dnext&id=3Df4d2e4f0d12d88155cd1128ed3294f7827bf4c5d
> [5]: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git=
/commit/?h=3Dnext&id=3D2f3f53a3735a7e67bbe9e580cb49372bf9261967
>      https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git=
/commit/?h=3Dnext&id=3Ddf1a0d068d481b7d175c5af3970043206409a062
> [6]: https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-0-9d=
2959357853@google.com/
>
> Tarun Sahu (11):
>   liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
>   KVM: Introduce kvm_create_vm_file() helper
>   KVM: Export kvm_uevent_notify_vm_create()
>   KVM: Track weak reference to vm_file in struct kvm
>   KVM: LUO: Support VM preservation across live updates
>   KVM: guest_memfd: Move internal definitions to internal header
>   KVM: guest_memfd: Add support for freezing mappings
>   KVM: guest_memfd: Add support for preservation via LUO
>   docs: liveupdate: Add documentation for VM and guest_memfd
>     preservation
>   KVM: selftests: Split ____vm_create() and add vm_create_from_fd()
>   KVM: selftests: Add guest_memfd_preservation_test
>
>  Documentation/core-api/liveupdate.rst         |   1 +
>  Documentation/liveupdate/vmm.rst              | 107 ++++
>  MAINTAINERS                                   |  14 +
>  include/linux/kho/abi/kvm.h                   | 106 ++++
>  include/linux/kvm_host.h                      |  14 +
>  kernel/liveupdate/Kconfig                     |  15 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
>  .../kvm/guest_memfd_preservation_test.c       | 357 ++++++++++++
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  49 +-
>  virt/kvm/Makefile.kvm                         |   1 +
>  virt/kvm/guest_memfd.c                        | 185 +++++--
>  virt/kvm/guest_memfd.h                        |  44 ++
>  virt/kvm/guest_memfd_luo.c                    | 515 ++++++++++++++++++
>  virt/kvm/kvm_luo.c                            | 195 +++++++
>  virt/kvm/kvm_main.c                           |  94 +++-
>  virt/kvm/kvm_mm.h                             |  15 +
>  17 files changed, 1640 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/liveupdate/vmm.rst
>  create mode 100644 include/linux/kho/abi/kvm.h
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_=
test.c
>  create mode 100644 virt/kvm/guest_memfd.h
>  create mode 100644 virt/kvm/guest_memfd_luo.c
>  create mode 100644 virt/kvm/kvm_luo.c
>
>
> base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
> --
> 2.55.0.229.g6434b31f56-goog
>

