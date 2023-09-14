Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D90DEEAA77
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PiUFLWtRT98sCE5H2A1faWDhll8EOYIpzxykbZ3hOYQ=; b=Z9wsy75zmu6NvD
	chMLNucqnQT3H2qhanNVrubR+ZbiCGNGpmzOcLahv4COpnEUNZkbiJJbhnuzn7enaHLZHcs4pVaxC
	Mp9sQkLqMvkVC1GudGnTXJy29PLZnQTkBXCIaZnfqiPu1o92Q8ZhCZKTRaVIUabUGjGbad7ulVYaf
	IunSEq7Te0bgV8w2RrVFsi23az6w1bxfA7ap9zgY/I6mHeTiMTHhBxFYkmbwUppHbU0qttlnCVEls
	bB0wFcbVfZP49UXVitH2qLPkzclebDeRThelmoemo9+Fga6hZSRZmCwH3r7rh7MnjtAIPfX0Sy89D
	ryz/8euGsusX/is4dSpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgtWH-009HSr-22;
	Thu, 14 Sep 2023 21:05:01 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgtWD-009HRf-2Z
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 21:04:59 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DF75D5C0244;
	Thu, 14 Sep 2023 17:04:53 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 17:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1694725493; x=1694811893; bh=Q8
	C93Gk0ScZhXMgVCWiaWrSwELvWnPJr1AijyyP5Y4I=; b=XWjyVE3DCe4iMswqXJ
	esrgCVjVi5KmZXD6Lc1k/sQ8AQ2LvgvA8qYuIJb9AYqXXYIn3OJJlyMHAiiAYO3n
	eOfBluBhCE1Cy3AFTZ8y9qiIC42NoFVtqHouPLTRbk0vZMxgduhXxAIihoivxqmL
	CT8Pc4JIdqujm8ACii4V5Yr0jcZu/mIDVmqf47qs1z9IEtQpj18DaPUY/qlWeMgs
	xFIRF540lpUhCtAKjjT5msjrbamE14o4IC/ibzGEt7gRmZieSozSuZXjPH+OKhGS
	AxMg1HRH+MjQDermTbQRCrlsj2tk75JzmMJz1AO8F3QpbpWwj8mEYgMxx8dn2nxJ
	Ijhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1694725493; x=1694811893; bh=Q8C93Gk0ScZhX
	MgVCWiaWrSwELvWnPJr1AijyyP5Y4I=; b=mBsewF8sV8xnObt4tQGPqBiS4mdM4
	0r1KkYPvIE71sp+eRb6fN/ZKecV/HI4MrrjT0z0/1iv4uqrERN3rbJ5BAzPYY2rN
	K02rYyS1Q02XXJZiP5JBnrVMrBoqM0dYMd1WpTxmQW2H/ZmcDGMj2Scgr0W5YuC5
	+l+LfccrvdL8alf/wVYNJG6nQwzdE0oqlvhN/84MfF+Te7m3SIsQ/fhyYdXct/cj
	F4ip+GaSV1GSZDKKSmJ+QjfkN0miVX49d5yRUB7KDL3G5phXm3SrwrF9SxlhTXjh
	icdq3E/IRaCgolp9R//E/r/AVOyccesU8tWM0fb6sEOiaPYaTAsi+l+7g==
X-ME-Sender: <xms:dXUDZWs_USnV_xkhdH8zmhPq0aAd4RKGuxW95sKRVhMQxkkleQzvSQ>
    <xme:dXUDZbc-LB_bmHRIvgdWkSi5v17yiv0H5qLNTFTjrWFKYbBNAihsPXLVmmnxEPPB0
    Ik5CyHpvy70i2uHUBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedujefhffdvffeikedvkeef
    ieeutdffteelgeetfffhkeffheeiheehvedtheetieenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:dXUDZRx2Q4BCN-PN8IriM9hElbF5IzORT1b6b99-40b-yMSNSKTXgQ>
    <xmx:dXUDZRPeiaeLI_c0zl6kxWjYKmwTWZtU_-wZMagL2vemImgZV2TUUw>
    <xmx:dXUDZW9kAKOyfEzUeR8xUY2UJiQcAUM5MJaIq3Tj3GqpjoMArkfPNQ>
    <xmx:dXUDZX3wlBbJdMAmS6l5brjZqTkoNGU7LKttm1Q6qHZREdWzF1QWCw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0856E15A0092; Thu, 14 Sep 2023 17:04:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <0e1984af-88ca-4908-a5ca-3191d96aa63f@app.fastmail.com>
In-Reply-To: <20230914205149.51031bc9@rotkaeppchen>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
 <20230914205149.51031bc9@rotkaeppchen>
Date: Thu, 14 Sep 2023 23:04:32 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Philipp Rudo" <prudo@redhat.com>,
 "Lennart Poettering" <mzxreary@0pointer.de>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org,
 "Baoquan He" <bhe@redhat.com>, bhelgaas@google.com,
 "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_140458_206389_16A4CD12 
X-CRM114-Status: GOOD (  21.45  )
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

On Thu, Sep 14, 2023, at 8:51 PM, Philipp Rudo wrote:
> [...]
>
> In this context I hope it is also clear to you that when more and more
> people rely on the spec you need a more formal process when including
> changes. Especially when the change might break the implementation of
> others. So no more making the .cmdline optional and allowing it to be
> overwritten all on the same day.
>
> Having that said, what does "local override" exactly mean? Does that
> mean a distro can allow a user to freely choose the cmdline without
> checking any signatures?

The behavior of systemd-stub is to allow the bootloader (or whatever
called sd-stub) supplied cmdline when there is no .cmdline section in
the UKI. That's how I understand "local override" here. For WIP v3 of
this patch the behavior is to use the cmdline supplied by userspace to
the kexec_file_load syscall if no .cmdline section is in the UKI.

empty .cmdline section -> empty cmdline always passed to kernel
.cmdline section -> use bootloader/user supplied cmdline (which would
be empty by default)

This setup does not make sense for a locked down / secure system though.

Maybe the word "override" is not ideal. There is nothing actually being
overridden as there is no cmdline in the UKI in the first place.

sd-stub also allows the bootloader supplied cmdline if not using secure
boot. So maybe the kernel could allow user supplied cmdline if not in
lockdown mode for kexec maybe? If not in lockdown mode somebody can just
kexec an unsigned kernel + unsigned cmdline using the kexec_load syscall
anyways. For this case the word "override" makes sense.

The logic for all of this in sd-stub is in [1].

> I.e. does that mean we can get rid of this
>      https://github.com/systemd/systemd/issues/24539

This is a different usecase IMO.


>> Hence, seeing the spec as set in stone and as inherently low quality
>> is the wrong way to see it I am sure. Instead, the goal here is to
>> adjust the spec to make it work really nicely for *both* systemd and
>> the kernel.
>
> Sorry, I never wanted to intend that the spec inherently low quality.
> Just that it doesn't meat my expectations, yet. But that is fine. The
> spec isn't even a year old and there's only a single implementation,
> yet. So it's more documentation rather than a spec.

Let's make it happen.


[1] https://github.com/systemd/systemd/blob/5898cef22a35ceefa068d5f46929eced2baab0ed/src/boot/efi/stub.c#L140

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
