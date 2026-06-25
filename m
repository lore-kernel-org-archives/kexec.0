Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F632CDE001
	for <kexec@archiver.kernel.org>; Thu, 25 Jun 2026 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wFD3Z4KVfOMxeGD6x7jzXk02QR7lT8SFbTHg6iLim4=; b=bY7o/J208dj3+33ceoPaR89VyH
	sU1dDoPx7rwubfNUOcnOLfDtMwb0vvTbVtYFV8Bx8pfS2Ngr6AefMSoHu9z7BSesk7VDL8y1QiRmS
	e/1pu4dIO2+d/0VjZpz4icMKRGWf9uYCMjIXBLOxX1/FCAdZksOM88daFhqDDzeZUm5StajDkAsMe
	bHEB8zkZhivic/Lwjp7/4Iep5u/OcPPzp5P8K88sL78+/KXWudjq1JHzk/jsk7riY4s/KCG4nu1rf
	RH7Bsx6gWkX2tYLDldydwAARQZFpRw3v/75LR/F0qFvcfPIpBnWxSrcBFtFIHZh0SAQgyC5G0wgQV
	neVzqqLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wclAg-00000009LFo-28CI;
	Thu, 25 Jun 2026 14:35:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wclAc-00000009LFi-14pp
	for kexec@lists.infradead.org;
	Thu, 25 Jun 2026 14:35:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B9C3600AE;
	Thu, 25 Jun 2026 14:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2141F000E9;
	Thu, 25 Jun 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398109;
	bh=+wFD3Z4KVfOMxeGD6x7jzXk02QR7lT8SFbTHg6iLim4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dSkFo9kQ3Duzy2coh3AZjrEanzktsml4PVsc7hhHjx1E46Ls/rB7T/4b1kY6c7yoj
	 7ZBQBzD53BnNlicytToBhMtxxPK5TYaZOHCcR9e9eukQP/Dl7ANuvxGn5RKTEfhZMx
	 z/GAedQVwFV/4/ehgROjCN1hEsZfs0/eizpu72Y2JVGQTVCpV2VHinDyHkqhO1xJMZ
	 jMuWmvBwYPvZcTQYD5XaawdgS7FVaBuCNI3sjw/sQH2L83/GgM2RkSA0V0a/iCG5di
	 HI6Ke0ZKefHf1ZVEL62tkz2IqQHRIUG7ZgLfOHlqotSCEBctcfI4bp4hOzCyBR9GUq
	 6yy2gcnTDKf9A==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pranjal Shrivastava <praan@google.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Saeed Mahameed <saeedm@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Vipin Sharma <vipinsh@google.com>,  William
 Tu <witu@nvidia.com>,  Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <ajBgj_aSuzMZG47e@google.com> (David Matlack's message of "Mon,
	15 Jun 2026 20:29:03 +0000")
References: <20260522202410.3104264-1-dmatlack@google.com>
	<20260522202410.3104264-4-dmatlack@google.com>
	<178144432039.1257322.9644414453415904478.b4-review@b4>
	<ajBgj_aSuzMZG47e@google.com>
Date: Thu, 25 Jun 2026 16:35:02 +0200
Message-ID: <2vxzechulmcp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi David,

On Mon, Jun 15 2026, David Matlack wrote:

> On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
>> On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com> wrote:
[...]
>> > +	}
>> > +
>> > +	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
>> > +	dev->liveupdate.incoming = dev_ser;
>> > +
>> > +	/*
>> > +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
>> > +	 * that dev->liveupdate.incoming does not get freed while it is in use.
>> > +	 */
>> 
>> How would that work? If finish is not called FLB stays around until the 
>> next reboot.
>
> True... I think if the PCI core trusts drivers to call
> pci_liveupdate_finish() then we don't need to hold onto the incoming
> reference here.

That was my point when I was arguing against refcounts on outgoing FLBs.
This is very easy to abuse, especially when we are talking about device
drivers. And this refcounting mechanism makes the FLB no longer
file-lifecycle-bound, since now it is entirely up to drivers to decide
the lifecycle of this data.

I have been thinking about this a bit more in the last couple days, and
I wonder if we are doing this right. Here's an idea I have been thinking
of.

We should make live update a first class citizen in PCI. Instead of
patching in liveupdate via the liveupdate.incoming field, and letting
drivers figure out when to use it, we should separate out probe and
retrieve paths entirely.

Probe and retrieve are fundamentally different operations. While they
may share some common initialization logic for the _software_ state, how
they interface with the hardware is completely different. I think mixing
the two will result in driver code being more spaghetti by having
liveupdate checks sprayed out all over.

This series doesn't add support for any drivers, but looking at some of
the code we have downstream, I see this problem. The liveupdate code is
all over the place in the driver and it is very hard to wrap one's head
around how the device is actually retrieved.

So I think PCI core should track preserved devices, and if the device is
preserved, it should skip the probe and wait for retrieve. Retrieve does
the full initialization of the device. This fits in with the LUO model
as well. You can make retrieve a callback of struct pci_driver and do
some wrappers to talk with LUO, so device drivers don't directly
interface with LUO at all.

We should do similar things on the shutdown path. Shutdown is a
fundamentally different operation from freeze, and so we should separate
them out as well.

This solves the lifetime problem as well. When PCI core is initializing,
it knows for sure that no retrievals are going to happen. That's because
none of the drivers have registered yet. So it can safely access the FLB
and initialize its state. After that, drivers can register themselves
and start accepting retrieve() calls. Once the last driver goes away,
the FLB is freed automatically.

I am sorry for suggesting a big refactor at v6, but the early versions
looked good to me at the time, and I only thought more deeply about this
when trying to figure out how we can make the lifetimes cleaner.

What do you think? Does this make sense?

-- 
Regards,
Pratyush Yadav

