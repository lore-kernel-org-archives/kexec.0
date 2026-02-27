Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F47FEFB5D
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3lrzFyQElxBxtWsP+osjrtrIRj/rA3HI8aIxSL+eHc=; b=x8dF1SZAG9MeIhZzdT5mvc1JNY
	QgKAHJucte1mw3V9QIFOd5GjK/415cS+tiXYJ7HOwWo/U910SQsIjx6cvkEMDeyb9AiON0rKEUU/Z
	SJrtBPs7WYDmyAmtQ+/r4ExzQxsZKpJellfFXS2z36zyEIEY+haEIOBk780guwUKVRgc9DiI1Yo4F
	i2CQSYtlIr5TV47/Tv8Dt30zIM6NMsrc4gpRzULrI/NIzYKljS/U2bIqIN89zt9Y8ECdVBD+1C35f
	w+0/iidhDmhv2kXNxBuseXYicG4feIxI2R4xEBcJ+2yraG47un/eVt6DB56IA4AM7fDmPHLBuSJXX
	zguE2FsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw03c-00000008gIO-0I7i;
	Fri, 27 Feb 2026 15:47:12 +0000
Received: from flow-b1-smtp.messagingengine.com ([202.12.124.136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw03Z-00000008gI2-3Ec5
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 15:47:11 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 1409613013DF;
	Fri, 27 Feb 2026 10:47:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 10:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772207225;
	 x=1772214425; bh=P3lrzFyQElxBxtWsP+osjrtrIRj/rA3HI8aIxSL+eHc=; b=
	nSbeJn091CVUD7FTBlfHAGofIbMFpGvhhKPN5P+AXxi2R6g+zB9bTzPy8M7zKOX9
	190koYZVQtOhErFW5Nk2ZXp3dvbyl6UiMLVn8Vdws7SsR0yodwKy9wHBllJkNGeA
	AsGuDTTDeNXhDKsH6A+ttPLVwAgWN6I/IDfUUfKYIDL7djAhXluESe2mDgoVuE/0
	H5H5lmhuaO4ap/bK0tc8OziXtOlDMPcxvZ9+r+b71xqQG/wIdKjH1rs6QDjOCkRk
	NLaqv5GEjMIEAoVWLHqK6FLBpxQhya3L1m/31iVG+OzOLBESOmuKD7/FN0SBI+f3
	94CVvMVtttES7JAOlQJp3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772207225; x=
	1772214425; bh=P3lrzFyQElxBxtWsP+osjrtrIRj/rA3HI8aIxSL+eHc=; b=A
	7cma9dBosB0GIWXa1m7+Lm/GchbRtgqA/xwo85CSUbQlkjtuGWtWnsFqnFaEz26K
	XIjU47rn+BcT8PvTsqtvovSTHPoqwmFxcttdD8BqQeCdzm/9K2blLDhKqWUl3idP
	wIyeWR3wYpc5y+VTOnLFWijeVmHt3I48Wf5E5jBf3bfwmmPzfIEl5Uiq1ztEtCUb
	TtxChaiXmQlGbcnDqB0XuSPH9RUPouePhNnHw66TqOLnqCXBdIR+BZZwgl/mePTT
	2Ndu2PcdwnDMxOAC1MaII1xlSg8Ocgn1jc3idGiGtiMejdDwaHcAThhlfyHUQ01U
	YmEbEKrgFw3TDqLvqVi1A==
X-ME-Sender: <xms:eLyhae8NLfiHQAfvFbwIf5yfJxGrx7KxbtT7pspvJckoKaT9zcfsGw>
    <xme:eLyhae4tsQgypPwTHo2DeWnsQy7bTLUs3VcUPfd9RrYRFV5seJeMAhrG_sP3LC7Is
    d9Lnz9eMprZ9jmWg9vNexMWxYMBNR85faQxljPC31hLURgUua9RsQ>
X-ME-Received: <xmr:eLyhadjLu8rkkCiD9LuU-gLeXJaelMWBSD-DAgNH5GYD2MjN3YfraFIWVNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprghjrgihrggthhgrnhgurhgrsehnvhhiughirgdrtghomhdprhgtphht
    thhopehgrhgrfhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfh
    gsrdgtohhmpdhrtghpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhslheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:eLyhaViQEXxZhGRPLBgx3cIxwcB6BJldmDuFBveN-s3uybKGEg4BVQ>
    <xmx:eLyhaT1gmUrj3pS2nastletXexcegngkRYpkqQAlCWEUiBVKvt_8Uw>
    <xmx:eLyhaQjFwwGVa8eE3K-VjdGUDc_gumNbDo92PQ-hmX33aTYcusuheg>
    <xmx:eLyhaWqfdVOxky2hgCGNQH7N4KhqFKsCvw6Ruxq0xBQwJyfcQ9Ociw>
    <xmx:ebyhaTuRNv-HWsJCaeyQT_E-CL0vqudE11keKbVebqGUMZseVXYpmczH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 10:47:00 -0500 (EST)
Date: Fri, 27 Feb 2026 08:46:58 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260227084658.3767d801@shazbot.org>
In-Reply-To: <aaDqhjdLyf1qSTSh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
	<20260226170030.5a938c74@shazbot.org>
	<aaDqhjdLyf1qSTSh@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_074710_201501_8E88DDFA 
X-CRM114-Status: GOOD (  19.74  )
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

On Fri, 27 Feb 2026 00:51:18 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-02-26 05:00 PM, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:57 +0000
> > David Matlack <dmatlack@google.com> wrote:  
> > >  
> > > -	vdev->reset_works = !ret;
> > >  	pci_save_state(pdev);
> > >  	vdev->pci_saved_state = pci_store_saved_state(pdev);  
> > 
> > Isn't this a problem too?  In the first kernel we store the initial,
> > post reset state of the device, now we're storing some arbitrary state.
> > This is the state we're restore when the device is closed.  
> 
> The previous kernel resets the device and restores it back to its
> post reset state in vfio_pci_liveupdate_freeze() before handing off
> control to the next kernel. So my intention here is that VFIO will
> receive the device in that state, allowing it to call
> pci_store_saved_state() here to capture the post reset state of the
> device again.
> 
> Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() and
> preserve vdev->pci_saved_state across the Live Update. But I was hoping
> to add that in a follow up series to avoid this one getting too long.

I appreciate reviewing this in smaller chunks, but how does userspace
know whether the kernel contains a stub implementation of liveupdate or
behaves according to the end goal?

Also, didn't we violate our own contract in this patch by adding the
reset_works field to the serialization data without updating the
compatibility string?  Thanks,

Alex

