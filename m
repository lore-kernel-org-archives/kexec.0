Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBC1CA0EC6
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 22:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wyh0VsT/criywN73crbZMD52bnycbq/0SKTFRs7Gvz0=; b=b1dsNJCMJGBUkD
	bVZj0QZdWC0pELrn62uMDr3GprUSIeZJ6+aN9efIimNsRs02uXOwBQJFHwkfjjF8Ihjrx4NuhP/sO
	rURK5si8+34Of9tdOULaWbAfMb+P6fly60ABfPSLsRtoR2d7XXkJ/YWU5D3TtGH1Cjz3Id6X7NS7M
	Yf6eepNIqN4D9edueCa8fvJVW55brYlArFCR6RsfEuXF82EkYYNfC0FPi+5hJcgM7Ne8i5byEdtxe
	fQ8+jQkQk5LN55V56O/bWCmvGBvZhLfppZB9AIaDqf59kXqT0WIsA3fGYiGy3zBJrWFx8e5qxudgc
	PUnabUO/CpQdIvly2f+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfppN-001YJX-2h;
	Mon, 11 Sep 2023 22:56:21 +0000
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfppK-001YIA-36
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 22:56:21 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id F06373200918;
	Mon, 11 Sep 2023 18:56:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 11 Sep 2023 18:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1694472971; x=1694559371; bh=Ea
	pXY/dHk/L+KfdsJnZIXaxdmbC/YxZh0fcsusxzVFI=; b=Z1qW4isTxdg0I62aD1
	I6xzs2VtaTEAsQ3HsKYDilLUwxksu1tbRY7mkgyromFZzzxkqw2HD1OytTiahXb+
	Nx++gyTMlYhEOXbv5M15Sv3+PtNQihmUsv3dOXcMUtH4uwaQKDG+Ke/WcFaO7JJD
	aWeyNoWEb0IIa0nI/WAbnscDv5AfH0utP2SU6SMXqufpPeS5IhkHAWdMizSCIZK8
	Rz7/9L4qibgjCRoAvPnTFe0cpuOXJ48NBHwsFq99KJKgcmlKi/Uov1iytDlEUxzq
	8+Tp6wiTCdkbuTSw+voRiO9HvyeHG+JWSKYabZ+xsSS3dUAIumWHMwWBCFWYF9mh
	ClIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694472971; x=1694559371; bh=EapXY/dHk/L+K
	fdsJnZIXaxdmbC/YxZh0fcsusxzVFI=; b=yJVLsQbOVAvTKRVKS6v75wpQgMsoT
	9ywUmKRPfsf1BBXCY1CutXWcP7i+S+utGssDMp7J1Two2sJEdzhkuWaz1mMBECld
	BBjrrwYVyp/rU/5zE0a/OfxQFuTohRzT8ONhSZ1v5Obka3Ca+TOmBJq3oMmTjQq1
	8ofvp3OmG0Otplz7RMq7oH75+X95yAahcq9rqtZnPK5yJQ3eowitbf9xw+l+B719
	bVH1NVp76WU/he8clQ/fxPKSUVuyza4XyVwFIszRYV+bcvZIjpynjaYSYnjCipRP
	ukY7Gq9Ls7qeZvo5Xan5Kaf9L3BwiPL1ovkg+VNiCwo5p0iNvkJbR2ciw==
X-ME-Sender: <xms:C5v_ZEpwyEBB74Zm39jhT64htpAlb6MdMT-bXMXlW4cKqlytXz5fXg>
    <xme:C5v_ZKpnaKI4JTufIEfztGy9tX4JHGg_xeZiadJLZl8SM8R6xxeO96G7pu7293XXi
    GKiEJCQuFZAYiD7jWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepteeluefhfeehtdejvdduvdel
    hfffueevteefgeeuhedtiefgtedtheekhfefiedunecuffhomhgrihhnpehurghpihdqgh
    hrohhuphdrohhrghdprghrtghhlhhinhhugidrohhrghdpfhgvughorhgrphhrohhjvggt
    thdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:C5v_ZJM3r-dc6IffYP6H__wC090VsMK6o19bPReC26my5OUjiXLX6w>
    <xmx:C5v_ZL4n8AvAAM-g_ClsLtVIwL1EW8AyhNcUWsrH0sj9qsY7PP3V4w>
    <xmx:C5v_ZD5kYXz49K8Fj_OGtrvGT6f35vMs4ZRrwW4uTHAdtcKGdgvLDQ>
    <xmx:C5v_ZAyCAZRXV9ddr4oruuG9fD_5ZU-TmNH4hCtm0tQwHvP3F5eNPw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E597B15A0091; Mon, 11 Sep 2023 18:56:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
In-Reply-To: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
Date: Tue, 12 Sep 2023 00:54:32 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
 dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
 akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
 lennart@poettering.net, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_155619_194341_9121C2FD 
X-CRM114-Status: GOOD (  11.58  )
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

> What the heck is UKI?

UKI (Unified Kernel Image) is the kernel image + initrd + cmdline (+ some other optional stuff) all packaged up together as one EFI application.

This EFI application can then be launched directly by the UEFI without the need for any additional stuff (or by systemd-boot). It's all self contained. One benefit is that this is a convenient way to distribute kernels all in one file. Another benefit is that the whole combination of kernel image, initrd, and cmdline can all be signed together so only that particular combination can be executed if you are using secure boot.

The format itself is rather simple. It's just a PE file (as required by the UEFI spec) that contains a small stub application in the .text, .data, etc sections that is responsible for invoking the contained kernel and initrd with the contained cmdline. The kernel image is placed into a .kernel section, the initrd into a .initrd section, and the cmdline into a .cmdline section in the PE executable.

If we want to kexec a UKI we could obviously just have userspace pick it apart and kexec it like normal. However in lockdown mode this will only work if you sign the kernel image that is contained inside the UKI. The problem with that is that anybody can then grab that signed kernel and launch it with any initrd or cmdline. So instead this patch makes the kernel do the work instead. The kernel verifies the signature on the entire UKI and then passes its components on to the normal kexec bzimage loader.

Useful Links:
UKI format documentation: https://uapi-group.org/specifications/specs/unified_kernel_image/
Arch wiki: https://wiki.archlinux.org/title/Unified_kernel_image
Fedora UKI support: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
