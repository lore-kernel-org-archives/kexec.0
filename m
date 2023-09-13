Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1EEEDEC7E
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7pRHRjZWnvM98a2pbL7nBcKqEDcURUoL/8RK1OMiMXg=; b=PqkDjDGpeGAqrs
	me0J6h2MqfkzMgBQ4ys1uK6l/aiGNlUiBFjHKu3Ne9juQHSNp0Dj1pvGTZi+zGZl752EJyatEHxg0
	RdcpFOaySaLMDCnlWedo86jXLfO9dxgNL47VBHJwlIVcDD2lOfpkhmGoKDzkCDpy+IYrTz8R2y35U
	k4blgOz/ITU5M0iZEkGPV2QYnnrc6v6Dv06ORU57gvIH3GfN/uZc5eZ12pF0mJbQwC8Fxf1HNV+49
	A3Jo3QXXHAg0acwp3JMh6xXowEG3La/xC4Sh4rzXqB9TwDkfTc1Qu3yP+hNre1d0Mgr2w/zsHtal5
	zvi/K01FFG+rlFUgo9tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgSGe-006Huo-0F;
	Wed, 13 Sep 2023 15:59:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgSGa-006Htw-2Y
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 15:59:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AE93F61A15;
	Wed, 13 Sep 2023 15:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FEC433C7;
	Wed, 13 Sep 2023 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694620737;
	bh=OBuLdZYhtqW9duG/3BeKvKGUdSBgTL3slH5X/g4fjwM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=de/SmuILmLafq3M8LKRDYntRlxwPHNKSXo+jO55fT6mw8uw5BTyXqbTAgjUi8o5Az
	 4ExInWUCL4lhprhQzeavrkB6rPA+2mG4UzEV2bl/acI0+a33wAZuQGLB3Gr0tMSSw6
	 r5lmn0Bmaqox2w5o7QloLJvWe6O8AtPzsGoWJcTEcEw0BgenttpEfmQl6DFfw9P6Ac
	 d513s+LnFCXHg68lMueV851UhOI23qKeRhsUd/jVI+HtHYi85unKMcb4ek2y9xc/+U
	 hicROU0KvR9BsjjvxqXXgxTRU/CfR4LBMB/D5BnaKeeyxHxb5/E5osSmes/s2EMdaL
	 WhnUZ3MsteOOQ==
Mime-Version: 1.0
Date: Wed, 13 Sep 2023 18:58:53 +0300
Message-Id: <CVHWWXJJLNO5.25DGTKFOPD35Y@suppilovahvero>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, <lennart@poettering.net>, "Luca Boccassi"
 <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
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
 <11e0aff9-0388-4a6c-8986-301d4edc482d@app.fastmail.com>
In-Reply-To: <11e0aff9-0388-4a6c-8986-301d4edc482d@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_085900_915966_E82FA1B3 
X-CRM114-Status: GOOD (  27.05  )
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

On Wed Sep 13, 2023 at 6:07 PM EEST, Jan Hendrik Farr wrote:
> On Wed, Sep 13, 2023, at 4:45 PM, Jarkko Sakkinen wrote:
> > On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
> >>
> >> > These are sort of "tautological" arguments. There must be some
> >> > objective reasons why this architecture was chosen instead of other
> >> > (i.e. using what already pre-exists).
> >>
> >> I think I misunderstood you in my earlier reply. I do not understand
> >> in what way you think my arguments are tautological. Can you
> >> elaborate?
> >
> > current Linux kernel has these features *already* in place:
> >
> > 1. CONFIG_EFI_STUB
> > 2. CONFIG_CMDLINE
> > 3. CONFIG_INITRAMFS_SOURCE
> > 4. Secure boot with MOK keys and .machine keyring to manage them.
>
> Well, you also have to add
> 5. CONFIG_CMDLINE_OVERRIDE
> 6. CONFIG_INITRAMFS_FORCE
>
> Otherwise the bootloader can supply an unsinged initramfs/cmdline and
> the kernel will use them.
>
> And then you do not get all the features. One of your earlier responses
> asks how a user might change the cmdline with UKIs. With UKIs all they
> have to do is create a small addon file and sign that (with their MOK if
> they are using a generic distro with shim, instead of using their own
> secure boot keys). With the bzImage alternative they would have to
> recompile the kernel. This was reason #1.
>
> Also what about #3? How would you pass PCR signatures using the normal
> EFI stub / bzImage?

I did not notice anything in the description about PCRs but this
counter-question does really enlighten what I've been trying to say. You
should take time to explain where's the gain, and why it makes sense for
the users.

It does not really make sense for me to "defend" anything if I'm against
something that I don't understand what it is and is capable of and such
and so forth. I don't really care if e.g. systemd is using it, if it
does not make me understand the topic better. It is then just argument
by authority, which not a real argument in the first place.

Linking URL to the specification is good enough for *details* but it
does not save you from trouble of painting the picture what we are
looking at.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
