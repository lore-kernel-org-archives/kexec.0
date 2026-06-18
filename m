Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39975CD98F6
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsJMMWgRXJeP7sRFHXfktToOXcpEZ/f5CxFBiOSnxko=; b=yQxQ2qLh+9QrivV4rPu2mJHhwv
	QzvfsIlXzal2IGi+kIn5AZ2aNMMwP/Lvdc0Sz9oydv21xBk0W3xk7j5k2NqWkjiYFQF5cM/cNPSAB
	ZcJIuY22oB7lbcKv21UXysrBPoW+BT1KMi4k02KjeKsmuPX103r0vE1d+s7ZdlePHPOxViT9Y1fZs
	n6ZVRO+x0VGYaNK780W/QnDNpnutE3V3k5puyU4kZuVWrDx8izZ1/MU5S6IllC6Vi50GncYh0xLCe
	GMMhU+fkDaw+e9ZBuJ34pQ6KVclrvsP8DuztCA7C8GHJMurZMAQhZUP+s2vTdOiEDJBc8c45goekp
	FyNakWrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waFi2-00000001aXQ-35MN;
	Thu, 18 Jun 2026 16:35:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waFi1-00000001aXD-2w6u
	for kexec@lists.infradead.org;
	Thu, 18 Jun 2026 16:35:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB0C860008;
	Thu, 18 Jun 2026 16:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675591F000E9;
	Thu, 18 Jun 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800516;
	bh=lsJMMWgRXJeP7sRFHXfktToOXcpEZ/f5CxFBiOSnxko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G+hznsO4NdzNl3Gkceu6+dMhQAy0qH9tUu+J2fyBDdk++OZthy7TmqQJaHnAHNACU
	 dl6/15d+E2QM4JRjhWdCmN3vQN+TCIsMoF2D3r2Y0HyinMkShHFJnNgyPjAVzSy5x2
	 Y6YZzLDRHAdWOmp2WdegRGeQjHb0cTBFiLUgH8XSkvG9lae/hepKATS20sjZEn4deM
	 vLTiupNLzUYrQE4/h9r/p3CXODGSEQxW7PIWPhZh+lGTadHTcweH7ZjsvcBq9eB6oV
	 TLy1qSJQQ4seD7ktCKN42S1pEV1l9Y7dIOAIfy/nIBHtGT+G+DI7OGBYs+TnrkEloe
	 rhn83wUnqctXw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Parav Pandit <parav@nvidia.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  Vipin Sharma <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
In-Reply-To: <ajPzC2Xh1NMbfokP@google.com> (Pranjal Shrivastava's message of
	"Thu, 18 Jun 2026 13:30:51 +0000")
References: <20260522202410.3104264-1-dmatlack@google.com>
	<20260522202410.3104264-2-dmatlack@google.com>
	<178124130274.908199.14827357870284807134.b4-review@b4>
	<aiutNINqxhtlm2Dt@kernel.org>
	<178126123047.908199.12042730612990730743.b4-reply@b4>
	<ajB6V6yBHOjgK5ew@google.com> <ajPzC2Xh1NMbfokP@google.com>
Date: Thu, 18 Jun 2026 18:35:10 +0200
Message-ID: <2vxzv7bfolhd.fsf@kernel.org>
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

On Thu, Jun 18 2026, Pranjal Shrivastava wrote:

> On Mon, Jun 15, 2026 at 10:19:03PM +0000, David Matlack wrote:
>> On 2026-06-12 10:47 AM, Pasha Tatashin wrote:
>> > On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
>> > > On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
>> > > 
>> > > > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
>> > > > 
>> > > > Please add Pratyush, Mike, and myself so we are notified directly of 
>> > > > incoming patches, the same as with other areas where the liveupdate/ 
>> > > > tree is specified.
>> > > 
>> > > Or we can add PCI liveupdate files to LIVEUPDATE entry.
>> > 
>> > That will not work, as we cannot serve as maintainers for 
>> > PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
>> > PCI components, and we will accept patches once they have been approved 
>> > by him.
>> > 
>> > The simplification we could do is to create an email alias 
>> > for the live-update tree maintainers. This would allow us to use a 
>> > single entry instead of listing all three of us individually.
>> 
>> We could create a Live Update mailing list for all code that can be CCed
>> on all patches that must be merged through the Live Update tree. I would
>> also be interested in subscribing to that list.
>
> +1. I'd like if there's a specific Live Update mailing list for
> submissions & discussion about the Live Update tree.

We treat kexec@lists.infradead.org as the "live update mailing list". We
considered getting a separate one, but I reckon the traffic is low
enough on kexec@ already that we can re-use it for live update.

So perhaps we just Cc kexec@? Is there anything to be gained by creating
an alias?

-- 
Regards,
Pratyush Yadav

