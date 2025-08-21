Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC3BCA0EFC
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grUxT1GprFt3EryXoM3a2x8+gD6ansHK/9PFX4wkYnw=; b=yrUQyKYqqgKQ2+RZ6p864WkGMM
	clMUmXL3zMBk0OavCkwY2ybqAqRishbERAFBe8+X4O9QUqaayc/sNHL/gGvvB4c1JbdBfBnLiqy4h
	8trHdrhY/3e4l3oVlHK8GnWLqef5TxTJzw0j6B2wQATdAyUgwh0kn5Oy53ezUg5F3m70Q4MIUKzjp
	/TQF72894tBk89qZNQ5wNsGjUlqyEGkCLT0/62i3P1Rn58p1LU5ZA8iKfRzRQvZMSvA+nyIfoRuT6
	4zb0X689boG//EzOUk3UkBodaRDibT4qdKkyUdaSMIO+cVI6tojADXFFCwhwDGADYKcctAWzd8V3e
	vD8iDk/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7FJ-0000000HN17-2X6h;
	Thu, 21 Aug 2025 15:30:33 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up3Wx-0000000Glk2-3HBy
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 11:32:33 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3c4368ab352so467722f8f.1
        for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755775950; x=1756380750; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grUxT1GprFt3EryXoM3a2x8+gD6ansHK/9PFX4wkYnw=;
        b=KRBu9/YOSIsRx6F43LPeQ7+edKUBzaOKaGDrN/sLP/H+S4n5iOPpHsuX3SBi165Wru
         i0PeHvMqrkE7vjV14yNwkOAh1OLU4TvfBHN1He+6lBeHIE8ok5HYQBYwKBnVyprV+06z
         F8tf/v0m25FPTBFUPqn+HPrmsXH5ILAk7AbWN2aPOU+09G7qC0wiFaoiJwc10B6tbuQO
         XUzl0jCqesYsZ73qkwHon0S7b6jAc4wMd2NFBbx5Kt/PbU6PDzr+1Fy59rx2FjRwsC+l
         mziG93m4/4Y9pck+nVXAn0zvbxBy+b32EwSgRS/xGLvpIL/8zk3XubU9noD+Hb2v33kF
         tJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775950; x=1756380750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grUxT1GprFt3EryXoM3a2x8+gD6ansHK/9PFX4wkYnw=;
        b=Ftdxsc2CMNoN9ylMI+soSevNGqEoO3jqT6trfBX7o9MPyoHzSOgh6tLFtap09tGRsw
         1eXMwOvyPc6Y/rTFFVZJxXjQCDQITjIDzmU93jSLixW7YJNc/xJvYvBqoB9pnFOu/6Tg
         OKuluEOjyTc0LpRpv9wk96Q/Zcd9E9x4vG85g9SQgcW9AwpFoYCdDS9vao0Tu0cQ/e4t
         8w1slrmqq8OPDQOLgJCN88GqGOkHgEE4ylb7EiCKk/f7ldlO08kkpEDons5hP15VnBAR
         UXWA+KXTBdOqwkdhjhhevK/CoVdq5WxQyprI27SY0X9XHmApFCLjEgLObVCRNM/RwVjW
         B11w==
X-Gm-Message-State: AOJu0YySLU5CJp2lS5JNM0Fv3DVKu/FJ+oC0qUaoM8igmSpcZE0gYM89
	RBbSBI0P1LdTb+xaWhPe/Fpuwe8k1i/3jhcbzClT/hCV9vTwGOCx2ic4
X-Gm-Gg: ASbGncsXF6qJ/nkeZjZT6gzz+Bs7AEZ0i8jQ9+7vWC2VM90dIKJXlTMkvoQsoOdcbdp
	FEhuYiWoLCohNCRcSHwDKIQ7BGNmZ98RzrExXY1qc3aqr1zyzGx8YoDYMAbOZNA/3u6nrQbae8F
	FtMNt3W2hMZoPn8oS/baMYEnmZf/D02Wncx8AvJkpkaKbFAnGWeKAYqqQbQY9d1ZdLJcQ4gne8w
	E8fBmg4yxsN7HPJBY+/vCEP2BkPAGrY7aeNS8M3RZFcW8Iy17SjrzVBvkzKBAqPg+UqQRODr6b2
	s7KoTFxMiRZKgZl/rKYB6zb/xLNmrTIKBDo4vRB+sM9nrK3GqmRGBrXIhZH+X9kch8zDhbZg/GH
	yn5gmhJ8TLZ9Zh1xCGrCufz3R1mltGKo3nH6A/vNz2WB3fDsn7sHXdOVwa+CeaZAvhRNYTHZla1
	axhhtMNf5nGlZ6JaY0NDCWR9Y=
X-Google-Smtp-Source: AGHT+IG31km4egDBIbCZPj3uFPYlxDAPBf7hOXDxcQhEbdReldcE0MHDXAHFaSvpiMv/6w6IG7kv+w==
X-Received: by 2002:a5d:5f4b:0:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3c494fc6fcemr1823209f8f.2.1755775949704;
        Thu, 21 Aug 2025 04:32:29 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43ba5sm11417290f8f.22.2025.08.21.04.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:32:28 -0700 (PDT)
Message-ID: <f24af1e6-509a-4a36-8b7d-0188b3a2e9e2@gmail.com>
Date: Thu, 21 Aug 2025 12:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kexec: Add bootconfig support to get_command_line
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, paulmck@kernel.org,
 leitao@debian.org, kernel-team@meta.com
References: <20250811153736.3865487-1-usamaarif642@gmail.com>
 <aKaSRJ9HGNR07Svl@MiWiFi-R3L-srv>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aKaSRJ9HGNR07Svl@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_043231_844464_B9ED3A7F 
X-CRM114-Status: GOOD (  23.40  )
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



On 21/08/2025 04:28, Baoquan He wrote:
> Hi,
> 
> On 08/11/25 at 04:37pm, Usama Arif wrote:
>> If the kernel is enabled with CONFIG_BOOT_CONFIG_FORCE, it will
>> always append the bootconfig at the start of the kernel commandline.
>> If reuse-cmdline option is used in kexec, the bootconfig will be
>> repeatedly appended at the start of the commandline on every kexec.
>> As there is a limit on the size of kernel commandline that can be
>> used, --reuse-cmdline option will break kexec depending on the
>> size of bootconfig on repeated kexec.
>>
>> Bootconfig is embedded in the kernel, so it should not be considered
>> when reusing kernel command line.
>> Modify get_command_line() to first attempt reading kernel parameters
>> from /proc/bootconfig before falling back to /proc/cmdline. This allows
>> kexec to use the original boot parameters without bootconfig which
>> is embedded in the kernel.
> 
> Thanks for the great fix. While I have some questions about the change.
> 
> 1, if we can read kernel parameters from /proc/bootconfig, does it mean
>    we will skip other kernel parameters, e.g I set some parameters in
>    grub, meanwhile set bootconfg? Is this allowed?

Hi Baoquan,

Thanks for the questions.

/proc/bootconfig treats the parameters from bootconfig separate from the rest.
i.e. parameters from grub will be coming after "# Parameters from bootloader:"
in /proc/bootconfig. It shouldn't skip grub parameters. For e.g. on my machine

cat /proc/bootconfig 
kernel.csdlock_debug = "1"
kernel.mitigations = "off"
# Parameters from bootloader:
# crashkernel=.....


kernel.csdlock_debug = "1"
kernel.mitigations = "off"
comes from bootconfig, while the crashkernel and the rest come from bootloader [1]

[1] https://elixir.bootlin.com/linux/v6.16.1/source/Documentation/filesystems/proc.rst#L739

> 
> 2. If /proc/bootconfig includes the whole kernel parameters of the
>    runnign kernel, setup_boot_config() will parse and append bootconfig
>    to kernel cmdline again, right? But it doesn't matter.

/proc/bootconfig contains the whole parameters, but the bootconfig is seperated by "# Parameters from bootloader:".
If we repeatedly kexec using /proc/cmdline, we will continuously append bootconfig,
and wont be able to kexec anymore once the commandline gets too big..

> 
> Sorry, I am not familiar with bootconfig.
> 
> Thanks
> Baoquan
> 



