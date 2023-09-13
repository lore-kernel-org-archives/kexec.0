Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609DAEDEC6B
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RRTV9VIHnkQoF1hjYjSi+HelZNVhly21OxKFtHZz1kQ=; b=D4hdi9Ee3TZQ76
	LzyA+XdmwYq2GwZbV+WU+FO0XF82uEEN+/lwTRz1/LXLisvcRPklRsJVbreg9gqp2KLBtwcYM56Mu
	zsKBiIxU1uP2HawthyR6R5/mrV56OIYPcmG9z4hI3qHVP6y2ynkjWK/46IZnxVhtBHE+sHRWcEvvW
	7tAwVu67c2PHLIq1x1ty0GTuxBY4D/JT5O/jKxG2R5dB/vtmDFIg2EJYpE5mudirNc6BdFZCV/f/t
	eMhxw2SFl6DzRO/mSaI2/2stdbuBQX4N8CJzn6IRB1W/3kOb/KIJmgSEKN26ZaqLu10jM0NY9HyTd
	hCSI5xnCMH+eJxBNe5LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgR7J-006965-2Z;
	Wed, 13 Sep 2023 14:45:21 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgR7G-00692p-05
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 14:45:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AABA3B82345;
	Wed, 13 Sep 2023 14:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECECBC433C8;
	Wed, 13 Sep 2023 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694616315;
	bh=21jb4SlwYggpUuBiHB+zXUXjDoCem9aDhvc2KROaIus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTqruD+X6hP2710U2cq7ErV4IDgLCUlUCWLvSmOE6Ep8OovA2ChYfFMIMvYwcPnO1
	 HUfBCu4SeqpY/uOUyO28R6fXHq329sPuQGg18Jmwy0kfx+gA+B+TWtKMMg2mqsO3dN
	 PSxqroGSrpXJTgLxCF3Dvc4XoRYrqps5ziIX1iSfuziF2s8gzCCAfrUeKOtJHW5GYi
	 1Knq/V8EW07fns8+rNRuyyQASjp+D1WkIGgEgJcsWXC+NJtLOsWx1X7tdQt67NE22l
	 VXV5EflSahPQ3M2RW5iIm0y8/Mmy+7T0uB7OLGJB+jJN0JfwIEPPOqcFR8W+l9HjAV
	 EdLj4cWXNY4Fw==
Mime-Version: 1.0
Date: Wed, 13 Sep 2023 17:45:10 +0300
Message-Id: <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, <lennart@poettering.net>, "Luca Boccassi"
 <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
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
In-Reply-To: <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_074518_324681_1A1D836C 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
>
> > These are sort of "tautological" arguments. There must be some
> > objective reasons why this architecture was chosen instead of
> > other (i.e. using what already pre-exists).
>
> I think I misunderstood you in my earlier reply. I do not understand
> in what way you think my arguments are tautological. Can you
> elaborate?

current Linux kernel has these features *already* in
place:

1. CONFIG_EFI_STUB
2. CONFIG_CMDLINE
3. CONFIG_INITRAMFS_SOURCE
4. Secure boot with MOK keys and .machine keyring to manage them.

Given that every single feature in IKU does exists in some form
in the Linux kernel, I think it is fair to ask why scrape away
this all existing science and reinvent the wheel?

If your reponse is "systemd", it is a tautological answerk, i.e.
same as sayig that "it is good because it is good". Not very
motivating.

BR, Jarkko




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
