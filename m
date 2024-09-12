Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F93EED613
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u0eVUJzhQHvTiR+fGTios8l1jUEk3OsLPASTTe1o2tA=; b=j0SSn+y9ck+Xf3
	w7bnazmGadnOI5nxvgxNhKLH42vQeCuMCI9tZJMp8O97/MVCfriisMB1QR9VruIJUeA9KVsQ7WyCV
	vOOIGB7NH7rDtJ/cj7qr6rJqS3WXAj88g7jlKLJKdrA4gwLyxNuE2VRBj+WRvyuJ31J7tejOmsGxZ
	l5fWtpQrY1fJPiRUk5cnPoRL4yy5syTfnIGt1wb8IConE/H2UtcMqfFMBVzdRHPliseyqln9RQpsh
	NxVVQmjl0OEfFSg/+yLE1BW3jd2x39qkzeLKy+bISHDiKhyGM/IuEIJh1D5zHfxQwTyoxdmkyzELM
	642yEpl0NKYXxn1MaVkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solg0-0000000DXp2-4457;
	Thu, 12 Sep 2024 15:24:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokSa-0000000DIoS-3inX
	for kexec@bombadil.infradead.org;
	Thu, 12 Sep 2024 14:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TP2we3VkJZPJTvbKu5nVPcolGRvApdW73wZQCDhDdNU=; b=cSUMPHT6EP9OBryQue+zXXYpHV
	//9Kf3BjAr6ActkbOASqS5LYkchd/rLxTsC4SHz05owIxhbLTGwKnFucDx8iQYewZ+6DkF0GngW29
	/EfMimowWyooQsuykB5+lku3XBwOTbM+0MmrQpaEsZl8zghZ5qxR6PC+QZLbjkrBQXF2RWyA9Gkbu
	LLmYzI8r6KjKM3rIctu6EZDE0WdOEYR+HRLjcvSx4h0ZtDK2jiDTOSFTOVPOX/hj2q3/+GraTYR4O
	IX+A8mnEFdr69qde7iy1QdtzYYDr0xKzz7JBiKkTvnATahiqvi/2+RaEQtvvOLr7x64zPMxvpLfuo
	nUWckJeQ==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sokSW-00000000UOx-2yHr
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 14:06:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F24F2A455B8
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 14:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF76C4CED2
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149964;
	bh=WoTZyIHrJjlfxGW93PZ+yOu/QfOQLw3D21hwcUP9KdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=knqMA+whITnJ+OH4n2sjAeO2q+FI48jPuDOf5+REuybUD8XzVNW3f1xQ8KvzOpQ9j
	 CWo2cD5U+1QW7gCfxga5syXpWVxvp+2eOg++Inxj93lHRaVZf95vYOh997syTNdqZI
	 rPkJZa4BgR8QjTZ/XoioRdlHYQotW4a/8oQl18zwociSmYceqVefOQgw2XidX9UOGB
	 TH4Uecwm5VWBDiCfFr4RtGHUTjuocFZtQ/+Oo4F6JdPJMfZsf8KjixDZd5jmgTj3Go
	 cLtTXB8pUk2mYB4m3q0UerAfUDx9vH9/e7xFKxW8Zz54/Z/VyY9+oiaM15N6WIsKpq
	 YV+vXeyfyvjtg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so12592631fa.2
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 07:06:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhsGbfXcmgdlpI2qnqC22/tEppDEISOpymfhBU0ReirmykF/ZlKeIlkbiaWKd8D4H1zL9qyg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1ZqEDPppVkWxwb7z5htZs+pyQpil2fkLkPHMhHix8vNsCf5Ns
	cz0+3f6lF9HUiORIuGcNfMjH+7suYyHgeXQxQY+hImMGcQDEAYgxTj0ylMxrEnNpR+lfdV9eHqO
	vVa6FUYV9tJNNB9UNNvLbyvNxPjM=
X-Google-Smtp-Source: AGHT+IFMsEZDeFz4sbFkQuhnyEESr6pin/nTPXVyorAnmtEnZ4xszs/8JjoTuGO1Mj8SPV0ZXY9LFKY9RcSzFUchjws=
X-Received: by 2002:a2e:4e02:0:b0:2f3:f111:9bc4 with SMTP id
 38308e7fff4ca-2f787f4f44bmr13758301fa.43.1726149961641; Thu, 12 Sep 2024
 07:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
In-Reply-To: <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 16:05:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
Message-ID: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_150608_986854_000003ED 
X-CRM114-Status: GOOD (  15.22  )
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

On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > Does the below help at all?
> >
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> >         }
> >
> >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -       memblock_reserve(efi.tpm_log, tbl_size);
> > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> >
> >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >                 pr_info("TPM Final Events table not present\n");
>
> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> which is e820_table_firmware.
>
> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> its end, just with e820_table_firmware instead of e820_table.
> i.e. efi_mem_reserve does:
>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>         e820__update_table(e820_table);
>
> while arch_update_firmware_area does:
>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>         e820__update_table(e820_table_firmware);
>

Shame.

Using efi_mem_reserve() is appropriate here in any case, but I guess
kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
table, and 3 (!) versions of the E820 table in the correct way
(e820_table, e820_table_kexec and e820_table_firmware)

Perhaps we can put this additional logic in x86's implementation of
efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
with configuration tables produced by the firmware that may not be
reserved correctly if kexec looks at e820_table_firmware[] only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
