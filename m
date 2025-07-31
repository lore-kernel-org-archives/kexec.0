Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328B1C87FD8
	for <kexec@archiver.kernel.org>; Thu, 31 Jul 2025 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ibTg+SRgN11l3CBDii5Rlz1jYBOrGbR0x6FnQRT7AjU=; b=vbTztcfwfa/sW6d0hT7cStuDcA
	3OUzVrvcVvJG7l1dlzPfQEQC63G1ZVjlTIFbrDKS8/d4aig1WAbCWk1IF3zV5pClmEsP8mT16b7IH
	spQitUTkkiHFuWkubsVA4gp9RjuQWBE3rXv3sZOB3uD59uM5ctWHyADau/BRpoSJT822lrTgHJWPN
	eIABwWytKnm0kxIQQolYBkbcl0anIbEqow+O2TgJeq1ovbDnw3EsnmQz2r9mxUN0AA7yrI6K9HUM2
	hbU2pHplypmtw27cFaZ5rbXe6Vskv2zZbbto4+vDjmfidUDkFESm0Pf4T3Dp6k/qhourrDZFVLbJA
	coWcuaKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhPdK-00000003HRf-1gds;
	Thu, 31 Jul 2025 09:31:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhPb3-00000003H48-0TPt
	for kexec@lists.infradead.org;
	Thu, 31 Jul 2025 09:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753954147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibTg+SRgN11l3CBDii5Rlz1jYBOrGbR0x6FnQRT7AjU=;
	b=IzRe6BVjsgxI45O6aooE9TjP9rkXtZHR9mWl7YHYmUcAwhPZH3dIu+ueRdMahiY9VEBGyq
	neku4qT2G21BcoCWy8RjlZSzZzAlTvwciva2HaUTbU430KS6cI8U1gPTJ8bQLOxkIzH2Ps
	//skuGK1jenx9IM8aN3Lya3kmOlsUno=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-dlbSNCjSNhCMqPKlNPsAYg-1; Thu, 31 Jul 2025 05:26:49 -0400
X-MC-Unique: dlbSNCjSNhCMqPKlNPsAYg-1
X-Mimecast-MFC-AGG-ID: dlbSNCjSNhCMqPKlNPsAYg_1753954008
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5551b49f3c6so434652e87.1
        for <kexec@lists.infradead.org>; Thu, 31 Jul 2025 02:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954008; x=1754558808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibTg+SRgN11l3CBDii5Rlz1jYBOrGbR0x6FnQRT7AjU=;
        b=NsBMijPEZ7zOolhRD57nWDhEmY/4QIbo9KGBCnE9z8CjRzSiZ18uZAdhcaNs0fRj8k
         DM6/iXWUlp3/eqDuRcd9o2KNaNuRy9cjr3Alf8WoyZRDKggtpWfOri2aR4vxq4GUhU6N
         OkcuoNFn2hHeSxd2bomeVLaJ78YjqTWiXk7b7CZtjFd9dzhftAJTzXgzV9Wp7m0X3bwg
         wbZrITRdami0qHiYYOxTLhQ3yqX3kEdCmNcL8PgK2PI/gWAV90FvYK4Dcfrx0tbPrQFs
         N7BtNxvPKP/bTk2+zfa5S1Qdaa/wHNhoDBxOMgdlKIk+mXbMNEDPcXHKlvxwoUjarnJf
         jgzA==
X-Forwarded-Encrypted: i=1; AJvYcCWDoQtt0+WXGPidihShouLOEFWZVBuNO4m8p87iH8fhKvhT0ud2kb4QMuyYMS69Qqe7yZ52Tw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRc2qWyTn+opo29XiKeG3fyHmsLbioM/P615MECraBbZxKvwDA
	U6WmfJBoP6lMRjEXCsr2BnWM7xM7zye4m7pK/iT89tWH1SzWNsIb3seSteWJmg35OO61T6j0BrD
	fuk0rDfQpA5eq3UUUV1JXr7U6JzhJjENRXPo3Of3xhBD2nrKdpDYmnQJjGRrCgrCIcs9VWyvXvb
	EJNMlO8Eeq0Pt+Lt0kNx43JPXIeQdYmo+l0N5Q
X-Gm-Gg: ASbGncuKB/23cZs7CUwTGLWdas8O70fWeMeJar5cXtaWQ9PzWkWnYoNAp8G+AWXVEJ8
	C3DkMCRIhRTcl+d/6YLIedXWhSECrim+il6XMuLfEUMxSwBv62Dypo9dP5NKoh/XmibRfIfxSpy
	O3upFQbRSu6wUBPjFsl814zQ==
X-Received: by 2002:a05:6512:ac6:b0:553:34b7:5731 with SMTP id 2adb3069b0e04-55b7c01c215mr2392889e87.3.1753954008193;
        Thu, 31 Jul 2025 02:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE6w2XDOCOmK9k6ZYQLq7cJeDiihFurFL/7bI1T0/78yuOQamPsKrbCnQYFIzjpGMXgWrAJFuIIpVjZd5I+aM=
X-Received: by 2002:a05:6512:ac6:b0:553:34b7:5731 with SMTP id
 2adb3069b0e04-55b7c01c215mr2392869e87.3.1753954007682; Thu, 31 Jul 2025
 02:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250729182142.4875-1-makb@juniper.net> <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
 <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
In-Reply-To: <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 31 Jul 2025 17:27:27 +0800
X-Gm-Features: Ac12FXwS3FbJHa6wq7k1KIlDvA_sJjQJcjFuKheLdux5xeNdmmqeCSyBgT_ih2o
Message-ID: <CALu+AoQzQGypYRWXLiu1zfipL+H++x2H3pnL1uZgXPCFvumDiw@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bvxaaq5lDCqZaV-quty8rKgSzhczRoOOihEPybQww-Q_1753954008
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_022909_217112_4D764131 
X-CRM114-Status: GOOD (  25.88  )
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

Hi Brian,

On Thu, 31 Jul 2025 at 01:02, Brian Mak <makb@juniper.net> wrote:
>
> On Jul 30, 2025, at 12:31 AM, Dave Young <dyoung@redhat.com> wrote
>
> >> +#ifdef CONFIG_OF_FLATTREE
> >> +     if (initial_boot_params) {
> >> +             setup_dtb(params, params_load_addr, setup_data_offset);
> >> +             setup_data_offset += sizeof(struct setup_data) +
> >> +                                  fdt_totalsize(initial_boot_params);
> >
> > I suppose current boot dtb should be valid for the current runnning
> > kernel, if you use kexec to load another kernel the next kexec reboot
> > could fail due to unmatching dtb.
> >
> > Make this unconditionally could break the previous working kexec?
>
> Hi Dave,
>
> Thanks for taking the time to look at this change!
>
> The behavior on ARM64 for carrying over the current boot DTB is
> unconditional, which is why I've made it unconditional here as well. I'm
> open to suggestions on this though. Realistically, would there be a case
> where having no DTB wouldn't break, but carrying over the current DTB
> would?

I worry about it since dtb is for providing boot related information,
weird things could happen if the kernel versions are different.

About arm64 and powerpc I think maybe just nobody noticed this
problem.  IMO it is wrong as kexec is designed to load different
kernels not limited to current running kernels.

Otherwise the current kexec_file_load syscall only supports passing
kernel_fd, initrd_fd and cmdline,  no extra param designed for dtb,  I
don't know if there are other ways via attaching dtb to kernel or
initrd.

Probably you can try to add a new flag to the kexec_file_load syscall,
 when this flag is set 1 then use the current dtb, otherwise do
nothing.  For arm64 and power,  ideally doing the same is better,  but
I'm not sure if we should change the old behavior, maybe they can go
with  default to load the dtb, but users can choose not to do that.


Thanks
Dave


