Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3A2C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:References:In-Reply-To:
	Message-Id:Cc:To:From:Date:MIME-Version:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PdjdVXyhdBZXLrn/wd6DlYLnRXD3zL1oq5Jvn4XQtTg=; b=XBYGl4h9ROfXOXAwyPeShqjAne
	vgUjH2ktrhM6uIUn6ilaM8WshoYyqOjCOls1+MOxrs6tRIlEXZc+u+t0EC7Pz6Eux2PzqI/7Ilg0D
	g+zl2uRF7uekaxNtvTzOysH0K0UYqa8A3vkgmXIyTRrszzpNSChLv8kYXwB32t6E194Eq7PV1Gulm
	Yctk/ansWzWYyITCdrryM+VgsI1P+Sjx95KxXYUsCjOxP0yEJCOJWNvKVKPHHsILlIqTX4dVVI+Et
	pR1SEF2ShTOyeegT70G6kdXmy312/L1iZNH9rq7T94Rmr9BINmQu2wDeI+St5pUaR4Gj+0m8RO0bM
	DIZcIUDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5UZ-0000000CUoY-1dZm;
	Thu, 22 Aug 2024 10:56:35 +0000
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5UW-0000000CUnq-1oHl
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 10:56:34 +0000
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BA10138FC54;
	Thu, 22 Aug 2024 06:56:29 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724324189;
	 x=1724410589; bh=ZLaLyJEH9kAfKRmJ7C9mQmjk14xh4u+FXopaAqi2VN8=; b=
	lhSM6N0FPks4+A+qc5VwYCIhb49FxO/NT/Y5fYZwykIZO1L32xZ0fqRg5ovXGgb6
	ok9gRWUxKXrUqHKDusthrherCwa344O6Fnd/x5rCa8VxyrF+AwzHcGoGitCwL23K
	lVB8Lx+XCuPS+P7wmguWt0aIcXilkYiNccs7PsghfhuDdHyE0zOYUgBB+sQbgxDd
	RlReFhIsXDQRcxkSJhZFsRJC4xR6r20baZygaSkv42mfkav1tBcyqN4a//3rsxtn
	loGW0vJrQ/8uTKCzjU9uwA9QB9+jn1FwO5CwJ9BtMapsqviYytM1gT1IK1u2Ip14
	vYocBQfHjkFOZOQCz8Pmxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724324189; x=
	1724410589; bh=ZLaLyJEH9kAfKRmJ7C9mQmjk14xh4u+FXopaAqi2VN8=; b=q
	lQXi0OgCaiuSf5foI+YXfLATsug7LcWWj0ucMGwIhCGz10gmC6juSdNY22qLUdhH
	ddGBwYAoJrinrvFV/uUfPajTVtkQAQ+QVxu397m0/pmfNiHmc2fFftbu0xEfLWhs
	VdPwB9OSuXNMFEY0XFoyJygQqfJX13a+M6gg0xpQfTbujw5PRPhRDrfWAs9pMXOh
	cjA1Cy449T7j2MbHldTaIfnHAAU/iD5BN3FbUJOM9ai8FzcERltatx0Oh4heIu+p
	na3dQPg3iVZeWWId/jZFSw6ti3i4dDM2QrxYM+j4LE63Vge5p9aDZO6rrP0lwmxN
	j7tHYf1WOkZ8hrYkuB7pA==
X-ME-Sender: <xms:XBnHZsPXLAFwdU3KNEtUuScoXi0ht7Ug7A0_6XEV5c2pP81eoWuPMw>
    <xme:XBnHZi8sqxM_-UkAzwWZ7Ce2M5Sb1mOksGUCTna1U2DAuGNh44rw-qs9Ul_29iDPx
    PRdVKGmbLpbLUZ612A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdluddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrg
    hrrhdfuceokhgvrhhnvghlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepvdeu
    gfegheefudeikeeihfekgeevvedvkeduudejhedujeefgedvleffteeiffffnecuffhomh
    grihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrd
    gttgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmiiigrhgvrghrhiestdhpohhinhhtvghrrdguvgdprhgtphhtthhopegtrghtrghlih
    hnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvgigvggtsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepugihohhunhhgsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:XBnHZjRiSJ5uhVIWfntvv_tdKfRRzIx1KmTP1PqKDZlk6xphx3SuuQ>
    <xmx:XBnHZkv031FSjHiPTHeY2evQdxQ7GQqawYlO0HSlldcs6FaE30rhpQ>
    <xmx:XBnHZkcqPo1EYr-qJso-71jeYZWsIeGHIY7FDqUnEE-mfJi_7AwMew>
    <xmx:XBnHZo1mzgmqluJlONDy8nw0Az1p0BshL3g2BQ0yVyO83UiK5kNR0w>
    <xmx:XRnHZj_C7_bGGBPLtlDFN0agSRPIeKJNqTXmbTP2BuwpgG2xYtfC0dZp>
Feedback-ID: i01d149f8:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7C90780062; Thu, 22 Aug 2024 06:56:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 12:56:07 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Dave Young" <dyoung@redhat.com>, "Pingfan Liu" <piliu@redhat.com>
Cc: "Lennart Poettering" <mzxreary@0pointer.de>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Philipp Rudo" <prudo@redhat.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Eric Biederman" <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
In-Reply-To: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_035632_845430_910AD097 
X-CRM114-Status: GOOD (  12.25  )
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

Hi Dave,

> I forgot why we can not just extract the kernel from UKI and then load
> it directly,  if the embedded kernel is also signed it should be good?

The problem is that in the basic usecase for UKI you only sign the entire
UKI PE file and not the included kernel, because you only want that kernel
to be run with that one initrd and that one kernel cmdline.

So at a minimum you have to have the signature on the whole UKI checked by
the kernel and than have the kernel extract UKI into its parts unless you
somehow want to extent trust into userspace to have a helper program do that.

That's what my UKI support implementation from last year did.

v1: https://lore.kernel.org/lkml/20230909161851.223627-1-kernel@jfarr.cc/
v2: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
v3-wip: https://github.com/Cydox/linux/blob/2908db6d8556fa617298cfb713355edaa9e4b095/arch/x86/kernel/kexec-uki.c

It however also lacks support for the "side-car" files. One option to add them
would be to load them using subsequent calls to kexec_file_load with a special
flag maybe.

TPM measurements are also not done although they are way easier to
implement with this approach as we still have the rest of the kernel around.

However TPM measurements in this case would be implemented by the kexec loader
in the kernel not by the UKI deciding what to measure. So we would have to
have a very firm agreement on what to measure.

Going the UEFI emulator route gives the UKI format (and other (future) formats)
way more flexibility. The cost is to potentially implementing a large portion
of the UEFI spec, especially if the goal is to support future unknown formats
which IIRC was one of the reasons this approach was suggested.

Kind regards,
Jan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
