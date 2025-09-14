Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26865CAC58F
	for <kexec@archiver.kernel.org>; Sun, 14 Sep 2025 01:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vjCs7FIKhGYTaI5MHKlkJ6fq8tqN7U3QyTgSWV87yJY=; b=arLUrGvSWX1u6R+IMLvRezwh+s
	uTe4bVc+BkDm/U1CFd6J53aP1SN0juP+wfyntXWo83J9H3K3RAI+Vgo6gFZA6Eca7clfaNJx8LOqO
	Ef92rXTzHplCyJbV8MzQNRxg0XKNjsMWYDLs2qcA0wgfXNAwUbfXyOAPnxhmpHIWaUWx13meq+/hk
	8FNMaID7qnuUNpBgCLXuIPOgNjGGsDQa2FnkXahD4+ehKGF9L3gB8DqtygnTDz6JZjDx9u6uWULjK
	zGjiDK3qQZq4wBrZs1rGY4s2FZFUYqLbs6S4lQeY2DtXh53nutwP/5QPGDzzuO248C2GP5V+KNaIJ
	q28sT/Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxbyb-0000000H60Z-3Zl5;
	Sun, 14 Sep 2025 01:56:25 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxbyV-0000000H5zL-3uNZ
	for kexec@lists.infradead.org;
	Sun, 14 Sep 2025 01:56:21 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-25c90c3ba65so155085ad.0
        for <kexec@lists.infradead.org>; Sat, 13 Sep 2025 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757814978; x=1758419778; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjCs7FIKhGYTaI5MHKlkJ6fq8tqN7U3QyTgSWV87yJY=;
        b=I+SQ4pNsUsVdHBBSB7wsE8lfBTb7wUXlILVrl5sUUBi4/Jkrckh3+umh4lMdNrsilW
         Ner7a8gbUPjly1ComiA/ohDM6s5cnvSyRwkxlgNXH9s8Dr3hS8bcfd4N18QEvTI7P3aj
         llbRTXfSqjye1YzXK0oAUCXqxfuDH9d0iNc6GihtqoQjEEq9e9RRXY9/5on/jN83F3T5
         p1ya6EfSXoWpfWD4miao51hMewUQuayNNuYRYGcG8k+58jhkwopcvhNhLBeY+X2lpK0B
         cDM8oxGXkltipHy8JU3oyY7iUxKHKKO/uaSiKWn+/uhYp4rL+lUv/bmhvwolFzO4/lav
         Om8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757814978; x=1758419778;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjCs7FIKhGYTaI5MHKlkJ6fq8tqN7U3QyTgSWV87yJY=;
        b=uCjst72R8t5NuRnHpy2KUFkJQC1arqhW+50hA71d7Rh0uwZwMY55lb4RT9fJaZrkZd
         5BQr3aVKhB6y1sXcN9w3buviGIBCBA3GxctN8k4hGXEZOV5Up6+p3qO8JU8tb2pLK/A/
         p1o7qTQ4G0Y86TFDS6EHuqzuTkP3hKDzz5QnaRbssUHPZY1ZWMJgBN52Vr7Z7o/m02BT
         mLbyIeaoQtwytHybYsniwtZ86+EqXUlHrm0UPJnyMra3XqcOsEhYwPib7ImCgoNEZT/o
         DZzPEA8ajfJnE/QUA7thty1aq+JO6VDb4r45rT7ZxtfrYH/F6SAR7pFgsY1qOPEXLgfa
         67JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNLBBHVbP1W6qeda3psiftERGieW3hD55wFWyez+rB+paqarubGpIuWKCrJ1HWrx2ZR1qzCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGyN5pPF6bI+ktCtqQ6rHnOAOM9AuZUrSyyqStjfium4/eo6yT
	4d6wy+LpQFrbRRGRB/DttvqfnkEufzH+Y9UPLk5abBaT0VzWkk8s9GPBM0qpNqYw5w==
X-Gm-Gg: ASbGnctmRhD2A4qX8Ke+nzRDgZifSp2St7P7J4gvXnjH41uy2ESr9bGs6Uma83ZeCKB
	aKktsO+QdZ4r/k63Fd7Ob08ejRKG1KJJkSl+IjmbGZJPR3d+sw0x+Qmz3vg74kOTJ21ePVksjwJ
	36v4Prnn2qopI6OlIvsLlOFtxaBzi/4RFhMvpjEPlj2tvKmRWyqWwML6QUWT0Q4UtGTMvyjHUjZ
	CGIA/NPPPeIJZCSDELAzBvtedTC9NtmL6N9hMbLO6RiXqcgikQUWhEip7tYriUvqE1pOPLKfNjr
	PqfGx8AUoDuFUDPyRJ/dxyBTf/guEM70Y5UDBckbaFlpDG56UYRXWF8GIvPugimckr8LzocHf/x
	CHr1VTCWBHWhk9qwVR8KO02ZJ13V7SX/0cLd6UWdeXSvJubL10akV3adw5mvS8xcsrTQUyv5tdA
	k2VeXYzg2DT5K3fUtwyaFArS2WHHFfzNLGeTqyaxVDQWfWoVPm2uQdrAiephy8vXGQMDuItvBTH
	iOO
X-Google-Smtp-Source: AGHT+IGDJa1lL70XMMd5Je6cvOH5zekLB1M06oJvDtXwFRJlN15res7fswi8As8eyCvf7x9Yz50GYw==
X-Received: by 2002:a17:902:ecd2:b0:264:f533:75d0 with SMTP id d9443c01a7336-264f5337a4amr159305ad.9.1757814977860;
        Sat, 13 Sep 2025 18:56:17 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:9637:d030:f547:d052] ([2a00:79e0:2eb0:8:9637:d030:f547:d052])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e0c2863e6sm3512068a91.28.2025.09.13.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:56:16 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:56:15 -0700 (PDT)
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
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from September 8, 2025
Message-ID: <e3935e6b-0475-e780-fad0-85933377aa38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_185620_001744_34594DCF 
X-CRM114-Status: GOOD (  26.44  )
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
on Monday, September 8.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
I relayed updates on KHO, LUO, and memfd preservation:

 - Jason Miu shared the page table like implementation for stateless KHO
   to Pasha, Pratyush, and Mike; they'll send this out more widely after
   iterating on it

 - Work on LUO v4 continues with session functionality being a work in
   progress, luod will be able to create the session through fds and pass
   them to the clients and fds can only be preserved and unpreserved as
   sessions; this requires an update to the design doc

 - Pratyush shared an updated version of memfd preservation; we chatted
   about the 1GB limitation.  He will be incorporating changes for that
   into his next patch series.

Chris clarified that the work happening on the page table like 
implementation today are not real page tables that get loaded into the 
cr3, it's an abstraction different from PKRAM that used real page tables.

----->o-----
Chris Li brought up a topic from an internal discussion on whether 
stateless KHO would support folio split after the page has been preserved.  
The answer was no, if a folio needs to be split then it needs to be 
unpreserved and then split before preserving again at the lower order.  
This has some complications if something under the hood is doing collapse 
or split.  Chris clarified that this happens during the preservation phase 
of memory (live update prepare).

I suggested that things like khugepaged doing collapse could easily be 
enlightened to avoid this but split is more difficult.  David Matlack 
asked what actually happens when we try to split folios that has been 
preserved, i.e. what's the failure mode?  Chris suggested that this isn't 
handled at all and the new kernel will see the wrong order.  Jason 
Gunthorpe said this was user error if folios are being split after 
preservation; after a memfd, for example, has been serialized then you 
cannot do things like punching holes.

Chris said that the call should return an error when this happens and we'd 
want to avoid silent errors.  However, the only rules that exist today are 
that you'd need to unpreserve if splitting the folio before represerving.

----->o-----
Chris discussed KSerial and the kernel-to-kernel API interface, not a 
kernel-to-user interface, so it should be considered possible to update 
later.  Chris mentioned that he was working on incremental helper 
functions.  There was also discussion about posting patches before any LPC 
talks as a general best practice.

For PCI preservation, Chris said he send an updated patch series this 
week.

----->o-----
Andrey Ryabinin noted that he had prepared an update to KSTATE on top of 
LUO and suggested that KSerial may be too much.  He asked if there was 
interest in this being shared, and the group echoed that there was 
interest.  The patches will need a little more work later, but it works.  
Chris suggested there may be some good collaboration opportunities here.  
Andrey would also submit an LPC discussion for this.

----->o-----
David Matlack noted that Vipin Sharma had discussed VFIO support for live 
update at KVM Forum[1].  He suggested that we may want to have the same 
talk happen in this meeting series.  There are not patches available yet, 
but they will be available for LPC.  We planned on setting up about 25 
minutes in the next meeting for this topic.

----->o-----
Next meeting will be on Monday, September 22 at 8am PDT (UTC-7), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on latest status of LUO after v4 and next steps for merge into
   akpm's tree
 - any updates on luod based on internal and external feedback
 - update on memfd preservation and status of 1GB limitation before
   integration into akpm's tree
 - discussion on what happens when we split folios while preserved and if
   there are failure modes when this is attempted
 - update on the latest status of PCI preservation, registration, and
   initialization
 - any updates on VFIO with noiommu as a next step for preservation after
   Chris's v2
 - update on status of KSTATE and its integration with LUO
 - 25 min: VFIO support for live update from Vipin Sharma
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://www.youtube.com/watch?v=IYfR1jYeM1g&t=1583s 

