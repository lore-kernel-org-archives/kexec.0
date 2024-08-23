Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAC3C52D7C
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+g/3aonnJNsWgzp2hnFC/jL2yDmkw2360dTOBXPaKsk=; b=GyTBySb0SR/H5C
	II+9zC3JGRCBNfEbJxqIn+7bwlTTp21F2KuulNpHV2Ls2rt4kwdubLLgxECQJrXl/xN+CHOLYiK39
	tmJIdMHT6EwE5nMkUJKeemiwxDJWN3Mgskng2SIw3KJtrUMfcWEIMfhIHo9R+g6o6jkgDCyj4ItmH
	l44Gfn8qWAIbF1nFvunu40jqWt7/9W8WB0+g5ISyzRfXUR/jtQWaVwqXBkyEsiStlnRsDsj66slvv
	7LKLT5kT3oTQUVyQMIfNcOU49029KOYu0O0DlFNF0c6Tw626502SQUG7mwREo6WTENw4n/tHh59Ih
	pbL1xFjDPDLI5T8t6DHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shT3H-0000000Gdeb-1xNK;
	Fri, 23 Aug 2024 12:05:59 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shT3F-0000000Gdde-1pbX;
	Fri, 23 Aug 2024 12:05:58 +0000
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe58fcf29so10521111cf.2;
        Fri, 23 Aug 2024 05:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414756; x=1725019556;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGZF0AvlZej7rqgff9jJof3mfOBatM8jwICNkXKrrqk=;
        b=dH+LvYiTcvkIt9LTJv7lYo8OB/pWQeFMCFSn1bXu80D2K07qeGU2pKG8vjq2AOf+SJ
         g/RMtHfNOuXcfR8V2gwK0kPeltkm64sINnCN2bp6IxqaMpAJfwTtDO8oJ00QTc/e3+kE
         yqSHLg5LYpOuFsdfUPMwDkqXrIeoeM1f8A8f1QjCfjoAjq1fGJbpErh9yFXv38/1CEHq
         45ccQEoLroBmQyFBKzQR8rN7sN/fqnpV+Vs/+iPLhBCtulzqkz6eJm+Qybm9z2Qj/Y+P
         cQi0cBOFtINvnWnoWKUwB0wY8wdZRYVvIIV1muKGverRJxOAk1qnspwCdWO3W+ry5NTt
         YJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEGN3eY25OmKdIAG+MVqyJkUnOkJ7RhkPDl0mn5QgD/f1O4JlFDrKCsstcPXXe04X7/HqIrzoU7S1WxwAWhCQGeg==@lists.infradead.org, AJvYcCXArkvx7hci9NzE2BuuQobr4uu6STK51um+/k2cxZl8SA0WMdfBM7gwBL3Rv2J8vDgLK5GwXKa5kp6djYI=@lists.infradead.org, AJvYcCXLR493CYdW2srptgJlpUYJGIXnYjKcMYdHRSqldf4hP/o+uEQw80Vu39tHDHb8bNFs+u2AxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcZyixdxSrBba6h5pWWFMvjCGOzAZngxfkO4uxw/toZ9KSBhw0
	zPGDEbuVsJsq2K55I+VTxO9xK7jQpbRdjv5FPJKMj+9+9bf+1fCP
X-Google-Smtp-Source: AGHT+IHUiEQ2UHjFnBpHefvI6CBVfER5s973r4J8f4wJcBtlNN4Eyl+cyb4eanEq6/83M/3CpkPpMA==
X-Received: by 2002:a05:622a:1f06:b0:447:f41a:aac5 with SMTP id d75a77b69052e-4550964738amr23293121cf.25.1724414756229;
        Fri, 23 Aug 2024 05:05:56 -0700 (PDT)
Received: from [192.168.2.219] ([65.93.184.127])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196d10sm16584871cf.71.2024.08.23.05.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 05:05:54 -0700 (PDT)
Message-ID: <e7629e1e-ab41-4400-85c4-e3b39cf5be2f@vasilevsky.ca>
Date: Fri, 23 Aug 2024 08:05:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related config
 items
From: Dave Vasilevsky <dave@vasilevsky.ca>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 kexec@lists.infradead.org, debian-powerpc@lists.debian.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com,
 hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk,
 Sam James <sam@gentoo.org>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-6-bhe@redhat.com>
 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
 <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
 <ZsfR9rdMt8yn1+Bz@MiWiFi-R3L-srv>
 <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
 <c74e24213fd98b252a2a1ff02a107005e50f4f7b.camel@physik.fu-berlin.de>
 <dc4a1941-6671-4e89-90c2-3a1c19fd3e1c@vasilevsky.ca>
Content-Language: en-US
In-Reply-To: <dc4a1941-6671-4e89-90c2-3a1c19fd3e1c@vasilevsky.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_050557_511339_9C4E858D 
X-CRM114-Status: UNSURE (   6.25  )
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

On 2024-08-23 07:58, Dave Vasilevsky wrote:
> On 2024-08-23 03:16, John Paul Adrian Glaubitz wrote:
>> It should be disabled on m68k and sh by default as well.
> 
> Sure, I can change that. What's the reasoning, so I can explain in my commit message?

Oh I don't think m68k even has ARCH_SUPPORTS_CRASH_DUMP, so it will always be off. My question still stands for sh though.

-Dave 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
