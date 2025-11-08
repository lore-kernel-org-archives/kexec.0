Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF5ECCFA18
	for <kexec@archiver.kernel.org>; Sat,  8 Nov 2025 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qwrxSi6UEHqswkqxklVcNAH4yAiA2ZEOPwBLU1p/RJ4=; b=b5kIXVeapqDCP4+DANKFgk2zOi
	RfE3WhMLDqaJe1Qsu5YjJ+/1poFWknWmwDI9dqvXnLH15SITrtMB6PKOiDZwaQzhZanmthlSJFOnE
	ddsrIL/MP6hJpaNBgtymnT/2HGaP3K7KGkp8SKcmBeC7UB6rpDpVYAyWnyPt4WNw2TsjSv2Fab1Ht
	TRb+N8hbfRPyMlo9pwVJNXMcMi6zjGFoHwfNEn19NxFCId3iLuXkpXtvFYHg4hvqrfdBBgzYD/b0s
	LT1joTZHx2IOaL0fM05Z/UFLk9paVg+YkNEF5JEJpjuvGY16eolEBRT6ZBb/J0HuQ4i3ZpkKMvg8N
	p6UNXcNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHsfi-00000003aKO-3hWK;
	Sat, 08 Nov 2025 23:48:42 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHsfc-00000003aJa-30Xt
	for kexec@lists.infradead.org;
	Sat, 08 Nov 2025 23:48:38 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-295c64cb951so174015ad.0
        for <kexec@lists.infradead.org>; Sat, 08 Nov 2025 15:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762645715; x=1763250515; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwrxSi6UEHqswkqxklVcNAH4yAiA2ZEOPwBLU1p/RJ4=;
        b=xo1nzYIgA92BJ5j6LtugSkrJRU5BAkcFs9OPdjwp/JpG8VaoQmS/vKZ+DRP/BOqyLq
         5GlMgLtTZxfyw0Gs4eQSvN14BMw6RcC2zZPuQ7oJehDKFoS3a4YM8fCwdbUwEN7kTefl
         xbpMa3un7H4vxmYEZmURAcyZAt1vORSPx/7hWgH4b9PcvthSYEv+uVvSUZPsX9Nh/11b
         ZLkeWPlIbZsFF8ZnlWE/HPWyFKewQs/dVnt/G4iR10FuauGQ9l8kwpt6f7noWiy/v3g0
         RxgFUQYx4MHaXGUmb09EG+6SvfyEgu+5IV8Sk7FghsnRwy90OOjoaBKsIw6ikVKivuEa
         XZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762645715; x=1763250515;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwrxSi6UEHqswkqxklVcNAH4yAiA2ZEOPwBLU1p/RJ4=;
        b=NYuC3dCkdqVhlq0LDNy6dDG0hOMvWBU10lpCFZSdAYGLZY/k8iGFNlhm5Wj6hl5HAn
         eA19FaAc4btGnkQUS67zp3z1W5CVE/1GnajqKn0wOdaUQg4Vy0h6BUDlAGCq71SuXlLb
         EfJ1HsmaUwsD/dzMRe/wgQv35um0t6wpVDHpmisoxsXmyFy8oDlf+wddty18UYJ6gGjn
         uGFQ+5KpXobOpll6EgKugEJYojFAXqcYgRFtXgDr16+zPWS4i/tsW0DwIahsD00KetlD
         V5jtRPpHvEbh57s7hrGThHTOD72s5n0WLySHIw7xMmb5776yDSePUAe/3w4tYLnRpxno
         buow==
X-Forwarded-Encrypted: i=1; AJvYcCWOwr/bbNz/KIRA8xB/DrovdvT8aZsCyXAYa0Zi6is+hhGZrA1KLVca07ZqfbNkZ4OwVbm4EQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfrzHqZdp+NDQYdaXAz2k9mUT6YGxec0MrFhxKKFRQPXytFMCt
	pubRfQX1SxFHnMdzBs6kj+8te6VmrMpgMh4KrTdJ2oKv17jvmnjTUaMNhSqAXo2ZRg==
X-Gm-Gg: ASbGncvZlLyz5/XVTx9PxRb0OrNiGopuGHR/Lm8YJVJflh75eMuKojnN0iRTDza3BiG
	aoZ3ZTCPPK5IkCliMx0UHGWI6iWLH0jKCM8Hykw3J3hEVgW/OqFGNjs9qTrpVuzcwVsLPSMd5FB
	ZU1RmY1XDKH50Xm7ieaW74lh4yVm3vt1z2wbI7gwaL7bF+idXhvViY7wH1sw7gNtPoW9BCF80Qy
	5JwcJJVd4fI51COZuC3LZUZwSUrt59N0lY4Gg+UCKdZ8CP2ZSYurywneggl+1a470b6yd4aLBF7
	l6bady7Z8iBybpdFhatRav9W0DFpfCJJRPyEYHwd7OlslDHGQ6yHNWpWOhmRfUGZ75nC4RsWBSl
	5CUDdsXZT5PWDN7gHsOVPJ3j7dfQ3TTUWhkZD49FLZ5vv53UfZi/Dtn+MjLbRcE+7RP+w5OATUd
	/R0Uc70OEj0qbv/RHNQXb0pi+re1YfbZ1qzzvis1Qny96lZdgOTNfDm9EKgGg6tQ1fnXcvv8OHz
	GfNV5Zmr3eCs6SG3JJ6TaNJovWj4V4AyO/n9Qk=
X-Google-Smtp-Source: AGHT+IHnRXXlbxI6BuGqHQ+Qtc6VE3S+F4KHSKReZWqHs/e+LWVIZk8w0dmbYu68ZQcpwXrQfqtj7g==
X-Received: by 2002:a17:903:1a70:b0:294:e585:1f39 with SMTP id d9443c01a7336-297e569ea05mr2974675ad.14.1762645714529;
        Sat, 08 Nov 2025 15:48:34 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:1130:5154:e55c:701] ([2a00:79e0:2eb0:8:1130:5154:e55c:701])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f20dsm98249625ad.65.2025.11.08.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:48:33 -0800 (PST)
Date: Sat, 8 Nov 2025 15:48:32 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    David Hildenbrand <david@redhat.com>, David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from November 3, 2025
Message-ID: <7742456c-b248-04cc-0e1a-9da7d0546f1a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_154836_792481_0BC3E905 
X-CRM114-Status: GOOD (  27.68  )
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
on Monday, November 3.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We chatted briefly about the status of the stateless KHO RFC patch series 
intended to simply LUO support.

Pasha started us off by updating that Jason Miu will be updating his patch 
series and is expected to send those patches to the mailing list after 
some more internal code review.  That would be expected to be posted 
either this week or next week.

Pasha also updated that is plan is to remove subsystems to simply the 
state machine and the UAPI; this would be replaced by the file lifecycle 
bound global data created and destroyed automatically based on reserved 
file state.  He was also simplifying the state machine to keep the minimum 
needed support in the initial version, but with extensibility for the 
future.  No exact timeline although it is currently ~90% ready.

----->o-----
Pratyush discussed the global file based state and how it may circumvent 
the LUO state machine; it's an implicit preserve of the subsystem 
completely independent of global state.  Pasha said the state is now bound 
to the state of the preserved files only based on sessions.  We're getting 
rid of global state for now.

Pratyush suggested to tie subsystems with the file handler but this would 
not be possible if subsystems are going away.  Pasha said the new global 
state is flexible and can share multiple file handlers; one global state 
can be bound to multiple file handlers.

----->o-----
Jork Loeser as if there is a design/API link for the memfd and whether 
this is something a driver could use to persistently holding data.  He was 
asking if a driver could associate arbitrary pages with a preserved memfd.

Pratyush said the memfd preservation was part of the LUO patch series at 
the end.  A driver can pass a memfd to LUO after creating an fd.  Pratyush 
suggested using KHO to preserve data; the data may moved at runtime but 
would need to be unmovable during preservation across kexec.

Jason Gunthorpe suggested using APIs to get a page from a memfd at a 
specific offset.

----->o-----
Vipin Sharma had posted a recent patch series for VFIO[1], David Matlack 
will be working on v2 of this will Vipin is on leave.  Feedback was 
received about not moving the PCI save state and making them public, so 
that's work in progress.  More feedback said there was missing bits and we 
need more PCI core changes that would be updated in v2 to be more complete 
(but also include more PCI changes).  No specific timeline yet on v2, but 
it will be based on LUO v5.

David said the VFIO patches are using an anonymous inode to recreate the 
file after live update and asked if we care about associating recreated 
fds for userspace after live update with a particular inode.  Jason said 
that VFIO would care because it uses the inode to get an address space 
which it uses with an unmapped mapping range and this must work correctly.

----->o-----
Sami summarized the discussion on IOMMU persistence.  He was working on 
updating the patch series to v2 based on the feedback from v1.  He talked 
about restoration of the HWPTs on the restore side.  Jason thought that we 
wouldn't have an IOAS for the restored domains and suggested it could be 
null instead.  Sami thought this may be slightly invasive including where 
we are taking locks; Jason suggested against a dummy IOAS.

----->o-----
We discussed briefly about deferred struct page initialization support 
with KHO.  Pasha said KHO isn't compatible with deferred struct pages 
although when using KHO we definitely want fast reboot performance.  We 
decided to discuss this more later after LPC where there will be some 
discussion about reboot performance.

----->o-----
Pratyush noted that he is working on the 1GB preservation but will take 
some more time to clean up and have it working properly.  He said 
guest_memfd would use hugetlb for 1GB pages so he's working on hugetlb 
preservation.  Pratyush was focusing on generic hugetlb support that could 
be ported for use with guest_memfd when it supports hugetlb.  He's aiming 
for an RFC to be ready by the time of LPC.

Ackerley updated that the hugetlb support for guest_memfd is currently in 
RFC patches posted upstream.

----->o-----
Next meeting will be on Monday, November 17 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on the status of stateless KHO RFC patches that should simplify
   LUO support
 - update on the status of LUO v5 overall
 - follow up on the status of iommu persistence and its v2 patches based
   on v1 feedback
 - update on the v2 of the VFIO patch series based on LUO v5 and expected
   timelines
 - discuss status of hugetlb preservation, specifically 1GB support, with
   regular memfd, aiming for an RFC by the time of LPC
 - update on status of guest_memfd support for 1GB hugetlb pages
 - discuss any use cases for Confidential Computing where folios may need
   to be split after being marked as preserved during brown out
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://marc.info/?l=linux-kernel&m=176074589311102&w=2 

