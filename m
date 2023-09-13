Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84503EDEC71
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 15:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vSOOw2a6aSqQnRQd+tFR/b0TE8l4EQpTGhHcp9lAhq4=; b=2fX0f22JtnOHH8
	Zd6GX3mVC31w7XTaBJKlZ8F42Iw253gOs4RYRtrn6WrJyhPhI2KGjOoycfSNwjZ9dyDLnIA0V8yiK
	I1r6gZD+E6/HRhRhu1zcjX4OgBWCss7XAefyFjLi1s2LOYJS7SdO9o7S7z8de4T8M7F3ePR6VgXoj
	NxI+2TGYvl6juE5iRr9pgcZeZ9bU26g+y/Mwv7nKll/lShphuwUJZeivUjlU8r3Urb0OCUS3dKbSw
	V+O0QCCTw+9pMdqyOrg3jbPBGSda2INJalw9yuyjLwwJ6ExA3kC0Yk4l8qMpn+CYUi7L+nT4k5xzL
	UckRe8TfUg8nNTzhAmeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRTO-006BQS-0e;
	Wed, 13 Sep 2023 15:08:10 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRTK-006BPr-22
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 15:08:08 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A55FC32009BD;
	Wed, 13 Sep 2023 11:08:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 11:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1694617684; x=1694704084; bh=vj
	M/jYFR2qdUh2vuA7Pk/tqRh3E9vy5+10ysE/89vhE=; b=b2F8aD1gtCXrwZhtv5
	vkwJmMDY/m9eSkSa5n/UEZBY1Js6HmjQDwNeOp1Irpabs2QyzmqKvttg6tvOji8e
	0M4omAVdjJj4H4HjmgtbwEihUieUhgFF1mmsS5FcxlV7HwzVZ7Vgvd+3pcEbV2zf
	yXVsDfstjVdCeNHGnAwMgHOXe94yE4UFkLiIlWsnELZM55MqOGs5xAsNQWq8qbUd
	YnnefeAEcfVcJ9mt5yi8R8C3S048oiYK12R1vdh6KQ0JM79RLoSXPwCEDIjK72Ou
	HXjxhInZAqxUhFodEAO4n+DXwy/+hN7eZncxpsmv8Xw9wwS700VLMX/N0UHeLKcB
	zXJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1694617684; x=1694704084; bh=vjM/jYFR2qdUh
	2vuA7Pk/tqRh3E9vy5+10ysE/89vhE=; b=h9gS6lu305E8O+X9qLML8SHJwX+bQ
	GI8Ih6blkYGxMCgPOXYBDOlUF3epbOpOz50n1/hVwJ3ZLt7SZFCL49dfVGOaUhi7
	lzc2pBoE7k45ULIUG723A2mFHQaPQltiXd+cVqcrsjMnkF5gMIh3EiUNHwpox/3Z
	vIOyDL1+foQIgd92TJ0DHYoN85V3HoLmbYQTn2os/4kXI1K2zmwOu5RAEc0Z881i
	tB4SkmB1jVEvcPSVcud+0SPIN0fY53xMHRkgKwLFA4sZUGIl42r1oKwsYoGUY/Y4
	fYmmTdg+tXA0+GiR+lpGAyzi/8GdUth1xsYUAnWeDK377OmZC8Hj4DjJw==
X-ME-Sender: <xms:U9ABZR57fqM-ECMePEbGwjqIYB1TNtmU8Tw5IUYfjSb0BOIeePU4fQ>
    <xme:U9ABZe57FQvZlaVWE4o2JTtbtV_FwEa73gEmla97dkQtSiJtAx9DVv7NWDFjm9JEY
    BYye_TXze5hdj5jI8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepleetheegueekvdeihfffffff
    teefledtjeeileetheejudekheetvdethffgffelnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:U9ABZYfwRaAlKaM2arHGAk0mIVTl_br5eymeZ_B4xmYEGzYjxjVlDQ>
    <xmx:U9ABZaIfOCcV0P7644ryWyx6PUfSfZdqLPnk3oo2X2HsyosfAqNdHw>
    <xmx:U9ABZVLI7AA2hmzqGDki3koSt4-QvHhuaPxHEEZKFj45GBjPixYVDw>
    <xmx:VNABZSATPivrCvjn6reba6ZUjp5OQjehD4tZf4omNsl2NiLv3_VKNA>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8AA6C15A0091; Wed, 13 Sep 2023 11:08:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <11e0aff9-0388-4a6c-8986-301d4edc482d@app.fastmail.com>
In-Reply-To: <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
 <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
 <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
Date: Wed, 13 Sep 2023 17:07:31 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
 dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
 akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
 bhelgaas@google.com, lennart@poettering.net,
 "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_080806_698741_30D33A45 
X-CRM114-Status: GOOD (  21.59  )
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

On Wed, Sep 13, 2023, at 4:45 PM, Jarkko Sakkinen wrote:
> On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
>>
>> > These are sort of "tautological" arguments. There must be some
>> > objective reasons why this architecture was chosen instead of other
>> > (i.e. using what already pre-exists).
>>
>> I think I misunderstood you in my earlier reply. I do not understand
>> in what way you think my arguments are tautological. Can you
>> elaborate?
>
> current Linux kernel has these features *already* in place:
>
> 1. CONFIG_EFI_STUB
> 2. CONFIG_CMDLINE
> 3. CONFIG_INITRAMFS_SOURCE
> 4. Secure boot with MOK keys and .machine keyring to manage them.

Well, you also have to add
5. CONFIG_CMDLINE_OVERRIDE
6. CONFIG_INITRAMFS_FORCE

Otherwise the bootloader can supply an unsinged initramfs/cmdline and
the kernel will use them.

And then you do not get all the features. One of your earlier responses
asks how a user might change the cmdline with UKIs. With UKIs all they
have to do is create a small addon file and sign that (with their MOK if
they are using a generic distro with shim, instead of using their own
secure boot keys). With the bzImage alternative they would have to
recompile the kernel. This was reason #1.

Also what about #3? How would you pass PCR signatures using the normal
EFI stub / bzImage?

I can see how #4 is kinda tautological, but please don't dismiss the
other arguments without even responding.

> Given that every single feature in IKU does exists in some form in the
> Linux kernel, I think it is fair to ask why scrape away this all
> existing science and reinvent the wheel?

No, not every single feature of *UKI*s exist in the linux kernel today.

> If your reponse is "systemd", it is a tautological answerk, i.e. same
> as sayig that "it is good because it is good". Not very motivating.

Again for #4 I see the point, but what about #1 , and #3 (#2 is not that
important, tooling can be fixed)? Also, do you see how your argument is
basically: "The current way is better because it is the current way."
I'm not trying to be snarky. But I'm coming from the perspective of a
user that actually experienced a problem (not being able to kexec my
UKIs) and trying to come up with a fix. I'm not trying to push something
for the heck of it.

Also the UKI spec at this point is not ready for the kernel, so this is
not going in anyways right now. See the discussion on v2:
https://lore.kernel.org/kexec/ZP+41JvEFjsnEG19@MiWiFi-R3L-srv/T/#t

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
