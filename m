Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5894BC3DA4A
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/UW6HtEjTA2QqrIQIio/Y+64wTtoe3BhsTzdw6T7AE=; b=NqzThQESUNbw1e
	ocl/IgUd/XyR1KNENSOs4L7UI4E96JwwBASI1aphqmHbXC6T8M09YXC1DduekMhzjE5RJ+BPssNWQ
	5V9o/Z4VgxWZ7Hq+mRNY8AdhOodfP81bNbbNlTVux/KoeIOg+52f5WBOH91S2DNIPPTEXKvVFUe4b
	NneQP+sxngypItB2SaWtMpZpZrFq4r5AWnpyJ4p1TPy2r69yumrCKEKigmrPASOPkAqR7gZLnXROR
	meE5ZOI9YiWRUuBqgBIMNcl33nF8osuAs0Hop/sLKKdPdC1XVh6aCM9Qa+YAtJ50GzAAthEflDXQU
	Sup6umb7ObxG6N8hkrhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZn8O-000000081VQ-3Sqk;
	Fri, 02 Aug 2024 07:55:32 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZn8L-000000081UJ-0lD4
	for kexec@lists.infradead.org;
	Fri, 02 Aug 2024 07:55:30 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so10903314a12.2
        for <kexec@lists.infradead.org>; Fri, 02 Aug 2024 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722585327; x=1723190127; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iiLa95PkjLGr8EZW8pWxLPDawc+bvhxIuWW8rxxnntM=;
        b=MLyv7oCYaXbnK0bedk5hfbsH4NFXe2bVpfsOCOG/aTV3/v0Wso093dxUHiHNAwP23c
         BzuWIsHgDs4pJW58rLLXdd3elhK9TFixq4L9Tzuf68hZTmC7bisDRH2gZ67VUPfcHR3W
         2SNmk97CwRVfzUb9hg2zjgxrtTo2A0TZdkj1BKvs476zgj4WIwgD3JMeLEX8uWyEL1xg
         8n5lWQEepyoZfuRfm+XfGAcTHFkiO7BAXHIPLtZl27RULpciAU71/hikZ9yz6G6pz/05
         Hv5HBiSkqcVfvOlbK6+30t1vvRgnVcqLvtUguxwZxfVwfExNZ75eilVvUoNbmviCnYM2
         TWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585327; x=1723190127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiLa95PkjLGr8EZW8pWxLPDawc+bvhxIuWW8rxxnntM=;
        b=j+ErRTd8KwdRDN270qU1Ik0fBjTsVqLLquXMFyalWjJQ3dtxU6qwU7rTw2Xu1BAdLU
         enmCEPbAMbUFu6iXhEh+dfmZDgj86TwnGPNi/orncLCW3KIn8FcPziiHOo0jYa+dHZZX
         A9+Wg1t2P1+YU1CK6TDIgWc0xRdSGvYAt4zFztoTdkt18694LNde86LAMcUaobtl8O9b
         nzpxtgEkPQe3wGwEc0hukKsb1CIH095gS4b+Cnq6AZ6whlDUYInTvZV8sEJ8jHKyalJG
         xx7u2ddDRaIx+BLAqajGAA/xngAX4WuABF6BveNyG4oZMzUkI708a1Tacu5ycfsL/zh3
         /WDw==
X-Gm-Message-State: AOJu0Yxynxr86icjsobjEbG7kt8aOVB+7j3DUm1356BBViN/M1dHms61
	LdE0FCOZpkUn67bq9+yA+jRW0j2zcfKUCH6OE85nAWwOefyFazFxIfpb1Fit3p+7H0tNIjTq55M
	=
X-Google-Smtp-Source: AGHT+IErj1BTA7Zf5HTsmj2a2xYL6sNOpfrm5LD7weo/NvZUOwCyxwCGdR9FFwJ/S72/wyxivZAkXQ==
X-Received: by 2002:a05:6402:40c:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5b7f56fd439mr2051010a12.24.1722585326916;
        Fri, 02 Aug 2024 00:55:26 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83960f308sm769528a12.4.2024.08.02.00.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 00:55:26 -0700 (PDT)
Message-ID: <ac57dec1-68a3-471d-8f4c-c87fd9dca619@suse.com>
Date: Fri, 2 Aug 2024 09:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec failure with Xen 4.19-rc4 and 4.20-dev on linux host
To: A Kundu <avikalpa@yahoo.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au,
 xen-devel@lists.xenproject.org, Baoquan He <bhe@redhat.com>
References: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
 <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
 <ZqxUMgcEHakeFPaU@MiWiFi-R3L-srv>
 <abaceb99-4b80-49d7-ab7f-b190f73e858d@yahoo.com>
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
In-Reply-To: <abaceb99-4b80-49d7-ab7f-b190f73e858d@yahoo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_005529_257588_7471A506 
X-CRM114-Status: UNSURE (   7.88  )
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

On 02.08.2024 09:28, A Kundu wrote:
> On 8/2/24 09:06, Baoquan He wrote:
>> On 07/31/24 at 06:34pm, A Kundu wrote:
>>> I am experiencing issues using kexec to load Xen 4.17(debian's apt version),
>>> Xen 4.19-rc4 (compiled from source) and 4.20-dev (compiled from source) on a
>>> debian host.
>> You should CC this to XEN dev list so that XEN dev knows this and may
>> provide help. Not everyone is interested in and knows XEN.
>>
>>> System information:
>>> $ uname -a
>>> Linux host 6.9.10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.10-1 (2024-07-19)
>>> x86_64 GNU/Linux
>>>
>>> $ kexec --version # compiled from source tarball with ./configure --with-xen
>>> kexec-tools 2.0.29
>>>
>>> Steps to reproduce:
>>>
>>> 1. Set variables:
>>>
>>> XEN_HYPERVISOR="/boot/xen.gz"
>>> XEN_CMD="dom0_mem=6G dom0_max_vcpus=6 dom0_vcpus_pin cpufreq=xen"
>>>
>>> 2. Attempt to load Xen 4.19-rc4:
>>>
>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>>> Could not find a free area of memory of 0x3b6001 bytes...
>>> elf_exec_build_load_relocatable: ELF exec load failed
>>>
>>> 3. Attempt to load Xen 4.20-dev:
>>>
>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>>> Could not find a free area of memory of 0x3f8001 bytes...
>>> elf_exec_build_load_relocatable: ELF exec load failed
>>>
>>> 4. Attempt to load Xen 4.17 (from debian rrepositories):
>>> # kexec -l /boot/xen-4.17-amd64.gz --command-line="$XEN_CMD"
>>> Could not find a free area of memory of 0x3b4001 bytes...
>>> elf_exec_build_load_relocatable: ELF exec load failed

And with all of them saying effectively the same, did you verify you
actually have a sufficiently large area reserved? The obvious
place for you to look at is Xen's boot log (obtained via serial
console or "xl dmesg" immediately after booting the system). If you
find everything as expected there, ...

>>> If you need any further information to investigate this problem,
>>> please let me know.

... please provide that boot log.

Jan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
