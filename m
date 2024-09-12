Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774A7EEB59F
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sff784+OJ5FELxSKn4sFEUwBjorOnnqtGhnYQ+CRU6k=; b=E47Qi3uo4w4St8
	IoIp2sw/WEq6VlqhE5bnqk3X7QCjI5SiinD+TS9f12c7uEazsEOHGmJCGi+HpHh4Kgb+BWhxrhSNg
	lEfncs4atSaFgCh9Dkxu+mM//3Q3OQMibmmk3UvjKeYOxjLslwgaAClb2fgDdd9u/ZfU7d9TZvu2f
	UnHiQF6gxolfIwcu6WUXBI2PnmWJavMdeymJO1AAHPzLR1DilE2buMDEic7rjRSgmS3joMQ9YbnTz
	U5jIyIs/Ta+MfN0iuyUTTaq16II+q4PjrVy442oEXl9rR6t5wowEfKOA5bFKTMkK+gH8xx4RDRx7z
	9QmargaOblNGrHF13Pgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojUJ-0000000D8QI-3rnE;
	Thu, 12 Sep 2024 13:03:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojU4-0000000D8JZ-2V42
	for kexec@bombadil.infradead.org;
	Thu, 12 Sep 2024 13:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/wD1KPTzQDpIQtFX4qhbxAiy+8aMq7IxhqW8VdszRzc=; b=HL33viBAbsr1qHY3FM9ZrD63LI
	6wstJfznBYuFP9nyx/FtYfwLALBKvjJx2710gAG1mgEipDkJYOg3FtaT6O0aoUoU+dwZ4SzDOiQ2j
	aOlAqu7nqR3QikOTEqeCRxlQDngoYwL4blrfBlkFrNi0oCyn8gBcuZYo+KneaxtT7+Uaw7mkSrqBa
	XchbO+7Y3G86414hsUyHBsAnAuwoSsBVHoJx/UCUf7tcZOETmxbDfWitTjNVNSp+B3nRxe3kUeSdI
	kcyK3+oiI7/2rM3fyzN2IGU+VRK1HF653dkSb0NLzZCYYZPkmx/a3yye4ozXhBKpT8q1jgGhXZZvQ
	7LZBnqag==;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sojTz-00000000TiW-3zqN
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 13:03:39 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so1067877a12.1
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 06:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146213; x=1726751013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wD1KPTzQDpIQtFX4qhbxAiy+8aMq7IxhqW8VdszRzc=;
        b=wmOxeVPjHt+v/YQrz3g3lwuIasUmpEjIA7p8dHraQuq5EnNqF7EVWojK3ZWk+yMKJN
         7ty3U6vdzLiCNiCsXA0TLGxIHRAwztWfrYIwPK1O643daEAxYyC9p7divOdcu2meEdf5
         jIXUTrxalOAKmTNOo/BTVgue2xmz8xMYKgDc8gPuyUEPBatr6C83QtOvvRXKJPxInwvI
         PjAsDVrzfY+C6ABym48LcVj7H3itWpErFEvRCTojVN9N28IfFfGLFOs6F4tnblQjw7kv
         2h+OdKbrDW6xhv476xs45tIW3wiXLyQ/mnUODdrkgDQwAupChA8JkuexgwJIaCVJeXRI
         RELA==
X-Forwarded-Encrypted: i=1; AJvYcCVQgSXvTme2tl4MlQgvcknFEXC8ydZ9wTNTzFaZ9hNU9eJFNMlE/65raHp1EwkhDOWsi93zjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJ/ut8VAJwUmHmQVeV/DZsaynCaWPSSpzTzWM+8FjD75+0/YB2
	B5VXhXWtAsqzcfA2mAv/xZsu0h/qROfxYNP95TPQpvv5gzc54pSH
X-Google-Smtp-Source: AGHT+IEAJDQ4WL7SOl5bsfConzrkXcuMXNQUB3PfItXJ+RTcTlmgoNbZImDHp5Lnh51sPpOpj21bcQ==
X-Received: by 2002:a17:907:7ea1:b0:a86:ae95:eba3 with SMTP id a640c23a62f3a-a9029690d69mr238676866b.62.1726146212358;
        Thu, 12 Sep 2024 06:03:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm746424466b.39.2024.09.12.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:03:31 -0700 (PDT)
Date: Thu, 12 Sep 2024 06:03:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
	gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_140336_119848_7D4A91EC 
X-CRM114-Status: GOOD (  14.07  )
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

Hello Ard,

On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> I don't see how this could be an EFI bug, given that it does not deal
> with E820 tables at all.

I want to back up a little bit and make sure I am following the
discussion.

From what I understand from previous discussion, we have an EFI bug as
the root cause of this issue.

This happens because the EFI does NOT mark the EFI TPM event log memory
region as reserved (EFI_RESERVED_TYPE). Not having an entry for the
event table memory in EFI memory mapped, then libstub will ignore it
completely (the TPM event log memory range) and not populate e820 table
with it.

Once the e820 table does not have the memory range for TPM event log,
then the kernel is free to overwrite that memory region, causing
corruptions all across the board.

From what I understand from the thread discussion, there are three ways
to "solve" it:

1) Fix the EFI to pass the TPM event log memory as reserved.

2) Workaround it in libstub, and considering the TPM event log memory
range when populating the e820 table. (As proposed in
https://lore.kernel.org/all/2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com/)

3) Workaround in later in the kernel, as proposed in
https://lore.kernel.org/all/20240911104109.1831501-1-usamaarif642@gmail.com/

Please let me know if my understanding is flawed here.

Thank you!
--breno

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
