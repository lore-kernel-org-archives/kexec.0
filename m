Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCFBE7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6K79GL0Aierbj2HhfWQCiqT/6tsQrxB/FOaaxsEgb4=; b=K26DNe2dK6tEhzZiCh6a9Ynajf
	BPul+s2ECsAE+EWnO6UpsiOXk3CBiG4czKdwgrMmpAOwLLHZedOzTGZTc85Y11ZHfZnFo3CwxmFug
	v+g5MrLAfzzZb7JtS+sPV7xpoYp3uublsuD+K+CENplvLKdHDn4IVUS6xFaP+AKZcIWyNVzjqtRSo
	KnylXKAidbmkunRFyxYjXiq9gThcjHK2mVAw1fj7EhXUts087ba5QNkFQ0bZNup9qL7rWhnSOQlcZ
	8Hgzkk//2eKKnY0Nw7SiBTAQUYkT4zDbpqzjWysokyEQdIuBW3QyM+JVVas8gVchR5JuXD7BN7jBx
	+De6jQnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD2N-0000000F5Cb-1ZnN;
	Fri, 10 Jan 2025 11:18:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD1m-0000000F56x-4AIk
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 11:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736507889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6K79GL0Aierbj2HhfWQCiqT/6tsQrxB/FOaaxsEgb4=;
	b=RrQXpBQZar5C9y18/B1yKHqsRa79aRkM+VNFsQxF/O58RYXEUA5lUMrtQZmBqmpwouAx9q
	Pc19UcDr3iKLgRErWaroF2k1aXfjcNaqsZY7W9btJPE5d73Xzt1SBvPax5BcQCElrz6hyc
	4FN19u3Kc54AnYuADzlXlrw4lrnj+dg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-k4ZcfJH2Plq40F6kcvbieQ-1; Fri, 10 Jan 2025 06:18:08 -0500
X-MC-Unique: k4ZcfJH2Plq40F6kcvbieQ-1
X-Mimecast-MFC-AGG-ID: k4ZcfJH2Plq40F6kcvbieQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so17629135ab.1
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 03:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507888; x=1737112688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6K79GL0Aierbj2HhfWQCiqT/6tsQrxB/FOaaxsEgb4=;
        b=UTGyfYRemWkqFxtsbd0rLUUZ8zuVs1T6+C3hZ3HQMZ7S7MdS72SQUsViO0/S6m+GqN
         zw81R2cQFbvNrcBGZQGt09z4ahcX5/iJUPJpzQvBzr0+OPBwvSUSpeKyWbeYQt66UPgl
         gwqX1OmOngJsU3fnhmmU1gaF+xUqniwMz0YOGgn8chJqUmTrOU3yr6IeJjilfhmwHxJ3
         pEyBGvBO/8nzerNWAz/b5jFN0+CPBMIZPkcnq2rvA6W4Tf4p1UjQDJN8suPCwCThpPoV
         B4m4W5MMnGpzYx/ZjhSplv8l9UrUMF2/ksBNgevaKclJe3UOn/AZS6HnOiN17yX8gT7z
         kBMA==
X-Forwarded-Encrypted: i=1; AJvYcCUWCWFheIOyRVQbUViPlZ+nrNdMSWyVAK83jP3uuhbyfdihaeJd2siCEsh8o6kKhThOIaY5XQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzRvUuz15e8SJgiIXfxKapk2DbXr5oQQharl1nxMJs1moSXs+LI
	8bBCI2zZMy66QZYchmcX3QxW+e00ksq0uOBe38NfKWL8XqZfk2DM9sSdaYs9nNwQ+2mhtbldfD5
	eaHgkspxEJB30zJzZRExT6BNV3/1ZeDRYgS3FQihK7ca0bsHWDcFhBta9GS3wHDbzZp3rzfMC0u
	8oBb3TwPozIEIQIntS9p0aheKEXru94SIp
X-Gm-Gg: ASbGncsWOKdKOZMbQitwoRK3Kkv701bmIJA/l4uzDLyMu4YCHZnLO+9YQGZuDhjIgv6
	3RARWV8n8P9bW00KhyJaQjvOezZx/TnOLNgsNrjU=
X-Received: by 2002:a05:6e02:3dc2:b0:3a7:8208:b847 with SMTP id e9e14a558f8ab-3ce3aa74516mr73500255ab.22.1736507887822;
        Fri, 10 Jan 2025 03:18:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA7dAfrgLzkJ12E7/vbM/rmrd89W2Jgnoku0ZUGP83tR/OARctRAqpmJ70EkI7oznqyYN3kZfUJQheZWG8tPY=
X-Received: by 2002:a05:6e02:3dc2:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3ce3aa74516mr73500125ab.22.1736507887562; Fri, 10 Jan 2025
 03:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
In-Reply-To: <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 19:18:12 +0800
X-Gm-Features: AbW1kvY3NgOP3VeQdRDz6rjTWoDkxnlxQ8g34ZJbAqB_EjoQkm5bJ2aQPEFf6e8
Message-ID: <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nWUOHhUJtQ6vLOB07ZOAzxV4Mjiz4iDUzwat2dy9XQY_1736507888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_031811_105025_ED4098BA 
X-CRM114-Status: GOOD (  17.83  )
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

On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 10/01/2025 02:50, Dave Young wrote:
> > Hi Usama,
> >
> > On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >
> > Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> > work for you?
> > Just refer to esrt.c.
> >
>
> Hi Dave,
>
> Its a bit difficult to reproduce the problem and therefore test the fix, but
> we are seeing it a lot in production. Ard proposed the same thing in
> https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
> but as I mentioned there, I dont think that efi_mem_reserve would help,
> as efi_mem_reserve changes e820_table, while kexec looks at
> /sys/firmware/memmap which uses e820_table_firmware.

I sent a question to pm people, if the sysfs memmap comes from
e820_table then it will be fine. Let's see:
https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/

>
> Thanks,
> Usama
>
> > Thanks
> > Dave
> >
>


