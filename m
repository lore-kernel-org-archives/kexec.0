Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED628CCF2DF
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4LazPcF/wnlQqrBB0dkwPZ2Jb2xDS0R7wte5tpEq3I=; b=IGLR9X4I8doYaqlPf9YDc1cfIB
	KyzVQ0rhQyrsEuZuKSIdUkzhuJ2AMPYseew2yhOEIrXMnqUSEk9l4rJ7l1OP1BTyRe1SquaiqJjdY
	LPH3ixKtjzHHhZGbODlpM4IW9ZLwp+/yutR8QVdSIrstuYJQ5OIEwM8kEQ8tLEay6wgXMrrEvWC51
	cjRp2j1yAA083CNBd5RRt/mOcDPGhd8N70Zh8HkSj7PGeOwX3g49PImIlMUpyPF+iRuGA+9jRnRLX
	iAouJX3AJpRWlvsm51hs5E8zdr/ASBGOLJ2Sb8i9Jn+ym5bfAA2X36ZSySmrT7fUxJAYGNHUX2idD
	9dcyVkaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhn0P-00000001qIb-2LQZ;
	Mon, 19 Jan 2026 11:01:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhn0E-00000001qHQ-2Gb0
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 11:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768820457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4LazPcF/wnlQqrBB0dkwPZ2Jb2xDS0R7wte5tpEq3I=;
	b=SilnFcaBjcxJ6fRdPy5fwiqIhltzGUQ7UvorNglqjh2JmPql6mopomsFgUTVu10SFfhJNV
	kYvtJb7+cqsmk0srirygsFc/ZAOgGM7+HyyOH9KbBBIa/2+ykfOs5jEUkDiquBNAGFJmo1
	pGrW7sm/PSD9Y+KMOW+V6Z8buXt+4fs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-IuFArPfIM7mS-0S5lmrhRA-1; Mon, 19 Jan 2026 06:00:55 -0500
X-MC-Unique: IuFArPfIM7mS-0S5lmrhRA-1
X-Mimecast-MFC-AGG-ID: IuFArPfIM7mS-0S5lmrhRA_1768820455
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f66686710fso7157502b3a.3
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 03:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820454; x=1769425254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4LazPcF/wnlQqrBB0dkwPZ2Jb2xDS0R7wte5tpEq3I=;
        b=f0JHkk+4Ayqy5yt2m+wAGhgvDVoGHIxxXJqJ6+XRggijungrL5s9p8wMgEnxYeZ0Nn
         /JVo7DY668oZytIjI0GdX1dCtyAka8nxUmbMHn9iKkkuUBelOXeTIj1H8BGfa9R3AHYK
         fhP0+Chc3RxVyhgbQRYm//JvLNCQYOWT6pNNZIGxOGyXTmGv7/bsmBEd9yrf74YGHSKS
         utFYDI8gyo5PCZNsDJ+/NynGF8dcoKFqCBZt/d1f26WlyLDfqg1ftVdCe7J8peHj/gL6
         vVzrtT4v/ghNGuWAYbtIKFd8UP9JidATqK1WGdy5H/AjcGuiQ4VNBSme1YoHqkJFfEXr
         1XKQ==
X-Gm-Message-State: AOJu0YxbBjoqDoENwBr/zzDWO6OLdqL9qaYHhiw4XCpTdSc+S3inMavF
	ksKaGSPKGMcUwUlDn1rzbloG6Q6fp1J2p5a7OtDJuZo0Vw6EV8FnC9kt9e3r5c0h2KaVS6D6lxK
	s7vd+E9eWIW43dhv8GQsEAetHpl0nBKPdL274raH3WXsXNoujDan0kJ6lwTGpBw==
X-Gm-Gg: AY/fxX6xJInudx+oCzFqnVi5DuBfZrw5HwAJ2PWKCVtk6ei7j8Twbi96vISxyk2UYcl
	t5y6XZcbBEZCLqiN4u8MsGXKPBaCELPTk4fMsobUNerq1JMtBXbCpmbSwSdS6oZ/m6mg06r2wkV
	irwhvSkW7POA2Qyc2yCR7WxoXgfa1vAc/64v8JQKmJWLDs17Dilx2E2deSHcjBHnvZX1i7Z2gBQ
	wcsBdMhcAB2tfVDGjpeJyoa7+GYx2Pa9cN8U0ExraAWSHTwH47/qp2Re0EX5ORL8zZZl5/AW0D8
	atD/BXqopMudtHM0sqqITpK2Q7pWj1izNtiRirhJ6wsdulzwVktjTT2I5r5707kqEgbte6h3+qW
	R
X-Received: by 2002:a05:6a00:368d:b0:81f:3b6e:21be with SMTP id d2e1a72fcca58-81f9f6850b8mr9116335b3a.11.1768820454505;
        Mon, 19 Jan 2026 03:00:54 -0800 (PST)
X-Received: by 2002:a05:6a00:368d:b0:81f:3b6e:21be with SMTP id d2e1a72fcca58-81f9f6850b8mr9116305b3a.11.1768820453951;
        Mon, 19 Jan 2026 03:00:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c03e1sm8433770b3a.22.2026.01.19.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:00:53 -0800 (PST)
Date: Mon, 19 Jan 2026 18:57:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Rob Herring <robh@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aW4Jq9on_4a5o5o7@Rk>
References: <20251226141116.1379601-1-coxu@redhat.com>
 <CAL_JsqLEsUV34tMZWSMc6w-xDV=M0JpOmS95TxrtbbBMRoD3Jw@mail.gmail.com>
 <aV49pPV3OViTDe8c@Rk>
 <20260114210859.GA3197242-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260114210859.GA3197242-robh@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u0RBrSrg-ydc_fUoE1-3FJzfJxnbRgSfA9R0WNJW7KI_1768820455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_030100_072774_D160C054 
X-CRM114-Status: GOOD (  33.78  )
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

On Wed, Jan 14, 2026 at 03:08:59PM -0600, Rob Herring wrote:
>On Wed, Jan 07, 2026 at 07:39:24PM +0800, Coiby Xu wrote:
>> On Tue, Jan 06, 2026 at 09:44:37AM -0600, Rob Herring wrote:
>> > On Fri, Dec 26, 2025 at 8:11 AM Coiby Xu <coxu@redhat.com> wrote:
>> > >
>> > > Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
>> > > LUKS-encrypted device dump target support to ARM64 by addressing two
>> > > challenges [1],
>> > >  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>> > >    machines, a system administrator may not have a chance to enter the
>> > >    password to decrypt the device in kdump initramfs after the 1st kernel
>> > >    crashes
>> > >
>> > >  - LUKS2 by default use the memory-hard Argon2 key derivation function
>> > >    which is quite memory-consuming compared to the limited memory reserved
>> > >    for kdump.
>> > >
>> > > 1st kernel will add device tree property dmcryptkeys as similar to
>> > > elfcorehdr to pass the memory address of the stored info of dm-crypt
>> > > keys to the kdump kernel.
>> >
>> > Is there not any security issue with putting the key into the DT? The
>> > DT is provided to userspace. There's provisions already to not expose
>> > "security-*" properties to userspace (see __of_add_property_sysfs).
>> > Though I think that has a hole in that the FDT is also provided as-is.
>> > However, I don't even know who or what uses these properties.
>> >
>> > Rob
>>
>> Hi Rob,
>>
>> Thanks for raising the concern! If I understand DT correctly, this
>> property is only accessible to the kexec'ed kdump kernel. A new DT is
>> allocated and set up by of_kexec_alloc_and_setup_fdt. Btw, to be
>> precise, it's putting the memory address where the key is stored but
>> not the key itself into DT. The key is stored in the memory exclusively
>> reserved for kdump. For more info on by who and how this property will
>> used, I've created a dt-schema pull request as suggested by Krzysztof,
>> https://github.com/devicetree-org/dt-schema/pull/181
>
>Okay, that's a bit less sensitive. That still could expose a memory
>address to user space which has generally been locked down in recent
>years. Though I'm not sure we'd consider addresses of blobs passed by
>kexec sensitive or secure.
>
>>
>> And yes, there is no need for even userspace of the kdump kernel to
>> access it. So this idea of "security-*" properties/__of_add_property_sysfs
>> seems desirable. Thanks for bringing it up! I'll give it a try.
>
>Since it is just the memory address, kdump just moving the key would be
>sufficient. Or the property can be removed early on. I think we do that
>with kaslr seed IIRC.

A security-* property is still exposed to user space. I think simply
removing the property is an elegant solution! It's also much simpler
than moving the key. I did a test and somehow wiping the old memory
in read_from_oldmem_iter made it fail to read the keys. So I'll apply
your suggestion of removing the property to next version. Thanks!

>
>Rob
>

-- 
Best regards,
Coiby


