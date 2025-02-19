Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA02C021AF
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 04:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/1CbMeTGavk4T2TQG8Wh+P+k6CxlJkoFkaDMpL3O9rM=; b=Sl/yn84/1bLCecoA9Xk66yf8gw
	zBsDaZMHN91PucbNRJwQB94KcBUFCUVEw/ovIw47WVPTWYa+tMJAnw1U+PfrzcwIvIbCsZCnnVbwg
	CJkLSlFLgIhMDA+glxAeUzP++GBaXUKrVv6zEr154ZH4GsKBRxJ5E/+Ok2OTiPBZ1cEUR9iVrBcs+
	Gd8q7pXVnz+hshDTqaDYeQRYmvgWlpqlwFGAAgdGw2uPlVl9R+wU2oAqLKeFQ/hyGDF8jTRSlcsjS
	uqkKAnjBQy1KCXBXnOMM7z+CYwlLWLpDu8eHgxwVVwGixTbBSi74sq8biXc6G+1AUWyNGgnd+QiiH
	mUD+W4gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkbKP-0000000AnwS-2Ryz;
	Wed, 19 Feb 2025 04:04:53 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkbKM-0000000Anuk-2zRA
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 04:04:51 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-22117c396baso542405ad.1
        for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 20:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739937889; x=1740542689; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1CbMeTGavk4T2TQG8Wh+P+k6CxlJkoFkaDMpL3O9rM=;
        b=DfjU3nEtmuYk/v26sRviQGAVmSF1lQTWabR2RsmrHgdXIyXSK7CG+I9A3dpvpWuHbl
         QEXNLmIll9aXr5EMYov2wMWFH8ebgIDfl3+PZmNBZUzrF8zlSc74fTpAGW633IKGprX/
         r8pG6CKc5epIcPBtCMTxtcVIlTKgrF5novmerSa4Dxi8A3YVhWu1I2ekn7i0JhLLI3JV
         m42luDu4GGR3SJjIXm5Ze3G4tUgdDzfFPzr9vtpC+mvyPDuqCYvlyRgcPTgBc8bOYpSn
         6Q93rRGfN4cbVNGetEeXpKsmUmTIdAGTvNXa6PkQechAlmJ6AdE+a09XBC6FhoKMq9TI
         Vfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739937889; x=1740542689;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1CbMeTGavk4T2TQG8Wh+P+k6CxlJkoFkaDMpL3O9rM=;
        b=k9iDs1bUwWa/0zC0hH5AzFa5wObB9kj4FdYnf3uO1aaHNmTHWY6mKxcVTUfjChTms9
         P04gRl3Uv7gHeeQyDhAvMDQRlTbNC1rJj8ziEayEq23jFlDGD+zdueqwfgJKhNfg2Y5A
         VbSfkJHvuMkdh1RymZ8Wiuy006o6RUyZjGu+Fap0ahdqF+SZRmXLyqVV19Z9Bfq10Ad2
         nL4Lh3rspGAIkuiCS/yPIpnJw8z17omprEdT65k/MccJVJesGmWgDllCvQYdnpDKk1sV
         MBFpc1M/iVT/ZNOC0NX2bgJxnCPqXJUS/Q+5odAR9n/1v/DVZTOf7DGl7+YtjSLkTukS
         wxcA==
X-Forwarded-Encrypted: i=1; AJvYcCWwqFyagQNZ/IwH4uF+IPHcCByndP+Jc0Vb1BTHPRuNkPER7Veoz2UtlEJqNJIxSqS/w/woxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRP5y1LhqCsO+sgpvukdqaqNY00+Wy4nb+i13uNfrxDfFnJkit
	zbY4sFymOwqEvWZJTAYz9HYM88I2bpUmGSFFgfR+kB0eK7LRHmiAsXqF1SxyPw==
X-Gm-Gg: ASbGncvMGY4hmb0NRntj4D3vWqzwKE0DvMJobzJ6tmauAm/v5L4fJK6KtqXXWuxU0KG
	GX2g5SeOZO3XgqgnkYZGrVG3J6/KG2uIoIjpJ0Q+b8DBfSeL1Ozc2R1SKkfezHrUZpDKJbyGDzA
	i3Ww4CLxKLwAwaTGPjP6zCSKbDN2osZ6hiiiPCvh+EHUZHKszNI+lDF7wk54d+Ws7PLck+ybiwr
	dmT24FkW8+mFfzKfIX7iuoyKuzmuTli4LN6vApcMiFmI2qhJY6XRgHwxtSutFL1Akdkycttte7e
	r9QdgCsJEiUKS5OdJx9rd3dgVYBXwQ3LE9EZPEKixF8xGb+ykjLUVLLhesuHuTErbCqG0h6do1O
	gI5Du3EbU4g==
X-Google-Smtp-Source: AGHT+IHmBPa+/ldm44EMohM9jKZFDe+NLuVimzm7brPo/TKk+ElQlGUFHQ/mL9HTDct7sfwqaYSEaQ==
X-Received: by 2002:a17:902:ea06:b0:21d:dd8f:6e01 with SMTP id d9443c01a7336-22175a850c2mr980465ad.5.1739937888904;
        Tue, 18 Feb 2025 20:04:48 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:3222:29ed:dda9:52c7] ([2a00:79e0:2eb0:8:3222:29ed:dda9:52c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22117cd038fsm54494735ad.218.2025.02.18.20.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:04:48 -0800 (PST)
Date: Tue, 18 Feb 2025 20:04:47 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from February 10, 2025
Message-ID: <dc1ee0c3-d3e7-4284-6329-346b8cea68b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_200450_769157_5F06021C 
X-CRM114-Status: GOOD (  32.13  )
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
on Monday, February 10.  Thanks for everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
James mentioned guest memory persistence and the future of guestmemfs,
including feedback to allow for more prototyping.  We didn't get into
this topic during the call, so we'll touch on it in the next call.

----->o-----
Mike brought up the sysfs interface, whether or not we want an activate
or not, as well as aligning with the devicetree feedback that was
received on the last upstream posting for KHO.  Every new binding would
need to go through their code review and Jason noted the scalability and
flexibility concerns for this.

Jason noted that older kernels can ignore newer devicetree components and
everything still works, which is different in the cases of live update.
He suggested a much stronger compatibility for live update purposes
between pairs of two kernel versions.  Andrey agreed that we don't really
need devicetree here and pointed to a patch series he had developed that
doesn't rely on this.

Pasha agreed that for the short/medium term it may make sense to decouple
this from devicetree.

Alexander noted that FDT was chosen deliberately: we want a generic
key,value store and the ability to add attributes without invalidating
compatibility.  Andrey noted this can be done without devicetree.  There
was discussion on using this as a KHO-tree and not precisely a
devicetree.  Schema validation was another attractive characteristic of
FDT.

Alexander noted the current discussion has been focused on nodes and
sub-nodes as a structure based on runtime data: the decision had to be
made between structured data (incl debugability) and data that is always
in memory and gets translated from one kernel to another.  Jason thought
we needed both.

Pasha noted Intel in 2021 had preserved VFIO passthrough devices using
PKRAM.  The PKRAM patches and its interfaces turned out to be very
difficult to maintain, given PKRAM did not maintain ABIs between kernels.
It relied heavily on developer insight to specify what needed to be
maintained in yaml files.  Mike suggested that we'd need to be able to
allow drivers the flexibility to point to an area of memory, a struct, or
a scalar.

James discussed serializing all inodes in guestmemfs with KHO in previous
work, and this turned out to be very useful.  Newer kernels were able to
add new fields and move things around, but the downgrade path wasn't
supported using this.  Jason noted there were similarities between stable
ABIs provided to userspace and filesystems.  He stressed that complexity
here for driver maintainers may become too burdensome.

Jason suggested starting simple: structs pointing to structs pointing to
structs.  Have drivers that have versions 1, 2, etc, and allow for this
to become more complex when needed.  There was a general desire expressed
to not maintain the kernel direct map and the virtual address space would
end up getting scrambled, and that must be supported.

Alexander noted that KHO's strategy so far has been that FDT has been the
standard for compatibility and the usage of it versus other solutions
depends on the specific use cases.  We'd need to extend tooling to do
validation in the future.  Alexander noted that after writing 1 to the
activate file that you'll grab a snapshot of the device tree from sysfs
and that can be used for validation.

----->o-----
We shifted to discussion on KHO v5.  Mike noted that there was a sysfs
interface that enables KHO and then the KHO data (devicetree and scratch
description) gets appended to kexec images.  Only the scratch space would
be touched by the new kernel, not all memory is preserved, although it is
in the kernel direct map.

There was a discussion about using a bitmap (or an idr) to indicate what
memory should be removed from the buddy allocator during early boot.
Alexander noted you'd still need to be able to associate that bitmap or
data structure with the specific driver that needs to find its memory.
Jason noted this would be the driver's responsibility.

Jason stressed how this would be used to establish the ABI, for example
if a driver does alloc_pages(), store memory, and then use to_kho(), this
is a nice clean interface to preserve driver memory.  Doing things like
GFP_KHO would be more invasive for this.

----->o-----
Pasha led a discussion on the next KHO series to be sent upstream and
alignment between people in the call.

Pasha suggest we don't want to have kexec file load as part of the KHO
process and rather these should be decoupled from each other.  We want to
minimize the blackout window as much as possible.  If the VM is still
running while doing KHO activate, we'd need to prevent any operation from
changing this state that limits the VM functionality.  Pasha wanted kexec
file load to be completely decoupled from KHO.

Alexander noted the point of the activate phase is to accelerate the
kexec so that we can serialize state, goal being to keep 99% of VM
operations still possible.  Pasha noted that some devices need to be
preserved across kexec but others do not need to.  Jason suggested not
coupling this with a global activate state, in that case, and Alexander
agreed on allowing certain drivers to participate and not necessarily
all.

Jason stressed that we need to all agree on the state machine given the
discussion two weeks ago.

----->o-----
Next meeting is scheduled for Monday, February 24 at 8am PST (UTC-8).
I'll send a reminder on this mailing list.

Topics I think we should cover in the next meeting:

 - the future of guestmemfs and what it becomes, including alignment so
   prototyping can be done
 - Andrey's patch series that didn't rely on devicetree
 - alignment on not preserving the kernel direct map and using different
   virtual addresses in the new kernel
 - v5 of the KHO patch series with minor fixes
 - establishing an FSM for all of the various states that are agreed upon
   with common language (when memory mappings can happen, what is
   disallowed at certain stages)
 - extending the above topic on a separate FSM for the entire live update
   process (what happens in brownout, blackout, shutdown, etc)
 - iommufd patch series (as well as qemu) from James
 - establishing an API for callbacks into drivers to serialize state
   during brownout
 - topics proposed by Pasha: reducing blackout window, relaxed
   serialization, KHO activation requirements, and decoupling KHO from
   kexec
 - implications of preserving vIOMMU state

Please let me know if you'd like to propose additional topics for
discussion, thank you!

