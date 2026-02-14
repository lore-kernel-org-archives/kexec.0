Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6448EF584D
	for <kexec@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CkdJp5ac3TutvWba81u61sOxpegpzJzEEd6Unh7sqvo=; b=D2rnpUnCS6DscDa2Diftlfyxst
	cmnkchU7iJ4BWiaII+FyCxQB/xqd+TVdP4xBDROqBWedyo7ZU6YrMFxkB+PJuEzu4/wJo9Zgcu3QB
	IGNyjKMNt96L6887/ej8F3geY8W6qnmnKotOzsMcFVv1xSq/67fqegk2OEKCNa1KWeb/v6EE/GuC9
	9fhVq49uvdtBbkGWVQa8M1Vt35bKqfQ3yVCSZ6RS2charLX7UvxyhtOwflkTVKCtUTVCMvqw5umGW
	SKBaJ/kVN1PnNHrISIbIWZp9+y7PSIFAqkqcoNer0OTNDdSq3ZHCmVKB+wK9qka++vmJq4146T/5Y
	cPVLFgJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrPNZ-000000051Zg-0Oty;
	Sat, 14 Feb 2026 23:48:49 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrPNW-000000051Yt-0nxe
	for kexec@lists.infradead.org;
	Sat, 14 Feb 2026 23:48:47 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2aad8123335so55805ad.1
        for <kexec@lists.infradead.org>; Sat, 14 Feb 2026 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771112924; x=1771717724; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CkdJp5ac3TutvWba81u61sOxpegpzJzEEd6Unh7sqvo=;
        b=bS3onhuFaUAy80GjhA+Hac9ZQbiVWo8zbGHLy/HH1nHgC3XcZ6QuASjJgfzho0drpZ
         vVwfqiPDQeUfgqGn34vyuIbIposGQi3vghmgSbjWtFr+yOiKb3u9dncDUUCewZImJbjd
         4hstu/+n3NtF0OwiBIV4yB2/POO3Xzzhexjs9IRVMZclfjGf4tHPWtv6Em/eR2KKC1HQ
         /83q/+Vp2GM+cbFvOfIQmLqYyiOA1Bacgpf/GDOs+WasCFRGBSnWguBHdbqyZv2IrS29
         3F4svdR/aYAp4vuVZQ/T1f0jXofdq6zDHVmiZbGAJY+ZpdWkoQ7kIYH/qIHZxq0BEbRY
         P2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771112924; x=1771717724;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkdJp5ac3TutvWba81u61sOxpegpzJzEEd6Unh7sqvo=;
        b=gk3YdeMMUPCyTOVY3GXDFPwFk3BEZtoON/cWfJjY3oWuO0Ux2uUlpYVyNWoxFBsiwu
         2gkBHBR9atMJBPOn38SV0H414rh146mS+kG3K1lFkBSP5Thu9R6hkbDtQCHWlf2j6My8
         7s2Spnu+gXNSpz5WE0MtDX7PIOjI0W89bEH+AwrXKutUGYmw0IJHijaW1bTDmcmBU/xP
         trjTSEjjG5Yf2KGQisWywRGQTazKV0mietvTPd87OTCLwt4EjS4SIoxfUQme67Zo9gzT
         wIYbQLBnUk74eBolRmMl2GefipZccd9/cN+cz+uPDga6ynL1uRVmzCdqcluhytw5DU6k
         XCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDwe132zf4av3h3XUha4P4X6EFokX4ireX6qYib+4Rx2ROeGbgPtt+93VHqqogeVFcFzG2w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6om8MMdtetTSPcWHTwtuVRVbtOCVu7hPCMvh7k0ie5Eq87SO9
	NIJqW8Hq6VL0Xm+3nH+Jxxes5ojyTGGsbSYJUJtnMCfCCX4C+M7HnA3cyQkml53VhQ==
X-Gm-Gg: AZuq6aLh3usx/7FGp6LV8YwLcWOj0tEsvh2woXHCHt9YhXKNrKure7k/A8Zhatagllw
	CxhHoP0WpNltnOuMJp5xZVQzXT9rINjbjdfAfriljtaez/QrEJ+CKilZPiNRUJbiB3Qr4AkKUgx
	WP6KpClrlpP8GnKqCufOcqkklN395LLfj5kwhxIwH8T/IPspi8W2+67Y33lRmiZAwzHEtfcdDwN
	ergjWs4UGR2xUC1JMX3xwNacTJZdyPN9KCF8FIz+0AGpFk9y45AqAjfLJHfGxcOSpfBiOWYvhH0
	sOA9W9LpzuKe+KHu5ExAgGuc49SWCk2GCnWA1+qfXU0nAhtLlkW6twPIOldk5NviNZLYPave9gm
	XjnFQRTMEI485ZioGgpjhfb6fSpn3Bid6Uv8INDfA53nJP7qP3IsH5trIoRSlrOpTdXaVZzI21u
	PNNmhmbPTBwSwNF22i2F95RItefOzL6JT+YRQUKENBtPtTPlPYrbSeWTHXINbyk4A02ZbjLkSSb
	aIE+LnBPjPZcq12B4s9+4y6kCYe2E8R9MUjBKP1EzGUffABcEuXCw==
X-Received: by 2002:a17:902:db03:b0:2ab:333:22d2 with SMTP id d9443c01a7336-2ad1f0ded00mr889685ad.20.1771112923780;
        Sat, 14 Feb 2026 15:48:43 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:97ad:c968:9be7:91a9] ([2a00:79e0:2eb0:8:97ad:c968:9be7:91a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2afeesm7588583b3a.2.2026.02.14.15.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 15:48:42 -0800 (PST)
Date: Sat, 14 Feb 2026 15:48:40 -0800 (PST)
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
Subject: [Hypervisor Live Update] Notes from February 9, 2026
Message-ID: <4697ba0d-8291-d9ca-8895-c3dfe4113166@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260214_154846_274993_0EB2F09E 
X-CRM114-Status: GOOD (  17.02  )
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
on Monday, February 9.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Stateless KHO was reviewed by both Pasha and Mike upstream and they are 
on-track to be merged into Andrew's tree with no blockers.

We're awaiting additional feedback on the luod design doc[1], so please 
take a look and provide feedback directly on the doc or bring comments and 
questions to the next meeting.  The main question is whether this should 
be part of systemd -- if so, it should have a different design based on 
systemd.  Luca was noted as being interesting but there hasn't been a 
design review yet.

This is important because VMs would interact with my luod and LUO 
sessions, so there are APIs to align.  If luod is standalone, then this is 
more challenging to align; if part of systemd then this becomes easier for 
qemu, CHV, etc.

----->o-----
Sami updated on IOMMU persistence.  He sent out v1 last week and there was 
feedback from Jason to divide them into two phases, so Sami sent out the 
first phase.  First phase only has preservation, the state of the IOMMU 
page tables are preserved across kexec.

----->o-----
Pratyush updated on the status of HugeTLB preservation, he's planning on 
sending a series out for RFC v1 next week.  He also sent out a proposal 
for LSF/MM/BPF for this topic.  He also suggested we do a Linux MM 
Alignment session for topics between LSF/MM/BPF and LPC.

Ackerley updated on guest_memfd support for HugeTLB.  The next step is for 
conversion support for private -> shared.  Although not a hard constraint, 
this is what the community has decided on for upstream merge.  Pratyush 
suggested parallelizing as much of this as possible including for HugeTLB 
cleanups.

Vishal discussed folios being fractured on conversion and the Confidential 
VM requirements.  He also discussed dependencies on guest_memfd specific 
features that work needs to be done on for HugeTLB support.  We planned on 
carving out time in the next instance of this meeting series for that 
topic.

----->o-----
Next meeting will be on Monday, February 23 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - stateless KHO patch status in Andrew's tree
 - determine if luod would become part of systemd and discussions with
   Luca; implementation and next steps
 - versioning support for luod to negotiate
 - HugeTLB preservation support
 - ordering issues when disabling interrupts based on feedback from Nvidia
 - VFIO patch series that would be incremental on top of the previous
   version
 - phase 1 of IOMMU persistence patch series, then phase 2 status and
   updates
 - hitless replacement for iommu domains and series from Baolu
 - [15 min] guest_memfd support for 1GB HugeTLB pages and preservation
 - live update related topics to propose for LSF/MM/BPF 2026
 - later: update on PCI preservation series and next steps
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://tinyurl.com/luoddesign

