Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0BFC43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfVt0dLDbTiv4PpAtrwhKzxXpv1xoioA+IuFVvJFddY=; b=JUasVNXImWyjPS97PXTUYZHZnk
	NEB3/FXrv95MADd6/f0glRTCT4UvZJcxEFNbZJSLJnJ33yy6V550R+g5LrtRcYVhIyGNKuNeQ80fR
	EmqBzDxBDw9BNMbAqGYpabWNGrd8HuFpH+X2fuZ7WRiFMuAxtY686vL2NgiinU1n2joi3UOh4P54U
	2f4f9/gsvklwtfdqcuA1SlwgtaYudx0As0BfCrG6ZuPlaaYiwbIMAqDjplNEiCvyv2eOsVb1X5VAO
	dkvng6O0q4fxsODUqE5q+IyHHgTvC4An31PoWsBTiq6hKNwbY8pOPmEaAefIVlP+Zb4yHlJFQz8w7
	dmjAN38w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eBT-00HNPS-EF; Thu, 16 Jun 2022 01:20:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eBI-00HNKq-6X
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 01:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655342416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUR6nWOeJsMYO8qiB/3GvSDR9XKhnZ2gA6LlsAwErmg=;
	b=CEsjUeV8G4iB/eXtUksVky75RniU9zy3KLQiU+3RaJ/FBrmJQotOWmGjAECpGbvaCnrnYT
	vpgXMF05QXdiYoTuC0usdY0KUGIKsW2EacydOQ+KWFlX9HsIVaT2ziZJpP4afUyVx7HRq+
	/gBe7YboDzJsmXSFK8SdMfHgoMO33sc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-6GCAwWB_PvCpXbPJ6cuzIA-1; Wed, 15 Jun 2022 21:20:15 -0400
X-MC-Unique: 6GCAwWB_PvCpXbPJ6cuzIA-1
Received: by mail-pg1-f199.google.com with SMTP id 78-20020a630051000000b003fe25580679so7305309pga.9
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 18:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cUR6nWOeJsMYO8qiB/3GvSDR9XKhnZ2gA6LlsAwErmg=;
        b=jFZeiXqlRN56G0fupnllkVlRYtZ4WjRgFwTPDyUwLpBu8GHExdG2e7lVZqO8zqiQFA
         6DPpYm7Vn+qoUcEGFy+hMrR92qrghW8tUC7A6FfHN82rBrLHWRtsLXvIgguJMFy8tthf
         dBp2sC1/F0wTCz/z685wRE64lqzAsQUAbqYBqL7YUFjcTA1paI1MV7I4xUr0tfw3yJ5B
         EDBSHgImXJX7JpwtN+pzzy5smOO89etBqEBNP6DTlU35z8epEffsfkEaR+77nVXRBu/z
         z8YtHJv90CXmfWd5X5BbeJJLWT3Pu/LBtDygCYl++M+LPnn+Sp52vDrpwDAHGiJo5YMm
         x4uQ==
X-Gm-Message-State: AJIora8tOC5bX0y5Y2omBupVS2x+M5bqDU+siyqiMPqcF6Xm4QXPb77p
	/gm/vulCtRZR6DOyXy+uWEzrJaSsgu7PFnQw8nSynERmcNcCZvWACUKy/WT59DBGz5dUBW/MsKm
	pmm4jZ8GK6Kasgo8u47ed
X-Received: by 2002:a17:90b:4a90:b0:1e8:626c:e1b2 with SMTP id lp16-20020a17090b4a9000b001e8626ce1b2mr2294016pjb.141.1655342414204;
        Wed, 15 Jun 2022 18:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqn3VKAg0dT9yU0B8MQXd7ZqDFnMewBiFUBEgCK9ufgmpXuBk8K/IcHn1AjJ01Rre8BgZIZA==
X-Received: by 2002:a17:90b:4a90:b0:1e8:626c:e1b2 with SMTP id lp16-20020a17090b4a9000b001e8626ce1b2mr2293986pjb.141.1655342413815;
        Wed, 15 Jun 2022 18:20:13 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y14-20020a170902d64e00b0016397da033csm281330plh.62.2022.06.15.18.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:20:13 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:15:06 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v8 0/4] use more system keyrings to verify arm64 and s390
 kexec kernel image signature
Message-ID: <20220616011506.ymbz2xuhw3refasw@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
 <20220525095957.vvref4yeaidd5iww@Rk>
 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
 <20220527134315.afnuszqbfqkpnxpv@Rk>
 <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_182020_590809_53D3CD35 
X-CRM114-Status: GOOD (  33.24  )
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

Hi Mimi,

Thanks for carefully reviewing the covert letter and patches and
suggesting various improvements! And sorry for the late reply as I need
some time to learn more about secure boot, lockdown and IMA to better
make sense of what you mean. 

On Fri, May 27, 2022 at 12:45:54PM -0400, Mimi Zohar wrote:
>
>> new cover letter here to collect new feedback from you thus we
>> can avoid unnecessary rounds of patch set.
>
>Agreed.   Much better.  Just a couple of nits.

>
>> Currently when loading a kernel image via the kexec_file_load() system
>> call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
>> .secondary_trusted_keys and .platform keyrings to verify signature.
>
>Either "a signature" or "signatures".
>
>> However, arm64 and s390 can only use the .builtin_trusted_keys and
>> .platform keyring respectively. For example, one resulting problem is
>> kexec'ing a kernel image  would be rejected with the error "Lockdown:
>> kexec: kexec of unsigned images is restricted; see man
>> kernel_lockdown.7".
>>
>> This patch set enables arm64 and s390 to make use of the same keyrings
>> as x86 to very the signature kexec'ed kernel image.
>
>  Fix "very".  Perhaps "verify the kexec'ed kernel image signature".
>>
>> The recently introduced .machine keyring impacts the roots of trust by
>> linking the .machine keyring to the .secondary keyring. The roots of
>> trust of different keyring are described as follows,
>>
>"of ... keyring" -> "for the ... keyrings"

Thanks for catching those typos and improving the wording!

>
>> .builtin_trusted_keys:
>>
>> Keys may be built into the kernel during build or inserted into memory
>> reserved for keys post build. The root of trust is the kernel build i.e.
>> a Linux distribution vendor. On a physical system in a secure boot
>> environment, this trust is rooted in hardware.
>
>Please look at my response to your question below.
>
>>
>> .machine:
>>
>> If the end-users choose to trust the keys provided by first-stage UEFI
>> bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
>> added to this keyring and this keyring is linked to the
>
> Grammatically "and this"  needs to be fixed.

How about 
"the keys will be added to this keyring which  is linked to the..."?

>
>> .secondary_trusted_keys keyring as same as the .builtin_trusted_keys
>> keyring. Shim has built-in keys from a Linux distribution or the
>> end-users-enrolled keys. So the root of trust of this keyring is either
>> a Linux distribution vendor or the end-users.
>>
>> .secondary_trusted_keys:
>>
>> Certificates signed by keys on the .builtin_trusted_keys, .machine, or
>> existing keys on the .secondary_trusted_keys keryings may be loaded
>> onto the .secondary_trusted_keys keyring. This establishes a signature
>> chain of trust based on keys loaded on either the .builtin_trusted_keys
>> or .machine keyrings, if configured and enabled.
>>
>> .platform:
>>
>> The .platform keyring consist of UEFI db and MOK keys which are used by
>> shim to verify the first boot kernel's image signature. If end-users
>> choose to trust MOK keys and the kernel has the .machine keyring
>> enabled, the .platform keyring only consists of UEFI db keys since the
>> MOK keys are added to the .machine keyring instead. Because the
>> end-users could also enroll there own MOK keys, the root of trust could
>
>"there" -> "their"
>
>> be hardware or the end-users.
>
>It's always "hardware".  "or" -> "and"?

Thanks for catching these issues as well!

>
><snip>
>
>> >>
>> >> The root of trusts of the keys in the %.builtin_trusted_keys and
>> >> secondary_trusted_keys keyring is a Linux distribution vendor.
>> >
>> >The root of trust for each keyring should be described separately.
>> >
>> >.builtin_trusted_keys:
>> >
>> >For example,
>> >
>> >Keys may be built into the kernel during build or inserted into memory
>> >reserved for keys post build.  In both of these cases, trust is based
>> >on verification of the kernel image signature.
>>
>> Correct me if I'm wrong, without secure boot, there is no verification
>> of the kernel image signature so the root of trust should be trust on
>> the kernel builder.
>
>No, basing the signature verification on secure boot could not have
>been upstreamed.  

Thanks for correcting me! I was a bit confused by secure boot and
lockdown and also forgot enabling lockdown automatically when secure
boot is enabled is a downstream feature. Btw, when testing the 4th s390
patch, I found s390 skip signature validation when secure boot is not
enabled, is this a mistake?

// arch/s390/kernel/machine_kexec_file.c
#ifdef CONFIG_KEXEC_SIG
int s390_verify_sig(const char *kernel, unsigned long kernel_len)
{
	/* Skip signature verification when not secure IPLed. */
	if (!ipl_secure_flag)
		return 0;

> IMA is based on policy, regardeless of the secure
>boot mode.  A builtin policy may be specified on the boot command line,
>but should be replaced with a more constrained custom policy [1].
>Unlike the builtin policy rules, the architecture specific rules are
>persistent[2].   The architecture specific rules are normally tied to
>the secure boot modes.  On OpenPOWER, the architecture specific
>"measure" rules are dependent on the trusted boot mode.
>
>The current IMA policy rules can be viewed by cat'ing
><securityfs>/ima/policy.

Thanks for explaining IMA to me! There is still the question of what's
the root of trust for .builtin_trusted_keys when there is no real
signature verification. For example, when CONFIG_KEXEC_SIG is enabled,
the default IMA policy is to not appraise kexec image. Since lockdown is
not enabled by default, there is no real verification as
kimage_validate_signature succeeds even when kexec_image_verify_sig
fails. 

>
>[1] The builtin policies are not LSM aware.  The policy rules need to
>be constrained to avoid integrity violations.
>
>[2] arch specific policy rules:
>security/integrity/ima/ima_efi.c, arch/powerpc/kernel/ima_arch.c
>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
