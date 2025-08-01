Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A27CA0EFF
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=; b=EkMYBoF3EN3PoOedM9BJjv14JV
	h7TfrbhFZXb3hBG2Cr4zk0lq+vAfxOV0MJqjXB6Y/XY0P5FbesmONQqxfn5oD0H4ZpQNknd34CnSb
	V8oKWegEIi9b57pif8tHxkrVrSO46KyT6UcBVAQmfJWD5RoGr4xNzhZhNhyLgqO63iVZmxE+FUFHR
	UVTd0Vxk8Qr5NqTywGv6f9o8aApPlSrmZkAoT+x8vOYXs35AdJpzkN0kAtnj+L9Rn/YmKO3NqMxe0
	iv9TbShSi0HI0cEQUJSSbXjA8yq0VaCX7zQ0dt7zlCHzPrt0dMIWiIvNj3YWmqmsprCXZCpvlpV0q
	vb0QHBtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg4-00000008G1m-3VK1;
	Sat, 30 Aug 2025 17:47:48 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhrkp-00000006MTP-35Gf
	for kexec@lists.infradead.org;
	Fri, 01 Aug 2025 15:33:09 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-3322d1dded6so20054691fa.2
        for <kexec@lists.infradead.org>; Fri, 01 Aug 2025 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062385; x=1754667185; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=vQmnIgrhHwRULnNZYkhYMyeIp2YFvlwGr024trz2rQ9jJkxLsTuwbq+oqEb5S6eijD
         w5sFRRd4Rom4qpI10UnPoGOHRC35AfBLC1oxlyPbFWLSdYOEUA1lUHgVWjTIe6sJXkP0
         UJnKNE76KskcpCS9G34GzX0585Wn8YA6U94xlbzYynjm3S7IDy1CRle465EgUyVspujc
         b5NU6uzKvWxNq/IbuoMCoiNpbGpuraljmBT0Hqcrf6CkYvGdomf+jQZC+st0FtpZ6K2n
         gubzBISzNlwxQr8IF2XnXtOC0TK/3YOtay5vd973M6REt3+AdFxxwx1e4DMLqEG6K02L
         3Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062385; x=1754667185;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=H1yzcEZM0CBXbDDdk/EnsSF9UGLLpMdw0Z/e70NMbnDYJAlCUqFOXdLesEdfgFj9By
         GJbPe7VCzfqoSrXptykmjXg1UiIy+Lr+gguqK22UUXGGbIbtchn5FPH7ZiCz271qN69d
         g7cZ0l1AZCbMGNqxtwRCW2rIqsShLWecJ5nWUOUzhVHd3oSXCvdM2wzbadAsIThokFAp
         R4QcqJPDCnRhOHcp5igML3EYi7eEP9zLBgJsvz5XPAsNikkR57ex5Z41FYqrUyVflRdO
         YsZ/7GrEQ66wasWd9X3RJ07VS6nF9v/zuoKamSRa5F3lbNPF2FM3uChMfpoanAuJZaF7
         9d2w==
X-Forwarded-Encrypted: i=1; AJvYcCWECQh6EbwnH78yO6ZtETKV/qwSZTyZ/PwVgvJq/VdlUeDWFCQwL3TXZ8Z1Cq0U5UHZFS/4jw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzV9dHPFjOoyItwZsnXS2K5R2sutQbNRPu4N3SZI8MDfAsVgWAy
	INgHPW5juKbWLOOBHu3mS4snxYs4DsaoXPqO5U1Yi/a/Y96REcnu/Bx6WqnbIECMHhZ7Wb5QQ7g
	+jz0GH4PoPBQzy+Hk6bonPQuBWoCPyTsdAyxBMjbo
X-Gm-Gg: ASbGncvgqJxp2si6JAWFDJJXaYNPx0plT7c2DO3BQbdLl6+KFceVfugRXsSFhzoXOQo
	y/lET11EhOU95HT+u2LApqjmiaICdJt7pt3u1DOTDKEllatrw7oQjBLiKlrekdvaZGboWEQKw1M
	+cYmZku0MasbcK9Codwc4wXI3KgYyFe+Rq8pPZuUlgF9B76yY5XIQrpy791m3PFXXpXMsgo+xvf
	TfXIteiGHCzmW2ybQ==
X-Google-Smtp-Source: AGHT+IElqGqJCtZOhO3R6EOALjhIxAosCdG4c6JAw0Ii5GIvvlZsjTd7NWmVyt9CTRdEgA600P6iKWvTGZcKiA6jmn0=
X-Received: by 2002:a05:651c:4117:b0:32e:aaa0:b06a with SMTP id
 38308e7fff4ca-33224a5e95emr27853181fa.8.1754062384765; Fri, 01 Aug 2025
 08:33:04 -0700 (PDT)
MIME-Version: 1.0
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 Aug 2025 08:32:37 -0700
X-Gm-Features: Ac12FXzLKnSwpLBskXSaJfx0o2ePwkZV7fNIT0lZA44HGFkBJgr6jkivWR4r114
Message-ID: <CALzav=d_Bjfy=6if+rPmxgGJfUV8ijnQ5hf40HoH6Yozg_H6Ew@mail.gmail.com>
Subject: Live Update MC (LPC): Call for Presentations
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, kexec@lists.infradead.org, 
	Linux MM Mailing List <linux-mm@kvack.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Cc: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chriscli@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Changyuan Lyu <changyuanl@google.com>, 
	"graf@amazon.com" <graf@amazon.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, "ptyadav@amazon.de" <ptyadav@amazon.de>, 
	"jgg@nvidia.com" <jgg@nvidia.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu US <witu@nvidia.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, dave.hansen@intel.com, 
	David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>, jork.loeser@microsoft.com, 
	Junaid Shahid <junaids@google.com>, pankaj.gupta.linux@gmail.com, 
	Pratyush Yadav <pratyush@kernel.org>, kpraveen.lkml@gmail.com, 
	Vishal Annapurve <vannapurve@google.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250801_083307_774545_36301C24 
X-CRM114-Status: GOOD (  12.19  )
X-Mailman-Approved-At: Sat, 30 Aug 2025 10:29:56 -0700
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

We are pleased to announce that there will be a Live Update Microconference at
Linux Plumbers 2025: https://lpc.events/event/19/contributions/2004/

This microconference aims to bring together developers from across the kernel
to discuss topics related to Live Update support in Linux. Live Update is a
specialized reboot process where selected devices are kept operational and
kernel state is preserved and recreated across a kexec. For devices, DMA and
interrupts may continue during the reboot.

The primary use-case of Live Update is to enable hypervisor updates in cloud
environments with minimal disruption to running virtual machines. During a Live
Update, a VM can pause and its state is stored to memory while the hypervisor
reboots. PCIe devices attached to those VMs (such as GPUs, NICs, and SSDs), are
kept running during the Live Update. After the reboot, VMs are recreated and
restored from memory, reattached to devices, and resumed. The disruption is
limited to the time it takes to complete this entire process.

With Live Update infrastructure in place, other use-cases may emerge, like for
example preserving the state of GPU doing LLM, freezing running containers with
CRIU, and preserving large in-memory databases.

Topics to be discussed at the microconference include:
  - Live Update Orchestrator (state machine, userspace API, implementation)
  - Generic infrastructure for preserving file descriptors across Live Updates
  - Live Update support for specific files (memfd, iommufd, VFIO cdev, etc.)
  - Integration of Live Update with the PCI subsystem and Linux device model
  - Integration of Live Update with IOMMU and Interrupt Remapping drivers
  - Serializing, deserializing, and versioning kernel state that is passed
    across Live Update
  - Persistence of movable memory
  - Leveraging suspend/resume functionality for device state preservation
  - Optimizing kernel shutdown and boot times
  - Support for Confidential VMs
  - Automated testing

Please submit your proposals at https://lpc.events/event/19/abstracts/ and
select "Live Update MC" as the track. Submissions are due on or before 11:59PM
UTC on Wednesday, September 10, 2025.

We look forward to seeing you at LPC!

