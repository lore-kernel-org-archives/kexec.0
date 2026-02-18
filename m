Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F57E9A02C
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHFDN1IYMnoxpZS5G2oXFtVgwf5W7hU3Pl5uv7ygFKo=; b=bglqkmZGRzlmlNXU4NW++X8Urq
	4PpIbJ3FNngS6dEEreu3CKT45gNQyUuyWF36VUXKMQ8V3WLbc4QPtjNdzvrIpyzqi+piAhb3vZBl6
	7aOVrvyQXbBLQIhRNywRvuPiBCKmLHGNtCK+UXNOVbKsZVsY0WmyuIQWdD0L+MHL/pqXpiKRCxrMZ
	Xem7B/pO/sPe9/QblnEmlKOgtzQFWIEaRUQLrvetRrRFOR/WbVjIG8aeibVOGpKtWEsJ7sDar27q6
	8np6D3Z9Ky81xDqSMvNKrRBj8wGHy90Gs7QC6CByTCUaFFyA/t+s045jhWr01qv8dKYaMdUQPjGn8
	wWatidXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslOI-0000000AB8Q-2HVU;
	Wed, 18 Feb 2026 17:31:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslOC-0000000AB7t-3lBT
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 17:31:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EC93F442C4;
	Wed, 18 Feb 2026 17:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D3C19425;
	Wed, 18 Feb 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771435862;
	bh=ohdYdo9+SBYLGFQheyzJQWf2ZP0wlboQxRYJXiSxQpA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ICFm9DGkhYGoZm1Hm2GXWdOKuTAN+epLKbnBbB1UVRPUOjyJi3X+YtQVvi+VoTvQ6
	 kEFmWBcGWaxXNrEt54md00f2GjcXdY11bBgGpSNNC/TZFrO/kMzKdxvhAcAfk4tE/0
	 LpZMKcvYVSL/Qpso1QObNstDGMOwJfeNCRQiQYzN1sw7LSs10KwWFamzgQL2b0Svs/
	 Is+DZLmnkzUsVM9KT9OZiPbZLWJhED/CTgcj6doPsHLZdqrTF8sqcxcJDz5c1cSSYU
	 uj5KVTQyCMipdd78j8dZ4ViP6i2Fuqj6ZFIl5E6/NyQhhY5nZb35D+auCxfIAqWeuY
	 prrQAWLkSB2xg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id ECEEFF4006A;
	Wed, 18 Feb 2026 12:31:00 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 18 Feb 2026 12:31:00 -0500
X-ME-Sender: <xms:VPeVafpE2Ie32Cr6UQi9iwoHWZ9_Rr9MqAAo1vEXiVlQhmrDG617lQ>
    <xme:VPeVaUfOFGNo3VT8oEAE7hLFwJ9DpJ-RP2iVZBqnhASdxM4yGBbZBFJogZSNFZoBi
    CsfIPQE6VIiWkp0TRIRoowEEduygVFDFkG693K5qZVhnNLWZCeodK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:VPeVabBa_wd2qiCyTsIYs17e1uoC1yTqNE-7TFe-OcghnALLLc-tIA>
    <xmx:VPeVaVyJm99RF_spmJcqwucqbb1AYRyIzzhpzFGiuxEuUOXhMZg0Ug>
    <xmx:VPeVaTjcWWUCCp0TUy9DYntPyyAuQ5IPaEAter_T9s7mH21bCLrzSw>
    <xmx:VPeVaceUTFrpzfQacbKuMEvVrz1H6P4BuyBUoxfBA2vA1uy_jqpcCA>
    <xmx:VPeVaaVtmATKPIh2w_we3MNdpdlcZTnTNlXcV8Tn0zN6tsgzgLNH-oJ0>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BAF30700065; Wed, 18 Feb 2026 12:31:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Wed, 18 Feb 2026 18:30:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Ross Philipson" <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 luto@amacapital.net, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Message-Id: <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
In-Reply-To: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_093105_010360_9485C694 
X-CRM114-Status: GOOD (  22.15  )
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

On Thu, 12 Feb 2026, at 21:39, Ard Biesheuvel wrote:
> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>> On 2/9/26 09:04, Ard Biesheuvel wrote:
> ...
>>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>>> 
>>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>>> - the EFI stub executes and decompresses the kernel as usual
>>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>>> 
> ...
>>
>> I think this is a great approach for UEFI, though we need to reconcile 
>> this with non-UEFI situations such as booting under coreboot.
>
> There are two approaches that I think are feasible for coreboot in this model:
>
> - just unpack the ELF and boot that - there is already prior art for 
> that with Xen. We can stick the MLE header offset in an ELF note where 
> any loader can find it.
>
> - stick with the current approach as much as possible, i.e., disable 
> physical KASLR so that the decompressed kernel will end up right where 
> the decompressor was loaded, which allows much of the secure launch 
> preparation to be done as before. Only the final bits (including the 
> call into the ACM itself) need to be deferred, and we can propose a 
> generic mechanism for that via boot_params.
>
> I'm working on a prototype of the latter, but GRUB is an odd beast and 
> my x86 fu is weak.
>

I've managed to get a working implementation of the legacy entrypoint, by repurposing the dl_handler() entrypoint you added for EFI [which no longer needs it in my version] as a callback for the legacy boot flow. This /should/ work for i386-coreboot too, but I have no way of testing it (I only tried 'slaunch --legacy-linux' using the x86_64-efi build).

I've pushed the changes to the branches I mentioned previously in this thread.



 

