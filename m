Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CF1CFD314
	for <kexec@archiver.kernel.org>; Sun, 14 Dec 2025 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Sdsg4erWIutvgEa7dX1ZHucXpg/1kUTw5cVvZEYCiLk=; b=BKwO0MH3Vrhu0rUoOj2IJ9TfP5
	nGXgfziDTQ/EufN9EqUd8XQpf0qRzk6bMT39fIiruA5a5Jp9TKrkzaY4T+gxWEADdyz6avXjPtrI+
	Q33LtGMLSfYGbPIEcnJ1/qpkAPc45urslzE0X3XVACPvaR4xpv+00bBOWNDjmdzmsSAAdyq1dmEBm
	ZD0wAdBjvC7H0OgueybL88URddFbXmQNCsYhBsK1+kL6m3dlj9G2td/FGnTAtEcvWunLz0pOL1IQe
	/Y8D7pxmFym8SMbWyy1RfyQGuIGpbTgPPMPCWrrPPlBaWQN7Be57yArVCBk+pDlQ57wL8Fzjwl4Vs
	XDq6E/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUdVs-00000002ASA-02re;
	Sun, 14 Dec 2025 04:15:16 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUdVm-00000002ARk-36Fu
	for kexec@lists.infradead.org;
	Sun, 14 Dec 2025 04:15:12 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-29e0753e5d8so698885ad.1
        for <kexec@lists.infradead.org>; Sat, 13 Dec 2025 20:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765685709; x=1766290509; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sdsg4erWIutvgEa7dX1ZHucXpg/1kUTw5cVvZEYCiLk=;
        b=urti57YN1P7Rlj+ve3dpX8rQtuW24lYilzaacxTaDaVQl91NfLq2EPBeAayzIFwO19
         3nzD5RTd95e64gLzB7lDy3O0f0aF3Ybg/voEvqFxGldEebHRHDD9+b5hUIVJ0ekvXw+/
         O5hESGPuXid431/gywrdSLk7SCZx8rw0tIUvJ8j7ZRTTKKDtqbzqtuqaJo8iJywy8SHI
         o4jWbmuAm6PRQX8NGFqbvh9Pi0Y//XgKFtchmlovRhnkObS6kGoex7Cjk5pZJdz95LSD
         eSQtC10zNfpG89WHgEB9l75iEV2U9YYtyQyR7v/5LMEUN7Pwe4DBH98ntHnCBsWPIVc2
         CEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765685709; x=1766290509;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdsg4erWIutvgEa7dX1ZHucXpg/1kUTw5cVvZEYCiLk=;
        b=gdfDws0Hdy7CwxMs0N+tfFH4eu4fx+kCInd+tAAV4KJtYCCwFCxyaUaLv3Sz8I2ZAo
         pzbO/5EEaUEM52xKdd19ra0pMlKad/ae7BAFQ/3JhgtEIqzghe1ICFbI9SjwiVwZiDMK
         A58fLdqRqp9pMzxTPUm8LPRm3PY46ygzD1+94hCQuvh2JBtoUSvPKEUgd4Rx73lb9bTt
         0bnSGgTIMOca8lOIl10cal7lSdNoDnvepBmTt0L+G+UC+aUA/Xezq9OJoREjIJOhj0/o
         2Mt/J4ZB+o5uQ269eOaqFt+BFhYuDmHyBh4LOjDP/hXoizS96NXiWJZhqy1RkBFoi8JR
         ihOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUagnkudUstwQ1PUUfoaYW/NN9dHg9maATQwfu1o6/wHE0536cgPtlUGLYd2yFNTcMg2zdwRw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyireD0kO7uLfqOi4pZqH6w1hqOlvbAOA+a0D25deEIyBaHqso0
	VgluiXugnyrK5CRG4dOreL1WwyZGsaUHkUZc59uMNi+mx2S8JK6j5jNxOZzcAkrCeQ==
X-Gm-Gg: AY/fxX7LMCdWyUYS5hoFXAOvzXN2AIbUrHN6TTy6XB9D0pLChNZ6VutGTmvsMLYl8WT
	uURiqiwoObAiWFZ80tQPFBwZ+8VskaiPKIuBqzymZKMIErple/GE1OYACBvmq0LoYAGd9TvxJoR
	ZtJuZN+k+3jE6OWFX0Uk3HYlFxEdgxDruYVjddYIfbXkZL8FFpH047xdUg6A3pCP0ArJubU6Eus
	vG+nfC5UW2kOQwG8wcedHPr+50gUJg4MxGay3PdCCdgaSrtGBg7nqK1JC9AggsCU9RZrERZ4OLk
	wXJly4mcEQIT9FVZoVCFYlR3mG6XfRhKvlgsEaRL5UcZ2d7hIj02pCtUjehKY+ETCjX90tVopB8
	3BOFchcV3KfdnQCHWwqgLDG4sDVjk5oo4ldC+niIy1jIQlPgbRCe2eDoGLykdt2pE67kkP1cF9d
	HRT0oRHFFWYOr43/5i8rVmgaIvF5kaVo6nDqgSJuvixDv/nZ6vcciOJWrugVtRT9CqgiYTef4YV
	7si3VJdeEVQhG5uHQf/lCb7/ojS1sN8dzjIl+E=
X-Google-Smtp-Source: AGHT+IExXFmG4ZkryCzQAXH2+nkErBtP5RMjFwMlasAYbVEuysL//WH3R+aZs7pF+b/vG6hdceMudA==
X-Received: by 2002:a17:903:1b63:b0:298:45b1:6ef4 with SMTP id d9443c01a7336-2a09060d850mr2737425ad.12.1765685708353;
        Sat, 13 Dec 2025 20:15:08 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:54d9:374:d4d6:8842] ([2a00:79e0:2eb0:8:54d9:374:d4d6:8842])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06ae3bsm96645555ad.93.2025.12.13.20.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 20:15:07 -0800 (PST)
Date: Sat, 13 Dec 2025 20:15:07 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    David Hildenbrand <david@kernel.org>, David Matlack <dmatlack@google.com>, 
    James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from December 1, 2025
Message-ID: <02fa839b-2e4a-20f1-9eaa-03df5947976c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251213_201510_814979_D3AFEEE2 
X-CRM114-Status: GOOD (  33.86  )
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
on Monday, December 1.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated on the state of stateless KHO :)  Jason Miu sent a recent 
update which received feedback internally and then will be sent again to 
the upstream mailing list.

LUO v8 has been merged into stable and is scheduled for merge into 6.19 
now that the merge widnow is open.  For LUO, there are a few patches still 
outstanding: end-to-end testing (there is one patch that allows for 
creating a VM to do automatic testing) that is postponed, a change to 
preserve file life cycle bound global objects (no user in original patch 
series) that is postponed, and a patch for an internal API to retrieve 
struct files and get tokens for dependencies (no user) that is also 
postponed.

Whichever user is merged first for preserving file life cycle bound global 
objects will upstream the overall support.

----->o-----
Jork asked if user mode tools intergrate LUO into systemd.  Pasha said 
that luod will be integrated with systemd; the design proposed the way it 
would be integrated.  luod would be holding the sessions through the 
reboot command so that the VMM can exit.  Jork asked where the designs 
were, Pasha pointed him to the cover letter for LUO.

Pasha noted that the source code for luod would be open source and added 
to our GitHub.

----->o-----
David Matlack updated on the status of his VFIO series[1] that was 
recently sent out; some feedback was being provided upstream that he will 
be iterating through.  This series is largely mechanical to add the 
plumbing to preserve the VFIO device file descriptor across live update.  
Actual PCI device preservation will be built on top of it.

Pasha discussed BDF for PCI device preservation and whether we should use 
a path instead, which shouldn't add much overhead.  He opined that we may 
need to preserve devices that are not PCI, like TPM.  Chris Li noted that 
the bus number is assigned from the ACPI table so you need to infer that 
the root is flat and that the first bus number is the slot, but that's 
ugly.

David said that for non-PCI devices that these would likely need their own 
solutions.  Pasha asked if the PCI device preservation would be extendable 
to non-PCI devices if possible; he acknowledged that BDF can't change but 
still wondered if there was a more common way to preserve.  David 
suggested that anything here could be added incrementally on top later.

For PCI assigned buses, Pasha suggested ignoring this parameter or disable 
live update if the parameter is set.  It opened up the general question of 
how we should handle conflicting parameters -- should this be handled by 
VFIO or by LUO?  Chris suggested bailing out when the buses we care about, 
i.e. those involved in the live update, get changed.  Pasha suggested we 
could allow the auto assignment on first boot and then ignore the 
parameter on live update.  David suggested that whenever a PCI device 
needs to be preserved (a callback into the PCI subsystem), that code can 
check if this option is enabled and, if so, fail.  The next kernel would 
still need to check and perhaps panic if it's set.  Pasha compared this to 
sanity checking the memmap for the new kernel which would be required for 
consistency.

----->o-----
Samiullah updated on the status of the IOMMU preservation series that was 
going to be sent before LPC which was building on top of the VFIO series 
that David sent out above.  There will be no autobind in this one and it 
is using internal tokens; the LUO get token API will be integrated later.  
This is currently planned as an RFC.

Pasha asked about the lock-unlock functionality and whether Sami thought 
that this was lagging -- Sami said that it was actually better now because 
there's better flexibility.  David said that the only locking for his 
series was synchronizing finish when the FLB is freed with anything that's 
using it.  Anything using it already takes the mutex.  If you try your own 
locking, then this ends up in a deadlock that is mentioned in the cover 
letter.  Sami did not encounter this issue.

----->o-----
Pratyush did not have updates for the HugeTLB + 1GB page preservation 
support but was hopeful there would be an update in the next week.

He also updated that end of this week or next week he was hoping to have 
an RFC to share with an early implementation for versioning support to 
discuss at LPC.

----->o-----
Jork discussed measuring KHO recently for internal use cases and found 
that traversing the preserved lists and inserting them into memblock took 
the majority of the blackout time.  He asked about the later agenda item 
for deferred struct page initialization.  Pasha said that was actually 
unrelated to the blackout window, it's rather an incompatibility with KHO.  
He acknowledged that KHO is very slow at inserting the memblocks, we need 
to address this scalability problem.  Pratyush had some ideas how to 
handle this, but none of them are easy.

----->o-----
There was an update from Ackerley on guest_memfd support for 1GB HugeTLB: 
he was working on qualifying an internal version and was hoping to get 
reviews on extending xarrays to support splitting to multiple levels[2] 
which was a prerequisite for the series.  This was on track to post by 
early next year.

----->o-----
The December 15 instance of the meeting is canceled due to LPC travel.

Next meeting will be on Monday, December 29 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on the status of stateless KHO patches from Jason Miu
 - update on the the status of LUO v8 for Linux 6.19, any patches that are
   still pending after upstream merge
 - discussion on design and status of luod as well as its integration with
   systemd
 - update for the VFIO patch series to preserve the VFIO device file
   descriptor across live update
 - timelines for PCI device preservation on top of VFIO patch series
 - next steps for iommu persistence to build upon the VFIO patch series
   once that is merged
 - status update for HugeTLB + 1GB page preservation support that was sent
   out in preparation for LPC
 - continued discussion on versioning support for various components for
   luod to negotiate
 - later: update on status of guest_memfd support for 1GB HugeTLB pages
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1]
https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
[2] 
https://lore.kernel.org/all/20251117224701.1279139-1-ackerleytng@google.com/

