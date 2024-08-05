Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B9C3DA7F
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hZI9n/2dDUiafUk16Pkx8dV0B0QH9GHRLfrPsKhtCTQ=; b=OGV4crPO4vCcyo
	ZVAkXrb1w2PnGPB9Fi1at4hMBfJMIXvw/08C5Dkb2B72j8czQxfdFFr5zDmAbsstyNpwL6H0BRKwx
	pSYgQLSGTLvYMuJTKHIVSgNbBdm2Wf+o9x9HRBXAs6enIjDahFTVKS0Ggu4d2KEJMbUnliaOghVTn
	38I61yhlRr1cioQQt0ZY0nh4LgdpdoJxkvU4dt0qWsONyT2yFuC7FGjMop95AE/WIfuR/UFovj4Bi
	3rO+NjaYtL37rVg2PqlFATYHSGV6rQ+r2L5D305ZWTZUbbpGc1pUrDoVaFAmdiI4aO7t6OxYiw+8j
	glN6CRJiC/kjLwuVjX8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saqms-0000000EkfN-1Qvo;
	Mon, 05 Aug 2024 06:01:42 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saqmn-0000000EkeO-0TBt
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 06:01:38 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so1720387a12.2
        for <kexec@lists.infradead.org>; Sun, 04 Aug 2024 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722837695; x=1723442495; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lED7dYRCywCuRbUhwJdEA2o6RkCdCtgphXCI+gOxtf4=;
        b=ZpCCdVD4jTiNEedPMAEb8Gb8Z+QGBSsDxqK16Jb3vgXQdYe/tzLO6lPG23xrRYzNLY
         j2cUJuzvoDo6DIPBWJymT+xy/L3CO4iq1aigKHesm5eMIxQlyPPwesJVYyidnnY/rPEB
         0auGu/thCXexHWk3i5fPnCA/ScnCo/rtU51eCwO1Ifgme1afBel+6FbJ8wgHPg6o5fo+
         XiCAtyX2bLWBUXOJ8Cf8GiBlBBCphMKPI2mhMaLwvdqkWtlY0e/xFpWljOfg5ltx9pgE
         NtlJRlqFBCviz65eWWI1dJn/bW5gyTU58aLq9iIUePTjsBsv5akwfAiJPpcqs1TVeUoZ
         2BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722837695; x=1723442495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lED7dYRCywCuRbUhwJdEA2o6RkCdCtgphXCI+gOxtf4=;
        b=qzy34XeetykJEHjiAnGuGaAVtYVhhOO/dpYbwiF1B3Ujan708LkqQhmGcbsLbvIrAg
         M+6mru3mAyS8Um29kC40Usq4l/90TiPzX2IbZkuKf3vo6s9vojocVGug/UPNBooXh654
         2Xgx7WNKNQdN14Tf7JOfcZobtdK5WKesTJ88u9KA+pmSGzdlBYu/KHhJvi6LlF2dr3q0
         GjrV9irHnE1muKUqeFnECxDOsCDXKbSQAJDS0r/SVIPBy5zELK3ybqDhWle65nIt/7nd
         K+QD7oRP6P7HuPcI62MG4QSStA8JRsfzi7cqdK1v6pJyGdkDsV8l0yO7VfyuGz2MJTFX
         gI7w==
X-Gm-Message-State: AOJu0YxKDtxJz2OnrvO7dZbPHAHisCYXkeoeUqjL2YXvtvFYUSrB0GJw
	AFYR8U5uquZBkrB0VQ+fb/+59nD0JdMQkfo7iyc+fDKbM3+0rSJRAA3+Z62frQ==
X-Google-Smtp-Source: AGHT+IF/MuyBawxYvRAf2/TBrWgfmNs447RfTFJwEQ0MmP6J7PKNna0mpxrB9khI+C1oUahtt2JhwQ==
X-Received: by 2002:a05:6402:2689:b0:5b9:462d:c539 with SMTP id 4fb4d7f45d1cf-5b9462dcb76mr6299336a12.3.1722837694547;
        Sun, 04 Aug 2024 23:01:34 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c24084sm4432996a12.30.2024.08.04.23.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 23:01:34 -0700 (PDT)
Message-ID: <18032298-e535-4405-890e-6ab9d54cf7e3@suse.com>
Date: Mon, 5 Aug 2024 08:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec failure with Xen 4.19-rc4 and 4.20-dev on linux host
To: A Kundu <avikalpa@yahoo.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au,
 xen-devel@lists.xenproject.org, Baoquan He <bhe@redhat.com>,
 andrew.cooper3@citrix.com
References: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
 <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
 <ZqxUMgcEHakeFPaU@MiWiFi-R3L-srv>
 <abaceb99-4b80-49d7-ab7f-b190f73e858d@yahoo.com>
 <ac57dec1-68a3-471d-8f4c-c87fd9dca619@suse.com>
 <dc5c9dff-6bee-493a-8315-b2eee48bd802@yahoo.com>
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
In-Reply-To: <dc5c9dff-6bee-493a-8315-b2eee48bd802@yahoo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_230137_201778_36807384 
X-CRM114-Status: GOOD (  27.23  )
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

On 04.08.2024 15:17, A Kundu wrote:
> On 8/2/24 13:25, Jan Beulich wrote:
>  > On 02.08.2024 09:28, A Kundu wrote:
>  >> On 8/2/24 09:06, Baoquan He wrote:
>  >>> On 07/31/24 at 06:34pm, A Kundu wrote:
>  >>>> I am experiencing issues using kexec to load Xen 4.17(debian's apt 
> version),
>  >>>> Xen 4.19-rc4 (compiled from source) and 4.20-dev (compiled from 
> source) on a
>  >>>> debian host.
>  >>> You should CC this to XEN dev list so that XEN dev knows this and may
>  >>> provide help. Not everyone is interested in and knows XEN.
>  >>>
>  >>>> System information:
>  >>>> $ uname -a
>  >>>> Linux host 6.9.10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.10-1 
> (2024-07-19)
>  >>>> x86_64 GNU/Linux
>  >>>>
>  >>>> $ kexec --version # compiled from source tarball with ./configure 
> --with-xen
>  >>>> kexec-tools 2.0.29
>  >>>>
>  >>>> Steps to reproduce:
>  >>>>
>  >>>> 1. Set variables:
>  >>>>
>  >>>> XEN_HYPERVISOR="/boot/xen.gz"
>  >>>> XEN_CMD="dom0_mem=6G dom0_max_vcpus=6 dom0_vcpus_pin cpufreq=xen"
>  >>>>
>  >>>> 2. Attempt to load Xen 4.19-rc4:
>  >>>>
>  >>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>  >>>> Could not find a free area of memory of 0x3b6001 bytes...
>  >>>> elf_exec_build_load_relocatable: ELF exec load failed
>  >>>>
>  >>>> 3. Attempt to load Xen 4.20-dev:
>  >>>>
>  >>>> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
>  >>>> Could not find a free area of memory of 0x3f8001 bytes...
>  >>>> elf_exec_build_load_relocatable: ELF exec load failed
>  >>>>
>  >>>> 4. Attempt to load Xen 4.17 (from debian rrepositories):
>  >>>> # kexec -l /boot/xen-4.17-amd64.gz --command-line="$XEN_CMD"
>  >>>> Could not find a free area of memory of 0x3b4001 bytes...
>  >>>> elf_exec_build_load_relocatable: ELF exec load failed
>  >
>  > And with all of them saying effectively the same, did you verify you
>  > actually have a sufficiently large area reserved? The obvious
>  > place for you to look at is Xen's boot log (obtained via serial
>  > console or "xl dmesg" immediately after booting the system). If you
>  > find everything as expected there, ...
>  >
>  >>>> If you need any further information to investigate this problem,
>  >>>> please let me know.
>  >
>  > ... please provide that boot log.
> 
> I have also followed up on your suggestion to check the Xen boot log
> using "xl dmesg", but unfortunately, I received the following error:
> 
> xencall: error: Could not obtain handle on privileged command interface: 
> No such file or directory
> libxl: error: libxl.c:102:libxl_ctx_alloc: cannot open libxc handle: No 
> such file or directory
> cannot init xl context
> 
> This indicates that Xen did not boot successfully, so there are no logs
> available.

The fact that you have Dom0 up makes clear that Xen booted okay(ish). The
fact that you get "No such file or directory" from xencall suggests you
either didn't load the xen-privcmd driver (normally arrangements are made
by distros for this to happen automatically), or you didn't even build it.

>  > And with all of them saying effectively the same, did you verify you
>  > actually have a sufficiently large area reserved? The obvious
>  > place for you to look at is Xen's boot log (obtained via serial
>  > console or "xl dmesg" immediately after booting the system). If you
>  > find everything as expected there, ...
>  >
> 
> In an attempt to resolve the memory allocation issue, I have tried the
> following:
> 
> Added a crashkernel=<size>@<offset> parameter to the host kernel command
> line to reserve a dedicated memory region for kexec, and attempted to
> load Xen into that area.

That was a remote guess of mine. This command line option is meaningless
when running under Xen. The reservation needs to be done in Xen.

Overall for the moment I'm inclined to say that xen-devel@ isn't the right
forum here. xen-users@ might be quite a bit more appropriate until you
actually run into issues with Xen itself, not with its (correct) use.

Jan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
