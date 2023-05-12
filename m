Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C382FC7EE2A
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2vMta/mioR68YKxtylnH0r+h95bsBhb+x+cYHabXcmM=; b=0XfCj1Qu1siptw
	NrS+4UaO62vLDGuVzEa00H18IhDV3CwTx0SDAYi9CC70tYjMn6hbt1+yFMNKS7VXtqCefEhfDsWkh
	DHAhehK0fH8i7T/mrfwcVgo2R6/FXQCDhnHhusE7PQ/90ZZrHPC2r24l6w/RRKb22ZR1wh/DPm34P
	q45ZuwlnVuuAvTUc44n/KmmXtAzlu4N0gs4Tp4f4DqUUOqEOWTvwdTG17ruY56HHYSk/xihEhzjal
	rp9a292eGUcCKlJr6V4WhoVgH9tkp49pak6VgBsi6C3tb/1fKQ3Y4Rb8MY7aMC1ahyiwNALgf6qV+
	p8uBTix4b7BKyyN6CTfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQnf-00BnMr-2n;
	Fri, 12 May 2023 11:19:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQnc-00BnM3-2f
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:19:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAD2654E5
	for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4668FC433A8
	for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683890339;
	bh=wrH/Idv9KsCcTtB6AEiMG8KI/BJCz1nJH6Vnh8hMzRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V6trYjUgtstm5dpjpCYea1rOSnD3aeOkI2RIw1qK6pV/lewPI0AnCrW06WfEqtYZc
	 9LAet3VMOMlI1GUsKtOBxhIQuyEbhuuYQWK/W6xIty4E//fwvjkAYImTcfzv1MnIGu
	 OuVZRxah59hU0gqRMOO92eykexszq5MWG/sc4pHOKaAYEuGcsZrvIodbVRFYbOmNYf
	 qQ4Qd8vUIhS4EBbe5XZ4t5sYL3WaJfjtlIhO8NDqkl+VzT6jUEZJPJGSGhER/SVICI
	 JNeyMKkgT6TSfJZ3jPMK456k7HYTPNQ9ToeeqTWRe11aYNXPjJLGaBL3mBjcj2RpCs
	 Ekx6B8fn/ovLA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so11051438e87.1
        for <kexec@lists.infradead.org>; Fri, 12 May 2023 04:18:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDznub08VMGWsNsIr1Hh5cPMcJaotd7peeMXvtgQebJ9YvSPDWNo
	7Ltxlj1/NAx8C5ONFpdJ259UNTxqghFSwanGBA8=
X-Google-Smtp-Source: ACHHUZ6DcMj03Yf/WFptKjdSvGMbYyaFXfuBq2GVQwGFgSoSXnv8faAMu33gdmWGPUcUBML9YF2JhMMaXS1ogxTh7As=
X-Received: by 2002:ac2:5de4:0:b0:4db:1bab:98a4 with SMTP id
 z4-20020ac25de4000000b004db1bab98a4mr3828248lfq.32.1683890337217; Fri, 12 May
 2023 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com> <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
In-Reply-To: <20230512110455.GD14461@srcf.ucam.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 May 2023 13:18:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
Message-ID: <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	iommu@lists.linux-foundation.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	James.Bottomley@hansenpartnership.com, luto@amacapital.net, 
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_041900_925682_9D0F1595 
X-CRM114-Status: GOOD (  15.52  )
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

On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
>
> > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> > now?
>
> TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> at the whim of the firmware in terms of whether the SHA-2 banks are
> enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> extending the SHA-1 banks, a malicious actor can later turn up and
> extend whatever they want into them and present a SHA-1-only
> attestation. Ideally whatever is handling that attestation should know
> whether or not to expect an attestation with SHA-2, but the easiest way
> to maintain security is to always extend all banks.
>

Wouldn't it make more sense to measure some terminating event into the
SHA-1 banks instead?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
