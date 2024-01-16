Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE85DC4706C
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MIlKSLLUdZppahVlZzQwgR2fXq1Acnrw9559OrCO+aI=; b=Ijn+zLrHiOq/sX
	HLMrl4+/Bg3Xt/j/XUIreJr0x26aCT0x4GBDXeO+DmAJtQKF6LIdahaB+ADIAnuL11l9UImEijhHj
	i/2oatKhNHX3qWS1PluVhn5WD5XXbL6xcKJEYKIWgBYS5tdfhKo0MjxiNjvEYjcQLlRjYkCFZZ9Jq
	uQ97dlitVqO6sdoRKcD22OdP7YXzsl285m0tNVs88k2DzheFU2lvspcALDMG1bDhlf+vNMwQ3sRv7
	trvDLwO+vUzWvgUrXEMMqefWSiE318h8lpklej6UKX5HtElq4URmkjaZhzxcXdlPT+SAGrJwwjnWI
	/1ycC8avwvTat2NBvFzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgqc-00BgtU-1I;
	Tue, 16 Jan 2024 10:39:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgqY-00Bgrf-0p
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 10:39:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705401541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8Ce2hXgqBBuget7dshE6ixcdocflUQ2pKys9ztMfJ8g=;
	b=fzWcoyiAO4CI/ScHPJXXbwQJO0Hsa6I/fkmW3SthhEY2ry3G9GwdV7CQ8eh5Ubo7NL64i0
	ikNlD40h++thFW9acX87uPhersyX3wpEPRb9Xb6uqOQR4VIoGcr+5BIVWAe173QQnpGltc
	txjwTlBJ8Gw8ByN5QxzlJmmkA6NdhNU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-x3cx8ioKPSS6UmvaBoLdYg-1; Tue, 16 Jan 2024 05:37:15 -0500
X-MC-Unique: x3cx8ioKPSS6UmvaBoLdYg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2e66e65f6aso26806966b.2
        for <kexec@lists.infradead.org>; Tue, 16 Jan 2024 02:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401432; x=1706006232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ce2hXgqBBuget7dshE6ixcdocflUQ2pKys9ztMfJ8g=;
        b=gfW5XDHO2G03aAm2I2ElN+YDvWTnhyDEYKuDTk0WjCM+Crr+BlsTxC/0c9Ly7zJN5D
         P2wi/NFeJn/5FvjqeckR5EM6Cp81TkbYs23qcjA3c/abvpSx2ZaXWzqB81Un6FHQMYNa
         LtUxGgysXuNeHUcaKJCatjRcfrbHTY3thG9uAZ2lyegrk5qnEbe2f7p4x6Jhbpyngkqp
         fvoDwe+bY0AIvVVOIXxScCq3PB1JR91c0NKa14nwZuaFECYbf+mrJCOUKY6J5DDJJUj0
         YOofGfbA42nJCIJEYfuOWkWnckfFwrkgME5KSpCVhPNY2O8POGGBYMY2KaosPZ8HJ6kd
         oQ1Q==
X-Gm-Message-State: AOJu0YykLJpB//9rHj31yMi5l+IqU5mVyslmXclOvI9OIQlQDTDyCWVR
	uIvqttfvANbMB8Az+6scOv4TemfCKkFdJSIPKspV0ibD0e/6DxMrL6qKdTBu9ze7fWvwoSR+mBC
	tQCC6S116RRa1Oz+5d7ULqpFJ6EE=
X-Received: by 2002:a17:907:a643:b0:a2d:58c9:f8f4 with SMTP id vu3-20020a170907a64300b00a2d58c9f8f4mr2570276ejc.95.1705401432649;
        Tue, 16 Jan 2024 02:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh7P8NJZrq6VaklVqXkN+++OL0DafouD5yOZU0+6IIHwyycUPd02qTbxImPcCxYH5787HyqA==
X-Received: by 2002:a17:907:a643:b0:a2d:58c9:f8f4 with SMTP id vu3-20020a170907a64300b00a2d58c9f8f4mr2570259ejc.95.1705401432309;
        Tue, 16 Jan 2024 02:37:12 -0800 (PST)
Received: from [192.168.50.107] ([83.240.63.96])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b00a2689e28445sm6333594eje.106.2024.01.16.02.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:37:11 -0800 (PST)
Message-ID: <1edc32f2-858b-4afa-a883-2632be6d909e@redhat.com>
Date: Tue, 16 Jan 2024 11:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
From: Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_023906_384298_3E5E0D5E 
X-CRM114-Status: GOOD (  30.82  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Coiby,

I've started working on a patchset for systemd utility. I have one 
question/suggestion:

On 10/01/2024 08:15, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption. Many users choose LUKS
> and in some use cases like Confidential VM it's mandated. With kdump
> enabled, when the 1st kernel crashes, the system could boot into the
> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
> specified target. Currently, when dumping vmcore to a LUKS
> encrypted device, there are two problems,
> 
>   - Kdump kernel may not be able to decrypt the LUKS partition. For some
>     machines, a system administrator may not have a chance to enter the
>     password to decrypt the device in kdump initramfs after the 1st kernel
>     crashes; For cloud confidential VMs, depending on the policy the
>     kdump kernel may not be able to unseal the key with TPM and the
>     console virtual keyboard is untrusted
> 
>   - LUKS2 by default use the memory-hard Argon2 key derivation function
>     which is quite memory-consuming compared to the limited memory reserved
>     for kdump. Take Fedora example, by default, only 256M is reserved for
>     systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>     to be reserved for kdump. Note if the memory reserved for kdump can't
>     be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>     1st kernel.
>   
> Besides users (at least for Fedora) usually expect kdump to work out of
> the box i.e. no manual password input is needed. And it doesn't make
> sense to derivate the key again in kdump kernel which seems to be
> redundant work.
> 
> This patch set addresses the above issues by reusing the LUKS volume key
> in kdump kernel with the help of cryptsetup's new APIs
> (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
> this kdump copy of LUKS volume key,
> 
>   1. After the 1st kernel loads the initramfs during boot, systemd
>      use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>      volume key and then save the volume key to specified keyring
>      (using the --link-vk-to-keyring API) and the key will expire within
>      specified time.
> 
>   2.  A user space tool (kdump initramfs builder) writes the key description to
>      /sys/kernel/crash_dm_crypt_key to inform the 1st kernel to save a
>      temporary copy of the volume key while building the kdump initramfs

So this volume key copy cached by systemd utility in 1st kernel does not 
have to be readable from userspace.

> 
>   3. The kexec_file_load syscall saves the temporary copy of the volume
>      key to kdump reserved memory and wipe the copy.
> 
>   4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>      initramfs asks the kdump kernel to create a user key using the
>      key stored in kdump reserved memory by writing the key
>      description to /sys/kernel/crash_dm_crypt_key. Then the LUKS
>      encrypted devide is unlocked with libcryptsetup's
>      --volume-key-keyring API.

Unlike here where it has to readable from uspace so that libcryptsetup 
can verify the volume key.

Is it correct?
O.

> 
>   5. The system gets rebooted to the 1st kernel after dumping vmcore to
>      the LUKS encrypted device is finished
> 
> After libcryptsetup saving the LUKS volume key to specified keyring,
> whoever takes this should be responsible for the safety of this copy
> of key. This key will be saved in the memory area exclusively reserved
> for kdump where even the 1st kernel has no direct access. And further
> more, two additional protections are added,
>   - save the copy randomly in kdump reserved memory as suggested by Jan
>   - clear the _PAGE_PRESENT flag of the page that stores the copy as
>     suggested by Pingfan
> 
> This patch set only supports x86. There will be patches to support other
> architectures once this patch set gets merged.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
