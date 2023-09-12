Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF517EE3F06
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NlRdCpOKXU6AMwucjMW96t34vvc1kJrga2IyEi83uMo=; b=rvCq+z+1ACjLjx
	ztQLDnsRAP4S2i5b/i0JQdhAqlWmGW9YgS3K31uPe7BK6T+H8ssZhSKZoyf9dy/fStG7lzFa4ysKg
	YjBYag5SnwKAUwUjxjJHyzpnXfGZmLcNtpjUgnwEiUhWN0tKV+n9VYrwf3kV3GUtWpCQ6xizZasvO
	3cZ9IcqX4jl+iEmFWnfUd3XwzyjhNa0IE/yr7QhbO8A5+Q3a+Tp3maEP8CLusWcVUinjlnfCEiJHy
	jmaq2T5IwtWX6tjstz8uJ5CXXPI3K1tiUQYJhNep0kHydPgP9Z8tBGpm/hDM46n/pYlZLeNRbkBfJ
	sBvQ4Fa8/08W1mvljhGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg7OT-003vCl-0E;
	Tue, 12 Sep 2023 17:41:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg7OQ-003vBq-05
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 17:41:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id ADF0CCE09ED;
	Tue, 12 Sep 2023 17:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81422C433C7;
	Tue, 12 Sep 2023 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694540498;
	bh=XN9VLs/RWqIKbir9oOJKNB68E42vRN6udYWXC6xNx3g=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=AUAeaB7Xrro3wr98z/qT44pYdzgB+sn9/iogCEnYTZY26XGn2eL0GxsRDDu9sYLSf
	 1EamAyK771TErgxTI0DshiQJr56K73toeoxpktx1PMkJ0je4Qs/bRXx42voXUGVeeJ
	 Y2eAoCcyEvHDeAuRCawyKNFhzaaiXl1lMVqhm4NHLtoyuE7d+BG6XrfR02XnLEf4fy
	 GPMbgapZIeU7YRRiYAgTBLjJ2DIIbcbsuKNRTEagA1L9xYa8H58fhQSSu3u3+CRCc0
	 BSnRm5k867ea4Q3QJB38fSocyLnawl7PN6ym1u3akhHa9GtguPA7HgN/TDNvKE1p2q
	 jpzIKnMGyfD8w==
Mime-Version: 1.0
Date: Tue, 12 Sep 2023 20:41:33 +0300
Message-Id: <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, <lennart@poettering.net>, "Luca Boccassi"
 <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
In-Reply-To: <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_104142_237500_9079C0CB 
X-CRM114-Status: GOOD (  13.70  )
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

On Tue Sep 12, 2023 at 6:32 PM EEST, Jan Hendrik Farr wrote:
> >> The format itself is rather simple. It's just a PE file (as required
> >> by the UEFI spec) that contains a small stub application in the .text,
> >> .data, etc sections that is responsible for invoking the contained
> >> kernel and initrd with the contained cmdline. The kernel image is
> >> placed into a .kernel section, the initrd into a .initrd section, and
> >> the cmdline into a .cmdline section in the PE executable.
> >
> > How does this interact with the existing EFI stub support in linux?
>
> It doesn't. During normal boot of a UKI the stub in it is used
> (systemd-stub, see:
> https://www.freedesktop.org/software/systemd/man/systemd-stub.html).
> The kernel's own EFI stub will still be in the binary inside the
> .linux section but not used.

What sort of bottleneck does the EFI stub have so that we need yet
another envelope?

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
