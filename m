Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDA8E7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x1TCeMy2kehH/G5/Ac6gcakvpunAPT8hClM5DzIPErQ=; b=0ckZP5n9N0jkoWuSb2CSf/i/jB
	rxxjuuMcIeAD+HqB9qZlIGwp3+QVBhnqIFuOQSPKOMYdryrgbcyT181DMk7ALk5nX1gRzFFeUYGCV
	+idtLnb5lKih4wkBV98UhTcJ2wWWIxhRF2IhrHovJtWc+6SSd/iel3S/5+g8o54AwRMbEgM0AEVKT
	Fuk6ccmGS1Ak44LALYFi3atJOeN6gVFOeZ4CKQX7XIeFT47kk/43K20AejnPc6ht7zA5p0Y2sslVO
	/a5exBeqjDWkkN1jQYoj1qpC7SCtMsNMQM9TgLAM3Q/kjUf8i8jo+tB+bz7CLz/FDiBWvodVSAJEa
	6SZCjKYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD51-0000000F65l-1jeE;
	Fri, 10 Jan 2025 11:21:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD4D-0000000F5wQ-0gy1
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 11:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736508040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1TCeMy2kehH/G5/Ac6gcakvpunAPT8hClM5DzIPErQ=;
	b=TUyOMJyedpseFcgKbPLKy4zQx/MKptiY6V6VDHT9wWtT/TpWOtUkwQg1xJ85j5+ynUvrXf
	B4hsRSh4CpzZN6Rq4K/o9PzbEExXhINjgOt9/XBSyzpURqJt07l2igTIiY1XX0X1KeTz0P
	LgvSIbgcetEOTfXt8cDbzlVaREj64vs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-JOHQOjsJPQy3cvcLU89l3g-1; Fri, 10 Jan 2025 06:20:37 -0500
X-MC-Unique: JOHQOjsJPQy3cvcLU89l3g-1
X-Mimecast-MFC-AGG-ID: JOHQOjsJPQy3cvcLU89l3g
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a814406be9so31439125ab.1
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 03:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508036; x=1737112836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1TCeMy2kehH/G5/Ac6gcakvpunAPT8hClM5DzIPErQ=;
        b=Dj3VRNGA5idwH5o6/qOQznnXuxVNwfH1aoUTnG4XuhhO+q+MIfwMEnn2+mk8imMy+b
         BWoVGVMQG3my1tqMwKeNFCYo33sThBorUpryLYTqygOr2okGXertJn7mRQ50lFY/jpI6
         vbFYfyh5Tw7OeXm0RtMN8s707LpHUzPsut3m7lJxq/bxaiaFl9frhyH1G0th1MZsTQ9j
         PAUIHiuvO3O3rIFIQQ2L7ZvhclWDDaoQGtfy4rVp0NubANK2vccymLoFPZ0Tt9fVPOox
         uIZCgmGv6fFcwtPyuMmr5us12+ISVoKYSgWdusm9RhVsahhCy7WuecnsbHClHvoBqbv8
         GZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuzhtMyEKPH5KI8yBuumXFNOMDT5AqkncAmXIvS7EWHJEYWX2WDbthDjd4M4n1gZwzMIVv/w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3FSeVU7Pfcvs6IVMSn1tAI3Jz7KopE2AMQobl3jEs1QoPZlnm
	j9NR30sBRmC1pPYwtSNaeR9sDvvJ1h8WxkoD9b5TYpqs66iG2W/mlFKcsB0hErly/acv7jk7N3a
	Q8uQIs7q4dUjGBrl0aFqv3J5H9OstScTr+5FK4KbA5WBXExK1FPkUPiEmYi7EB8fBC7u3Cjf9Jc
	tJdnMm8IHmN/yJuC5YTV+rlvRiHiNAUxeW
X-Gm-Gg: ASbGncv12G0eng6Ql6/rnUoVczJeqXbR0pZi//0BHg56P+qQkYCE4xyuFx2xsP0URpO
	FWu5Q2QXKLOAEgdZP0d3P7876do2+WaIQkYhMHNc=
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id e9e14a558f8ab-3ce3aa7c305mr88727765ab.20.1736508036302;
        Fri, 10 Jan 2025 03:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/ZGZxn93BTZUgwgl5385CpZFhIe8wtltjq3xgYCHF4KnVPQrulNtY+5TAzkMXX76hdNVwHy/TuoHO3lYD9qo=
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3ce3aa7c305mr88727725ab.20.1736508036092; Fri, 10 Jan 2025
 03:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com> <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
In-Reply-To: <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 19:20:41 +0800
X-Gm-Features: AbW1kvbbbsAFGnLq07CQCS7hEathkhH1cwo6Bz0H1Eer0IQxRMwEsY9rVx_lHSM
Message-ID: <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jx5H583gHnXQMT_y79w-5gklHz2PZnTeHQM9l9OHpjY_1736508036
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_032041_393569_76176093 
X-CRM114-Status: GOOD (  20.59  )
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

On Fri, 10 Jan 2025 at 19:18, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 10/01/2025 02:50, Dave Young wrote:
> > > Hi Usama,
> > >
> > > On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
> > >>
> > >> When this area is not reserved, it comes up as usable in
> > >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> > >> to find usable memory regions, can select the region where
> > >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> > >
> > > Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> > > work for you?
> > > Just refer to esrt.c.
> > >
> >
> > Hi Dave,
> >
> > Its a bit difficult to reproduce the problem and therefore test the fix, but
> > we are seeing it a lot in production. Ard proposed the same thing in
> > https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
> > but as I mentioned there, I dont think that efi_mem_reserve would help,
> > as efi_mem_reserve changes e820_table, while kexec looks at
> > /sys/firmware/memmap which uses e820_table_firmware.
>
> I sent a question to pm people, if the sysfs memmap comes from
> e820_table then it will be fine. Let's see:
s/e820_table/e820_table_kexec

> https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/
>
> >
> > Thanks,
> > Usama
> >
> > > Thanks
> > > Dave
> > >
> >


