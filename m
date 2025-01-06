Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3197E77199
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 05:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LuPI2QoCWSGABhNaHmyyQbTaoQ2qivKcvMjG9VSzHt4=; b=qxgWNcamRLxC+f72/p8/odY0kS
	hm5wEs5CRwqKTfKQ/FFl4aj9UbhnwVHaXr012K4cTRnar3/tDWnoSuxuki3xjOZIq6CDxDBhXYCdG
	EAd652pyV3K/XAQupqiSLk8POneFl2KkuByQp6VYnSCOXUQrvTBWTYBRXtBW8eezoiGwLuMLHBN+s
	B8ydP9R8Yn+5So9IRQOT9uzupwNsNqOGxkt7GpBXwCzMa4ODihs2vlmug0PvWZWDzmgGh4H8ygYbx
	wXQ4wrmnKosqYOTklF14I8+yGfbP0yw/8d4WfWhLYBrNXL8cm294PBSTfDkaCdgd5zQ02cHBliu3Q
	26DGvYvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUfLN-00000000DWo-1q46;
	Mon, 06 Jan 2025 05:08:01 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUfLL-00000000DWP-068y
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 05:08:00 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21669fd5c7cso201415475ad.3
        for <kexec@lists.infradead.org>; Sun, 05 Jan 2025 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736140077; x=1736744877; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuPI2QoCWSGABhNaHmyyQbTaoQ2qivKcvMjG9VSzHt4=;
        b=SH6GO+gtBffiNY5NXSgrSaks6w1iMFKHSOKZ1ucaHsdxtv1MeYqdRGnQP+UHD9tJyp
         XxcHZBvCUcr52KEu5dnPPGUGTu5IW2Ke142UYNCu6yeLX+kd7s6hzigpBhoJ+AwhULpb
         SlrRoyU/WaJbZvomc3G74MAzCHBaagEKXvfxNx1pGPlNVQTIlmQP+UdQxbmKXsQSBJWH
         dl87sacmSHp/1bRwBY/y0vM6gGzYHAPsd4I4bHnCvKEWAGJhNlII1Vpo7WLz0i1shrQG
         M5X3aJExGNH3sy0QdYBrbqduuBdnsyM8pOFaBfNFZn3+qtXmLyovYy36c79MvIH2qfo7
         3xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736140077; x=1736744877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuPI2QoCWSGABhNaHmyyQbTaoQ2qivKcvMjG9VSzHt4=;
        b=KjltvlfQT5Hq/MfzUudgUE5KOdT4M88ATIM4NyyYQArjkfJvEAcTVEG6iIJ5/6rVO1
         6cTlTUPlheZl3UQzMMf4Xiy5N67IePegD6RuCf8fyB1c5xliXIl58MAzMJBaiXTCKut7
         zYLl0NKhtteKmPSO4dJs0x/z9DIF0WpWY9s26JxGIVTKtbnrv4wSd/X38KHjvv5RJRmn
         YcBXdtkAIjZTMfokSS1ERv1Pvxw2kyomhpI3DL7QYpVrDerloAbqALynzMFTEt9Lxi8G
         Q2PNSm03OisQEjcZKCvRBoVHRiQ5I8SwuD3kEzvf628wOOH2HzRqkrx/2QZSvhjUHn8w
         AzrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJLtytCA68Rzui8GgTA3APMcjTvp1r0nBBt1Fd7j+GuG6/r3JAPawBoOBZsLjtEMGjDAL9cA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyadDGwIWv95O1M3mQWeGs5pbCK816CL51S0OsSYs+UeQg8LVjb
	dqTIdIu0xMTcB8RVLes8zjGWtnxlUKa1/O1m/oW5P/g7+enmuKUSBa781x3ZmUE=
X-Gm-Gg: ASbGncsiYfbTA10ybT4RNY5o4P7X8EUrP8MFxuuZz5zPGMsNHw8XxU9IMwdUqjXXvUK
	k6w1uJsU/RpDntuFWIQgg0gz+yuIgSpgA3BSn6EoHuIiYYDb9y9EAakcd79XH44PQ7/EY7Vo27h
	Kszux2GtArcsSfoC2YU/P/dQaV43A7Sq15yv85N4l907Lz6nx5D4o9tzBzWHcoNe/tuoUOYh4Ig
	ygXfe44+G2gFkzkzG/fzBhBk9Yn5k2/+3JLT8iCWaBeML6NmnTM3Gc1LziVgWtQ
X-Google-Smtp-Source: AGHT+IHO9h+H3nQtpCAylHi4N1tDhCEXwfFp2Ug4YvZcEwI3J7mIrB866g5t/GIXJEMR5ZJQFBtNMg==
X-Received: by 2002:a17:903:1209:b0:216:36ff:ba33 with SMTP id d9443c01a7336-219e6ebcfc7mr750060565ad.26.1736140077545;
        Sun, 05 Jan 2025 21:07:57 -0800 (PST)
Received: from [10.100.1.231] ([157.82.128.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e94dsm285208985ad.67.2025.01.05.21.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 21:07:57 -0800 (PST)
Message-ID: <70daf544-f59f-404b-bec0-0d60e892a9e9@daynix.com>
Date: Mon, 6 Jan 2025 14:07:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org, devel@daynix.com
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com> <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_210759_341550_55972403 
X-CRM114-Status: GOOD (  20.19  )
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

On 2025/01/06 11:21, Baoquan He wrote:
> On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
>> elf.h had a comment saying:
>>> Notes used in ET_CORE. Architectures export some of the arch register
>>> sets using the corresponding note types via the PTRACE_GETREGSET and
>>> PTRACE_SETREGSET requests.
>>> The note name for these types is "LINUX", except NT_PRFPREG that is
>>> named "CORE".
>>
>> However, NT_PRSTATUS is also named "CORE". It is also unclear what
>> "these types" refers to.
>>
>> To fix these problems, define a name for each note type. The added
>> definitions are macros so the kernel and userspace can directly refer to
>> them.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 83 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index b44069d29cec..014b705b97d7 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -372,8 +372,6 @@ typedef struct elf64_shdr {
>>    * Notes used in ET_CORE. Architectures export some of the arch register sets
>>    * using the corresponding note types via the PTRACE_GETREGSET and
>>    * PTRACE_SETREGSET requests.
>> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
>> - * "CORE".
>>    */
>>   #define NT_PRSTATUS	1
>>   #define NT_PRFPREG	2
>> @@ -460,9 +458,91 @@ typedef struct elf64_shdr {
>>   #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
>>   #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>>   
>> -/* Note types with note name "GNU" */
>> +/* Note used in ET_EXEC and ET_DYN. */
>>   #define NT_GNU_PROPERTY_TYPE_0	5
>>   
>> +/* Note names */
>> +#define NN_PRSTATUS	"CORE"
>> +#define NN_PRFPREG	"CORE"
>> +#define NN_PRPSINFO	"CORE"
>> +#define NN_TASKSTRUCT	"CORE"
>> +#define NN_AUXV	"CORE"
>> +#define NN_SIGINFO	"CORE"
>> +#define NN_FILE	"CORE"
>> +#define NN_PRXFPREG	"LINUX"
> 
> No objection to make them clearer. Thanks for the effort.
> 
> Wondering where below arch specific macros are used. So you just
> added all NN_xxx for the corresponding NT_xxx? Not sure if this is
> needed if we don't use them at all in the current kernel.

Indeed I just added all NN_xxx. The kernel won't use the macros that are 
defined as "LINUX"; fs/binfmt_elf.c uses "LINUX" by default as the notes 
named "CORE" or "GNU" are exceptional.

Userspace applications may still be interested in these macros as 
demonstrated in:
https://lore.kernel.org/r/Z3f7zJwu8bu8HYln@e133380.arm.com

These macros also serve as documentation; correcting and clarifying the 
documentation is the main purpose of this series.

> 
>> +#define NN_PPC_VMX	"LINUX"
>> +#define NN_PPC_SPE	"LINUX"
>> +#define NN_PPC_VSX	"LINUX"
>> +#define NN_PPC_TAR	"LINUX"
>> +#define NN_PPC_PPR	"LINUX"
>> +#define NN_PPC_DSCR	"LINUX"
>> +#define NN_PPC_EBB	"LINUX"
>> +#define NN_PPC_PMU	"LINUX"
>> +#define NN_PPC_TM_CGPR	"LINUX"
>> +#define NN_PPC_TM_CFPR	"LINUX"
>> +#define NN_PPC_TM_CVMX	"LINUX"
>> +#define NN_PPC_TM_CVSX	"LINUX"
>> +#define NN_PPC_TM_SPR	"LINUX"
>> +#define NN_PPC_TM_CTAR	"LINUX"
>> +#define NN_PPC_TM_CPPR	"LINUX"
>> +#define NN_PPC_TM_CDSCR	"LINUX"
>> +#define NN_PPC_PKEY	"LINUX"
>> +#define NN_PPC_DEXCR	"LINUX"
>> +#define NN_PPC_HASHKEYR	"LINUX"
>> +#define NN_386_TLS	"LINUX"
>> +#define NN_386_IOPERM	"LINUX"
>> +#define NN_X86_XSTATE	"LINUX"
>> +#define NN_X86_SHSTK	"LINUX"
>> +#define NN_X86_XSAVE_LAYOUT	"LINUX"
>> +#define NN_S390_HIGH_GPRS	"LINUX"
>> +#define NN_S390_TIMER	"LINUX"
>> +#define NN_S390_TODCMP	"LINUX"
>> +#define NN_S390_TODPREG	"LINUX"
>> +#define NN_S390_CTRS	"LINUX"
>> +#define NN_S390_PREFIX	"LINUX"
>> +#define NN_S390_LAST_BREAK	"LINUX"
>> +#define NN_S390_SYSTEM_CALL	"LINUX"
>> +#define NN_S390_TDB	"LINUX"
>> +#define NN_S390_VXRS_LOW	"LINUX"
>> +#define NN_S390_VXRS_HIGH	"LINUX"
>> +#define NN_S390_GS_CB	"LINUX"
>> +#define NN_S390_GS_BC	"LINUX"
>> +#define NN_S390_RI_CB	"LINUX"
>> +#define NN_S390_PV_CPU_DATA	"LINUX"
>> +#define NN_ARM_VFP	"LINUX"
>> +#define NN_ARM_TLS	"LINUX"
>> +#define NN_ARM_HW_BREAK	"LINUX"
>> +#define NN_ARM_HW_WATCH	"LINUX"
>> +#define NN_ARM_SYSTEM_CALL	"LINUX"
>> +#define NN_ARM_SVE	"LINUX"
>> +#define NN_ARM_PAC_MASK	"LINUX"
>> +#define NN_ARM_PACA_KEYS	"LINUX"
>> +#define NN_ARM_PACG_KEYS	"LINUX"
>> +#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
>> +#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
>> +#define NN_ARM_SSVE	"LINUX"
>> +#define NN_ARM_ZA	"LINUX"
>> +#define NN_ARM_ZT	"LINUX"
>> +#define NN_ARM_FPMR	"LINUX"
>> +#define NN_ARM_POE	"LINUX"
>> +#define NN_ARM_GCS	"LINUX"
>> +#define NN_ARC_V2	"LINUX"
>> +#define NN_VMCOREDD	"LINUX"
>> +#define NN_MIPS_DSP	"LINUX"
>> +#define NN_MIPS_FP_MODE	"LINUX"
>> +#define NN_MIPS_MSA	"LINUX"
>> +#define NN_RISCV_CSR	"LINUX"
>> +#define NN_RISCV_VECTOR	"LINUX"
>> +#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
>> +#define NN_LOONGARCH_CPUCFG	"LINUX"
>> +#define NN_LOONGARCH_CSR	"LINUX"
>> +#define NN_LOONGARCH_LSX	"LINUX"
>> +#define NN_LOONGARCH_LASX	"LINUX"
>> +#define NN_LOONGARCH_LBT	"LINUX"
>> +#define NN_LOONGARCH_HW_BREAK	"LINUX"
>> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
>> +
>>   /* Note header in a PT_NOTE section */
>>   typedef struct elf32_note {
>>     Elf32_Word	n_namesz;	/* Name size */
>>
>> -- 
>> 2.47.1
>>
> 


