Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF9DE77198
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l5qyePdTQsadGlhhkm88UTLOJyB05IwMsFPhm2KKy5k=; b=YTYCIQpC4WlD/k9W50lWXpUp+o
	oA1iCIa8ZJC+Y7UioVMrhoCwUC7kxfhAM1gQ6o/XQn4X+PtUXIeW7dD1U0+e8f9aINa6o+3dWZk5E
	KiseWgfNjUXx8eL9MtSbRcBmIBa7Vhxd56jMY8r08iQFFlegiaFJkZehtJDiMIfGCFMz4yf+uDDPl
	giJaAdUmjy/O07hEEnfOV/az6G0yVR5qlDIjHLA+hdOTH+cpI3qjCiteZ/k7OPOJqI85yrANrkc6K
	dO/1LqxK37VUz5ETsboYeYx/Jb9BwJ2XAjNMG8MFAb4qbLWFj1g+mwnPpnP4V5Yj8O9QQwhK6C1ei
	l18qwKww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVNm7-000000077My-2efV;
	Wed, 08 Jan 2025 04:34:35 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVNm4-000000077MY-1BqI
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 04:34:33 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso18418153a91.2
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 20:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736310871; x=1736915671; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5qyePdTQsadGlhhkm88UTLOJyB05IwMsFPhm2KKy5k=;
        b=Is8a//Zb6xbwHGf4G4nn1pfj5B5ZRT/R3vWS5E9fl1xQdib07IJTEuIiBhh1VBlNjq
         NedDwz5KjKvFfgaHB8PR5kjsdsfj0DH/IIflcTyCzfHnQnsb6fIWms3pAJsu/ATtWOHf
         06qbx0f0MOBIyAAuCBtav1WD+lIKZBquvg42JRwOUtIOYNZmqG9IHRY9W6L0lWp5VcFL
         4IhiucmIuvrYhvQRpkAFdWUAWNkGLrl9daA+5IQ8YY1L25z3nssV7SN7Ll9yz8o9lcoC
         2qAqVR6G7FV1F/OkF734P+wCBGLPQUVxlc3wvG17xTC6BpQ8pgv01qZFdlNsGTepUxPJ
         idUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736310871; x=1736915671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5qyePdTQsadGlhhkm88UTLOJyB05IwMsFPhm2KKy5k=;
        b=S290tP1+Nafx0O4ZRTlWeoXH7nYSQ7glKyszr4knKWlNSMe1jLCWX3rXe0H5LKdlWP
         rP7Hutxz2Uqby9YgZgHwPZOzv/4QpoZtsqKONmDqEP30iBhXRTmKGNqnhyj2X+4HpCwU
         VmZ6OjxQlgY6NDokwyUzA0gYuQdaacmeZkQFkTfZqv5ODLymjCb6Fl2CsxxzIu6X2GqJ
         9jwCNM7M0Er+wIh6vLIgKms/olakHC2lMJ3O5ogkflmVaFyuqG+tcaWRPkumvT2z9z3i
         pmu+p2+IPWyAPtAg2Z2UJ65kKrGlyxCeOsXeJQprW3HpLQeyTOOhdGrFgv3xAiabJ4B8
         YxGw==
X-Forwarded-Encrypted: i=1; AJvYcCVzbVH4IK8/kGDoM7oNAodAnYodALq/1naYy7VgHL0pWygBwFSWEHOOsp9X4etHXzFRyGlJqQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0JoZ29fZVb7IFP5Ag++YOf+d2jm6/8eXFhY77QZ5G9tlKbdCD
	YqJa9VSeppdfpzGCkFSRei7ezce3mncnJ0Yk5Y0TOMwLCGiXthvruTSRpJ19IZE=
X-Gm-Gg: ASbGncsFVAqvi6V3AaCuIc0ZK2+Y0FuIWr9jvqRL1uqol/zpvMMIpMBS1TkWa89ZsS1
	NSRb7CkdmbFRkdPCcMFVP9ZrWitjmbProL95EXn1ESF+zVDy1w8MiF7EUij/wqaN6lvIZi/QUXt
	pnE9aBeOPCH6KsL+9LswTMUkDP/UXiae+AD6cC+3vRutCWRfSCGVZq3w575HXm9naxaIZInOK0p
	Mf3AHnEfgQQX+f8mh3sgReI530rODuaaE2QCDsTNR8uNDscB7ysAm+1TFZVf0Smvxo=
X-Google-Smtp-Source: AGHT+IGQRKZLowOpLDJxDKDC4Zdlnk/imeV0cILJj+G12S7tUJ9/SfK9Sf0wRtST8EIlv//HMUuIqA==
X-Received: by 2002:a17:90b:3bc4:b0:2f4:43ce:dcea with SMTP id 98e67ed59e1d1-2f548f1edafmr2196020a91.25.1736310871016;
        Tue, 07 Jan 2025 20:34:31 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34d91bsm448853a91.32.2025.01.07.20.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 20:34:30 -0800 (PST)
Message-ID: <2c6f2c95-b2fc-46e0-91ce-1b9f14b28d3d@daynix.com>
Date: Wed, 8 Jan 2025 13:34:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] binfmt_elf: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
 <Z31T0dMgMucke5KS@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z31T0dMgMucke5KS@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_203432_593861_2BE2B6F9 
X-CRM114-Status: GOOD (  32.14  )
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

On 2025/01/08 1:18, Dave Martin wrote:
> On Tue, Jan 07, 2025 at 09:45:53PM +0900, Akihiko Odaki wrote:
>> Use note name macros to match with the userspace's expectation.
> 
> Also (and more importantly) get rid of duplicated knowledge about the
> mapping of note types to note names, so that elf.h is the authoritative
> source of this information?
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   fs/binfmt_elf.c       | 21 ++++++++++-----------
>>   fs/binfmt_elf_fdpic.c |  8 ++++----
>>   2 files changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 106f0e8af177..5b4a92e5e508 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
> 
> [...]
> 
>> @@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>>   	do
>>   		i += 2;
>>   	while (auxv[i - 2] != AT_NULL);
>> -	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
>> +	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
>>   	thread_status_size += notesize(&auxv_note);
>>   
>>   	offset = sizeof(*elf);				/* ELF header */
> 
> Looking at this code, it appears that the right name is explicitly
> taken from elf.h for a few specific notes, but for those that are
> specified by the arch code (e.g., in struct user_regset entries) the
> name is still guessed locally:
> 
> static int fill_thread_core_info(...) {
> 
> ...
> 
> 	fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
> 		note_type, ret, data);
> 
> 
> It would be preferable to clean this up if we want elf.h to be the
> authoritative source for the names.

If we want elf.h to be the authoritative source, yes, but I like the 
current form as it ensures nobody adds a note with a name different from 
"LINUX" and it is also simpler. There is a trade-off so I'd like to keep 
the current form unless anyone has a strong preference for one option.

Regards,
Akihiko Odaki

> 
> It would be possible to add a .core_note_name entry in struct
> user_regset, and define a helper macro to populate the note type and
> name, something like the following:
> 
> struct user_regset {
> 	...
> 	unsigned int core_note_type;
> +	unsigned int core_note_name;
> };
> 
> #define USER_REGSET_NOTE_TYPE(type) \
> 	.core_note_type = NT_ ## type, \
> 	.core_note_name = NN_ ## name,
> 
> ...and then replace every .core_note_type assignment with an invocation
> of this macro.  A quick git grep should easily find all the affected
> cases.
> 
> 
> Alternatively, as discussed in the last review round, a helper could
> be defined to get the name for a note type:
> 
> const char *elf_note_name(int Elf32_Word n_type)
> {
> 	switch (n_type) {
> 	case NT_PRSTATUS:	return NN_PRSTATUS;
> 	case NT_PRFPREG:	return NN_PRFPREG;
> 	/* ...and all the rest..., then: */
> 
> 	default:
> 		WARN();
> 		return "LINUX";
> 	}
> }
> 
> This avoids the caller having to specify the name explicitly, but only
> works if all the n_type values are unique for the note types that Linux
> knows about (currently true).
> 
> Experimenting with this shows that GCC 11.4.0 (for example) doesn't do
> a very good job with this switch, though, and it requires building
> knowledge about irrelevant arch-specific note types into every kernel.
> I think that extending struct user_regset is probably the better
> approach -- though other people may disagree.
> 
> Cheers
> ---Dave


