Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE40DCA0EF2
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G1jDR5YXJfr43CjvuUUcBSHhew398mT/ohbfF0OyRw8=; b=yon/wbD/Z3zVC9
	aZgdffLTdzvfphuCOS/KPaShGxreCQJKfS7vmFGRy2uXaNNB5Zl0HAcnkge7UbybYZIUYqSrvIspB
	PEGSbtjZalWlJL1n6CfJLN1bGp1bW7S9a0tUh9BQT7EEatzpgo6FCTaSQFyFVf44N2BA+6AhUEovN
	3e4EY1Y2HmOUYkLY3hrLq3EWRAHVFZZaKrJqq5FXGHjrMsMRCbjCq+8FdTtBwaAp2YY9WOUAsz4LD
	YBZ/6S3j97nEbCmevivOT0qIcbXWOJL5OWxJ5vsMc3LATX6nKKb7rRJvtmTGEZO0Jql4bsRNE8X5D
	zgWq+SxMmmyaXk0seYDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5Ol-003jSG-1t;
	Tue, 12 Sep 2023 15:33:55 +0000
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5Oi-003jRZ-0D
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 15:33:53 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7A89D3200980;
	Tue, 12 Sep 2023 11:33:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 11:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1694532822; x=1694619222; bh=KO
	z5h3i0laQ2JDFHsBvYcLYWW5n6o1vdglgxXAJAFV4=; b=TtPPo6ZoKzSk7P4qDt
	jDuj0AN0PfaC9W+XHhwpWgwYMNPxzijHDCn0Vl+WsV8QoHZ79H08dC9uB0a82I2U
	1pywhW7Po5LVgnWlbvnFGqbScLWKgwBXi1qRGRU6MlZkoqGof1AreiEqqaUdErV3
	p534KN+KOrn73q4t1S4YxPCM0AbL/qMxYA7nA1IXJniCwHBUFEioNPvmrCrC6HXx
	+IXQXKnCmoS9tyLjAaGz41x8PB2V2q0VqEhGYP2eibg3C1GWOiQrQJQeSP9TwV7p
	G4Y1W3I7fugPC131JQw1aenqaR4HxMxtxrPPzWQ//xjnpOolS17/Zfzb/avjWBY5
	gM7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694532822; x=1694619222; bh=KOz5h3i0laQ2J
	DFHsBvYcLYWW5n6o1vdglgxXAJAFV4=; b=N3byRdtHn3WQe+Q8zV36ZVWcMVjMI
	WCNxG+CuN/Bso3xbNBwrnsvMbSLphtivO+/EgviLdXiQoj5yKbANla4CM1eJZBmt
	3fQeMDSFFFJRdw2ez29AELn678XkKihqqi9hS3ClLGSYMr40xTyHWiKPRgG6/Hch
	9kd5MglSh2BQnpglt5lbsN/KBsYYPqWAxwo+uCQl852vSBieDVJoqIQ+ZWjiSRtH
	6Ws/NP0z/YXc83SgnIV5gptrB5Yz2C0sFlh6ywYj+JtnF6X6NypcFPs0Wmg6c2D5
	9jRk7LgPzWuNqkwu/5ZywhoNObmxAep22z5AbDW7DP2VRNoWKEMTHjlVA==
X-ME-Sender: <xms:1YQAZYZQP2ZmnRsr8L8nreYVL7hX3E2d3RqDf_UovKMdYVSawJaWaA>
    <xme:1YQAZTbJyyIqy40Em5gTwRtKov7phG91xYKr4dr9NtgUMG9bap77jUvc4EExw8IlN
    QelHpo69h4Ozok3GJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepjedtjeetteeftdejgeejjeef
    hfdvhfehtefghfdtlefhheekueejtdeggeetffegnecuffhomhgrihhnpehfvgguohhrrg
    hprhhojhgvtghtrdhorhhgpdgrrhgthhhlihhnuhigrdhorhhgpdhfrhgvvgguvghskhht
    ohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:1YQAZS-IszAfcFzfxXtn4xL3cGVfkA8iauFXj3JaL2bLm43mcyoO9A>
    <xmx:1YQAZSqiApuUwaIDjxXg2lGDtfV1WDNTtyuJ6OCc_ovwKf-tOxmDNw>
    <xmx:1YQAZTqMzIQJfnfXK-VXae-Tz7tcIT8KP8fq78g0mc6Pcz7Pdozhtw>
    <xmx:1oQAZQihtitFtbSDtzF-WnXgxZOoXE618GHH5mfoQAUwXtokHRB1SQ>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 85E3215A008E; Tue, 12 Sep 2023 11:33:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
In-Reply-To: <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
Date: Tue, 12 Sep 2023 17:32:41 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
 dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
 akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
 bhelgaas@google.com, lennart@poettering.net,
 "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_083352_137955_3A8B3E1C 
X-CRM114-Status: GOOD (  19.77  )
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



On Tue, Sep 12, 2023, at 12:33 PM, Jarkko Sakkinen wrote:
> On Tue Sep 12, 2023 at 1:54 AM EEST, Jan Hendrik Farr wrote:
>> > What the heck is UKI?
>>
>> UKI (Unified Kernel Image) is the kernel image + initrd + cmdline (+
>> some other optional stuff) all packaged up together as one EFI
>> application.
>>
>> This EFI application can then be launched directly by the UEFI without
>> the need for any additional stuff (or by systemd-boot). It's all self
>> contained. One benefit is that this is a convenient way to distribute
>> kernels all in one file. Another benefit is that the whole combination
>> of kernel image, initrd, and cmdline can all be signed together so
>> only that particular combination can be executed if you are using
>> secure boot.
>
> Is this also for generic purpose distributions? I mean it is not
> uncommon having to tweak the command-line in a workstation.

This is for generic purpose distributions. See fedora's planned rollout: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1
Or Arch: https://wiki.archlinux.org/title/Unified_kernel_image

There are UKI addons that help you achieve this. These are additional PE files that contain for example additional cmdline parameters. On a generic Linux distro doing secure boot you'd generally use shim, could enroll MOK and use that to sign an addon for your machine.

This patch currently does not support addons. The plan would be to support them in the future though.

I personally always run my own compiled kernel and build a UKI from that so I can obviously tweak the cmdline that way and sign the UKI with my own secure boot key.

>> The format itself is rather simple. It's just a PE file (as required
>> by the UEFI spec) that contains a small stub application in the .text,
>> .data, etc sections that is responsible for invoking the contained
>> kernel and initrd with the contained cmdline. The kernel image is
>> placed into a .kernel section, the initrd into a .initrd section, and
>> the cmdline into a .cmdline section in the PE executable.
>
> How does this interact with the existing EFI stub support in linux?

It doesn't. During normal boot of a UKI the stub in it is used (systemd-stub, see: https://www.freedesktop.org/software/systemd/man/systemd-stub.html). The kernel's own EFI stub will still be in the binary inside the .linux section but not used.

Now in this patch (also see v2 I already posted) obviously non of the stubs are used.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
