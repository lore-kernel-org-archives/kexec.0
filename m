Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C8CE9A03B
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=; b=bqRX3bHzFNLUSzLNm5BLdBg9af
	mnFvNUFnOOtecSkYEJdpVlqSocbZnqas+PGiHCpRkQctQqSOGukWDnb8RBugsKhlnrjYFSwOUBVpG
	L9lmfij1kxxQxWDgEIfyDfa4g8LJU9PK0mnUu5irz2sYw56g1AUDPCqvj+doAEW0dKDzEREpNmt42
	Wio3Ivy5g02o3M+eAGKD3vspHzFn0+oWs9jskFdhXbGs5ilWCRr6wmCH0IpMRREVB9Bh3HdqmFADh
	3gHXTLEC+V5+0cLyO1vbSElkUrRuvdGgLV5aojz8G+Rtoc5AIuyS5o/ZrzIZaK0UbXmZ8OMSqQM/6
	CFl8/DEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsy3d-0000000B0A7-0guQ;
	Thu, 19 Feb 2026 07:02:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsy3b-0000000B09f-07Px
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 07:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771484557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
	b=M1lL603R3nZeB/0QK2W37T7+VnysVFRlN48fHG+oqJXoW+1SQkvca4W10QCq3QFoxRLfsG
	6Je1MpmJdkAK+y7nZCIHmwmJlL5bD9JMbYzRioIHhxQ478rPPRU2BJC9Sa+7zEDmJop4bx
	o6wcBZTUQBiZGe+uJz+73oLjhHOISf8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-IolZ0zlQOC-E9F-YZJLpeQ-1; Thu, 19 Feb 2026 02:02:35 -0500
X-MC-Unique: IolZ0zlQOC-E9F-YZJLpeQ-1
X-Mimecast-MFC-AGG-ID: IolZ0zlQOC-E9F-YZJLpeQ_1771484554
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-385bd85a0f4so4219361fa.3
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 23:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771484553; x=1772089353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
        b=HKi4SkSLn3zM05c7pjSu3QXJd63bwcunRDhA6P3Wrp7GgYBkSq/gNNUTN8pDnnEfLb
         in8LY3Sgd7F+8+sczRN1sEccXOmUBF5Nly/XT1A1P7RfO1AsrpcRlvWdL1bT7PJtJzI3
         Y3x/jO+9wG4hY7VaCI7Qngx4CoxcatfiyGkBt/8mjc9xedeeJzm7vrwi4WrNTZCvWdUj
         WPCM1q12H3hRHKy92hju0mz/ScePwiJHxvNM6KTtPdnOS9yfmJKathUuWxfP5Lwpvl2h
         WV1qtSUT5EvrH9dn+xG8JaWAIx6+6k93y+vCEVoz0aQMKH8XcczORe3VcsWYDesJqeHI
         DR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/l8L6OQzDH6XRNpI6O+623d2j4EE4IB/KVEzPZADWBD/DisWf2+KJW4jDIHUy4Rt5l5BhPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZrd36KjK7naKY0Qr3/dwbX9jJ7m7sykM7oFD4pZTKMT/usqL0
	Pt4Rc5xX3Fy0OYZ8jBqwpGMfTDdF5hcFKkxAud+ualeLKObiull9WTZ4Y7E9DfB1MYyV+cEfCqi
	mM7S4Ajm8jUww93Ow/sipEBLvZq+07eZiJz/9ncIhFjnqGoIVhMqp/YwQ9x09lqglgC/FEMnOOy
	dtMVzmV7d5dhCM22BYCi5ygRFMB3FjCdFLPS1y
X-Gm-Gg: AZuq6aKCZzVSBzsjgJsVntebR3ERDIYw6k1FCRKZqyRWpke0dPlcjUbn25YiNoz9jCm
	VdKwPSqx91Tcee+8cvN9Tw0HS9mcXEHgX+yUXyxF250H7A0o0TERMKoA/bBrH75Phnv1MZVNfnd
	YKzxmV0p7Y3y+gcE4+tja+gY7c89KjhWFj7kjUf1WjE60BhVcFM1O3wCEFaJVwUuFGu3OUpJ2RA
	rj4xgjkWPOUy8paofLajcvafg94uuWrhkXAAvpFP9+BjK3vxOKr2HQ3BTsWipgKHdDV
X-Received: by 2002:a2e:a58b:0:b0:37b:b849:31c3 with SMTP id 38308e7fff4ca-38846e6e936mr13767581fa.44.1771484553386;
        Wed, 18 Feb 2026 23:02:33 -0800 (PST)
X-Received: by 2002:a2e:a58b:0:b0:37b:b849:31c3 with SMTP id
 38308e7fff4ca-38846e6e936mr13767481fa.44.1771484552924; Wed, 18 Feb 2026
 23:02:32 -0800 (PST)
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com> <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
In-Reply-To: <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 19 Feb 2026 15:03:05 +0800
X-Gm-Features: AaiRm52CO28LXPWE60CaPB6MX5LkIrQ6MX8PJpryZg4FynCBCqSHZH7nUJrQslg
Message-ID: <CALu+AoRK8OXYb17=0WKkJfS=Q_9ssuwj+Ub+ZFRuS9_kdzo=Eg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mpkVTo1jrlKzcfbZQMzKktpNyz9OV45A2e3unMXaeX0_1771484554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_230239_159847_DF4EF649 
X-CRM114-Status: GOOD (  13.27  )
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

> > > The kexec use case is it depends on the pre-kexec kernel saving it
> > > during boot for noefi case.  I do not have a better idea to do it in
> > > kexec code for the time being.
> >
> > How about something like this?
>
> Thanks!  It works for me, however the legacy kexec_load syscall still
> failed with a panic I did not dig into the root cause yet, I supposed
> it will find the rsdp from /sys/firmware/efi/systab file, maybe some
> userspace code bug.

FYI, the changes work with the latest upstream kexec-tools,
In case someone is curious, it fixed the wrong "%lux" with ""0x%" PRIx64"

Thanks
Dave


