Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F70AD715F1
	for <kexec@archiver.kernel.org>; Sat, 24 Jan 2026 23:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=41oDX9CeFkyWVe3DgqelqlEWjcwkHQMeIKtRf379l48=; b=GKGLqqlH7Bdh+ClN2NvmT9IqF8
	v2Aht2800QunOEj2tGLNxDS/NbRrpbRJ8naelnCArK8FIWc4JRyah9+s1fg/UladnUlS8wxgDNRSr
	dTqN1miwZrKN4ZtPyXGRbg1hzSPiATQG/gnK25YYqiVDcKPmqttH4y3vtGlD5PDaH0xNziKj1J+zO
	vp10Emmvt1L18GTlKRrUmLJL1hf+qzpWoWOLAT31J4X+8FicDosbLdLvzNM1EtaQ92Sm9/pzUGX8z
	LS/S94EVqxAHEHIt0qZiGAewSEEJiJ57G7Cg/CMgxPXcWAvvsj4arc80zghJZnMw7q/Y41cDb1a12
	w+3FnuYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjnXY-0000000AiTJ-2rSH;
	Sat, 24 Jan 2026 23:59:40 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjnXT-0000000AiSv-0eE0
	for kexec@lists.infradead.org;
	Sat, 24 Jan 2026 23:59:36 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a76b39587aso49045ad.0
        for <kexec@lists.infradead.org>; Sat, 24 Jan 2026 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769299173; x=1769903973; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=41oDX9CeFkyWVe3DgqelqlEWjcwkHQMeIKtRf379l48=;
        b=lzXE7+YWJCIwb1Boiwm1jYjKgWxMFnPHI1HwE99uRQtpdlrWRzgCrqGmPJxWJOjsu5
         BUU6UB4xrwPE9fHAC/fT1uDWrrFVD88nurUw4I18dMX3j3wekjeZldSyyGb/OjhbQFSx
         UKr1Y7AAPQ2SDltHpX+3NVs+1Yo2m0nOVQGkKW6j6nNLRExwt6oMkmZkdtqIE8sRkolC
         qVzdbzPDlDzCx1jkomc4eH7lW6V2FZdOS2KnwudfB/Yq634k8UKpGansrB7zCCjLhjxc
         fO8RP753ACT5859j3wcyiI9nBkPFclg6Dq9Rxn8NxGgJOtlSljm3BLgZjkE4q4W/4xSM
         fqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769299173; x=1769903973;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41oDX9CeFkyWVe3DgqelqlEWjcwkHQMeIKtRf379l48=;
        b=mvT+ehDzZNlHKekHuTvP+mpoc0qcN4r0+OFd/3OHCBON4mZODqXPl/jJiH4QpmNwv1
         44TDFFs7pmN2G6KMVAKeE3R726hF20kBAtVtHA0UeYnJ1WoYpby1Dh85PcuRiDRV/x9S
         Nb/AO7l6//Z3bltDiGOjsSsM92MOhyX1tq8HHyK3NDVlHAbfbNylEie3eV9aATh5SCgO
         gv7WLPObZ714I3IKqN0FkO9tp1cBKYFFuG7BYpLAGJg5h1RxdT13pAx/dceJbOe0IOLJ
         Kxy9oKT2KZhG/EYb9jBMD16OrymS/XNL80prT1wMxHQ7X5AlEBjerkBwoiurxC8SJnJz
         rwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7hnd5M8zZlw2JbEY4kv52BZP01pOMMJ0KQ/TFF4E2hZvKLtek8AsrecR3iXnWx38AduwDIQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzAlGZCJ+Pagd0zaoddSKJec8oPOPJtosuEjnlNXXsXO6Ffhjd
	yXYtgAENkPvVuC8bLia7aXDpVXCqUx1pL7dGhkrXCQ5O2r9rveAqYPs/Set0l5vhEQ==
X-Gm-Gg: AZuq6aL61czvDYikYbCAcxRCQxxc3JRFAKvulcI22LU2roAmpGT5nHyhyx2xFtZvewl
	06fCXGXOYs0whh8lxOc/rW7PJa2SRtNbqBw7Ne+ht6WRr+X7ySeDEozR4G4fioSaZ87q6NuUTq/
	ackowsJEnQ5zP9q4/ch1BU0s8FCKElkz7o3u7XwDOOlAaoerkNsYk8TlOt8PGjrKnHL8saNat9F
	g870OqFjrw2YOHONbiPReCtka7P2lllmR07w9Lto/jifwfIr9Ua3slrT3AFRfNdCeUQX46Oh4zH
	6rjPiRd9uMlCG7YLtTdieBq8HMRIvugwX2vVkPhoruYUHpgsDAnHRKPGIGpDQv/I/EEjdvz8DQM
	kbzUuSM9ywDMoRnWoceln0nUZRoHVp+gEULYYvwu/EXfdoP9ZEQhztQc326hyWHlVH8qaa6OdyQ
	nIu+CDyKpM2TaZz5BE1y3LWdYv5STqJVipIRmYyzo60jzHiPNMYc9sjs5E9H4tZ8Or7bJ3km0yQ
	gXI3aIDT5umh1abZjbcyI5SjhFBnYmgCJq0w0XKqg==
X-Received: by 2002:a17:902:fc48:b0:29f:2563:7772 with SMTP id d9443c01a7336-2a844b0d351mr92865ad.8.1769299172865;
        Sat, 24 Jan 2026 15:59:32 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:817c:d8ee:c019:7966] ([2a00:79e0:2eb0:8:817c:d8ee:c019:7966])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231864489csm5606494b3a.9.2026.01.24.15.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 15:59:32 -0800 (PST)
Date: Sat, 24 Jan 2026 15:59:30 -0800 (PST)
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
Subject: [Hypervisor Live Update] Notes from January 12, 2026
Message-ID: <0cd54dec-4c7a-03f1-e899-a4fb14d09e23@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260124_155935_253693_0DE9E0EF 
X-CRM114-Status: GOOD (  22.70  )
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
on Monday, January 12.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
This was a relatively short meeting due to the holidays and all of the 
fantastic discussion at LPC in Tokyo.

David Matlack discussed a follow up from the VFIO talk at LPC.  There was 
feedback that disabling interrupts on devices during live update may cause 
ordering issues so David is following up to understand it better and then 
decide the right approach to address it.

Pasha learned about other work on orphaned VMs which would be the next 
step for LUO: be able to do a seamless VM update as a stepping stone.  
This may take some companies longer to switch to an upstream 
implementation for live update given their current software stack.

It was noted that after LPC that Pratyush will continue to work on 
versioning support and memfd preservation.

Mike Rapoport noted that the videos from LPC have been posted online if 
people missed any of the sessions.

----->o-----
Pasha noted that v4 of stateless KHO was sent out last week and received 
some upstream feedback.  That series is getting better, Mike did not 
suggest any substantial concerns were present at this time.  Another KHO 
series is also upstream that moves some of the ABI to a separate header 
file.

For LUO, Pasha is working on luo-agent[1].  There was an upstream patch 
series sent out for qemu to support fd preservation using LUO, but without 
sessions.  luo-agent is anticipated to provide the sessions to VMs, so 
Pasha was speeding up the development of that: he also updated the design 
doc[2] for the work.  He was soliciting feedback from anybody who is 
interested.  There is also work underway to support LUO with CHV.

----->o-----
David Matlack updated on the status of VFIO.  His goal is to get v2 out in 
the next couple weeks, it shouldn't look much different than before.  The 
next thing on top of that would be iommufd and PCI device preservation.  
The PCI preservation doesn't yet have a solid timeline for the next 
posting as engineers are ramping up.

Samiullah noted that he sent out an RFC for IOMMU persistence that was 
presented at LPC.  His plan is to send out a non-RFC version next.  He 
also sent out a series for hitless domain replacement for Intel iommu 
driver; there was some feedback so a v2 is in progress.

Jason suggested that Intel would need to do this: Sami was going to start 
a discussion with Intel developers on that support.

----->o-----
Jason noted there was discussion from LPC about a storage box use case 
that could leverage KHO support for preserving information about the scsi 
devices so you don't need to go rediscover everything.  This may have 
overlap with the PCI preservation series if people are interested.

----->o-----
Next meeting will be on Monday, January 26 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - status of stateless KHO patches from Jason Miu
 - possible ordering issues when disabling interrupts during live update
 - luo-agent development and additional LUO changes targeted for upstream
 - next version of VFIO patch series to go upstream
 - non-RFC version of the IOMMU persistence patch series
 - PCI preservation timelines
 - hitless replacement for iommu domains, collaboration with Intel
 - HugeTLB + 1GB page preservation support
 - versioning support for various components for luod to negotiate
 - later: update on status of guest_memfd support for 1GB HugeTLB pages
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://github.com/googleprodkernel/luo-agent
[2] https://tinyurl.com/luoddesign

