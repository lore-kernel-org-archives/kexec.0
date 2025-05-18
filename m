Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBC1C3ABC9
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m1S5wux5Un3HR/J/zrUPg8YRxdL0/UwPOgAQamHb9Wg=; b=CKjeRSpl5CU9lvipaJw27pE6Qr
	A9Xsq0WzQiaPg35UCBHYQGXxFGMfkC6QjeW0JTQ1UvsRKOXOtBFy2hF9iekFEyaGIUEdObEyHSnoJ
	8gLRTjYoCPw7U98fIibh42+yG7Uf8/dzlHl/JbLFMCCbTFiOoY22d0hEsCA0H1RHZG6VYEfpWpnxv
	lckZYIT7Ebj7NowCYukfJPibLoNjdqxVBQUdrlW22NvDa9U7qnjUk+n8VuEPJjGO3nJvoAXmOmxCS
	hW2XcMca7b6sPRmu8B6ovG2aMjoLI2tO1exuISA7PnmtZpKSQr8FxvouyL6tNdLEa0HjFh+7z3+GM
	0ron9uvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGVYu-00000006iGt-2D4w;
	Sun, 18 May 2025 04:23:44 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGVJc-00000006hAl-28F0
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 04:07:58 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-231ba6da557so140095ad.1
        for <kexec@lists.infradead.org>; Sat, 17 May 2025 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747541274; x=1748146074; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m1S5wux5Un3HR/J/zrUPg8YRxdL0/UwPOgAQamHb9Wg=;
        b=NlykV8uAZH0oqRBP3XPplL1JS0FHM3K/syMf1t1IDUU/lr/R6ab713Oox04SsMOIQr
         xTgAB4/QS8EJo0jPr+pO8cWt4QqeSU1beEU3Y9xHKOt1gISGmROtVFCWyDaKHIQpUqS0
         mgUISNHQtTXayuwgMmTZElm9PFL3KRtndCIAsg7VYhQt09WX4xJMWa6KiojNWsIHasTK
         w3gRYu251KKy+Osr9N7Q8tHPR98XFjP0zkvxUfMkTXdSj3MwW7GDdJ0FRr9ECsmr5cuX
         s/8B27GxKl+9ucQRykNm/bbbS+F9eEUQ1ev6FdPW1k6i6gbgregSLc8rMlWoFDMlygcV
         TrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747541274; x=1748146074;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1S5wux5Un3HR/J/zrUPg8YRxdL0/UwPOgAQamHb9Wg=;
        b=IHwZI/5twdBtEuVbrv0vSLY8won1wR0BibSDQIPclhFHxcNh8GCsB3lKKcfegYTDqq
         Il79JgKEHPfard/rphaBnzAgAxa9Jw2tZua57DUQ+CS5Da8eeU9naMqbwUBcHfVrhrcV
         mBlxyey7clnOP8TmVhW7xcTI0PEOXeWcnFJZP1UXpUskRa5FyYcP20rNB159O+uVcj3U
         Ez0CBDSvZ8Xa4Cqa8xNFhjnLFJHM5iYHr4gtfbjasivxUVvNX0xHO7cNMV02F+Tayw99
         58llUkpEM10A37c3/kU608wQC9cnF6dFcdiiFy+6YWqka9PFvp/dogDZJLWYrNPYOXkk
         0Xmw==
X-Forwarded-Encrypted: i=1; AJvYcCUy7wzaHOkAiBkw3ziRrEvWtb4DXe8g9qV7rqSWYnUFObKMtm/0/Jiw7WwFm3XW2gbYyDFGog==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHpROXbOjTX7buekQjaF2tunCiw7eOQltJH1wsBNuzKH64uvjA
	OQ5KJgWPk9UToaxogqIzK2/cHleb0YKwAn7JmrKeL9EGUHVXPu61GE7kvERUb7YxNQ==
X-Gm-Gg: ASbGncvLiOMzXf8u5T9a+ExL07V4gkozF4dOAlvoTh0gOB9017cnplVcuPdpsTANaR2
	5ZvaAgsLaF8PiJWLIqGU1YVe7e2kUl/Us0B9x/0prLCSP2FjmWUfR4oPh9t36uGNYknUvLr7+2P
	gIsofB7C3cqJVzPQc3tvWLadnpvCb/qNtI2zxJGp1Dmn1/vxyR3C5TNuwwdsFt/cAE9YNZlTeHG
	2R5kR1T16dAUmUQtGIvWQT5nRN2qNbLqfjSZKyu7x11cB1UUmDAybLpJcR3VugsW5Y3AToL2Rnp
	+rfYRZPLdqLdH7+7NqysWxU+h/XGzQNLxI0C83tTCzNnx2GR8TkklNQ+26jJrD3jYErWBIoI3Mt
	I/NonL8EnqqsbBhkimCqpetsXe0kUP9bW2Apgnin9ERUa+9nGn4IzQXLGzfPz2Bl1Ttk=
X-Google-Smtp-Source: AGHT+IEgxvBhOFuCqEEVpkjjjRbwY5GhLbpjFDYwCP66o+lD5JckQmQSrsygVA2eRoddVrKz+dAwPA==
X-Received: by 2002:a17:902:e94f:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-231ffd31118mr2592805ad.16.1747541274090;
        Sat, 17 May 2025 21:07:54 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:c2a1:ddfd:5eb2:50a4] ([2a00:79e0:2eb0:8:c2a1:ddfd:5eb2:50a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e98082sm37688705ad.122.2025.05.17.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 21:07:53 -0700 (PDT)
Date: Sat, 17 May 2025 21:07:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from May 5, 2025
Message-ID: <f35359d5-63e1-8390-619f-67961443bfe1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_210756_575400_0C9237DC 
X-CRM114-Status: GOOD (  37.09  )
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
on Monday, May 5.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We discussed reviews on the latest series of KHO changes.  Pasha noted
that Dave Hansen's feedback should be fully addressed.  Small changes
were requested that could be handled incrementally on top.  Changyuan
echoed that an incremental x86 patch on top could be posted as KHO v7 is
currently in mm-unstable.

I asked if there were any major blockers to the series and there did not
appear to be.  Jason suggested that we just leave the current status of
the series as-is so that it can graduate to mm-stable and then eventually
to upstream.

It was noted that compound_folio() may not be handled correctly based on
feedback from Mike Rapoport upstream.  Changyuan said there was currently
an issue where KHO would have difficulty in preserving a folio for the
same number of times that it was referenced; the same issue would likely
apply to compound folio.

Jason suggested that if a memfd needs to be preserved by multiple
processes that they still get a single fd, it doesn't get preserved
twice.

----->o-----
The current status of KHO is such that it should be possible to build
iommufd and memfd on top of it.  Pasha said that once the compound folio
concern was addressed, and now that all of Dave's feedback was also
addressed, that everything else should be able to be incremental on top
of the framework.

I started discussing the next phase of development for the KHO framework.
Pasha said that LUO is the next thing that should land upstream as it
controls the lifecycle.  For KHO itself, additional support for other
architectures, bug fixes, and scalability improvements are always
possible.

----->o-----
Pasha said that he would be sending out an RFC v2 for LUO.  The first
user of LUO would be memfd that Changyuan is working on.  He was porting
fdbox support on top of LUO.  Pratyush asked for the patches to be sent
out to fix some issues on what he was working on ahead of time.  Pasha
noted that he would present LUO design in the next biweekly meeting to
provide more visibility for the rest of the group.

We briefly chatted about the future of guestmemfs support after LUO and
whether there is a future for it.  Until we hear more about additional
requirements that necessitate a guestmemfs, we'll drop the topic for
subsequent meetings.

----->o-----
Andrey discussed with Chris Li about the next steps for KSTATE on top of
KHO.  Chris said that he would work with Andrey for state saving with PCI
code; he felt that KSTATE was a solid direction for PCI.  FDT is designed
for information saving but not serializing state.  In LUO, there are many
recursive FDT objects and that breaks the fact that it needs to be stored
in one big save state structure.  Chris suggested that objects would need
to support pointers.

Pasha asked about recursive FDT with LUO and said this was not the plan;
LUO does not necessarily care itself.  He supported KSTATE for this.  LUO
supports the 8-byte pointer for preservation.  Chris said they are
shifting to a tree like structure branched off of this 8-byte pointer.

Chris said that for every object we store, there will be a description of
the member type, ID, and type.  Chris said this needed to be stored as
part of the binary format for the new kernel to understand what the old
kernel was using, including for rollback.  He also noted that FDT does
not support descriptions for the acceptable ranges that members can take
on very well (and version number may be inappropriate to describe this).

Jason said that per-member schemas would probably be very complex.  Chris
said this would be needed.  Jason suggested per-field would be way too
granular, he was skeptical that rollback was something that the upstream
kernel should support; if a CSP wants to deploy v2 -> v3, then this is
entirely deferred to them.  Jason suggested having very coarse versioning
instead that captures everything.

Chris said it would be important for a vendor to be able to add their own
versions.

Jason noted that it would not be possible to enable a new feature in the
fleet until the CSP is no longer willing to roll back.  There may be some
minor exceptions to this, but for more features they will need to remain
off until fully deployed and it's not possible to roll back.  Amit Shah
agreed that the feature must be available but not enabled; once available
everywhere then it can be enabled throughout the fleet.  David Matlack
observed the similarities for KVM features today and agreed.

The amount of state to preserve across kexec would have to be minimal and
updating versions should be rare.  Andrey agreed with this.

Pasha asked about the situation when enabling a new feature would run
into issues in the fleet and whether reboot would be the only way to
recover from that.  Jason said this should go through the VMM so that the
only way to enable a new feature is when the VM restarts and once that is
committed, then it's there until the VM reboots.

----->o-----
Jason noted that he posted his first patch series to make the iommu page
tables common[1] that could become part of the KHO work.  Pasha said this
was exciting to see and that it would be possible to add page table
checks for this.

That consolidating iommu page table implementation patch series would
benefit from review from the community, so people are strongly encouraged
to take a look.

----->o-----
Pasha noted that the support would be sent upstream soon to support dev
dax as 1GB shards similar to how hugetlb is managed.  Currently under
review was support pmem regions into arbitrary lengths.  There was also
support to provision fsdax by default but dev dax would be optional as
defined by the kernel command line.  This would avoid the need for a
separate tool.

----->o-----
Frank van der Linden discussed his physical pool allocator.  His concept
is for a common layer that is separate from hugetlb; the topic has come
up a number of different times.  For example, if memfd needs to be backed
by 1GB, then a physical pool allocator could provide this, as well as for
guest_memfd.  This will decouple 1GB pages from hugetlb entirely.

His series provides a common allocator for physical memory and will be
sending an RFC prototype soon.  The 1GB pages comes from a static pool or
from a dynamic pool and can even be removed from the kernel direct map.
Goal will be to send this out in June.

Jason noted that we should avoid having to store information about the
vmemmap across kexec if at all possible.

----->o-----
Next meeting will be on Monday, May 19 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - 20 min: presentation of LUO v2 design
 - check back on latest status of KHO series in mm staging trees and any
   pending concerns
   + including possible refcount issues for compound folios across KHO
 - possibility of a Live Update Microconference for LPC this year
 - discuss support for sharding of dax devices into arbitrary lengths
 - discuss support for defaulting to fsdax and with optional devdax as
   needed, provisioned by the kernel, on the command line without
   additional tooling (ndctl)
 - update on physical pool allocator that can be used to provide pages
   for hugetlb, guest_memfd, and memfds
 - SEV-SNP support for preserving guest memory and what foundational
   components AMD can depend on, building on top of KHO v6 or KSTATE
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://marc.info/?l=linux-doc&m=174645437711873&q=mbox

