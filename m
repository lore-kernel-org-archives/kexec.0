Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A80AC87FD2
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 04:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UCSBCXnMQmaIVAH+e3b7TVmR3mlo8rlRXRLYG8Vjwv0=; b=QCGKQ74hXSZ7LCRI0QOTNIqOLW
	nRoU+KjomMvTUnvKEWjrSnxkytSpNqk04zqdMf4inYTgvHoIs3WHWonXUqI7deJ3nBM5+vDs/joP5
	feBKxL95I2VWbFo7j83bfxdBoSaEspaZdkdzc1bv+FZDDu8bexEQ4l7PjmjSr08w4vEnq/tJM7JQJ
	4QL1CXldb1ARpam5fYGXoqOneQmH009rSMj+JX9qgLxe8i65hIcmK1PXld4QTFkp2iokThub/9/Bh
	VCWexQ3fE3kVkeT1qgXEC37oZxvI37ZPfk1XcmFrnPYhX8F778UM6TY5PArzFQDBnXB/VW0wmecGn
	NQ4SWN6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulK43-00000006T5z-1oGa;
	Mon, 11 Aug 2025 04:23:15 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulK41-00000006T5d-0IkQ
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 04:23:14 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-242d3be5bdfso187655ad.1
        for <kexec@lists.infradead.org>; Sun, 10 Aug 2025 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754886191; x=1755490991; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCSBCXnMQmaIVAH+e3b7TVmR3mlo8rlRXRLYG8Vjwv0=;
        b=bFY+iH9VNIolPByMk+qxdgCY/KEIQK8o+uZRyOyBvgO3O0qTGW3H556wOsfg2cKqli
         CBrYGC+4SwucuFd8UxDJSjAR2lZhcaFJWYqjvxW8M6p9qcYCy1D7XTllDB3N0VNEtEp5
         atWcHmP4C5YqarvVrL8UK/BBnrByWoNSt1CLm0j1A+vHJdxAmvwmXzt7mOKBrmclSJgn
         +RZuhDWTIneUHjvQblkwplt75x5q36xNLoTQBbNBBfiAW4dt4AE9nJnH0Y0Y19hL3bFj
         5OJQnPsOJi/kLZJ+AhrPPXsB6182G7VGZmFoPG3dtofe15u5G+3IgnIpLXWs2KjqBw4R
         M8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754886191; x=1755490991;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCSBCXnMQmaIVAH+e3b7TVmR3mlo8rlRXRLYG8Vjwv0=;
        b=fplUSbNe2peFJBJ1iVk47v0ZRYr2IKL6p4Ncua21PJ6pc8OtEJTwih97aBdAPQe8xS
         cUFP8I4djnQyq0eHx3FgbTEjVWYMf3f9k/To07d7Vzih+rmB2vDsusGamzzN/iOOeHVu
         O/PlaVxlPwGAfCywxBi3sFSFs2ghG8+1KTJ0T6J55ROQrtQi2T06z1Sq+/FsPNK8vDle
         HIfnYKtyRSCytFe88hL/84w8EKCoBwC9z6PP79jJOnPelvGS/XrO6rbrofXBarwNGwXh
         uSt2UtxRMYjmdk+SyTld54XiHce+Ha11JzMC11U1PraHQCG7lQoc5j1w5ZKYuk6wzfQ/
         3qmw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRhrXe12aMMgjvBhPJYcSUVK9iJOsjDvqjfs0dqeR55ofD7RcNHwbGhC9k3wsQp7nEd2ylg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2zA9mnpP01zS/ib8vVwAviVs2hqm3tziYvnfEuIqRoYMxymQq
	hdllWDrrz9ND2+0GgVdFDEUrNU2GZRTkqp2znFHADbb0XNQ0wQ7wb047XG0nsm1Tig==
X-Gm-Gg: ASbGncvzJCrs/9TRq4sNP6R4F4tp6vu36uA4RNvWFVf9mJrxsVxKitPcyADqNh5aoPt
	/hly4pJJMW2HwP+JEdrhAOr+gZsotJc/6PCjYLUwZsM5Oo10K+lik0mgPAbjfSvZ8+xM3GN/eT9
	79H+2uZS74N0z0lBQXWmbok2LhY/bzIBjgpXGEMAqPyuyoZ2m9ecr+i4sBBoMz0TrcX55TZvpCn
	JW3wrf7728mM5pHiy/rRYhcCIRTlRicLj6TRwye+tKrozlggFEBfsmarFfqy2gWzJoSaFRUbpFr
	Y1J4fw+TW9tHjGRGSTTgEEAnQftLw73Z5KzvQNnULLqxChcnSCcRF3cXT+C9biVni1rrBiBCYKL
	oCNy0I+Mm90kqLhZ3v/cEibdRsNFuiNMQKPvOsnQTTHal3NLfqgRNqZa959u0eNqeJzsJTcgNJi
	6yl29ew6T8yYdyWJ1i
X-Google-Smtp-Source: AGHT+IEPFfcbgvOfxJdst9AfZvSBtoZS/zbmaiucrFo4yynA5He38FqIVteTcaFq8sU9C/fFf6t6iw==
X-Received: by 2002:a17:902:d507:b0:240:2bd3:861 with SMTP id d9443c01a7336-242d2bc657amr3889325ad.10.1754886191100;
        Sun, 10 Aug 2025 21:23:11 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58] ([2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b6casm258903005ad.127.2025.08.10.21.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 21:23:10 -0700 (PDT)
Date: Sun, 10 Aug 2025 21:23:09 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Jork Loeser <jork.loeser@microsoft.com>, 
    Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from July 28, 2025
Message-ID: <05f47f4f-524e-0925-9e23-bfa7286d455c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_212313_134154_11FA127E 
X-CRM114-Status: GOOD (  38.63  )
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
on Monday, July 14.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha Tatashin discussed LUO v2 and what parts could be staged in the MM
tree.  Akpm suggested updating once the 6.17 merge window is complete and
then rebase and send v3 which should be around the next time we meet.
There will continue to be feedback addressed upstream in the interim.

Pasha noted that there were still filesystem discussions happening, so
that may change on future iterations.  Jason asked if there would be
objections to the series upstream; Mike Rapoport did not believe there
would be blockers that would prevent merge.

Mike noted that systemd folks were not overly happy with the new UABI but
that they can live with it.  The nature of the feedback was not
necessarily about the ioctls, but rather the systemd preference to have
everything be hierarchical.  Mike noted that upstream feedback preferred
VFS be mountable because of a preference for user namespaces, but there
was not a use case beyond init namespaces for now.  The feedback from the
group was that we should define the security model first before requiring
a filesystem.

I asked if this was a one-way door, if we could eventually go back and
support filesystem in the future; Mike suggested that we would need to
continue to support char devices in that case.  Pasha agreed that we could
do an extension in the future if needed.

Pasha asked if we should enforce a single open of /dev/liveupdate.  Jason
thought this was appropriate due to the clean up semantics.  Pratyush
noted that if we support multiple opens then the agent can hand out the
opened fd's to the requesters and if they crash the fd goes away as well.
Jason said we should do this with an ioctl to give you a new fd with a
session label.  Jason was concerned about the lack of the ability to
preserve the access control for a filesystem across kexec.

I confirmed with the group in the call that there was no objections to
proceeding as discussed for LUO v3.  Pasha noted the only planned changes
would be to enforce a single open and then use the ioctl to get the
session.  Jason was going to provide minor feedback upstream.

----->o-----
I pivoted to discussing the agent, affectionately referred to as
LiveupdateD.  As the LUO design was not yet finalized, there was no
decisions formally made on the LiveupdateD design.  Pasha suggested that
LUO v3 and LiveupdateD development could proceed in parallel.

We discussed where both LiveupdateD and libluo git repositories should
live.  There was a general feeling that this should be decoupled from the
kernel tree.  Pratyush was going to create a repository both for GitHub as
well as kernel.org.

----->o-----
Frank van der Linden then discussed his concept for a physical memory pool
allocator.  Frank presented this as an allocator for large contiguous
stretches of memory, such as HugeTLB and guest memory, including for
partial mappings like PFNMAP required for Confidential Computing use
cases in any size that we want.  If we have a 1GB physical range of
memory associated with guest_memfd, for example, it's fine to map a couple
megabytes of it; if you have a 1GB folio, however, you either map the
entire folio or nothing at all (or break folio).

Jason said that if you are happy with PFNMAP, you can map part of the
folio; you only need to break up the folio itself if you are going to put
the folio into the VMA as an actual folio.

Vishal Annapurve said that the way we are handling 1GB support today with
guest_memfd hands out physical memory backing shared ranges to the core MM
so that things like gup can use it normally.  This requires breaking the
folio.  Jason noted, as he mentioned previously, that you can keep the 1GB
folio and use pfnmaps everywhere else and ignore the folio.

Frank noted that our interim solution of using many devdax for preserving
memory across kexec is more convenient with an allocator underneath it to
avoid needing to specify tons of memmap= options on the kernel command
line.  Similar to hugetlb_cma=, this would specify external memory such as
extmem=0:1G,2:4G.  Only the bitmap allocator is used for creating raw CMA
areas that are physical memory only (this memory is removed from
memblock).  Jason suggested that there may be pushback upstream for
additional allocators; Frank suggested that if this forms the basis for
other allocators then this may be a different story.

Vishal asked if we should mandate PFNMAP mappings only for guest_memfd.
Jason said that if our only need for guest_memfd is to create a vma to
speed it into KVM, then use PFNMAP is reasonable, which disables ODIRECT
and RDMA, etc.  That may be appropriate for Confidential Computing, but
qemu certainly relies on it today.  So while it may not be possible to get
rid of the folios in a broad sense, it could be possible to propose.

Frank noted there is a conversion layer that allocates the PFN range and
does minimal hotplug as necessary, converts to HugeTLB pages, and adds to
the pool.  Additionally, there is a device interface that can be used for
testing.

The pool and device interfaces work, as well as KHO on top of this.  I
asked about the minimal chunk sizes and alignment, Frank said this has the
same alignment requirements as CMA today.

I asked about early RFC timelines and use of the biweekly Linux MM
Alignment Session.  Frank said an RFC about a month from now would likely
be feasible and we should continue to discuss Jason's point about the
concurrent use of folios.

Jason suggested that we need an answer to what problem this is solving and
if it's only to use PFNMAP memory for guest_memfd then this may be a lot
of complexity when there are cheaper alternatives.

----->o-----
We transitioned to discussing PCI device preservation.  Chris Li had sent
out the patch series the night before that can get the list of live update
devices and their respective dependencies.  For example, if you need to
preserve the VF and then you preserve the PF as well.  Additionally, if
you preserve the PCI device then the parent bridge also needs to be
preserved; this dependency goes all the way up to the root bridge.

Jason questioned how it will keep track of what devices are bound, that
makes the driver name part of the ABI which isn't great.  He imagined that
if the device is marked as preserved for KHO then it would sit in limbo
until somebody claims it.  Chris said that the kernel cannot detect when
we're finished probing the device.  Jason suggested using an ioctl into
the LUO file descriptor so this becomes the responsibility of userspace.

----->o-----
Next meeting will be on Monday, August 11 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - follow-up on sticky preservations with KHO, any additional insight
   provided for MSHV use cases
 - update on LUO v3 and akpm's request to rebase on top of 6.17-rc1 and
   send v3
 - discuss enforcing single open in LUO and also support for using the
   ioctl to get an fd with a session label
 - design discussion for luod, the agent previously referred to as
   LiveupdateD
 - update on physical pool allocator wrt folio support and the ability to
   pfnmap from within the range of memory
 - update on PCI preservation, registration, and initialization, and the
   RFC patch series posted previously
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

