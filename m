Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD9EED616
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PHUjdmBLOBswrnrEmxF6G5jA5QQNvFrwBVger9SQ9/M=; b=40fmpOkjfTAUrd
	fx/cgBNZuVzl8WElwFbq6yd455A69Ay2Db6DyIs7x0k7SBtWiFKJOkl9OLeJTKChl3Eid2XrNFy9Z
	g6SqRyUWDEEw/UGvBDb+3dXrjfmoGVqwRzw7YDA4JFz1DXpi9lTDZeQfgu/W9104uwLHPeuSKAl48
	is9nILBxAfIDdF+7LNhzKsNdzEmsXJw91SO2S3HfyM3f8ThVWAlcs85sk+Y3ltlD2wh+sV4dT3Xwd
	SPR1GI1IZjpoh8AzGX6QlyU2pZdTJLPiXgX3BRPROcZqrVUDeibEZh+cRl3rz3JTnwDEtMm0Qqdj9
	jdwbkaQTL73qlWfHOuwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solg8-0000000DXtI-0usE;
	Thu, 12 Sep 2024 15:24:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soldK-0000000DXQh-0L9m
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 15:21:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0C49A5C5BA2
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 15:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF4C4CED4
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726154481;
	bh=XoAQWmOKdAGe2LxePsrGsTfGlOK7zWHOGSNbSW1eKAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cHeya6fyc9mDA/zK8tWB4I7TqCeuvaakTqvC0BUJWcpvjYtuoY2IWJN4nwEZMUODy
	 JhsFID7YfQGVI3DjJsGbdQuvL++Vf8Ib7WcRg813GEkBtK/96uMy0vrhTB2j5WRnLV
	 DX93NgecbkgF35dg3frS5bg4gFpbgTOIC9evLLLv17wX9oGnpsRYAgzTwEHpClZlZq
	 if+8w7F6qweuHpX6lPFbVeGmv9uDzvVsxTfcDeU0aTIXrh+ToI6H1NmLOgmJhjP3gi
	 RX4yIJJ5KBbDsHJ3+xPqd7eJIie0h2jfU4XGch/Py3EWuLBlxDiczvZnZDFRvszDSC
	 K7EtGpjj8AA1w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365cf5de24so1401333e87.1
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 08:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe4G6fa7B3vy4FB/J0ssnVenP5A+APJ2Kc9IeSyhmo/rvjnTnKf1VxN0//hMDvcN/wJ1OSXQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyu4C2XSc9cEn9v/W5Io04ksoxTMWDhhKiX8t+EAfkuF5+hLGad
	hmEqF5Cjd6OCKPYFgbGeWWveIhP0nWR85SXEeKuRrAIjRu9ECbMki75r9yK3pvQ1W4BUh7JMUCO
	FYmvP+XTiWC9VenKkMbiAq0xtmvE=
X-Google-Smtp-Source: AGHT+IHgOs3mfCFDWSz8kmWB+CF7guYg1lA3puiGFoO0qOIGPDEteJfcHHhRjaQATWNg9FoAOzw2KhmhqqNzjmioQ3k=
X-Received: by 2002:a05:6512:3b0e:b0:536:5551:79ec with SMTP id
 2adb3069b0e04-53678faa022mr2183618e87.4.1726154479251; Thu, 12 Sep 2024
 08:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <20240912-sapphire-koala-of-focus-918cff@leitao>
In-Reply-To: <20240912-sapphire-koala-of-focus-918cff@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 17:21:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Message-ID: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_082122_227954_F7569829 
X-CRM114-Status: GOOD (  35.23  )
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

On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
>
> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
> > On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > > I don't see how this could be an EFI bug, given that it does not deal
> > > > with E820 tables at all.
> > >
> > > I want to back up a little bit and make sure I am following the
> > > discussion.
> > >
> > > From what I understand from previous discussion, we have an EFI bug as
> > > the root cause of this issue.
> > >
> > > This happens because the EFI does NOT mark the EFI TPM event log memory
> > > region as reserved (EFI_RESERVED_TYPE).
> >
> > Why do you think EFI should use EFI_RESERVED_TYPE in this case?
> >
> > The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
> > used for anything by EFI itself. It is quite common for EFI
> > configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
> > EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
> >
> > Reserved memory is mostly for memory that even the firmware does not
> > know what it is for, i.e., particular platform specific uses.
> >
> > In general, it is up to the OS to ensure that EFI configuration tables
> > that it cares about should be reserved in the correct way.
>
> Thanks for the explanation.
>
> So, if I understand what you meant here, the TPM event log memory range
> shouldn't be listed as a memory region in EFI memory map (as passed by
> the firmware to the OS).
>
> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
>
> Am I correct with the statements above?
>

No, not entirely. But I also missed the face that this table is
actually created by the EFI stub in Linux, not the firmware. It is
*not* the same memory region that the TPM2 ACPI table describes, and
so what the various specs say about that is entirely irrelevant.

The TPM event log configuration table is created by the EFI stub,
which uses the TCG2::GetEventLog () protocol method to obtain it. This
must be done by the EFI stub because these protocols will no longer be
available once the OS boots. But the data is not used by the EFI stub,
only by the OS, which is why it is passed in memory like this.

The memory in question is allocated as EFI_LOADER_DATA, and so we are
relying on the OS to know that this memory is special, and needs to be
preserved.

I think the solution here is to use a different memory type:

--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
efi_physical_addr_t log_loca
        }

        /* Allocate space for the logs and copy them. */
-       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
                             sizeof(*log_tbl) + log_size, (void **)&log_tbl);

        if (status != EFI_SUCCESS) {

which will be treated appropriately by the existing EFI-to-E820
conversion logic.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
