Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FCE7719A
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l28W7IOIAFJp9UnHqZfLXzZT+Zn5UtLpsfOiE7ovBeo=; b=Su3XYogK70P2xPDDuxQLJwU7iS
	XjaJ1SpyWNs8EPo3zY/kaeMAeWtY933tuUAMWsNa/2iKf93/MquSw6n1xUWN1gIgnRaGT3VjLmn2r
	fBm7QVsWbawKGbA7/3gKujqlpQ7tO9PLb8zdSkPOs/XZe+Rr/Iu1RGhKl+EQOdrtjGnV36IpFfwvv
	AKmZosgTIHPxOOORW9PuLTENXwN/gXuQR5QJRtNfTEBR718W/+Z0XnV7WMlv9P9Ps49VByNyHnIoj
	j34kVv4p8A0psKqVltrxsY/+i0aClYqPd8PB1jaHcN9CaE0q2btUGbk/BWf0ONmoj5PLwL6ccjZEW
	o3RAfk8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW56a-0000000Ds6C-2BPG;
	Fri, 10 Jan 2025 02:50:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW56W-0000000Ds5d-2dp3
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 02:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736477430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l28W7IOIAFJp9UnHqZfLXzZT+Zn5UtLpsfOiE7ovBeo=;
	b=LAgjjuwHu5lk5x3k2WRo6CjUCXZrDNGH030uSlx4saVVQuWdV2/Y7Q2oqMHE/X/sAWVpDn
	yH3gsjCWIHm5LrmvGGSbCwUxrpmXWs9efT87SugiXLxbgbSDTlfNnxEh2spjGbC2AcjD5C
	e/rA9FlMkbqULvFYN0tT6xmLD+YYfDA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-uw6UyqyrOb2BW0pdfHQx-Q-1; Thu, 09 Jan 2025 21:50:26 -0500
X-MC-Unique: uw6UyqyrOb2BW0pdfHQx-Q-1
X-Mimecast-MFC-AGG-ID: uw6UyqyrOb2BW0pdfHQx-Q
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce51b2fcc6so12371135ab.1
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 18:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736477426; x=1737082226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l28W7IOIAFJp9UnHqZfLXzZT+Zn5UtLpsfOiE7ovBeo=;
        b=baSbLHHgOfluImS2GQXSCcPb0XZJ9hmPmLRgqsC4zH9Q+09wrLPC6dgXtEFzcVSwwe
         dIRofvTCBOPW3PSUMK54SMihMuUUVsBEVAdUw2me8rM1yi1bqGZuA/vP7VC4McuhQMcF
         NmUDoKkfg3yCAwRGEjYZwfCwpkWAQCE/nHHjSiO/ef4CQSxPIhz13UJtx1TtgPZvzLXj
         l133HqEm6Fdw08ONUCCuEIjtQBu3LqhqQ1dzf1f2YmLC8Cgj47GdprI91SjdHolLfIMy
         tCbU8J/ElpKA/5BQprxpuLiJpMd1RmRNCJQSVJJ+tdkR9OcENEsxrNoJNEChKaKqB9vy
         kixw==
X-Forwarded-Encrypted: i=1; AJvYcCXr284tg5gltspGS5kQL4/s4gLxw+m+TJExpB+6LzBD0KRAUwNnZ+cmah5ivFfSeKsZROX2gA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzeCW8MigGXHjj+qFZR7h7lhbXCDUkj3uXsgeHIrQOrUzem/zor
	NCWsjQJ8gleuCF0hiBa7MakXSyaAWdl+hmNaqTNGajEnkRObAmRspVGwqdU3OjegjnD2WUnsiqZ
	Lngvsjs8KnvTsuitNOJzGpDqEImWvXMyh58LBk8rWfHEDO9TCJBM8GrCK/DhWpvNkpRWvzSw73h
	kEAC164v6oZCimrBX0DI+XDAflmNqrQDmt
X-Gm-Gg: ASbGncvqADDIgACz2Tf2TEWm77rblq/P1gnLwqG7jXfVgT6Yj7AZA2fbxjkj/H/othg
	kkD8Hw1LmoMasRqzMkaZQktYwRUrLCLWEz/GYWXc=
X-Received: by 2002:a05:6e02:1b03:b0:3a7:e539:c27b with SMTP id e9e14a558f8ab-3ce3a8bebd1mr56015665ab.17.1736477426100;
        Thu, 09 Jan 2025 18:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDGtliUz8u4ArhQvsNK3hU4dY2KdsRiD/CY4zDcby6FNqeeWso+rG5xRZbGE13XAQ77Nf1qFOrtPh284YbRLQ=
X-Received: by 2002:a05:6e02:1b03:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3ce3a8bebd1mr56015555ab.17.1736477425788; Thu, 09 Jan 2025
 18:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-3-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-3-usamaarif642@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 10:50:30 +0800
X-Gm-Features: AbW1kvYxA86BWuq5GqR14CbuyK2tb5JSgfWl1vXKLE_oVV-bgv-0DWHCSCe-nz4
Message-ID: <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PC3_0KzCo58Aan7koa_IBbHe_RkTkv5J5bzF5xP19j8_1736477426
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_185032_753845_C9519645 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Usama,

On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> When this area is not reserved, it comes up as usable in
> /sys/firmware/memmap. This means that kexec, which uses that memmap
> to find usable memory regions, can select the region where
> efi_mem_attr_table is and overwrite it and relocate_kernel.

Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
work for you?
Just refer to esrt.c.

Thanks
Dave


