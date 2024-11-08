Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E844D5C0C1
	for <kexec@archiver.kernel.org>; Fri,  8 Nov 2024 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wpWCzC7fWEsOoYbyTbRoo41m15kWgif2cOM4d2T/aoM=; b=XuJRViN6FpitCw
	AlRFI3IjpmcfmeB4on5EI4zK39yQQGd8Ce1iIl9LXECw2GR/WrNyi1fZgB3sNNyAd03zUSwrfK085
	dTdE9Y5C0pQrQHN9ywpbklpSiJD8sCQC8P8/52YhhXaUVRypKeE/v+j/8kymewK23uzbI7xfPbKRp
	8xksUQ6ReRwSzi4L6oy9iN+IWea4xacbNcs3hYbIS09WZO8IL8mJwmMQs7bvo79SsA1QmBOTHFl3R
	STmSsnI/tPwfa9ucW07KO+noJdKGmDBiKi6g4Q7CbLwWAL+u1AqccSEM2dT/SXRu7CZArX0EPcNpZ
	pUsu0j2YmE9etkP26HZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9OCL-0000000AXlq-33vX;
	Fri, 08 Nov 2024 12:34:45 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O7c-0000000AWwf-0JXb
	for kexec@lists.infradead.org;
	Fri, 08 Nov 2024 12:30:04 +0000
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C3DFB114018F;
	Fri,  8 Nov 2024 07:29:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 07:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731068988; x=
	1731155388; bh=lswsVrGpp09FHiwhKyiPQ9xrqp9u/7/U34DSTnM8j8c=; b=l
	WYdzHFRUNkOnEdL7BrNc6ZYF/SWB5RPZVN3nBWB6JH+U/OyuErKYv2aTwGJoy5K9
	5q8DKc+NfyEHlay+Aa0xyzRIfIf/Spn2PiYEHeQDX68HXlnARunbj6xJMSrIppuM
	tHXI+x5ST1SgOhBf4kCfBBpnrZdD2pjkZ4a20HJwFZKDPDDJ22jeosTHsvX8hm4x
	BS58K3UaaoRZiR5eOGw50fYqQVy75S/q/Cn9Cd7ORqdSEm6gCMXJEz5rmkXkmeh8
	mqLlt+XtLHDhoWF/eX1XhnELYO10IBj4fM9ceLzzW+RzP6tngRiicBnMe/ZkXXkV
	pyOts2ykq0pCwZlF4xDUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731068988; x=1731155388; bh=lswsVrGpp09FHiwhKyiPQ9xrqp9u/7/U34D
	STnM8j8c=; b=aShVMfxNQMyORWY2aVc5G6jMN1xR1Qeja+/EiRYMbiKeBS8Wsbk
	8N267Y4tAcUo7emrEUMmToMcyC50xwjjECr318MZqrQglH54G/PhlJLEkcdXVUnH
	cw80mgSP5LHu6ZzeoUnzYbtek2lL+O9zp5DyffSJzc1XwdHi+vEgrh7dw0jgFfsS
	0Nq/essHXeRpGznCCq3ASKN20f3VP+VlK/cGlHlc3CM4vpNlGgaMMXYdDmzB5Uaj
	+uouRPKKP81TPnhy+8InXDaO1zT+OfvoXC8qnXLtcl9ryT/WqVquoLFzb/F8/8B1
	nGjaStpqK3rBQhgpj7q8YidNIWfmVw/WKSg==
X-ME-Sender: <xms:PAQuZ9SJ3EFN-dM369OEyB8df5YCs_Of6W7lbJIElTHzuXOrR4lf5A>
    <xme:PAQuZ2xDIV5kxXMd16eSw93M-Yrq8pJpy0iWd06UXHooVaFgPucCt8o7HK7b3AFp2
    xMGZbOOiHmS-zu9SNA>
X-ME-Received: <xmr:PAQuZy0Vrb26583A7WxTkx1CGLaaS3pYD_yPU5tQAEvuXhw0gICnNS0P_bSbeN-vvbnkEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhhirhhi
    lhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    ihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehkvgigvggtsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtgho
    tghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepgiekieeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghl
    rdgtohhm
X-ME-Proxy: <xmx:PAQuZ1DeFxSowGphQsDsnbdh-mW-uWxdGD1DW73-LKeaJqkTlSJtyw>
    <xmx:PAQuZ2hM6Y3kVJq5AsSIVArK1X75Zw32D2iiX52TPIwsD_5czR6kRw>
    <xmx:PAQuZ5qUwSd5u8ENfxYLBwSawnns1pbVOlr8RP_lfoWXQ4qz1kJ6IA>
    <xmx:PAQuZxgzhNUWFzc9UvdeXtuNexKMgbytGapWJ1bNmix6C-F1eCL-9w>
    <xmx:PAQuZ_WiLzPmTwK5YCnLSusEadyAFfOGE9Q7uMBvSR9Gk6ALJ3X1Isbo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:29:45 -0500 (EST)
Date: Fri, 8 Nov 2024 14:29:42 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ozlssxlgc7a7hkwbq3tndam65l6l4ttfri6x3dmzye5qr5ehtn@qflzhgnipuxa>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
 <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_042952_463460_766EA935 
X-CRM114-Status: GOOD (  28.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2024 at 10:35:53AM +0200, Kirill A. Shutemov wrote:
> On Fri, Oct 25, 2024 at 04:56:41PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > 
> > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > deployments. Lazy is sane default to me.
> > > 
> > > Huh?
> > > 
> > > Unless my guesses about what is happening are wrong lazy is hiding
> > > a serious implementation deficiency.  From all hardware I have seen
> > > taking minutes is absolutely ridiculous.
> > > 
> > > Does writing to all of memory at full speed take minutes?  How can such
> > > a system be functional?
> > 
> > It is not only memory write (to encrypt the memory), but also TDCALL which
> > is TD-exit on every page. That is costly in TDX case.
> > 
> > On single vCPU it takes about a minute to accept 90GiB of memory.
> > 
> > It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> > it doesn't scale past that in my setup.
> > 
> > But it is all rather pathological: VMM doesn't support huge pages yet and
> > all memory is accepted in 4K chunks. Bringing 2M support would cut number
> > of TDCALLs by 512.
> > 
> > Once memory accepted, memory access cost is comparable to bare metal minus
> > usual virtualisation tax on page walk.
> > 
> > I don't know what the picture looks like in AMD case.
> > j
> > > If you don't actually have to write to the pages and it is just some
> > > accounting function it is even more ridiculous.
> > > 
> > > 
> > > I had previously thought that accept_memory was the firmware call.
> > > Now that I see that it is just a wrapper for some hardware specific
> > > calls I am even more perplexed.
> > 
> > It is hypercall basically. The feature is only used in guests so far.
> 
> Eric, can we get the patch applied? It fixes a crash.

Ping?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
