Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C6CA0ED4
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 03:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2gpU92QclCgCC2PdhBvq4f7n7AQv8akMownVrcuy7wM=; b=46i6aPONunkPCV
	41PJyb9UlQIMOnKWr5OBc6eU9/sbeEfVfTkiV2svKGDCq4s/KSgO6slZKKPknrlCkcKT4CAMAPHWX
	dTDnpKkQc4A/NWlKmUfTmejnkTYCDha9orxD9sX4RYG9m4+1moLqh25K9vjFNVYFESmv7KdGKa8Ok
	EqNXqZ7MLxvMDHQPFvaWNrEdD6k9l4MXZjt4zp3G811AKFQ0fRnezTlxf/ptB9r85m/GNNGdKUOIn
	BhllN3GcNkAXR9e3X2HhnLMVClhvijDgklxaVzRhPiPx++67qR2sMysD7p3NKMyo0VqYyhIIsVpSe
	Q+piPyhVYZl1qkmnRYuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjsSH-00000004X6L-3TVz;
	Fri, 30 Aug 2024 03:37:45 +0000
Received: from mail-qv1-f53.google.com ([209.85.219.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjsSF-00000004X5m-1h4e
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 03:37:44 +0000
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf6606363fso7666146d6.3
        for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 20:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989062; x=1725593862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo9L05Z0QSBRe+YpGa+Uw+0Mfbc5M8wNwQrY2Gw1TrU=;
        b=NigWUY8O+hH2/HphgQGcag83MTteFr0ty1Og8SNevhjHP6LGp+nfNLZvoLE6vKyDvT
         8LCHLPfKSC/Dq43157mleMJMDYcgFddDpLTJGFGvPrZec/4LA6Zq+u2VMTy9Pso+I2si
         Fa62hwAPXK61WpSbb770TIrpbk0fN6O4RYqHsK7jH9YH/ozCTLLwqm6snD5qAeZrUoKt
         /l+i85OhALDkFXTtD4Owvz3GssSlvFjszi898lH5NMhPp+3EPFVreCXkf0J0aLtwa1Ru
         OFUn/iGamIkJZ9/1oTwOpF5dO5WWtNKsRGefBIOt8klLqM/x2VBh0PLEOEhXIDskx75K
         Qbgw==
X-Forwarded-Encrypted: i=1; AJvYcCVVsx6xyFpAHYCdoebbZAN6Yv9jpXb439rG1L5Noq063c9QmRul/eLJlkc9ekycWpd0vppbsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxscOp3urmdY2xJXxJt+L7sR4D42iSc3F8b6s6IoXQwlEbddDY0
	F9GYG/CSFe0P9ZuQxU7w9XVC7nUjbcGQ5i9bhGHVTKMWDRAyixcn
X-Google-Smtp-Source: AGHT+IF5lvFeC41ykAP/5lmiaGuGSVJ62dpKhpYmw92FoqNUdVPe/V37Z2IbmmFTugcCgHwIe+E9QA==
X-Received: by 2002:a05:6214:3d9b:b0:6b5:d73d:918f with SMTP id 6a1803df08f44-6c33e4f053cmr61325206d6.0.1724989061710;
        Thu, 29 Aug 2024 20:37:41 -0700 (PDT)
Received: from [192.168.2.204] ([65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfafaesm11005716d6.22.2024.08.29.20.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 20:37:40 -0700 (PDT)
Message-ID: <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
Date: Thu, 29 Aug 2024 23:37:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: Baoquan He <bhe@redhat.com>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Reimar_D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_203743_478343_7BE613DA 
X-CRM114-Status: UNSURE (   9.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2024-08-29 23:15, Baoquan He wrote:
>> +config ARCH_DEFAULT_CRASH_DUMP
>> +	def_bool n
> 
> If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
> CRASH_DUMP will be off by default according to the below new definition
> of CRASH_DUMP?

Yes, that's true. But if we don't add it at all in sh arch, it looks confusing
in the search feature of menuconfig:

> Symbol: ARCH_DEFAULT_CRASH_DUMP [=ARCH_DEFAULT_CRASH_DUMP]
> Type  : unknown

So I thought it was better to explicitly set it to 'n'. What do you think?

-Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
