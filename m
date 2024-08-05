Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A7C3DA4A
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UIyrS+w2G9O3VpCxMzo1NmC89+d21q4tP4uYpD3ns2c=; b=E+651o4BlTeQkD
	8pMKelJ9vhI2rRFEakLlotj9ZfSvtc3yHDeYnjW7sSUS4iadGYqX0T9aUNsQzn39VO0z+Pe0v+bgg
	PLAs45JakC8WrFL/yWp5NAmh1ynLjTUgLtRHATrhYa0bOiA3ZfcK10OGY6LJMe0D2vQrpfVlg6J3p
	f6AGZX8D6j0g7VnLrw14dD6g413xziEb3j04hQSeYl6X2OsqUQd0ao3/ZXVUjuTFGSpCyCT8AYqMb
	m2zHHJi6dV5LLeJcigUZOpu4FhLxDtLWasiO4nyfdug1COHwtLvfIzY5bYmy3TkpWp7e1ZDqG5S94
	HoF0G63IE2aY02d4ndBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sasqN-0000000F55J-0fHA;
	Mon, 05 Aug 2024 08:13:27 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sasqK-0000000F545-1hI7
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 08:13:25 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so842699066b.3
        for <kexec@lists.infradead.org>; Mon, 05 Aug 2024 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722845603; x=1723450403; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RSVAtk8ASxSlNuTkSOv8+pp8eaYCgFgeM8xdbggOScc=;
        b=aVAwgX23GnEpgqLjkxYlsNhvapwap28w4ypgFu2Gg8yjDdkUTL6AVzh0gT/aT3YQJi
         LYPb/clCZE/hcOc23xDUq+tDThwKK1mZby+7LOMFwZm1o+6nvF1zBfSJeLjAyaSCC7Ou
         PHehXqzu7KjaP0ImjaLtk/93Cxq0O3BibNXoV4kXF548jAD7Se/5jBcxmahfMA7BIZIN
         jsajZKQJYnkHJ2GwUhvyAgm7FW9rLleCp4rRTe42gbM3hWthI80fs0FKzwCqsRp8zmjf
         WwWrc3fhyyzDIAV5AiDC+vpJ3oQpd8GPSlF0FLIiV9Ved2HLDbaPsFNG4iHSMLQAjszs
         REmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845603; x=1723450403;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSVAtk8ASxSlNuTkSOv8+pp8eaYCgFgeM8xdbggOScc=;
        b=THYOfugwsQinNUzAiTsYHq9ZbJrHKOhNwYwLU0QIkYo4PuHCe/7AEBkUL+q4Hs1LQ4
         IW5h9fHEV+hmjF04Ag4Q1zB3u4+IxvfFNrZCH+CzWbNi4DAasV1w+rAY6GxnP09VlJBY
         ZrHaWAGFNtM8N3sfQTJeYjP6hLY6N9bFQ5wI+49YV6tPNjmtrJPc9CEIAFVLHBcTMzCW
         aUEZyFIvbyWCeX2L7ZwNHsKl5koxk2OsssZal3mwZHluUapu24m5Gm+2p4h4SpKxD7+9
         iK3kOlWFF4k6kwM/KFN/HBDhXBRQOvPkv9W836xlMQCrTLNDjgj6IyyRrx8laDyV2EHK
         XYSA==
X-Gm-Message-State: AOJu0YzXJKGtE9X9x/4qWpclsznbzFxY2WC3TzPBuMezKWWm0ruSPTkh
	msq1tM9NQrZXr/KW6uNXiuK7tgBR4vt0lkdbHkwXycKZX/YTJe6hRIP4ba4XIZ/EA+Irnu0tbBw
	=
X-Google-Smtp-Source: AGHT+IE5ZRJCjb3GqsOmwC+xbgcZTTM2VpGf8UcOIyb+KQACkjiBdiAfi7ZL7+GH5plWx6S7KjODbA==
X-Received: by 2002:a17:907:c009:b0:a7d:cf4f:1817 with SMTP id a640c23a62f3a-a7dcf4f1a38mr702447866b.0.1722845602460;
        Mon, 05 Aug 2024 01:13:22 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb085sm420682166b.212.2024.08.05.01.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 01:13:22 -0700 (PDT)
Message-ID: <ee4d05f4-f533-4f03-99ba-65ddefa54d82@suse.com>
Date: Mon, 5 Aug 2024 10:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec failure with Xen 4.19-rc4 and 4.20-dev on linux host
To: Juergen Gross <jgross@suse.com>, A Kundu <avikalpa@yahoo.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au,
 xen-devel@lists.xenproject.org, Baoquan He <bhe@redhat.com>,
 andrew.cooper3@citrix.com
References: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
 <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
 <ZqxUMgcEHakeFPaU@MiWiFi-R3L-srv>
 <abaceb99-4b80-49d7-ab7f-b190f73e858d@yahoo.com>
 <ac57dec1-68a3-471d-8f4c-c87fd9dca619@suse.com>
 <dc5c9dff-6bee-493a-8315-b2eee48bd802@yahoo.com>
 <18032298-e535-4405-890e-6ab9d54cf7e3@suse.com>
 <74bac0d8-de7a-41df-87ed-b7e2d4140ade@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <74bac0d8-de7a-41df-87ed-b7e2d4140ade@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_011324_489330_7ED1C41C 
X-CRM114-Status: GOOD (  17.67  )
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

On 05.08.2024 09:52, Juergen Gross wrote:
> On 05.08.24 08:01, Jan Beulich wrote:
>> On 04.08.2024 15:17, A Kundu wrote:
>>> On 8/2/24 13:25, Jan Beulich wrote:
>>>   > On 02.08.2024 09:28, A Kundu wrote:
>>>   >> On 8/2/24 09:06, Baoquan He wrote:
>>>   >>> On 07/31/24 at 06:34pm, A Kundu wrote:
>>>   >>>> I am experiencing issues using kexec to load Xen 4.17(debian's apt
>>> version),
>>>   >>>> Xen 4.19-rc4 (compiled from source) and 4.20-dev (compiled from
>>> source) on a
>>>   >>>> debian host.
>>>   >>> You should CC this to XEN dev list so that XEN dev knows this and may
>>>   >>> provide help. Not everyone is interested in and knows XEN.
>>>   >>>
>>>   >>>> System information:
>>>   >>>> $ uname -a
>>>   >>>> Linux host 6.9.10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.10-1
>>> (2024-07-19)
>>>   >>>> x86_64 GNU/Linux
>>>   >>>>
>>>   >>>> $ kexec --version # compiled from source tarball with ./configure
>>> --with-xen
>>>   >>>> kexec-tools 2.0.29
>>>   >>>>
>>>   >>>> Steps to reproduce:
>>>   >>>>
>>>   >>>> 1. Set variables:
>>>   >>>>
>>>   >>>> XEN_HYPERVISOR="/boot/xen.gz"
>>>   >>>> XEN_CMD="dom0_mem=6G dom0_max_vcpus=6 dom0_vcpus_pin cpufreq=xen"
>>>   >>>>
>>>   >>>> 2. Attempt to load Xen 4.19-rc4:
>>>   >>>>
>>>   >>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>>>   >>>> Could not find a free area of memory of 0x3b6001 bytes...
>>>   >>>> elf_exec_build_load_relocatable: ELF exec load failed
>>>   >>>>
>>>   >>>> 3. Attempt to load Xen 4.20-dev:
>>>   >>>>
>>>   >>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>>>   >>>> Could not find a free area of memory of 0x3f8001 bytes...
>>>   >>>> elf_exec_build_load_relocatable: ELF exec load failed
>>>   >>>>
>>>   >>>> 4. Attempt to load Xen 4.17 (from debian rrepositories):
>>>   >>>> # kexec -l /boot/xen-4.17-amd64.gz --command-line="$XEN_CMD"
>>>   >>>> Could not find a free area of memory of 0x3b4001 bytes...
>>>   >>>> elf_exec_build_load_relocatable: ELF exec load failed
>>>   >
>>>   > And with all of them saying effectively the same, did you verify you
>>>   > actually have a sufficiently large area reserved? The obvious
>>>   > place for you to look at is Xen's boot log (obtained via serial
>>>   > console or "xl dmesg" immediately after booting the system). If you
>>>   > find everything as expected there, ...
>>>   >
>>>   >>>> If you need any further information to investigate this problem,
>>>   >>>> please let me know.
>>>   >
>>>   > ... please provide that boot log.
>>>
>>> I have also followed up on your suggestion to check the Xen boot log
>>> using "xl dmesg", but unfortunately, I received the following error:
>>>
>>> xencall: error: Could not obtain handle on privileged command interface:
>>> No such file or directory
>>> libxl: error: libxl.c:102:libxl_ctx_alloc: cannot open libxc handle: No
>>> such file or directory
>>> cannot init xl context
>>>
>>> This indicates that Xen did not boot successfully, so there are no logs
>>> available.
>>
>> The fact that you have Dom0 up makes clear that Xen booted okay(ish). The
>> fact that you get "No such file or directory" from xencall suggests you
>> either didn't load the xen-privcmd driver (normally arrangements are made
>> by distros for this to happen automatically), or you didn't even build it.
> 
> The messages seen don't indicate that Xen booted okay(ish). I get the same
> messages when having booted the Linux kernel on bare metal without Xen.

Hmm, I didn't even think of this as a possible case, considering the question
was forwarded to xen-devel (from a kexec list). I'm afraid Xen simply plays
no role when setting up kexec (to whatever target) from a bare metal env.

Jan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
