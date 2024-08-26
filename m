Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17968C5321D
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGL/naElV0MF9yeZ0MxsRh/ivmE3ILmfeheqk/EwfyQ=; b=FNBaZezEAkoJrR
	Wa/6qGAoVCNQ4kyRZb5rcGQSPIJG0V4W4tLeQlxM/9q/CicLfctknW0Q/EM9L+RzoC2F1dELsrbhs
	yxhU8DjwZsBqxbJ+9fVgrbUbNBE5LlvBlzar5Y6fZLrICdoIidWBtmAH8hZ+O6RK8A+iDJhSjM44o
	SIPb9onvertRvOOjTorhXlHYkNcvdbU8AoPaitmA5rKzJIX+mHMNLaXj2ivDWN8ZVxhSrPhPVQnEW
	c5K341L60F/aw0MRuyZb8ZyKmUjTr06rCjkmDlU1OihaDyy5XjRawXRLSo3hhTLcL6T6K0wADSu6J
	5glVGd7ssYoDi/G4c5rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siZx4-00000007XJ7-2njy;
	Mon, 26 Aug 2024 13:40:10 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siZx0-00000007XHt-1P6H
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 13:40:08 +0000
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id B36E5E80262;
	Mon, 26 Aug 2024 15:39:59 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 3829116008B; Mon, 26 Aug 2024 15:39:59 +0200 (CEST)
Date: Mon, 26 Aug 2024 15:39:59 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <ZsyFr8V6yizMiBTw@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_064006_541754_8B6290FC 
X-CRM114-Status: GOOD (  13.88  )
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

On Do, 22.08.24 22:29, Pingfan Liu (piliu@redhat.com) wrote:

> > Hmm, I'd really think about this with some priority. The measurement
> > stuff should not be an afterthought, it typically has major
> > implications on how you design your transitions, because measurements
> > of some component always need to happen *before* you pass control to
> > it, otherwise they are pointless.
> >
>
> At present, my emulator returns false to is_efi_secure_boot(), so
> systemd-stub does not care about the measurement, and moves on.
>
> Could you enlighten me about how systemd utilizes the measurement? I
> grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
> extend PCR. But where is the value checked? I guess the systemd will
> hang if the check fails.

systemd's "systemd-pcrlock" tool will look for measurements like that
and generate disk encryption TPM policies from that.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
