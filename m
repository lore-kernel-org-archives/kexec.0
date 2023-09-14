Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A33EDE998
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P8gV/b5e8uZXj4IguWNKg2ISrqJFpP47zGCOZSJFU7k=; b=WPcmKxnM3p5px6
	psNO9oowmA7nrElOB2AbQYBH72nmgVO4iTF9lWd2zQXs6Q/vS9xr0dsLKFT1bUynwpsfx7TU0FJ15
	tEqjTUce1/dIqkkHlclA0yeZO+tgSSBTPfPoVOx4V3IYpkt+1RTgtGdYMSwVPNK88JL7XAFr8fXlq
	imfZhsbCjlT9fs/suMSn+gAXa2lKiv7Ss0dOnccSPc4LCuP+t0Ti/+WPhv9fmdE6sT4j1yKvJ5LOB
	sbLmuH7SX6hvqx+QDSW8jqd9UwqnQTv8ohXUy0mHnSMco6CEOETbCuET0ro1GtiyWt7lzOTaGBlG5
	7A55aEkiBl0tYPvYCzNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi9j-007lty-15;
	Thu, 14 Sep 2023 08:56:59 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi9g-007lsE-0Z
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 08:56:57 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 5DD2AE801F5;
	Thu, 14 Sep 2023 10:48:56 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 0FC7C160258; Thu, 14 Sep 2023 10:48:55 +0200 (CEST)
Date: Thu, 14 Sep 2023 10:48:55 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
	bhelgaas@google.com, Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Message-ID: <ZQLI92sQrnTC9Wel@gardel-login>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_015656_375128_B45F1BD3 
X-CRM114-Status: GOOD (  15.62  )
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

On Di, 12.09.23 17:32, Jan Hendrik Farr (kernel@jfarr.cc) wrote:

> >> The format itself is rather simple. It's just a PE file (as required
> >> by the UEFI spec) that contains a small stub application in the .text,
> >> .data, etc sections that is responsible for invoking the contained
> >> kernel and initrd with the contained cmdline. The kernel image is
> >> placed into a .kernel section, the initrd into a .initrd section, and
> >> the cmdline into a .cmdline section in the PE executable.
> >
> > How does this interact with the existing EFI stub support in
> > linux?
>
> It doesn't. During normal boot of a UKI the stub in it is used
> (systemd-stub, see:
> https://www.freedesktop.org/software/systemd/man/systemd-stub.html). The
> kernel's own EFI stub will still be in the binary inside the .linux
> section but not used.

That's not true actually, if the inner kernel supports the EFI stub
then systemd-stub actually defers to that for kernel execution. It's
more portable that way, since the kernel then deals with the
differences in the boot protocol on different architectures.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
