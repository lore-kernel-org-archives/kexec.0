Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3BD116E2
	for <kexec@archiver.kernel.org>; Sun, 30 Nov 2025 03:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MCBBAxlTF2mP5Z0U0RiB6hYPJch5Onp44ekWPHKT/TM=; b=g8JqRCLe2vyVikKRDztQQbln6m
	DNtjb+TiukZnkm6fUcMsJg4bKSI/lliRy8U/HVvFKHy0tR10HcReawM629NqHR6hkHZrX/uVa3gOS
	jOzN2MZQiurtYbgYkOhwdf3pyAf8sHr+ala2FdUNKamdTGJuyUZWt5FHvOF3o1o1JR6ieDhQK+HXv
	740GNc/ndMRutAytbvUhCD492kIpH2hYgE2uZgK6QyERjpdH3XWbhfFHDtvEZnXqgV0d3dYbga/dK
	OXn9Dnee9jYV1l0ZUuatI1hM6xDjhPcmw165TrYVQiByWsELQZQIu0yeQFUs6gSFJRCFK7p6tgHzG
	udB0N8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXsF-00000001zPK-0szB;
	Sun, 30 Nov 2025 03:13:19 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXsC-00000001zOx-2S8C
	for kexec@lists.infradead.org;
	Sun, 30 Nov 2025 03:13:18 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2980343d9d1so510705ad.1
        for <kexec@lists.infradead.org>; Sat, 29 Nov 2025 19:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764472395; x=1765077195; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MCBBAxlTF2mP5Z0U0RiB6hYPJch5Onp44ekWPHKT/TM=;
        b=l3yp5fiyHvTSYtL669rmmle7udFEHgVMmRYLhzPWVKkHHkLdW+OH9U4VdrHLJyGRx2
         gYPFNZPOqN7pIZ0T2qSEzTRNIVgelSt/UjcU9ktRmfXPf5++tmZqO3WGzMMpQcSV0sAK
         4g6j+KWRU6dzL5KaSnFjD4O6vtjNC3cdp2yZIlj8RWMJ+NX8Dpf8Mv9T1UTAAkX2PdQY
         WjCDUqxQMEjtkcdX2+9q1Ow5j++TddOdBXPQ6VgIjnjAhCQNykuerCLLzq5UM2o6XjMI
         Fmeb3fhosWyA+JoSMa+Uefo+TsaouPVafJLQUpvq8FXJTSxtTEjEoNX+67+8OodJLP+e
         RNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764472395; x=1765077195;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCBBAxlTF2mP5Z0U0RiB6hYPJch5Onp44ekWPHKT/TM=;
        b=ePYTJCRiOLPDPFhBEsM0clri5R+LFiFVslVHNFT5DRBrZA22tkp91g8u+Py8YoVCyM
         uPtHFRATTFPPgI0WQ3PRuuaUo0dXDNO8CqVE8Co6eIMDVPqiJJ2+1O3OAzY8CJdvmgfl
         uS1K6ry9SI+5F4SV3ARXkVTYMu+cxzHKbs/0kPLGh1tjXenHBVXhoSPlb2bRSCxlhPWH
         bP3PaaoyET0ZDa9ifIES5yHgKZsVZgg1woXEJ9QRghmcHMkejGxdujeMN0XaLjrwSy98
         lrq0tG2ashGWhYsVsaW3E0vsiRpmuupT/tjH7ctrYwNqOD1LB9D5wrK3LssMo3l7PFIx
         aDfA==
X-Forwarded-Encrypted: i=1; AJvYcCXyzBUzL7jC0AlIw+X+y8p0Iz8Kt/Xjo/TM+vmMDvYOFQ8zIKaJOKlBjRsHLAiyE0dMnETYJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YybFpNuEx5DV0lSduoZWB2t46X8oUwrDHcjq4GujcbegexE/1p2
	qfhzk3zJtZlRnDu9oXLbRAhf/reZFb3sDYVlHmtA0yKVAOx+TL9LCpNRRtAWU6NkqQ==
X-Gm-Gg: ASbGncuTbqnFk3TmAMXdfSookrM2i0P/4CCYnt2vyKL3EH9ha80OYowT+/vh3zWh16q
	VYvKr0cgoJpVc6KiQduek8zLQ9DDWwq64g2vHAPYygES7dAWskuPMguFCYDcNVZ1PEAb2ZUA2mA
	tb8o5H2N3dOCsl+FyBlW+5cZh9qLVJsvO4befhqCfs2eBG7dHPOdj+jmE8zEGdHHWW3EMx06xvh
	MPmNOFJztxW97Cvn0OtXq4YvJLbHZIVr4AwO2QuiHpZy9gvCWnbZAQ43qaTNubbbvavUbT5jpbH
	3JD5B9hLEavSdIF5RC4zFbfcVdJhwRE8XdzD1l25yaRCefzh3LVC7ycbPmN19AAJtT0by0DCQUr
	4mLWN/GKho3PETkH+lVozXTMDbykdOZGoM0XHcUMdxqUFOXpXMSMCQxoUdBh1xagHGXZecBv9Mu
	cib2yRQbO+Of1Dec2msP+7XDxupJM4bmYouH4W40se/mNB51RDLsUNCE+Iq6YEiEVJcsXmiO5qL
	LEONj/bZAe+qWrmJKe2GZldUAPP+Wl5JLoXOWHrmg==
X-Google-Smtp-Source: AGHT+IFgfpSjKCxaZhf994kFnZ8HtKRLMATnNcuNs/sCEnSeCxzSVsaMlNU2QXY8ZnDwZ6McKV65gA==
X-Received: by 2002:a17:902:ea0c:b0:298:3544:aa72 with SMTP id d9443c01a7336-29bca38cdc8mr4716285ad.9.1764472394421;
        Sat, 29 Nov 2025 19:13:14 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:7b08:e467:32c2:1b3e] ([2a00:79e0:2eb0:8:7b08:e467:32c2:1b3e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm9410054b3a.29.2025.11.29.19.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 19:13:12 -0800 (PST)
Date: Sat, 29 Nov 2025 19:13:11 -0800 (PST)
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
Subject: [Hypervisor Live Update] Notes from November 17, 2025
Message-ID: <c08e37c1-d007-b518-f59b-f2d0ebf587e2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_191316_691153_F50A762F 
X-CRM114-Status: GOOD (  24.29  )
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
on Monday, November 17.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated on the status of the stateless KHO RFC: Jason Miu had sent 
an update of the patches but they need to be rebased on top of the latest 
KHO series.  There were some simplification patches that had been sent for 
KHO that changed how the FDT was used.  Thus, the stateless KHO patches 
need to be updated again as well as some splitting of the patches into 
finer grained patches.

LUO v6 was sent the previous weekend.  There were a number of comments 
received for LUO v5 in linux-next that were addressed in v6.  Mike 
Rapoport was going through v6 and provided the most feedback.  Pasha was 
planning on sending a v7 for the next merge window.

----->o-----
David Matlack updated that he was going to be focused this week on the 
VFIO v2 patch series.  His goal was to have it on the mailing list by the 
week of November 24.  The goal was to be able to gather feedback prior to 
LPC and then leverage that conference to discuss the open questions for 
that series.  Sami and David had discussed a minimal patch series for VFIO 
preservation as the next feature that could be merged on top of LUO, 
setting the stage for IOMMU preservation to build on that.

----->o-----
Pratyush updated on his HugeTLB and 1GB page preservation series, he got 
this working internally for v5.  It is not ready to post as an RFC yet, so 
the goal was to have this in a state ready to share over the next two 
weeks.  This will also enable LPC discussions.

----->o-----
Ackerley provided an update on guest memfd support for 1GB HugeTLB pages.  
He has an internal version working.  There is no preservation support for 
it, just guest memfd with 1GB HugeTLB support.  Pratyush had previously 
discussed with Ackerley and felt that the series were really independent 
from each other.  Ackerley was planning his next posting to the mailing 
list after LPC.

----->o-----
Pratyush discussed an idea about versioning for LUO: there will be 
different versions for different components like memfd, IOMMU, etc.  He 
was thinking to have a mechanism to define different versions.  This would 
be supported as an ELF header in the vmlinux.  When you load the next 
kernel in preparation for kexec, luod would read this next vmlinux, see 
what version it supports and determine its compatibility with the 
currently running kernel.

Jason suggested discussing the roadmap for FDT first, he wanted to ensure 
that the dependencies were sorted out fully before doing optimization.  He 
wanted to see more infrastructure to support the versioning and wrote some 
thoughts on this on the mailing list previously.  The ELF versioning could 
just auto-generate out of the aligned design.  Pratyush proposed writing 
an RFC that could be used as the basis for further discussion. 

----->o-----
Next meeting will be on Monday, December 1 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on the status of stateless KHO RFC patches that were being
   rebased on top of the KHO simplification
 - update on the the status of LUO v7 and its potential for merge in the
   next merge window
 - update for the VFIO v2 patch series intended to solicit feedback prior
   to LPC
 - next steps for iommu persistence to build upon the VFIO patch series
   once that is merged
 - status update for HugeTLB + 1GB page preservation support that should
   be ready to send out by the next meeting
 - continued discussion on versioning support for various components for
   luod to negotiate
 - determine plan for December 15 instance of the meeting since it's
   immediately after LPC
 - later, after LPC: update on status of guest_memfd support for 1GB
   HugeTLB pages
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

