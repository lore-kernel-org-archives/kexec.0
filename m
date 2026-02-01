Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B1CE7C6E3
	for <kexec@archiver.kernel.org>; Sun,  1 Feb 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f+oWmSGi3OnfcgGTsDgVrrdujfgV5/abaDUEB3zopaE=; b=bHzUfZq93CkQcBGGLIN7/805a/
	Dv/FaBK2UA0mBI54YmzbhRQcnyd93Wazs3baOv1Qt8VXbXJiJ7yPKuf6TMRgL+Th+OF2Cwx6ORxtb
	7Kku+feL209cPbw5Gt8AIWA/8tQYK3QDH/7hh7i+V0XT4LRwddtmh2h9YNAx6mOdYnygkG1gutjKn
	0MxN9XLd8jM3XaXm4T0a2ep+iEFje/LZRX+juJh+NKl+n5YzNjsRC2eU0p9a/hsB2huj/ink9qaSj
	x4JMD1Bh5t1I7ESxS7dBGy7sh8IwNsS3Ie/Fqmj+cj/e9K+KB+azMHVbn74+N2l+byABTCvWkdg0z
	CJpGmy8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmNNI-00000003C6i-3rt4;
	Sun, 01 Feb 2026 02:39:44 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmNNA-00000003C6O-3VdT
	for kexec@lists.infradead.org;
	Sun, 01 Feb 2026 02:39:38 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2a1462573caso65725ad.0
        for <kexec@lists.infradead.org>; Sat, 31 Jan 2026 18:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769913575; x=1770518375; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f+oWmSGi3OnfcgGTsDgVrrdujfgV5/abaDUEB3zopaE=;
        b=eO8PYALcbfCcCMQw64x4/X4EwzeTrXN64FsepUyJJeics7hzQI9e3PwIG7fLbBclF5
         KCpjWlexc45f9HeXRgxN9J+UOn+KisnQfjNficuEK1xYCyXRV0LC9ZbnQzkw7dvBVBZY
         AHVdyFb7rg8Iu3HRxZd3O0g+852BfPUmEYCIOSnO39KglNRgUZF31wnZjXODjXqe4XKZ
         2dhyGPtq6qfFtGw7TTejDc98RuyY5WUjcELHjrV6pUQhSPXBi3LSeAFT0Cm+SqzGg+Rb
         GsL7xXhzj3eFgTAH1TbspFFCerMR3QUJVoKX8X5YBEarFU2u+WZ0antWpFq7YuLHISfG
         8uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769913575; x=1770518375;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+oWmSGi3OnfcgGTsDgVrrdujfgV5/abaDUEB3zopaE=;
        b=qkVfaNUdUoAZYsSf/Hlc09fIiGIrCM/Urroaznwx+ZTZ4F+VcxmAK+Ev5vPm9rxTSS
         p8OWXF55Aw1mjHd54D01noCI3uTsnvIRV38xYlZKNBFKVmBZlZYLvlmjt8RHT5Rp6t31
         diTYhuv3urff3/6Sr6CTkLsU9tvElcn3Fci9OY0GI9bmaYs/rvYZbi+US8Ocds7YJd0T
         W2k3d+rG46+cQWY+QtkKfwx+VPWXpjDU1VKO+nminCSjlEueRpTGQ+hxyOH1JE1FyCvS
         iyyE7XiSmWqLrxuIj5hCmRuyl6neRf9ynRu+MWvffA/mqaBnV27Q/m6vSUMT0jS3bdsM
         Gfew==
X-Forwarded-Encrypted: i=1; AJvYcCWnsToASYamAcPXTm/sgzJ7bugNGXRy7pETDMhUEE5NZRjGshFYdtldy7dgSOcVxhhRMbrBjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQcs4fQrYbN2m4w/ZtlRG4XwaDnEG5LB3lLMFwD4rCz7ssDlTX
	mFpvm3le8OflyGzvejLG+EKcEqqAWfLE9azikDwVd+R7TaskdjQOKsO+Va+3zV4IXA==
X-Gm-Gg: AZuq6aJL49UuDRHzo8Io98SFYRedmbnTJYw1Qb7S7dJhnpfiJqKukpeQiWX1YbA2VuP
	cuEbwfuh80y8NJKPXj6stdkFHbd3A4n6xE3gaL3f9emW5ggO5pNxsJ+oPBOWoO6Jq42cfP4Egf5
	V2aMLKBhEevOPmo5JZQs0Emaf7vKxgfnVA9qfvWZ5s6k1/TGhf2ADhyzl7fVtPR8oohP7/nxMeb
	5evwfoxSwJ0IitXIc0LfQF3aekIVTpnz1vw/5Cer4MsT8WsngFfcegNUvhslWsu7kRZ7ew+sJXe
	dnaI5JuNyRHJHzovj/WwOUunKiKnNdzw39YekDDJLIs2H1JrBEPOAV0aSS5jtvbyEU4riFvYcvg
	0yjdMF39kvW3X9+SKDDFllh6bIyJFYGaF3Aa9ebuYfBdD48GhrDrllvcWAlaLOpagDXHCadEqc7
	V7M2uK7UH8c+jxN2Rmm7M5bRlWy17zfK4pyOzcXN2Y5kvIsETflZyERFXI+R1HOvhxpG/upjyxW
	gMA0COF939VUtF/CaZthAOU8immKOVNAK6TFOurdg==
X-Received: by 2002:a17:903:41c2:b0:291:6858:ee60 with SMTP id d9443c01a7336-2a8f303cd1dmr2763475ad.4.1769913574385;
        Sat, 31 Jan 2026 18:39:34 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:863b:f9a9:4fb1:e225] ([2a00:79e0:2eb0:8:863b:f9a9:4fb1:e225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d52c396sm3585655a91.4.2026.01.31.18.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 18:39:33 -0800 (PST)
Date: Sat, 31 Jan 2026 18:39:31 -0800 (PST)
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
Subject: [Hypervisor Live Update] Notes from January 26, 2026
Message-ID: <5f9a56f2-ee8a-0a7f-206e-fef46595c4d0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260131_183936_917964_843B2449 
X-CRM114-Status: GOOD (  31.88  )
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
on Monday, January 26.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
This was a lengthy meeting with lots of discussion on various topics.  
There were a few quick updates to kick us off.

Pasha updated on the status of stateless KHO: Mike approved of the latest 
changes from Jason Miu and a refresh was on the way as long as there were 
no more comments.  It should then be on track for inclusion in mm-new.  
More review will be possible even after that.

David Matlack updated on ordering issues when disabling interrupts during 
live update, he is working with NV GPU team.  They have a subject matter 
expert who is looking into the issue and will update David next week.  
This should not delay future VFIO and IOMMU patch series, the changes for 
interrupts would be incremental on top of those series. 

Pasha updated on the status of luod: there were no major changes since the 
last meeting but Pasha was still looking for feedback on the design[1].

David then updated on VFIO v2 based on previous comments and was looking 
to post an update this week.  This includes documentation for device 
preservation and then extended for iommu in the future.  He's also getting 
rid of the patch that does auto-probing.  He's also reworking the PCI FLB 
to not be accessed after devices are initialized.

----->o-----
Samiullah continues to work on iommu persistence, he was looking at 
Pratyush's series on memfd seal preservation so that will be integrated.  
The next series should be sent out in the next week.  He also discussed 
hitless replacement for iommu domains; he had connected with Baolu 
upstream and received feedback from Jason.  Baolu will be reworking his 
series and then posting a new series upstream based on that.

Jason noted some differences that will need to be done for hitless 
long-term to support ARM.  Sami noted that he'll have to look into that 
and discuss with Will.  Jason suggested using a temporary VM ID.

----->o-----
Pratyush updated on HugeTLB preservation RFC and then presented this at 
LPC.  Feedback has surfaced no specific concerns.  He'll continue to work 
on this over the next couple weeks including tests.  I asked if this was 
being reviewed by anybody outside of this group; Mike Rapoport noted there 
wasn't any feedback from core hugetlb reviewers yet.  This should be in 
good shape within the next month or so.

He also updated on versioning.  During LPC, it was clear that the full 
support is not yet ready to go.  The luo agent would read the vmlinux of 
both kernels before performing the load and then can look at a special 
section where all the versions of the different file handlers are listed.  
Unless you support multiple versions, you can never roll out a new version 
in the fleet, the next step will be to figure out how to do this.  
Pratyush was leaning toward his suggestion for version negotiation.

Jason suggested writing out all the versions.  Pratyush said there may be 
a conflict but also was curious about how that would scale.  Jason 
suggested there should actually only be two; this should be considered as 
an escape hatch and shouldn't be overcomplicated or with new UAPIs.  
Writing all versions sounds like a useful starting point.  Pasha said that 
adding a new UAPI could also be done later.

----->o-----
Pasha brought up topics for LSF/MM/BPF that is coming up in May.  Beyond 
HugeTLB preservation, he was wondering if there were additional topics to 
discuss there.  Another possibility is guest_memfd support for HugeTLB.  
Pasha suggested KHO may also be in scope.  Struct page initialization may 
be another topic to consider.

----->o-----
Stanislav Kinsburskii noted that he sent an RFC out for blocking kexec in 
the kernel.  He said Microsoft needs this ability when the kernel deposits 
pages into the hypervisor and we want to make sure that if guests are 
running or pages are deposited before we have proper support for these 
features, we want to block the kexec.  Otherwise, the new kernel would 
become inconsistent and can't access pages that were deposited.  He asked 
for any feedback on the list.

Pasha suggested to use fd preservation for this instead.  Stanislav noted 
that the kexec syscall does not shut down userspace so even if an fd is 
exposed to a userspace process, the kernel consistency depends on a 
userspace process to do an ioctl to keep an fd and if kexec does not shut 
down userspace processes then there is still a way to get kernel 
inconsistency.  He suggested that this may not be a reliable way forward.

Stanislav said with proper integration, we have a file descriptor and if 
userspace closes this fd before the kexec, things are consistent.  We can 
have a guest running and pages deposited into the hypervisor and then 
somebody can do a kexec.  The expectation is that the new kernel boots and 
that it is reliable; this is not the case with their hypervisor as the 
memory can be leaked.  This is different where the VMs are KVM VMs and 
userspace processes.  The suggestion was to have a hook to block kexec to 
support other approaches.

Pasha noted that if you have preserved the memory and the state then this 
is no longer a normal kexec, it's a live update.  Stanislav asked if this 
is the one procedure that can ensure consistency across the live update, 
if one does not do this exact procedure then they shouldn't rely on 
consistency after kexec.  Pasha said that with LUO if userspace preserves 
fds then those fds are going to be preserved across the live update; if 
the session is not closed before the live update, then those fds are going 
to be preserved.

----->o-----
Next meeting will be on Monday, February 9 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - latest stateless KHO patches and inclusion in mm-new
 - ordering issues when disabling interrupts based on feedback from NV
 - luod design feedback and implementation next steps
 - VFIO patch series that would be incremental on top of the previous
   version
 - IOMMU persistence patch series
 - hitless replacement for iommu domains and series from Baolu
 - HugeTLB preservation support
 - versioning for luod to negotiate
 - live update related topics to propose for LSF/MM/BPF 2026 (hugetlb,
   KHO, deferred struct page initialization)
 - later: update on PCI preservation series and next steps
 - later: guest_memfd support for 1GB HugeTLB pages
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://tinyurl.com/luoddesign

