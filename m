Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE6EC369D9
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 06:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IXkZowAPn4kNB/SMK4aQRzRcIE+j1k5vZeIINfBypek=; b=Nfyu0l9ZNhK1X6V4/FYag18Brz
	tMO/PbxIpATfwQiZQqRFhdWCi+0GRXxXxjI0xmig14dJDJUiZdZ1A4ueA9C8scyndz6oyWdH0fqED
	J88ca5Z0oazhy7qD6UWev5gZmX3lz++fMeNUHZL4ZrPEmIovumJxcTL0dizaNUzNLTSD/WWXdESmB
	3zASUhp077aYSS+Uvkur6db8sYe+iGqAS071lAjX5c9vkJb4rCh+ErurlBaCPIxLKD28OZgIfiGgW
	6BA3nxbPaKI+6bglW5O35KoSRHYV2dlGZTdtBjTcAMXT7mGBfbYn0OEpfz/dKJSw6NRvxsJIyljG1
	/fxr0t+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Hr5-000000052fz-2wEs;
	Mon, 28 Apr 2025 06:20:39 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Hr3-000000052ek-3NAg
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 06:20:39 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2240aad70f2so270615ad.0
        for <kexec@lists.infradead.org>; Sun, 27 Apr 2025 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745821236; x=1746426036; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IXkZowAPn4kNB/SMK4aQRzRcIE+j1k5vZeIINfBypek=;
        b=B9M9FUq1IlZvKICtzWabiMgq59qF7aYQrvlgobjg1wb77MRN7C/QGj6TgBH2EnS2fi
         6KfCWiw6OhBQlOFYovBErUjfRzybnB7bEheuNzonlnX0XYVEBfEveD6LM/CzrrCaU8c9
         jXNcJ/iHpFDwrAeSe/n2UTC/49BzKjEsjl5JkRJsAZ5Yo91N9uTDaFuRWwQmaeTbgeuP
         DOowcPsrdsQ2G1iI7KZt0CncY7NNM0qUGQBGph+sD1kKcULSqsGTYAvwKuFAWYqWlaB+
         GIUNxEL9BiBIZC3YAiFeA9N0tf/ciQ5Vj1gF96m9wt666SKTLD8JMTFRqkrkspx5DKn+
         AZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745821236; x=1746426036;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXkZowAPn4kNB/SMK4aQRzRcIE+j1k5vZeIINfBypek=;
        b=RmUAiym37gNMRNuCCQi2f28JSjeuX5uDpNezmsJlGZB64u0scpKe7JeNVqyN6JxzJi
         ZxVXKRrY/qxk6QMWMy29P4OsKUB3VhceItlODl79kzOV44ocwZQcrrKYSpmEeNo4KvjG
         VmjvFAc6AV+7i066Hm9l3vxPVS3ODxPIhCWGDdPBwV8XnNSuYAjiSm32KyjQT2F7vovW
         XflvvSNokGGlO4IQ8+sOZKMoXP+4vSTYcllB6eB6HMa+x+q64YcAADYZr+jx5BO7hKMJ
         Vz1ymzj63JsNpUinRf30PRvhHHXmjpl+IIiSj5erDVRFmK3xosBgMNZ9F4W6VXnMM1FB
         TuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTDWEncqXUF/O96d20rg3mjXWOVMVpmXPrvtocufSLHxmQaD1xvBL3wmDvhjQ4ztBGo4XrA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzq/Hlh5BwgnabohNjD5KBA802p0MpIIup7de8qWvEh4ie+dXKm
	itH1Wmtg4d8gPtmz7zDefWc+5P7ayye4In7eGofBbC4ehIvgEvlu/smEUY5soQ==
X-Gm-Gg: ASbGncuZ9wdUR1CNM1EP4BJq6YqAkOM69kfjZZ1SPEfrr12uH01fR+iosoPI8HPbQ+D
	/TxOma2SzMC5Eg6nR0VBDNTAjuZVVNSs1dc9FAX8hACa9s0euuiEi7F0nMPzIkV4A5kC69AqUsd
	PV1DPQ+f3k0+qTbbwSaj38rKwXn3MVmrM2K0BGFn8v0dBA1NKnAOnbR28j6O+0LEpOP5z5s35jA
	/N1/Evq9PJiDpR3fGv1Hvir1gYg8lRBrhhgZj+DP9PhEWibQq1MNjQALDDeTI+dfy+R4gOQtsYE
	1+3F97uKmc3JaIzRQgprPQyOanQpNOFslo2CvLJ6Td7eSYDU0nLncB90a8ojm1AbBdPzqU0Ab9L
	ahSFfLbS6i1rVy/3fNnSHK/+HqMjU+Dyc
X-Google-Smtp-Source: AGHT+IEbvwRZ9JywV9BzJ11zLBZSswf6lRwuo8vaSFHDzKdK9dK/CYp5zUl9jXJST/Ww91LUZrwVUg==
X-Received: by 2002:a17:902:d4c3:b0:216:21cb:2e06 with SMTP id d9443c01a7336-22dc90a4e72mr3004975ad.19.1745821235777;
        Sun, 27 Apr 2025 23:20:35 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:7d97:75a5:a2d:e3f3] ([2a00:79e0:2eb0:8:7d97:75a5:a2d:e3f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25ac87d5sm7166218b3a.157.2025.04.27.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 23:20:35 -0700 (PDT)
Date: Sun, 27 Apr 2025 23:20:34 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from April 21, 2025
Message-ID: <e03d2bdb-29b2-a0ba-1b7f-1f924dc47285@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_232037_870662_0F4D6657 
X-CRM114-Status: GOOD (  29.78  )
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
on Monday, April 21.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
KHO v6 is now staged in Andrew's mm-new tree.  We discussed what it will
take for this series to be pushed to Linus, specifically around
Reviewed-by tags.  There is not a ton of x86 specific code, but it would
likely be useful to have Reviewed-bys from some x86 maintainers.  Dave
Hansen, would you be the right person to take a look at this from an x86
perspective?

We definitely wanted to touch base with Jason Gunthorpe on this topic
since he was on vacation at the time.  Jason, do you have any feedback on
KHO v6 that would be blocking for its eventual merge upstream?

----->o-----
Pratyush looked at the LUO patches and noticed that it was largely doing
what he would have done with fdbox.  He expressed a concern about the
global states, which was not part of the fdbox thinking.  Pasha clarified
that the finish step would be when the final cleanup would be done; we
can still control what gets unfreezed and when.

Pratyush asked if the prepare phase worked the same way for LUO.  Pasha
said that the list of participating subsystems is added before the
prepare step, which does not freeze anything.  Pratyush noted this is
very similar to what he wanted to do with fdbox so suggested working on
top of LUO.  Pasha said that LUO v2 was happening right now and already
began porting over the fdbox support.

----->o-----
We discussed whether LUO largely replaces the need for guestmemfs as
discussed in previous instances.  It was noted that guestmemfs largely
was aimed at preserving IOMMU and now we have aligned on iommufds, which
was also supported by Jason previously.

Since we didn't have James Gowans in this call this time, we wanted to
follow-up on the upstream mailing list for this.  James, do you agree on
the convergence with LUO or is there still use cases where guestmemfs
would be useful that isn't currently planned?

----->o-----
We touched base very briefly about swiotlb in low memory, an issue that
Pratyush ran into several weeks ago.  Mike Rapoport noted that this was
now supported with KHO v6 upstream which uses lowmem scratch support, so
this should no longer be an issue.

----->o-----
The u64 in the KHO FDT was discussed from the last sync, which KHO v6
implements.  Each component has its own independent FDT that goes to the
global FDT's physical address.  We revisited the discussion from before
when Alex had previously implemented it differently.  The fixed maximum
size was one of the biggest blockers.  Now, with KHO v6, everybody gets
their own subtree and can allocate from anywhere they want.

I noted that one of concerns James had previously flagged was about
dumping the state of the FDT for debugging purposes.  This is noted as
being solved in KHO v6.  No additional concerns were flagged about the
single u64 that was implemented.

----->o-----
Mike noted that memblock is easy and useful for ftrace without a ton of
additional complexity.

----->o-----
We discussed the future of KSTATE[1].  Andrey noted that his vision
allowed for building it on top of KHO as a protocol for describing state.
This hasn't been done yet, but can be worked on.  I asked if the KHO v6
pending in Andrew's tree would cause any issues for this extension.
Andrey noted that this is a format for serialization and de-serialization
data, the data itself could be an FDT blob.

Pasha asked who would be benefiting from this serialization.  Andrey
noted this would be pretty much everything, including device drivers.  At
least with LUO v2, every component gets the u64 to store anything they
want and this memory gets preserved by KHO.  Pasha wondered if KSTATE
could then plug into LUO v2, since it doesn't have any format dependency.
Andrey said this could be done.  It has similar flows compared to qemu.

It was noted that KSTATE was going to be complementary, not overlapping,
with KHO.  Pasha suggested building KSTATE on top of LUO v2 and suggested
Chris Li review the current KSTATE proposal.

----->o-----
We discussed testing for LUO; Pasha noted that the plan is to add
selftests and then asked a general question about existing kexec tests
that exist, including with qemu emulator.  We need to create a mechanism
to do kexec testing with qemu that can be done directly with selftests.
Andrey suggested using a nested VM and to test live update between two
different kernel versions.

I asked about how we could enumerate upstream the supported kernel
versions that support live update, including their device drivers.  I
focused on how to describe the set of drivers that have been tested so
that others can consume that information -- is this done through a code
change that indicates that they can upgrade from a specific version.

David Matlack suggested focusing on automation and frameworks that
downstream consumers of the kernel can use in their own environments.
Pasha suggested a zero-day testing infrastructure for reporting
regressions and something like syzbot to track regressions.

David Matlack also noted that he is working on VFIO selftests.

----->o-----
Ashish Kalra asked about SEV-SNP support for live update.  He noted "for
SNP there is a VMSA page which is marked in-use/busy when the guest is
running.  Then the VMSA page for the currently running vCPU cannot be
dumped by makedumpfile during vmcore generation as walking the guest
memory and touching it will cause unrecoverable #NPF faults as VMSA is
marked busy.  So, this looks like a potential use case for preserving
guest memory across kexec (kstate patches), so that the VMSA page be
marked to be preserved and reserved."

----->o-----
Next meeting will be on Monday, May 5 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - address any pending concerns from Jason as well as x86 maintainers
   that start looking at the KHO series
   + we specifically want to wait for Jason to discuss the decision on
     everything being preserved by fds vs recreating the state on the
     other side of kexec
 - determine next set of milestones for KHO v6 beyond what is already
   staged in Andrew's tree
 - determine next set of milestones for LUO v2 in its development and
   limitations on current support
 - confirm that LUO v2 subsumes guestmemfs or identify required support
   that is not yet present
 - update on KSTATE progress on top of LUO and what will be needed for
   PCIe devices
 - upstream patches for 1GB dev dax support
 - update on physical pool allocator that can be used to provide pages
   for hugetlb, guest_memfd, and memfds
 - SEV-SNP support for preserving guest memory and what foundational
   components AMD can depend on, building on top of KHO v6 or KSTATE
 - later: reducing blackout window during live update
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://github.com/aryabinin/linux/commits/kstate-v2.1/

