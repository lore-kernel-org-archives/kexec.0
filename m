Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F7AEDE9A8
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N8V1Cr8tRcGk3bAexoR7ZOsp4HI5mJwzFghd7G0YjGA=; b=AUAApDlzie7HJT
	8DI2azoML4yTh1q8LRNg9wp4WMw/bUdhoOTkywS60U22EPbknniw0GWvVHhnoHFDag5hs3o4Gmxja
	U9t5p1//drnb/XFBPfPBH6SAac6VFAYttsDV9XS8VWiI1neyx3FzSf90zVYV3OVYwVGL9nXGhshHU
	HOhlCEegaciTx1lY3aCVaKBxsJp33MIuKlZySs2OmPtHkVQLAvO2m3KAPmghxd+vW/b8nHQJpDHo9
	5W8ooWrYFK6Qhgl271qusbcroFwsUBPy7n9Fw2M2cBRxeSWQhtsYbnsBf7RHIL6uHaJh9M+b5Vqs5
	MOQZ+VFwp0zelELmpNWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgkti-008H0H-0G;
	Thu, 14 Sep 2023 11:52:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgkte-008Gyk-1r
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 11:52:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id B6C72CE25E3;
	Thu, 14 Sep 2023 11:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94620C433C7;
	Thu, 14 Sep 2023 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694692351;
	bh=bY6gpFweje0TA1EJp0zihUndohZBvlaM4pTha0LTaaA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HEzvOyz2sdB5n75zpEBiYGCwixAXK/g6GTkdVt1HW5h1rdduTfBe1HUp3E3NRRfvu
	 /jCvLAk6vSoQoX4WKjqZC15948pOwjOnsN+LfWxeGDgeAc4y1brfY+0DznTwvxBtc9
	 On4Bbg+brNk6wsD7A1xlikvORVdB49qu2NYVpnbyg4kX9bmBQP7ZyqpiJpBr/QYTn3
	 Kw8UzLpetjgjWhmOJL+yne6upNiPNS7DDUv9R6sqQv2xT5mTU7HdadcrIYzcA6LIy7
	 nqXRk7dzZKtbQjg+PdcG8LJFRuCbvug99Y0v6jCiudlEQzr+yJKgEEo9m1C3WVsr1w
	 RqX16PtPLdVwQ==
Mime-Version: 1.0
Date: Thu, 14 Sep 2023 14:52:26 +0300
Message-Id: <CVIMAS87EVVY.27PMG6YI8CBLY@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
 <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
 <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lennart Poettering" <mzxreary@0pointer.de>, "Jan Hendrik Farr"
 <kernel@jfarr.cc>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <ZQLI92sQrnTC9Wel@gardel-login>
In-Reply-To: <ZQLI92sQrnTC9Wel@gardel-login>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_045234_784362_0DFE43D0 
X-CRM114-Status: GOOD (  18.17  )
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

On Thu Sep 14, 2023 at 11:48 AM EEST, Lennart Poettering wrote:
> On Di, 12.09.23 17:32, Jan Hendrik Farr (kernel@jfarr.cc) wrote:
>
> > >> The format itself is rather simple. It's just a PE file (as required
> > >> by the UEFI spec) that contains a small stub application in the .text,
> > >> .data, etc sections that is responsible for invoking the contained
> > >> kernel and initrd with the contained cmdline. The kernel image is
> > >> placed into a .kernel section, the initrd into a .initrd section, and
> > >> the cmdline into a .cmdline section in the PE executable.
> > >
> > > How does this interact with the existing EFI stub support in
> > > linux?
> >
> > It doesn't. During normal boot of a UKI the stub in it is used
> > (systemd-stub, see:
> > https://www.freedesktop.org/software/systemd/man/systemd-stub.html). The
> > kernel's own EFI stub will still be in the binary inside the .linux
> > section but not used.
>
> That's not true actually, if the inner kernel supports the EFI stub
> then systemd-stub actually defers to that for kernel execution. It's
> more portable that way, since the kernel then deals with the
> differences in the boot protocol on different architectures.

OK, that's nice.

> Lennart
>
> --
> Lennart Poettering, Berlin

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
