Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77893EED61E
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D2OwCsVdoUIo3vR+wdoSkl6AyvuyiklQ0ns6rufSaBA=; b=3ArAGtzgLDcfRh
	pQUnxCYPJ0JsKqSW76GjGRF9KdLCgk4jBkuYzNMdNU7xeaM9Qf0Wv3G50pwP+VC2e0QAnnLltVfba
	QaF7+H5LtQnSEV5kjA7T/xl3gY+WydEnu/jX8nJywVa4yrOxP9S9mBTj2SQK8hZc3wfPzMyjGfovb
	CKJ5DFoz+AqXT4fbffYNvSDjqt60le34UJEM/YQwIq/Y7Kwf9vwPRaGzf8Jq/r3ux1+yHfbSGRX/J
	+UyhO+ehzzJa4s/Oq9ujvmHBbTvLHK3bTQCv/Wk3pWee5rBfUAc9MH3sklUHlue5O6x6VzTo1t1Af
	2G5Lt67JHSW34Iwj8Mfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somh9-0000000Dhd5-14FA;
	Thu, 12 Sep 2024 16:29:23 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somgW-0000000DhQG-0Leh
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 16:28:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726158124;
	bh=1RRoQ/B4c+/9l2rOSmetknZ/zgMtHUG3tKaFxUMUnaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JtpFVzTIHu3vcsWd8FnI4U69MrrUlIzg5yn0PYJIfCV2mTy/nJC87hx4HiuS43Acy
	 DmTv7hmcKZpVcjWZUUx9oD5gZbLVAcRLUX+dLpiEUqThuhVl3TNJYDxzzrzmlCJgAZ
	 6/JNrn5qT7MuDwJCK/KZkKCZeNzteWZszWuC4gks=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6ADBF1287751;
	Thu, 12 Sep 2024 12:22:04 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gI1Frh6cg5OL; Thu, 12 Sep 2024 12:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726158124;
	bh=1RRoQ/B4c+/9l2rOSmetknZ/zgMtHUG3tKaFxUMUnaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JtpFVzTIHu3vcsWd8FnI4U69MrrUlIzg5yn0PYJIfCV2mTy/nJC87hx4HiuS43Acy
	 DmTv7hmcKZpVcjWZUUx9oD5gZbLVAcRLUX+dLpiEUqThuhVl3TNJYDxzzrzmlCJgAZ
	 6/JNrn5qT7MuDwJCK/KZkKCZeNzteWZszWuC4gks=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1084A128765B;
	Thu, 12 Sep 2024 12:22:02 -0400 (EDT)
Message-ID: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org,  linux-kernel@vger.kernel.org, rmikey@meta.com,
 gourry@gourry.net
Date: Thu, 12 Sep 2024 12:22:01 -0400
In-Reply-To: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_092844_138571_75B15C4E 
X-CRM114-Status: GOOD (  19.39  )
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

On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> Hello Ard,
> 
> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > I don't see how this could be an EFI bug, given that it does not
> > deal with E820 tables at all.
> 
> I want to back up a little bit and make sure I am following the
> discussion.
> 
> From what I understand from previous discussion, we have an EFI bug
> as the root cause of this issue.
> 
> This happens because the EFI does NOT mark the EFI TPM event log
> memory region as reserved (EFI_RESERVED_TYPE). Not having an entry
> for the event table memory in EFI memory mapped, then libstub will
> ignore it completely (the TPM event log memory range) and not
> populate e820 table with it.

Wait, that's not correct.  The TPM log is in memory that doesn't
survive ExitBootServices (by design in case the OS doesn't care about
it).  So the EFI stub actually copies it over to a new configuration
table that is in reserved memory before it calls ExitBootServices. 
This new copy should be in kernel reserved memory regardless of its
e820 map status.

Regards,

James


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
