Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F7BC43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 04:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UiSoyQUo3vpMssFwS2ewRW3uRWlFoiYd3+zGECIAL8=; b=LSezDUv69pYPh6879jpSMPKvC0
	WHimZoeczGAnHAY85mdnDazl3FVBSP4njFgS7/GKq+GUTrR+6hpj110oVEMLzSNV44OAbK1b6bdqv
	QVpIlG0nKqBPSR7g54XloAgud8GDZ0IyCa/VSEswOvXDTXhcEVyPJOwKTaqAWtCgkoISrURRxujHL
	Z1dYR8ylk1FfuyqkjyKWSH3He6HfMns73bjd+G9zDMCnKExyz82MQHHWGKiPuqbvgqxgjnleHcQD2
	D02jy81fuNCYIdTIWb3tqivEghwCP/akhL3r2erSDBqD5UiG7PYCa7NmtLH3HPJvPhbF4ixatoZbr
	Fbzy+3vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o23A4-005Mlk-5q; Fri, 17 Jun 2022 04:00:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o239s-005Mj4-3D
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 04:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655438426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ing8dPArpW3pQ7GiZn+B8cf12NTt8JD8SKnkYjVAEng=;
	b=eZ52D1h0PIilTzEviSv+E3WkDm+B8CtsdLbk8WDv1v5LdOSP4z77PfHNP83EFWTBDXgkU8
	argeitMQwrMpmLD5AFslxtm5R3AiWkVHqqZOvwRlTVax0KHon9bOkKTxvBVlpp2KMeqRBM
	R8Ovkjok9kfX5S/pQQFIG/xihAElfqI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-W-TPHV77PQCfIjWbBhYR6w-1; Fri, 17 Jun 2022 00:00:24 -0400
X-MC-Unique: W-TPHV77PQCfIjWbBhYR6w-1
Received: by mail-pj1-f71.google.com with SMTP id u9-20020a17090a2b8900b001ec79a1050eso127617pjd.4
        for <kexec@lists.infradead.org>; Thu, 16 Jun 2022 21:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ing8dPArpW3pQ7GiZn+B8cf12NTt8JD8SKnkYjVAEng=;
        b=PwRhFXEHukEgBAQ2mwdtfO7JU85V6jzR9xybxWGz1BzJCwz/pT/UVohnKbasOkqimJ
         Xmvvv50UigGW9/OSLy1l3gztWwFWItE0sLDAtCWRg4ZR8y98Td+cVIBHGVwIQAJVTDgh
         DE/JYX16UvALJmOt8j+1PDYHKMpPO4DN59lQOHNTTqhc/r3B0TQ5/PXkOemJmDEV78Ek
         bq0GcsLi9pWePBf1BhL+rYVaBJs7PQYgClAlId6VdJg8okz9NIb6oAfO2CxhB/0sgqVX
         HT2T6CkJxtRU2v0ZQ1/hOvAQFh1uJAi/R0E2s/bekb42pBFBG5aG/FSAt7iruDj1kdxf
         WA3g==
X-Gm-Message-State: AJIora+JtzAgqfTdH8PCZqTjWc/q+OE+FRCkn76G5tKg/eeIOjHpsSY3
	OMir36UTY8hSKFL5lFW4aSO5f2tCm3szXpD2P0GdkfkWliFpivo/pWWX7sIqPehxfg2NUWMmMAM
	PAMtm09AfJPRLs2jPPGkW
X-Received: by 2002:a17:90a:8592:b0:1dd:bab:d286 with SMTP id m18-20020a17090a859200b001dd0babd286mr8519187pjn.143.1655438423212;
        Thu, 16 Jun 2022 21:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3a9Zd2/6FIohWa9+3QSw+f3Yo8AxTYzaJlZffRepW3I4J7tDbKyyxqa0ROZkZS52ugtqDFQ==
X-Received: by 2002:a17:90a:8592:b0:1dd:bab:d286 with SMTP id m18-20020a17090a859200b001dd0babd286mr8519168pjn.143.1655438422794;
        Thu, 16 Jun 2022 21:00:22 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i9-20020a056a00224900b00522b27ce8f0sm2576012pfu.1.2022.06.16.21.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 21:00:22 -0700 (PDT)
Date: Fri, 17 Jun 2022 11:57:24 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v8 0/4] use more system keyrings to verify arm64 and s390
 kexec kernel image signature
Message-ID: <20220617035724.uyc7mp4n5gdlzta5@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
 <20220525095957.vvref4yeaidd5iww@Rk>
 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
 <20220527134315.afnuszqbfqkpnxpv@Rk>
 <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
 <20220616011506.ymbz2xuhw3refasw@Rk>
MIME-Version: 1.0
In-Reply-To: <20220616011506.ymbz2xuhw3refasw@Rk>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_210032_243516_29F80440 
X-CRM114-Status: GOOD (  27.30  )
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

On Thu, Jun 16, 2022 at 09:15:06AM +0800, Coiby Xu wrote:
>Hi Mimi,
>
>Thanks for carefully reviewing the covert letter and patches and
>suggesting various improvements! And sorry for the late reply as I need
>some time to learn more about secure boot, lockdown and IMA to better
>make sense of what you mean.
>
>On Fri, May 27, 2022 at 12:45:54PM -0400, Mimi Zohar wrote:
>>
>>>new cover letter here to collect new feedback from you thus we
>>>can avoid unnecessary rounds of patch set.
>>
>>Agreed.   Much better.  Just a couple of nits.
>
>>
>>>Currently when loading a kernel image via the kexec_file_load() system
>>>call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
>>>.secondary_trusted_keys and .platform keyrings to verify signature.
>>
>>Either "a signature" or "signatures".
>>
>>>However, arm64 and s390 can only use the .builtin_trusted_keys and
>>>.platform keyring respectively. For example, one resulting problem is
>>>kexec'ing a kernel image  would be rejected with the error "Lockdown:
>>>kexec: kexec of unsigned images is restricted; see man
>>>kernel_lockdown.7".
>>>
>>>This patch set enables arm64 and s390 to make use of the same keyrings
>>>as x86 to very the signature kexec'ed kernel image.
>>
>> Fix "very".  Perhaps "verify the kexec'ed kernel image signature".
>>>
>>>The recently introduced .machine keyring impacts the roots of trust by
>>>linking the .machine keyring to the .secondary keyring. The roots of
>>>trust of different keyring are described as follows,
>>>
>>"of ... keyring" -> "for the ... keyrings"
>
>Thanks for catching those typos and improving the wording!
>
>>
>>>.builtin_trusted_keys:
>>>
>>>Keys may be built into the kernel during build or inserted into memory
>>>reserved for keys post build. The root of trust is the kernel build i.e.
>>>a Linux distribution vendor. On a physical system in a secure boot
>>>environment, this trust is rooted in hardware.
>>
>>Please look at my response to your question below.
>>
>>>
>>>.machine:
>>>
>>>If the end-users choose to trust the keys provided by first-stage UEFI
>>>bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
>>>added to this keyring and this keyring is linked to the
>>
>>Grammatically "and this"  needs to be fixed.
>
>How about "the keys will be added to this keyring which  is linked to 
>the..."?
>
>>
>>>.secondary_trusted_keys keyring as same as the .builtin_trusted_keys
>>>keyring. Shim has built-in keys from a Linux distribution or the
>>>end-users-enrolled keys. So the root of trust of this keyring is either
>>>a Linux distribution vendor or the end-users.
>>>
>>>.secondary_trusted_keys:
>>>
>>>Certificates signed by keys on the .builtin_trusted_keys, .machine, or
>>>existing keys on the .secondary_trusted_keys keryings may be loaded
>>>onto the .secondary_trusted_keys keyring. This establishes a signature
>>>chain of trust based on keys loaded on either the .builtin_trusted_keys
>>>or .machine keyrings, if configured and enabled.
>>>
>>>.platform:
>>>
>>>The .platform keyring consist of UEFI db and MOK keys which are used by
>>>shim to verify the first boot kernel's image signature. If end-users
>>>choose to trust MOK keys and the kernel has the .machine keyring
>>>enabled, the .platform keyring only consists of UEFI db keys since the
>>>MOK keys are added to the .machine keyring instead. Because the
>>>end-users could also enroll there own MOK keys, the root of trust could
>>
>>"there" -> "their"
>>
>>>be hardware or the end-users.
>>
>>It's always "hardware".  "or" -> "and"?
>
>Thanks for catching these issues as well!
>
>>
>><snip>
>>
>>>>>
>>>>> The root of trusts of the keys in the %.builtin_trusted_keys and
>>>>> secondary_trusted_keys keyring is a Linux distribution vendor.
>>>>
>>>>The root of trust for each keyring should be described separately.
>>>>
>>>>.builtin_trusted_keys:
>>>>
>>>>For example,
>>>>
>>>>Keys may be built into the kernel during build or inserted into memory
>>>>reserved for keys post build.  In both of these cases, trust is based
>>>>on verification of the kernel image signature.
>>>
>>>Correct me if I'm wrong, without secure boot, there is no verification
>>>of the kernel image signature so the root of trust should be trust on
>>>the kernel builder.
>>
>>No, basing the signature verification on secure boot could not have
>>been upstreamed.
>
>Thanks for correcting me! I was a bit confused by secure boot and
>lockdown and also forgot enabling lockdown automatically when secure
>boot is enabled is a downstream feature. Btw, when testing the 4th s390
>patch, I found s390 skip signature validation when secure boot is not
>enabled, is this a mistake?
>
>// arch/s390/kernel/machine_kexec_file.c
>#ifdef CONFIG_KEXEC_SIG
>int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>{
>	/* Skip signature verification when not secure IPLed. */
>	if (!ipl_secure_flag)
>		return 0;
>
>>IMA is based on policy, regardeless of the secure
>>boot mode.  A builtin policy may be specified on the boot command line,
>>but should be replaced with a more constrained custom policy [1].
>>Unlike the builtin policy rules, the architecture specific rules are
>>persistent[2].   The architecture specific rules are normally tied to
>>the secure boot modes.  On OpenPOWER, the architecture specific
>>"measure" rules are dependent on the trusted boot mode.
>>
>>The current IMA policy rules can be viewed by cat'ing
>><securityfs>/ima/policy.
>
>Thanks for explaining IMA to me! There is still the question of what's
>the root of trust for .builtin_trusted_keys when there is no real
>signature verification. For example, when CONFIG_KEXEC_SIG is enabled,
>the default IMA policy is to not appraise kexec image. Since lockdown is
>not enabled by default, there is no real verification as
>kimage_validate_signature succeeds even when kexec_image_verify_sig
>fails.

I realize my reasoning is incorrect. Actually the signature
verification which establishes the trust on the keys happens in the
bootloader. So IMA appraisal or kimage_validate_signature is irrelevant
to the question of the root of trust of .builtin_trusted_key. For GRUB,
it won't verify the signature by default when secure boot is not enabled.
Thus the question of what's root of trust when there is no signature
verification is still valid.

>
>>
>>[1] The builtin policies are not LSM aware.  The policy rules need to
>>be constrained to avoid integrity violations.
>>
>>[2] arch specific policy rules:
>>security/integrity/ima/ima_efi.c, arch/powerpc/kernel/ima_arch.c
>>
>>thanks,
>>
>>Mimi
>>
>
>-- 
>Best regards,
>Coiby

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
