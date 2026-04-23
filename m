Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B9FDEE53
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lt0LRXP7f5oacTu2NcOl/7iPlzf9+apNICsUQAZ1DMY=; b=JEgLbv4JhukdtziQNqj26dR5Pc
	UiHU0bMHW9o42PhbswXB01/uefK6h6ORfLVkeqDspQquOUSjIgAdB5ZLSQH591dFjke59aM1Wncvd
	44K007zbqbwk+ah5bClFmqbfUHm0q+xO0LGmd77nAXZOBlaLkMDmoaRybVMf5lmCTjjMiNpZ1WtsG
	LcXOknIo9nE33G40IgPYK+GpWJ6kNJMn+KqxOflxFGXQfCpYyuY9VDRZGK5VjQrJjTIMz00zltcCy
	n011+nlWsRL0oUFPHjhhsEHW/yaPV6HbCoKxbUstlg/Oo6XVJmaP+jJMgSQxbLiE6e3OSiTid7Iu2
	nv/r7WyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3Sc-0000000CPes-0Inr;
	Thu, 23 Apr 2026 23:27:54 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3SY-0000000CPe8-3TRj
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:27:52 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b243198058so187505ad.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776986870; x=1777591670; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lt0LRXP7f5oacTu2NcOl/7iPlzf9+apNICsUQAZ1DMY=;
        b=jDTWAEIWoL9c7QITjb4aehudzCBTpR/4JgJNQDFiS0mnLaLjk38gsLHSQo9iG6QHJq
         gx0+yGnHqcxmj9Z+Jg46o92YfBHrMs+J0R2Ws3t9GurJsLdAfFP13dtp8ispmqONsu2K
         wwIZUnzJ1vb8gplESkcMswhKumuJl6jmbhkIGi2RXtMkrTTuOgRL5qoHBI9JP5mn8B1D
         Ezq47lWEv6mkP3+eDDyMgWqGnqKBRNiM5FH1K8ETlSL04FxtlKDmDOX5WhJjioD3SwTE
         cB1FvafflcjDNGEPYBGY6knZEONozzE/fiNPoeB1TkgL60BYgH52KyFBU8WeJSz78zis
         zsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776986870; x=1777591670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt0LRXP7f5oacTu2NcOl/7iPlzf9+apNICsUQAZ1DMY=;
        b=oYctc/aeDgoGElgPEVz999MaY8fDup77ZtQAhvBS6DGe2CzLK0SfuV8d13JF/kSVkU
         oxs+APAvL0Y6qtjuLbUEXsDCU+T8Yb6dctQVbKY3PeYOYd5dUqI33wJKI05dH8YOvaeS
         mo7DCt2s4RkcDCgSEtyU7cmatcdNDnmig3gL1ZdzRaMWsUS0LCgKSTtzS02MNCXRPjfQ
         5zFD3LFU8JkKsYgF96XbUcJdyieHZKxDxPZb8gSRL8DvlZBHQPJWgb0vRMOX2EXCk3pH
         uKC4xch6RWxy2M9clbA0KWOxkuoS82ap5ZDz5Vt/qb0qGz8hZq8GTQnifbsyQoX1oGqC
         7vgw==
X-Forwarded-Encrypted: i=1; AFNElJ9oN35Uy4mjfPcaeqJ2Cs5ogpjnhN3IGsWww4NFBySMZdRTtEOUmkxn18lFyGylalJ6AghsLw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWlXsY1Ii3p7fzayMMyPT5UpeGCmmLnARVJafJZWu3RgVHMrp3
	KwgPQoshcyYz9slr1kaIFeBe5SwkdHVu+P2gWm6wV8q8yiZ0U0cCLNDfa1wzTYU4Wg==
X-Gm-Gg: AeBDietQ0ZQtKdrc3eSZlZA7dHjw8YMILZKunvYM2PBElBydfYxn2GMTsVfiba6ALSA
	UF5QF1FetmNsAaa4jextzeflxXOu0gO34GBYgoTxpkRUwYx060otn4BAK8CrRKOvnP2/WF6wWqR
	Qxm5uOqCXVkSoT+iXJQqgkziSqR2JmW3vTyV1XegOqYbsRorx7Dkidfd+nECr/RjhRCamMatqGi
	F7m/VxUneax1QZ7GVG0pfZNFhIQWMNZk/JEsd+U2YaW9hGuTHcKyR+EodBEj3j1uH+ZqK6RBndq
	+nysp2p63hlJBWZUeOVLQII9rXMSsq39DyoBFanSvPbvIRk1ESJAPZalYFmZon7edMe8Qa1EavP
	RpzpN0F9xrYMUqo8H7esR1yoPgx0EtV16px9wWb6VVZDS+VmWlmbJ5260sf2+0JTQdZ+z0t7g/N
	CBpSXBo8eDUxwNorWRWiuiu12CK72jx4weVzDvMSyRUbwYw6CXU+0OrljkmxoPthMAwYKnRB/vI
	keGzCi/HM8=
X-Received: by 2002:a17:902:cf01:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2b603f4969amr20900125ad.5.1776986869309;
        Thu, 23 Apr 2026 16:27:49 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cabfsm18153636a12.9.2026.04.23.16.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:27:48 -0700 (PDT)
Date: Thu, 23 Apr 2026 23:27:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <aeqpJ7BeBtzoPIx4@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
 <20260423225253.GA3444440@nvidia.com>
 <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_162750_903742_1362E3F7 
X-CRM114-Status: GOOD (  31.96  )
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

On Thu, Apr 23, 2026 at 04:09:01PM -0700, David Matlack wrote:
>On Thu, Apr 23, 2026 at 3:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
>> > On Thu, Apr 23, 2026 at 2:23 PM David Matlack <dmatlack@google.com> wrote:
>> > >
>> > > Restrict support for preserving PCI devices across Live Update to
>> > > devices in immutable singleton IOMMU groups. A device's group is
>> > > considered immutable if all bridges upstream from the device up to the
>> > > root port have the required ACS features enabled.
>> > >
>> > > Since ACS flags are inherited across a Live Update for preserved devices
>> > > and all the way up to the root port, the preserved device should be in a
>> > > singleton IOMMU group after kexec in the new kernel.
>> > >
>> > > This change should still permit all the current use-cases for PCI device
>> > > preservation across Live Update, since it is intended to be used in
>> > > Cloud enviroments which should have the required ACS features enabled
>> > > for virtualization purposes.
>> > >
>> > > If a device is part of a multi-device IOMMU group, preserving it will
>> > > now fail with an error. This restriction may be lifted in the future if
>> > > support for preserving multi-device groups is desired.
>> > >
>> > > Signed-off-by: David Matlack <dmatlack@google.com>
>> >
>> > Jason, do you think requiring singleton iommu groups is still
>> > necessary/useful now that this series preserves ACS flags on preserved
>> > devices and upstream bridges?
>>
>> I have forgotten why we introduced that? There are alot of funky
>> things about iommu groups that might be important upon restoration..
>
>You had originally suggested it in this thread:
>
>  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/
>
>> Like if you preserve one group member but not the other what do you ?
>
>Yeah I imagine there could be some tricky cases there...
>
>I wonder if PCI core is the right layer to enforce this. Maybe this
>fits better into Sami's IOMMU core series since that is where all
>those tricky cases will be (I imagine?).

+1

Also I think this should probably be checked by iommufd and invoked
through vfio cdev. Basically when vfio cdev calls into iommufd to
preserve IOMMU specific aspects of device (PASID table etc), iommufd can
check this and return error.
>
>> Even if you have ACS flags there are cases where groups are still
>> aliasing DMA..
>
>Hm, if a DMA alias can be created after boot time enumeration even
>with the REQ_ACS_FLAGS check, then
>pci_device_group_immutable_singleton() is not really immutable.
>
>
>
>> Frankly, multi-device iommu groups don't even work fully last time we
>> tried to use them in a VMM. So I think I would not expect them to ever
>> intersect with live update. Blocking something tricky you can't test
>> does seem like a reasonable thing.

