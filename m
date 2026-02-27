Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66409FEFB6A
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9iPiw6U5zQK+rw2Kav/sKN2Hf6ijXsHI7/gXVV2UUoE=; b=I7X2eNrEpJaTsgORBhGCGrkYAd
	W3KP+WCi01D+vrVmZWz1FSXJwHhy6KEQYredUIIx+vn73aNz8UcoqLBIYyE6A9S1syf7Nj0eceB5R
	bWmhbQIPFakMV/PP4DwOjq/jnp7GHR0r2HK94puGFKlXzQ6Ozbnh+5Bh35IVZ1rNhMm6/QqNmIqm4
	Puy/q2izv0OYHrXOuM55MFlYRK+UNd3UHY2udgNwNRWcO2pxD87hRKQQ+SRmkhe1RGdaA5dyqEJQx
	mw8+YgdPRWNsWzffns/9+g/gMFflh5JAiGzGfAo7yESlVRivtgIElllxToU798fc3aGWSsFUg2k22
	pxd3lEQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0Kq-00000008i5n-4AgZ;
	Fri, 27 Feb 2026 16:05:00 +0000
Received: from flow-b1-smtp.messagingengine.com ([202.12.124.136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0Ko-00000008i5C-3rq7
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 16:05:00 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 43E3B1301495;
	Fri, 27 Feb 2026 11:04:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 11:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772208296;
	 x=1772215496; bh=9iPiw6U5zQK+rw2Kav/sKN2Hf6ijXsHI7/gXVV2UUoE=; b=
	jr3vgegUcdiHcY8N3v9Ti9WcEJ5nINZ1LAG8Tq0MP7dsOTevP5c791I1/P/v4BsQ
	7iHi6zv1sNVSXsUMC/t5FLaK2xSmrbpAOfmmZb18i1xzVnDp580eWMO6P/vu8J3V
	vwZdKbbp158lxye+S/hdnWtDfgurN6NArNK1wHg5kvh2T7k9D3Dl5AgSBo/Oh063
	rgZYEdUC4Z0rqwhPIHKhe/hnwRs9kCtNTpjS0BXScOr88+CNoLHwIpSo9mo5OTMx
	Ry2YwDsNycGr97KOYjlMny2hy9bIhPG3Yt5lw1qqv/D2fwpmZLUn6Ho2FM7GyIHc
	aGqnwznkm0tYuPiEISOBZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772208296; x=
	1772215496; bh=9iPiw6U5zQK+rw2Kav/sKN2Hf6ijXsHI7/gXVV2UUoE=; b=t
	vscZopf+ZIEohHyAEDRhsH6FvskiqkAmDpcbJ929YOc16kdoaID3AUqA/A2BuUaN
	T3NQnehlYy2NHaHOZTy905uPUXQvza+V1dfuXki/6uhpvSoc2L0RtungWGT1jrO7
	ZwCT4v71GqF8Lb2j9Wa5pO6iFsAT82AWVVzzfP6i5qBkN/NLD16OpXnsU9Um2Yit
	tqax0ePNsklBpO7D28r+WHWyEsyEB3dBdPzILFtuFeTep/W/txwnLoEbTm6byCiM
	ZyFo3GtCDe1fofD17VNEpSy38yMrZStnH4Y7exMTr87u2ozA0C9IAtaYmIuUOHGo
	++gnE/qKKaOXz+R9EfRlQ==
X-ME-Sender: <xms:psChaT2sM4Kvl-4-ynL2eVnQMEX39TidibWISnlH_elJUGQErX3wTA>
    <xme:psChae4zqe00s2rW3dmgGMuGnyWrupYFD0bGCo76dIRjuimHTSYe2q3WCJjvWTKjx
    4PzQz43jg2I0fHfbjnTERQhWe1Q9ptrfVZgA1EPP6ANrtJPb8-JHw>
X-ME-Received: <xmr:psChaYF1xEFxlqB1AHJOkAbJUOmtbZjtLf3IJgp5hsYNQFhKllAj9SiL1qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtth
    hopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgvlhhgrggr
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghjrgihrggthhgrnhgurhgrsehnvh
    hiughirgdrtghomhdprhgtphhtthhopehgrhgrfhesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtoheprghpohhpphhlvgesnh
    hvihguihgrrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:psChaW9Xw982ojlJdwBELBg5nUtIzvooVbtsR4EkEMCm_xurJFXzrg>
    <xmx:psChaaOp5diDrMTGhRQmY7BQEtexZqnvTbnjvKx4-4ezrSFwxx9F2Q>
    <xmx:psChaSyHxbqDw7kNVUBcF1TzS8IrpR_G2LRBbhhRg_GGFr9lHV0HNg>
    <xmx:psChacsS35VypjDMtowdC17AE2t6OJySB2L9fCOTFIyvV5HWrXnqKQ>
    <xmx:qMChac02xKCLa1txMJHJVVZiONFn_n7mbt_yHes_8ALNfR1pvZwQrzfN>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 11:04:50 -0500 (EST)
Date: Fri, 27 Feb 2026 09:04:49 -0700
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?B?TWlj?= =?UTF-8?B?aGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, alex@shazbot.org
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <20260227090449.2a23d06d@shazbot.org>
In-Reply-To: <20260226144057.GA5933@nvidia.com>
References: <20260129212510.967611-4-dmatlack@google.com>
	<20260225224746.GA3714478@bhelgaas>
	<aZ-Dqi782aafiE_-@google.com>
	<20260226144057.GA5933@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_080459_229618_92BF22E8 
X-CRM114-Status: GOOD (  21.00  )
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

On Thu, 26 Feb 2026 10:40:57 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Feb 25, 2026 at 11:20:10PM +0000, David Matlack wrote:
> > On 2026-02-25 04:47 PM, Bjorn Helgaas wrote:  
> > > On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:  
> > > > Inherit bus numbers from the previous kernel during a Live Update when
> > > > one or more PCI devices are being preserved. This is necessary so that
> > > > preserved devices can DMA through the IOMMU during a Live Update
> > > > (changing bus numbers would break IOMMU translation).  
> > > 
> > > I think changing bus numbers would break DMA regardless of whether an
> > > IOMMU is involved.  Completions carrying the data for DMA reads are
> > > routed back to the Requester ID of the read.  
> > 
> > Ahh, makes sense. I'll clarify the commit message in the next
> > version.  
> 
> More broadly you can't shouldn't the fabric topology while Memory
> Enable is active.
> 
> Renumbering or readdressing the fabric requires disabling and flushing
> any memory transactions.
> 
> From that reasoning it is clearer that you can't do that if the device
> is expected to hitlesslly continue performing memory operations.
> 
> That may be a clearer long term basis for describing the requirements
> here.

Not only fabric topology, but also routing.  ACS overrides on the
command line would need to be enforced between the original and kexec
kernel such that IOMMU groups are deterministic.  Thanks,

Alex

