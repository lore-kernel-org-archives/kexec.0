Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F76C5DF81
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6VimjWe3SmWZw3TNJVt1GnwULpIdvyBeLBzyA9oKCVE=; b=bJKqwYwsQKjloCi54WqQE/Y1cC
	AowJmPogIQGtbftc/Jsl1VK4rDTXKN/MD/kfQJfOUhdPWl4GRLoU+MuSEXpeUNwVd2WOJLEuXdUda
	7t6ecx/lN3Qk4pjG8S8hfbyvfISdSS2lFnTxQUyHejWRjsSLJSNrkf0uauvZ7wq5+pat3ryvfSVyA
	BvspAvPpaEsRjjdIS2mhAfVJlihXEWD22tvt3CViyJ7V9a4HjtaAkoqjKi5zeWfwdaW0eI2HRptvP
	mnIOBHt4Xj37QiXhyfh1uu6gKglffIGii64hGnHJHV3tmElj1dg1rRvsgyyEzHjDot01yUf+skh/e
	QqN8/qAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx7EY-0000000C1GT-1JM3;
	Thu, 20 Aug 2026 18:11:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx7EW-0000000C1GB-28hs;
	Thu, 20 Aug 2026 18:11:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98E7D60A72;
	Thu, 20 Aug 2026 18:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D21F000E9;
	Thu, 20 Aug 2026 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249479;
	bh=6VimjWe3SmWZw3TNJVt1GnwULpIdvyBeLBzyA9oKCVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ff04qASpnnH+GDL7vbbffBf0ro3l6ENId2a1UaG+kDxmpLGG9E/rRV8i0D6rOl3XN
	 wgxtGXB7UiV3blQzR27KjmkLdOWK6DZ7aWFU9oatFUX2e4j1XViEmrUEG1zFN9GHNn
	 WFOLI43qiCQ7ydx8oyzBlkLLDXLVCQnk3Qd8r9vtidG3JgSaat0NTyiVjaxr5kbsRy
	 /nMChtOImCKK1XOsLycua5DxDT0autDeembT79vP3FvbU1WkHlIaI6YZc4nwuRBNpf
	 s1J8dxXB66OukDIpjwkKfdKZ1ChSWeVZ/L9K34Gfa7vtHGKEMKsJfzo5pTUtcgPotU
	 +xlFa/ZaUx/8w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Philipp Rudo <prudo@redhat.com>
Cc: Mukesh Pilaniya <mpilaniy@redhat.com>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti
 <alex@ghiti.fr>,  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Tao
 Liu <ltao@redhat.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org,  kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
In-Reply-To: <20260820142114.0a36ac78@rotkaeppchen> (Philipp Rudo's message of
	"Thu, 20 Aug 2026 14:21:14 +0200")
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
	<20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
	<20260820142114.0a36ac78@rotkaeppchen>
Date: Thu, 20 Aug 2026 20:11:14 +0200
Message-ID: <2vxzik54zmpp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Aug 20 2026, Philipp Rudo wrote:

> Hi Mukesh,
> Hi Pratyush,
>
> having this patch makes sense. Personally I'd go with having a
> switch-case rather than individual if-blocks. E.g.
>
> 	switch (ret) {
> 		case 0:
> 			image->fops = *fops;
> 			return 0;
> 		case -ENOEXEC:
> 			continue;
> 		default:
> 			return ret;
> 	}
>
> IMHO that is better readable and easier to extend in case other error
> codes need special handling as well. But that is only my personal
> opinion.

Well, IMO both look roughly the same so I unless Mukesh prefers your
version more, we can keep it as-is.

>
> Independent on which implementation you use.
>
> Reviewed-by: Philipp Rudo <prudo@redhat.com>

Thanks for reviewing!

One tiny suggestion. Can you please reply in-line the next time around?
It is a bit easier reading this response below the code that it refers
to.

>
>
> On Wed, 19 Aug 2026 23:17:23 +0530
> Mukesh Pilaniya <mpilaniy@redhat.com> wrote:
>
>> kexec_image_probe_default() overwrites ret with each loader's probe
>> return value and returns whatever the last loader returned when no
>> probe matches.  The error code reaching userspace depends on whichever
>> loader happens to be last in kexec_file_loaders[].
>> 
>> Only continue to the next loader when a probe returns -ENOEXEC.
>> Propagate any other error such as -ENOMEM immediately. Return -ENOEXEC
>> only when all loaders have been tried and none matched.
>> 
>> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>> ---
>>  kernel/kexec_file.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>> 
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 59fb9d71e9d8..b3060e984ef3 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -68,17 +68,19 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
>>  			      unsigned long buf_len)
>>  {
>>  	const struct kexec_file_ops * const *fops;
>> -	int ret = -ENOEXEC;
>>  
>>  	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
>> -		ret = (*fops)->probe(buf, buf_len);
>> -		if (!ret) {
>> +		int ret = (*fops)->probe(buf, buf_len);
>> +
>> +		if (ret == 0) {
>>  			image->fops = *fops;
>> -			return ret;
>> +			return 0;
>>  		}
>> +		if (ret != -ENOEXEC)
>> +			return ret;
>>  	}
>>  
>> -	return ret;
>> +	return -ENOEXEC;
>>  }
>>  
>>  static void *kexec_image_load_default(struct kimage *image)
>> 
>

-- 
Regards,
Pratyush Yadav

