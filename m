Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CBDE7D0B4
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 05:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LWtCPxKOV80/P0kzIa1zoM0EFIVose+kscScTriQDFc=; b=43w59n6Oqin1he
	Jfesuw9DCu6jc1gXKIF4o75f1gxuU681wPHqrAtxG9vGHjGpzTitLhzFYhv6mVbIzIJejQuDUevog
	lpqHNYt62CF2DmnxuJQ15fZkKPVvykd/BMUxzj6umwPTL4pHS5g/+tLBN6mPdAzwcwufELzs986c9
	V7E/Rb30ZetHttIFdmLY3BM/RHo/TwlWeTlF9CcyiruKRscWjG1ESw3kmDOeC1K3YWxmdd7hVLzb3
	7NjN49wLpsJibmcILOg/l9SJQ7U7ienkghaAeWg6Ke0UUutHXC5BNLAAz8aYCGCM2zANu6R9oSTXE
	euLRDdDzxshUe9weJADw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjYZz-007uHU-24;
	Fri, 22 Sep 2023 05:19:51 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjYZw-007uFx-2Y;
	Fri, 22 Sep 2023 05:19:50 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DF86A5C021D;
	Fri, 22 Sep 2023 01:19:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 01:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695359981; x=1695446381; bh=sI
	mZwawhrAlSAj9rqR6mD9oRS9gtqddfHemubwEJhpQ=; b=UDpnI/8mmlayVHLf4l
	m4/3gUF7uj7omy6k4ElJUy7kaedsiQK2G+KLjdnJPz5BvxqKX5Zv7UXZ/yAB9gIT
	C8AhvX+rF6zYoK2cQq0hTkuMoimVo2piGEzU8Ex9ldUBbMJuU3hwzNh9pTm3zAGr
	9TtXINNzgKK1UmNE8NdlL+FL8WkVS00xpgdiRIGo9gR1W91I0tH2ZgPPiJ1RQV3a
	FR6x9Q37pL+xgSjcDRh+MtRPI0FMD7Sj1UjP5iFpL91vsea7tjRIx9ICNI/VeRIu
	o5bUJar+5lmDOarTmN8dvFOEIzw66bfF9nTclIRfTbLia3XyZZPxh5WItJ21od0/
	7avA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695359981; x=1695446381; bh=sImZwawhrAlSA
	j9rqR6mD9oRS9gtqddfHemubwEJhpQ=; b=Ca+52/0T1ttXgBWJ149du7KE2simN
	flPwcv7AuBKThqVk3cbbDD4ulrwPqmDQOgVRXV+Q/cKX7cCMxVoZejyzXsi23lOV
	7rglRfNpLcwMKZRwGwQo9txpDKQZpW/QzqfNePgZxkoIzzMfMNUPjDRRI+tJ9CPj
	sEhRFTW9dIWydA6g0bh66V/97F/hSV6AcKa6+5UsoKXTQNnjTwmUPHwmJCK7KrKg
	raQcnEs9dbjxjo8m1T061ZHbzZ+wDZhICzNiwsunec17MszjKU4InXP8dOvjpYML
	ybQhSxFK0txWyAJRQlpVqCdAP9revo3K3sU0O4adCcV+z7wr8Lie8FPXg==
X-ME-Sender: <xms:7SMNZbSKZYdBbPKLuDBcwGe0Rb78gbgTbNPGLvcyjGW89vrVcRrIjA>
    <xme:7SMNZczivx6RZ1a-Wue-RUncrJaSwItjoQqqcqplOj_U2aAkQSwJfsVE7gLaKuPbb
    xPQNEMuVJOFOoOI8n8>
X-ME-Received: <xmr:7SMNZQ0x53Caj-6dCgL0WSHUpz47vB-7yZghDjkeiMGWtzzU2ibesQ8hsopY0PjejJ8ZW7GwwDJ1VXBlyE5ot9OlDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjh
    hfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeehgeefffejveeuleekueeguefftdef
    hefgtedtieeghefhtefgiefhiefhtdetheenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgv
    rhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:7SMNZbD8YIuRD_AooZ6bAE5jgsJAsZUYkFBlqVy-y2u_JPeGHHg0Bw>
    <xmx:7SMNZUh71Uk48BslAAQw-dkeZ6UrzSexw4yb1Tp2WwCp5u1x14QHvg>
    <xmx:7SMNZfrJ7tM1-HQRbxW7EH-oXOoo6Udc79IBAEVQr3KIOlBPQzcE5w>
    <xmx:7SMNZdZ9IB3bBaTU5JbU9kDaqqLPemtOSuHUowrJlD7h9jdnKXFrmw>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 01:19:39 -0400 (EDT)
Date: Fri, 22 Sep 2023 07:19:36 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, mjg59@google.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
Message-ID: <ZQ0j6Es88aR8cjRv@desktop>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_221948_916452_ADA63A4D 
X-CRM114-Status: GOOD (  24.01  )
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

Hi Pingfan!

On 21 21:37:01, Pingfan Liu wrote:
> From: Pingfan Liu <piliu@redhat.com>
> 

> For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> can check against it. But at present, there is no signature for kexec
> file load, this series makes a signature on the zboot's payload -- Image
> before it is compressed. As a result, the kexec-tools parses and
> decompresses the Image.gz to get the Image, which has signature and can
> be checked against during kexec file load

I missed some of the earlier discussion about this zboot kexec support.
So just let me know if I'm missing something here. You were exploring
these two options in getting this supported:

1. Making kexec_file_load do all the work.

This option makes the signature verification easy. kexec_file_load
checks the signature on the pe file and then extracts it and does the
kexec.

This is similar to how I'm approaching UKI support in [1].

2. Extract in userspace and pass decompressed kernel to kexec_file_load

This options requires the decompressed kernel to have a valid signature on
it. That's why this patch adds the ability to add that signature to the
kernel contained inside the zboot image.

This option would not make sense for UKI support as it would not
validate the signature with respect to the initrd and cmdline that it
contains. Am I correct in thinking that there is no similar issue with
zboot images? They don't contain any more information besides the kernel
that is intended to be securely signed, right? Do you have a reference
for the zboot image layout somewhere?

> I hesitate to post this series, 

I appreciate you sending it, it's helping the discussion along.

> [...] since Ard has recommended using an
> emulated UEFI boot service to resolve the UKI kexec load problem [1].
> since on aarch64, vmlinuz.efi has faced the similar issue at present.
> But anyway, I have a crude outline of it and am sending it out for
> discussion.

The more I'm thinking about it, the more I like Ard's idea. There's now
already two different formats trying to be added to kexec that are
pretty different from each other, yet they both have the UEFI interface
in common. I think if the kernel supported kexec'ing EFI applications
that would be a more flexible and forward-looking approach. It's a
standard that both zboot and UKI as well as all future formats for UEFI
platforms will support anyways. So while it's more work right now to
implement, I think it'll likely pay off.

It is significantly more work than the other options though. So I think
before work is started on it, it would be nice to get some type of
consensus on these things (not an exhaustive list, please feel free to
add to it):

1. Is it the right approach? It adds a significant amount of userspace
API.
2. What subset of the UEFI spec needs/should to be supported?
3. Can we let runtime services still be handled by the firmware after
exiting boot services?
4. How can we debug the stubs that are being invoked?
5. Can we let the EFI binary know that this is a kexec and not a normal
bootup. Potentially systemd-stub would want to change how/if it does TPM
PCR measurements.
...


[1] https://lore.kernel.org/kexec/20230911052535.335770-2-kernel@jfarr.cc/T/

Added some more CCs.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
