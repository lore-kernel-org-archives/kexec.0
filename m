Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5600EED601
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aeAzka0lf8l4hPosmZQbVP0X9STPoSrDQPgQVMgVgo4=; b=Y/J/tBN3xJQYeN
	k6mhVOfhHpBcZGGkmGFvFsj6Lu1mAXIWNZO1padVhThF+CTnwgCNaJbrsm8Ez/YazWLIEXxv35PKJ
	b+n2q5h1lut95t2Kqcj3+0pCYXr6TrxxHnTSaHyF+U8oXFMAtWnLsahxCrIp5ieJ0rpoQGCi5xpvI
	vq700pUFGb9GZlHxtcs270YIKOlSp7eBTAmtk9cmEVNBtih5qkjLeDsLbfcqzke+Rq7Zw2UinFMRo
	FfTAtPBRuzoy2+9s88AcHspBj9lC4zFv46qybo5eYfgiBcU+dj1inO/FRIKttl5tQGe9/OOiC54ei
	HqmXnsP4J5qZvDwoJUOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojbD-0000000D9Yf-1Gl9;
	Thu, 12 Sep 2024 13:11:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojb8-0000000D9X1-2iZ5
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 13:11:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4C2A95C5AF7
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 13:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B48BC4AF0B
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146656;
	bh=pVjkE8pzjkEOi/MpgQecc17AU7Z6dbtmsPZ9CjjhpkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1wmVC6jMy5HidYKYX6gkDHOqJ04g/LVF2H3SLEIhiACcIpUo02s8Stx5av0ebRH4
	 P4pQagK4Wgu0ayR5fZVPd++gajPVzEJGk3B0ATpPmcFqbtQgnQX/XAu3F3qngJFxXI
	 fY0bxlmW5M3oClhrQ+3Z1r24YK6gbifjo34TvnzA48MeEQguQFbQwYXmzsOGbVnEtJ
	 ZjkIVO2vILSt/C6yndXP47Zy22Cj3z1ZaOw+IutJf7mkydD8VEz3LEWoRLCgOSNWfy
	 waCP9EjTTltyLSIF9clSJKt9BvvWKuS6vqHbNyV/O1YfyS98ls+vAVtu0z1yPgILfD
	 TS17Px8oFJ4IA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so12042751fa.3
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 06:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvY3Zp0sRiCLqIdd6oGiWqTbmsnqqyFCL1k3yDaE1isqHbqjo/RWmOM1rtDrybQEf/RJQrog==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxh/dVNaM7Z4U7AyEBUWEVYXJ8fPC8V2KTZk96tgQo1HND0XPtv
	CexWXRhL1XYBAbAxSbP1X+zNLF5C15rybuztdiKlGq6kTxO7m25UCUZAsZovxMtVjc4U4XwIM6E
	LmycQmMmhIbS4M8Dm2L2sxK/3waU=
X-Google-Smtp-Source: AGHT+IGjrOuPsLEXIxWof6GVdoN8GI0LIbmwDbSCBJpeeh/ccOJ3roKoI1IcDk5B73JTTHAPFOWlD8x3NCpNNbmbuWw=
X-Received: by 2002:a2e:bc1d:0:b0:2f7:708f:d1c3 with SMTP id
 38308e7fff4ca-2f787ddf3b1mr17068111fa.21.1726146654494; Thu, 12 Sep 2024
 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
In-Reply-To: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 15:10:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Message-ID: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_061058_866884_627431BF 
X-CRM114-Status: GOOD (  26.75  )
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

On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > I don't see how this could be an EFI bug, given that it does not deal
> > with E820 tables at all.
>
> I want to back up a little bit and make sure I am following the
> discussion.
>
> From what I understand from previous discussion, we have an EFI bug as
> the root cause of this issue.
>
> This happens because the EFI does NOT mark the EFI TPM event log memory
> region as reserved (EFI_RESERVED_TYPE).

Why do you think EFI should use EFI_RESERVED_TYPE in this case?

The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
used for anything by EFI itself. It is quite common for EFI
configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).

Reserved memory is mostly for memory that even the firmware does not
know what it is for, i.e., particular platform specific uses.

In general, it is up to the OS to ensure that EFI configuration tables
that it cares about should be reserved in the correct way.

> Not having an entry for the
> event table memory in EFI memory mapped, then libstub will ignore it
> completely (the TPM event log memory range) and not populate e820 table
> with it.
>
> Once the e820 table does not have the memory range for TPM event log,
> then the kernel is free to overwrite that memory region, causing
> corruptions all across the board.
>

We shouldn't be relying on the E820 table for this.

> From what I understand from the thread discussion, there are three ways
> to "solve" it:
>
> 1) Fix the EFI to pass the TPM event log memory as reserved.
>
> 2) Workaround it in libstub, and considering the TPM event log memory
> range when populating the e820 table. (As proposed in
> https://lore.kernel.org/all/2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com/)
>
> 3) Workaround in later in the kernel, as proposed in
> https://lore.kernel.org/all/20240911104109.1831501-1-usamaarif642@gmail.com/
>

Does the below help at all?

--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
        }

        tbl_size = sizeof(*log_tbl) + log_tbl->size;
-       memblock_reserve(efi.tpm_log, tbl_size);
+       efi_mem_reserve(efi.tpm_log, tbl_size);

        if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
                pr_info("TPM Final Events table not present\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
