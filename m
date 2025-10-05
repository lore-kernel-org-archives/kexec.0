Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C3CAC5BB
	for <kexec@archiver.kernel.org>; Sun,  5 Oct 2025 04:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YtRjel1HG5STXuZLFeW7ky9+MooC7qPIEizO0OKUdcE=; b=4C2DY9Ca4z4dqEwepNOHu2Myfh
	UH/+T3X6rGHSJm8n+pj9Her6ropGvzEEM1RRJb2Wb/6+skavZt5Xv8U/yuQi+AKj5cJUpKWihnrKr
	glT5+v2YbvAkesSoqMlxU3+0AJW5NvmuUpkEhNPWFoUoWeTDTWUnpHAa7oWTYXg5q8nVuxcf41/qd
	IGEJztsYC+bZ3dboRNejpIjfaHNPu7fpzap0KkVGtULJStnMA2bvgvcab03iIB1LFmOZLjTcZjZwE
	pGpI7IbOCHdSZBxKV9G4geCwyoB4sXtwnEzMpPrtZilFCWiI1xCzYRc1dljm5CFB4yUYAKL3qZscN
	OoZOWWxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Ggo-0000000EEJb-1BtD;
	Sun, 05 Oct 2025 04:49:42 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Ggj-0000000EEJE-1z6D
	for kexec@lists.infradead.org;
	Sun, 05 Oct 2025 04:49:38 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-27d67abd215so224845ad.0
        for <kexec@lists.infradead.org>; Sat, 04 Oct 2025 21:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759639776; x=1760244576; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtRjel1HG5STXuZLFeW7ky9+MooC7qPIEizO0OKUdcE=;
        b=HWKNyoL9hHHwIirl0xeOvUf5oW2nmGo+Zsgw+Y1iap+cE6AfiIZkYXg+6YzFBEmioV
         Gi5q1O2BDWfDGtSRL5EhsLAH+iGrcHFZXkXvrwKT2wqBXIVg0CjATR+fiA+xCH2Z/+AP
         0osSeHHrWh6SpmT4Qw321he9rfHTNy/V6SdtMFJzNfC716by9Iute2JhfK6fQe69WnRt
         GyEvsD13YVZpBUJmVKPamSm+XWaKrRiOntVl0sViwg2i8ni/JaXnyzdgUtsQdDwkM+Nr
         SmIzvMvR02tTAkIGvJdD2RAtol/GcbVWoHkLTTiYMjMzLYauUNf9a99cQNvLzGGjbVKz
         DiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759639776; x=1760244576;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtRjel1HG5STXuZLFeW7ky9+MooC7qPIEizO0OKUdcE=;
        b=YkX5PlforWcJXgm3DN257+2TG26IiW5Ftel/iUY8ShK79xXsE0Pgr5VpXJ3+npr7hl
         TeIQdNDDZWSsBHpVduL8vM8u6iMtBzPynK7ZPUb46P+YE8pQywlZ2WoVO0ZZnwiYfyw0
         6ECvYaUwd564uGeBe4TneMp7wcqFJKCJCPpbU3qv1OKHELHE6PSg7cNneHiEHxpmQv5Y
         MNML0VZN7CE+VLksZwdpwBkY+A3aSrrWhBj8ZSs3/bAVeMh/W90GKkgSPB1JZj9UuAxw
         QvXoJZl0yXwF8QmgiScpMTg5UMALXHYWoTTzNY+0A2App2mpfEIumPwi2gIwKP7MismF
         95tw==
X-Forwarded-Encrypted: i=1; AJvYcCXg2luvgC1QvJTemlaJP93iX3oZhIqA5QSEcEO8GDfq8IDSuNfYeCzmYMZeZM+ojhKYLqiCWA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywx1FxW5HghUNYtgObdzw7nwcqY0WOzvyhbxBTgCoYVss/hxl7q
	6FKnROFxLlhJUATpBU80gqfZNU1Y5WPCI4mwLaa7qyVF4JnUSXQWbIrCoalhzKgaXQ==
X-Gm-Gg: ASbGncsUOxLjPc/JJSq/OW4cWBI2K9GUW6IpBa3pd4Znt3vHKy20pupxIpwkhr9NF48
	G9Ady3EHTo1prlWSQLRcEbUF+nXBv+rYsbYJ02mpJ9yfLO1DiccqQh64JH6mwn/0Wb/QZT22P/n
	zYXAB+FBKPJ5pDbqbcihvda4NHKGz1yFkgX8WKvV4CbVMeaVbeirI7C2hnjIeKIRzlH1yGpJ3XA
	jzjN+WrD/efidNmFDLBLz8XOYNs9Mc0vey04jPuHmx4davcLM2yz08oPmCJxhAUzj2u1zseN/5L
	UGA8Fl49qMRSUjCC2v1JN7zgmPsOReNpbaSTSb0YovSXkjcuRF2opA3NvwQv03eWY9cc7jr2vcJ
	T0ZguRJZLH0nPF3kI9KS1JYpdGRjjgjHkp8Fhib1GjUawQlF1D6DXs2age+Dhs4FHg7llelElOU
	/CaqAIXCRs6DoRzCM2Heffb2NZPoR/H0V/1K2221LbSIlzgZhZxjKNbzNmEvgMR13nE0x9sSpGI
	c6b1j7sFCHypl3/nSlIeMOXSH80
X-Google-Smtp-Source: AGHT+IGl2dZ4bBXbAE3dltXggDm/JaFJh+YfPTUIUtiSp316mGfJLHul8RCceskvrrqOdr7ugKUMyQ==
X-Received: by 2002:a17:902:e550:b0:27e:e96a:4c6 with SMTP id d9443c01a7336-28ea7ec09dbmr3993895ad.2.1759639774950;
        Sat, 04 Oct 2025 21:49:34 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:2b1a:83b3:ba8a:7851] ([2a00:79e0:2eb0:8:2b1a:83b3:ba8a:7851])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11191bsm93535125ad.11.2025.10.04.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 21:49:34 -0700 (PDT)
Date: Sat, 4 Oct 2025 21:49:33 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from September 22, 2025
Message-ID: <365acb25-4b25-86a2-10b0-1df98703e287@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251004_214937_537955_7CFB73DA 
X-CRM114-Status: GOOD (  24.10  )
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
on Monday, September 22.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated LUO v4 by syncing with linux-next and was going over all 
feedback.  The session support had been added and he planned on sending 
the next series over the next couple days.  No major changes other than 
the session support.  There was a lot of discussion about versioning but 
that will not be included in the next series.

There were no major updates on luod, the design doc continued to be 
receiving feedback.  We planned on sending this to the googleprodkernel 
GitHub when ready[1].

----->o-----
We discussed memfd preservation and the 1GB limitation.  Pratyush noted 
that he had worked through all feedback based on v5.  The next version 
will still have the 1GB limitation and we're waiting for Mike's series 
before addressing that.  Once we have the vmalloc support, this will be 
more straightforward.

Pratyush noted that the next steps for memfd preservation would be sparse 
memfds and hugepages.  He suggested that guest_memfd may be simpler as an 
extension.  Pasha noted that HugeTLB support would actually be harder.

Vmalloc support should make it into the next merge window and then memfd 
support can avoid the 1GB limitation, so it may be possible for the next 
merge window to lift the 1GB limitation and include sparse memfd support.

----->o-----
Chris discussed preservation of memory with split folios and the error 
path.  If a folio is preserved and then it is split, the preservation 
needs to be undone before preserving it again.  Pasha said that this 
simply could not happen because KHO memory is not migratable.  Jason noted 
that memfd would have to prevent any split, including in cases of page 
fault with pinning.

Pratyush noted that we may want to add some debugging assertions to ensure 
all KHO memory is pinned, cannot be migrated, and the folio cannot be 
split.

Vishal noted for Confidential Computing that folios are sometimes split to 
handle the sharing of pages, the conversion of shared <-> private guest 
memory.  Since the guest can ask for this conversion during brown out, 
we'll need to ensure that this can't happen.

----->o-----
Chris updated the status of PCI preservation and sending out v2 of those 
patches.  The current patch series only preserves the bus master bit.  He 
asked for any feedback to be provided on the list as he was planning on 
pushing for this to be merged after LUO v4 is landed.

We discussed where to merge the changes when they are ready, the consensus 
was that this would go through the PCI maintainer tree but after the LUO 
APIs are already merged upstream.

----->o-----
Andrey provided an update on KSTATE, he said he will would be willing to 
go over the current status and plans through the end of the year in the 
next sync so we planned on carving out some time in the next instance.

----->o-----
Vipin went over VFIO device preservation at Google as a follow-up to the 
KVM forum[2].

Vipin noted the internal approach will be different from what is sent 
upstream.  Vipin discussed passing VFIO device file descriptor to the LUO 
ioctl for preservation similar to what is being done for memfd.  There was 
an open question on whether VFIO cdev should be shown in /dev/vfio/devices 
until the VMM has reclaimed the device from LUO.  Jason suggested that it 
should either error out or cancel the live update (resets the device and 
operates normally).  Pasha suggested that if the fd had not been reclaimed 
after kexec then it should reset the device.

Vipin discussed interrupt preservation and the internal approach for doing 
this.  There's an alternative of disabling interrupts on the device before 
kexec and then after kexec, set up new interrupts and blindly inject all 
configured interrupts.  At KVM Forum there was feedback provided about 
side effects of this for Windows guests.  Jason suggested sending patches 
for this alternative as a starting point.

----->o-----
Next meeting will be on Monday, October 6 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on latest status of LUO and next steps for merge into akpm's
   tree
 - update on the status of versioning support and anticipated timelines
   for inclusion
 - update on the status of stateless KHO RFC patches that should simplify
   LUO support
 - update on memfd preservation, vmalloc support, and 1GB limitation
 - discuss guest_memfd preservation use cases for Confidential Computing
   and any current work happening on it, including overlap with memfd
   preservation being worked on by Pratyush
   + discuss any use cases for Confidential Computing where folios may
     need to be split after being marked as preserved during brown out
 - [20 min] Andrey will discuss the current status of KSTATE and plans for
   it through the end of this year
 - [25 min] Samiullah will discuss IOMMU preservation plans to get early
   alignment with stakeholders
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://github.com/googleprodkernel/linux-liveupdate
[2]
https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/VFIO_device_DiiwG94.pdf 

