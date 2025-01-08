Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE89E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 04:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTAeASi7vVObUDW8V2zM5ksK3/uTU7NPiyOQuEofviY=; b=ojBYatg528O0eC2ObrSwOpyx1u
	rvmYXVbASpA+EEksuEFvQcQ82xGs+TQjJz0sZvExRcKqyg4HdldvWxK8l2jg/L+bUTOBZYsCMCo/p
	kbgjKLQEq/9nKOTXX8BRLEB+fPzjFHR7YmLZdR0K4HCz5GvM/lwolC2NUhwjvXqX3TjLqifF4CAJE
	fFY2FvRpWepvRlORhG9zDezwFXUqj3VjlqeitWL2wd3wTft7WHZpCpy5ypVrHQrLlJ52i9t/W8b15
	ed4j+OPxXAq02/WepnDIfrZzgpM6AnMeRImEasUm5XELguyt5uPGtCfkTMoOFgsHDGDwGsuuYusb8
	E7iwY31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVO4x-00000007985-1coG;
	Wed, 08 Jan 2025 04:54:03 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVO4u-0000000797Z-20gC
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 04:54:01 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so23665324a91.2
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 20:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736312040; x=1736916840; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTAeASi7vVObUDW8V2zM5ksK3/uTU7NPiyOQuEofviY=;
        b=N+jVBsIjUoY4asc6djHdVL2bhulAy43oYAuRCr7AmZVqws7rUFUDGgYT0ikf1t8KQu
         qBVoui5/WwhcHOZh4RfRGrmx3f+emifWX27legdBp2QosRTU4h//orKWOEhteTxWyEGW
         WAqQAzXdz9tpkyfRDONl9CUsWCuUkBAYm6U55lbdnJS1ma9ZDsEsAeAIIS6Sd+GENMs4
         8vF0ypJVfoH+Gv7HjA7EjijStMm1RLWpvuRwSzugOo6bKno6dklwKzwMjQkg8YHpHuVD
         bnLKdburIkEVqY/ZoYydqQoWvOHNjPkoV96Ci9hp92B7PCjUIyFB9AumW3YWlxz6E4jm
         fZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736312040; x=1736916840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTAeASi7vVObUDW8V2zM5ksK3/uTU7NPiyOQuEofviY=;
        b=oIyRQiqp8xky5cjuLDqaQgigAUwvR12waSH3NejdivlDeB12EfgElWVtpLPr0Unkc/
         cRYrrh99D+8A2Hn/u0R8BtVVuYeBgs7VusVHag5wF7QIMnehdxYuWYpiq2JHFKE+c13q
         KMbDSO2tLlFHTANrsvwsmVmhYJsfIvvcAyRxD4UYTdYqtnCAU1QVmJhzhWjFDoiMcE58
         kgaBW6FxBZUsgwKHyDEZA2ugKY9GaOl9u2r99zKHENInu0gaDEBccH/7ZF/3YeW+gULi
         RdsZB9UpCGcIsX/7bikGPMPZAD/EjAEvprr2hkHdoqqkv4mHBOxEyuUiuGmPTVtBLqtd
         1Bvw==
X-Forwarded-Encrypted: i=1; AJvYcCUfPN7KcTyVSVGZ8R/kAUdebcoMPDkBVDGNRzBmbN8EWPBLXyt1S/jCUZKbXCcf+6mbj0uY8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBQEw5E/oWlDwm/pVpxQge0Jhh7CYgVAECN4/IPoUE2OGL6yBh
	Takb66IK1HNi/x1rvdHN4aGVLg0sb6jxhPS0Gm+y7+vNq6X2SvgRdcAArf9jIQg=
X-Gm-Gg: ASbGnct3z/Idubdc0YzhrdtSqutqI/SjUPix2sdC3w+rQsyD6yWlUYjA4a573QXXd9O
	G5O5qV/1LgeD57I4HaTOpkx61oQd0fnzUf+2XqyLhMpLPq8o/POfTR7trBoUOMGXTZKIkiVs7A4
	AHRtELdU6pPELLL7nT1zcSW3qmJIZ6A4eBuOymYdBunqiMNNGQBfOPY0EBKfzuxYqmK1exIXFS3
	o4joF0hqrWBJjS8QaUxHltEy22ncxDn5NJqaL2vYnCbmXYbS90ExE9XD8IjdeX5mY4=
X-Google-Smtp-Source: AGHT+IGF/lDnmbVBM65O0BZ//6tKBYkr4Hn46ySNw0SXEM+WKDuSN4ZlNc368YPeAlJVvXi3c8brJg==
X-Received: by 2002:a05:6a00:1385:b0:72a:aa0f:c86e with SMTP id d2e1a72fcca58-72d21f17738mr1884512b3a.4.1736312039609;
        Tue, 07 Jan 2025 20:53:59 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d012b1de0sm4918303b3a.80.2025.01.07.20.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 20:53:59 -0800 (PST)
Message-ID: <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
Date: Wed, 8 Jan 2025 13:53:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z31Tp0nMhb/ntUW0@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_205400_527526_A70F86D9 
X-CRM114-Status: GOOD (  22.79  )
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

On 2025/01/08 1:17, Dave Martin wrote:
> Hi,
> 
> On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
>> Use note name macros to match with the userspace's expectation.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>>   1 file changed, 23 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> 
> [...]
> 
>> @@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
>>   	return PTR_ADD(buf, len);
>>   }
>>   
>> -static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
>> -{
>> -	return nt_init_name(buf, type, desc, d_len, nt_name(type));
>> -}
>> +#define NT_INIT(buf, type, desc) \
>> +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> Nit: this macro name clashes with the naming scheme in elf.h.
> 
> I think that there is a (weak) convention that macros with upper-case
> names don't expand to a C function call; thus, a macro with an upper-
> case name can be invoked in places where a C function call would not be
> allowed.  (This convention is not followed everywhere, though -- it's
> up to the maintainer what they prefer here.)

I wanted to clarify it is a macro as it concatenates tokens with ##, but 
I also find there are many macros that are named lower-case and performs 
token concatenation.

S390 maintainers, please tell usr your opinion.

> 
> (Note also, the outer parentheses and the parentheses around (buf)
> appear redundant -- although harmless?)

They only make a difference in trivial corner cases and may look 
needlessly verbose.

> 
>>   
>>   /*
>>    * Calculate the size of ELF note
>> @@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
>>   	return size;
>>   }
>>   
>> -static inline size_t nt_size(Elf64_Word type, int d_len)
>> -{
>> -	return nt_size_name(d_len, nt_name(type));
>> -}
>> +#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))
> 
> Nit: name prefix clash (again); possibly redundant parentheses.
> 
> [...]
> 
>> @@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
>>   	struct save_area *sa = NULL;
>>   	size_t size;
>>   
>> -	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
>> -	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
>> -	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
>> -	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
>> -	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
>> -	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
>> -	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
>> +	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
>> +	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
>> +	size +=  NT_SIZE(S390_TIMER, sa->timer);
>> +	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
>> +	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
>> +	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
>> +	size +=  NT_SIZE(S390_PREFIX, sa->prefix);
> 
> It might be worth fixing the funny spacing on these lines, since all
> the affected lines are being replaced.
> 
>>   	if (cpu_has_vx()) {
>> -		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
>> -		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
>> +		size += NT_SIZE(S390_VXRS_HIGH, sa->vxrs_high);
>> +		size += NT_SIZE(S390_VXRS_LOW, sa->vxrs_low);
>>   	}
>>   
>>   	return size;
>> @@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
>>   	memset(&prpsinfo, 0, sizeof(prpsinfo));
>>   	prpsinfo.pr_sname = 'R';
>>   	strcpy(prpsinfo.pr_fname, "vmlinux");
>> -	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
>> +	return NT_INIT(ptr, PRPSINFO, prpsinfo);
>>   }
>>   
>>   /*
>> @@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
>>   	/* PT_NOTES */
>>   	size += sizeof(Elf64_Phdr);
>>   	/* nt_prpsinfo */
>> -	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
>> +	size += NT_SIZE(PRPSINFO, struct elf_prpsinfo);
>>   	/* regsets */
>>   	size += get_cpu_cnt() * get_cpu_elf_notes_size();
>>   	/* nt_vmcoreinfo */
> 
> Otherwise, this looks sensible to me.
> 
> Cheers
> ---Dave


