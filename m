Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE0DEDEC6B
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eV3Nc/Ggjhq418QtOg5kExtgt0WMcxrStOKzNb5kamM=; b=Ks68qwQlEuWIBM
	sT/O1a+lJ2GMwICe1XDkYAHx118dJ2CNxyLrimxZD5CydiuB5RKY+52vv70Bmvv13h/5cx3kvD8wu
	ZuJ6OeyWbTnfRbonWVu2lKJPxz48yTQx8Ixe8q80T6JOPxVWD65lEKISZvymFcCz45Ml/OheBKImG
	E+f/CNR6fsfYgjw/goobUr6t3dN8CKYBXboGGw2v0u6orG2i1jkq/sUSEVP6/KRsAEeqBn7iEU1NJ
	sCH/dfn+Vc1fdVELceMWiLL2RnWADaflB+BAVG3GahI0dl6xFQ9rtB/cuTV8CqBL1ggJtHvdMqINI
	s/GbFrEWzGkSF72lXdPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgR5I-0068cH-1K;
	Wed, 13 Sep 2023 14:43:16 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgR5E-0068a1-2e
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 14:43:14 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2ADF33200124;
	Wed, 13 Sep 2023 10:43:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 10:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1694616184; x=1694702584; bh=I6
	KW7EN8WvVpcxWfprs/LJK5tndoIFl6DB/6pYFRPh0=; b=IsVydtLgKseG3i3ML8
	4b/WocveJKvs59G51DXEWtVbu7hHrUwVUyOEyVRtn/2UyVUVUNi2dT/E4U9cODza
	xkMIkOP1ZdPlWVLcFwIDXTVz7OGV5cwhEZM6v6fI4BnNrcKBZYNoJbQ0ChDyoTds
	4I2+JjcJIUKsjGzIOkfs6lzsdVIzsBswI7jGtDxs+YF70JHZX1kLtwUmQBVPWRLg
	HgipqwZTqTGY6p/YNlnCK1n60vjv5HV1XEb7xMKCBwQMMde5HWB1/96xrS5D+lph
	+fgykQNo3DCHkbwEH58sgXUOPoErO2Hlz/QNMaePc9eT5MRUch6DD9rmPHHTsOj8
	L1dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1694616184; x=1694702584; bh=I6KW7EN8WvVpc
	xWfprs/LJK5tndoIFl6DB/6pYFRPh0=; b=Vf0KujZYCawZbS+XrCdJUmeTAc7Gg
	7ywQukNuFVgldRRrsbK9lrfuSoTVoi2WNPbE/BwDJmW+TGeexiSFAvFKOZn/3LOH
	Tuit06RIOD5rVZzLQPHjL1l0DGQAgEloIr4lxLtcqeKM5YJnoZwnN3ZXabUK3gxY
	VfE0zyKOymr9uOLxyMC/2UW2CL8cix20TLNr+7mSRfGXhK5Ko9parr5aQPVUaoG9
	Of9CrdX75lqC8nga6LGXod8KEJUWQuqrQh6Y6OEagZwVrzt39kwfbd3uxTLQtxkh
	flalktSwldhtrREIM0ri5vCtee5zcKMV7sfFCnanBQdI1iN0cq58x7PWg==
X-ME-Sender: <xms:eMoBZd81D9U4PG1S6KuDuT32xq8PMoyJimrSqgXEuJxyKo33trJHnw>
    <xme:eMoBZRtmarVCRCNVbulJfPtXuR0a-PoWjyiCAAw26Cy1H0jz97FBjIfBUOfsA0foP
    RPV5_IU1_XMnSqh3b8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepfeeftdevveeihfetieduieeg
    teeftedttedtheefgfektdffueeujefftefhleeunecuffhomhgrihhnpehurghpihdqgh
    hrohhuphdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:eMoBZbATTlioymGAWf1Fl-90l4ZJkWDsZPLfWpKGbJ_7U-Jum5-YOg>
    <xmx:eMoBZRfuEcqcQxhFdajq8p0L8Nq_4oMSJ1DzLd323HZDTrN2O6ZoSg>
    <xmx:eMoBZSPOAtE83vmeOskNNhRUI1tEMouXukMkSNCDAfEPlobsQo6WJw>
    <xmx:eMoBZTEvlS-KDl4IqW3rE7EEl36sT1jSoPoxFPqonA_xDPlq8tIeJA>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3428D15A0091; Wed, 13 Sep 2023 10:43:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
In-Reply-To: <20230913160045.40d377f9@rotkaeppchen>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen>
Date: Wed, 13 Sep 2023 16:42:33 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Philipp Rudo" <prudo@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org,
 "Baoquan He" <bhe@redhat.com>, bhelgaas@google.com,
 "Luca Boccassi" <bluca@debian.org>, lennart@poettering.net
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_074312_931277_1A3A814C 
X-CRM114-Status: GOOD (  35.13  )
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



On Wed, Sep 13, 2023, at 4:00 PM, Philipp Rudo wrote:
> Hi Jan,
>
> All in all the code looks fine to me. Nevertheless I don't think UKI
> support should be added at the moment. This is because IMHO you
> basically reinterpret the kexec_file systemcall and thus add a new
> uapi to the kernel. Once introduced it is extremely hard to remove or
> change an uapi again. The problem I see is that the spec you based
> your work on is in such a poor shape that I don't feel comfortable to
> add any new uapi based on it.
>
> For example there are two definitions for the UKI which contradict
> each other. The dedicated one [1] you have cited earlier and the one
> in the BLS for type #2 entries [2]. In [1] the .linux and .initrd
> sections are mandatory and the .osrel and .cmdline sections are
> optional while in [2] it is the other way round. Which definition
> should the kernel follow?
>
> Furthermore, I absolutely don't understand how the spec should be
> read. All the spec does is defining some file formats. There is no
> word about which component in the boot chain is supposed to handle
> them and what exactly this component is supposed to do with it. But
> that is crucial if we want to add UKI support for kexec as the kexec
> systemcall will replace the stub. So we need to know what tasks the
> stub is supposed to perform. Currently this is only some
> implementation detail of the systemd-stub [3] that can change any
> moment and I strongly oppose to base any uapi on it.
>



I think I have to agree with you on this one.

I kinda experienced this first hand. My initial patch required a kernel
command line, because the spec in [1] didn't say it was optional. Then
I got a response saying that it's actually optional. And the spec got
changed in PR [2] (I have a WIP v3 that allows a manual cmdline if the
.cmdline section is empty as explained by Lennart in [2] and now
also in the spec since [3]). So there's already 2 changes in the spec
in the last few days related to my patch. That shows that the spec is
not stable.

What's even worse IMO is that the reason given in [2] to change the spec
is simply that systemd-stub has a different behavior than the spec and
therefore the spec should be updated. At this point it's not really a
specification but simply a flawed documentation of the behavior of systemd-
stub / ukify.

I also discovered that ukify treats the initrd as optional [4]. So is
this the next change in the spec?

In [5] Luca writes:
> [...] we fully intend for the UKI format to be an open and stable
> specification, that anybody can support and rely on.
But that is unfortunately not where the format is at this point.

What is annoying though is where this leaves a user that actually
wants this feature. They can carry a patch or they might have to wait
a long time.

Can you indicate what it would take for the kernel community to consider
this spec as stable enough?


> In the end the only benefit this series brings is to extend the
> signature checking on the whole UKI except of just the kernel image.
> Everything else can also be done in user space. Compared to the
> problems described above this is a very small gain for me.

Correct. That is the benefit of pulling the UKI apart in the
kernel. However having to sign the kernel inside the UKI defeats
the whole point.


[1] https://uapi-group.org/specifications/specs/unified_kernel_image/
[2] https://github.com/uapi-group/specifications/pull/72
[3] https://github.com/uapi-group/specifications/pull/73
[4] https://github.com/uapi-group/specifications/issues/74
[5] https://github.com/systemd/systemd/issues/28538

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
