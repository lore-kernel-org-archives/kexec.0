Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC606A883
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aoX1pX0w;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ME2y9xyQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9zpmpXZL2AGBZ7N2dDO3aafaZXcocghDPR43dgCZPFw=; b=aoX1pX0wwC9uzK
	qlxDd4l+MvrFxl1Cf31rXVbvBvvd2tSnBiYn1V7XCWb82ipft57YSZRCKREKvbHi46CcGjcSoWBBi
	9rMERx1MeVfD59H24N1XgNYhjeD8J8wwuspkMi/4Y0prnGwvmcGyZatucndgJGPWLvzy7XC+E7CV/
	s+DWbWZWeaMzYyUsXcmTqKm2Jt50U5BCcX2VN0aaRmPUfkxIjSmt9cTSa9BciD9mxLxbnta48pfsl
	Ufph/NSM6FyiVnt8sSiBry2gJbkfQieaZWU5bzpDRmC4FAY+IMKx766WWQzLC7plDScS4qyd1vw+3
	k0mFGkfg3MXeB9XLW50Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUMF-00000009wZI-3U4n;
	Thu, 12 Nov 2026 12:56:51 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUMD-00000009wR4-2ouR
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 12:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9zpmpXZL2AGBZ7N2dDO3aafaZXcocghDPR43dgCZPFw=; b=ME2y9xyQSgXxQ/87K9tSVQ83O7
	F2/nflMo9ecPeWDp1J8M4EtGVEIs1AEiHz6LQd1v9htvVHsjsSY2UrEeH9yOH1gw/6RxOfsGcrZHM
	1BQoJsBMcG+J3UXC35OcOz3qXJgXim4CTnqYStGIitVvQ/LGQpRYB2NjvEAnNgVbfnU0Q88kGHIVS
	L+Nctk2b3FYbw4P6c9AaTeZIBYJfA4zOhViJEknSQfYjIvKHIqVL43in3T9oLi0hSJmrvM25DJ1MU
	JQfnrcYzZX/xM+Ho6zCKi8RB7SKoLT/dF2nMh+XgBhn1gZLPT2YfjDp3LoVzVB+VNDnN75edvgIWI
	kZH9hgYA==;
Received: from [::1] (port=58526 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xRULY-00000003KjR-3O2T;
	Thu, 12 Nov 2026 13:56:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:56:06 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after failed
 loads
In-Reply-To: <0d1363e419054c1aa1b0bfee645314c7e4aec0f5.camel@linux.ibm.com>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <0d1363e419054c1aa1b0bfee645314c7e4aec0f5.camel@linux.ibm.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <4edd198bb0e2b6010b438701994394e3@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_045649_855366_BB6E7F76 
X-CRM114-Status: GOOD (  15.79  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12 03:07, Mimi Zohar wrote:
> On Sun, 2026-11-08 at 19:04 +0000, Jérémy Jean wrote:
>> When kexec_file_load() fails to install a new image, it can leave the
>> global IMA scratch buffer larger than the IMA segment of the current
>> image. When that image is executed, ima_update_kexec_buffer() copies
>> the larger log past the end of its reserved segment. In a test, KASAN
>> reports it as:
>> 
>>   BUG: KASAN: vmalloc-out-of-bounds in 
>> ima_update_kexec_buffer+0x265/0x280
>>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>>   ...
>>   Call Trace:
>>    ...
>>    __asan_memcpy+0x3b/0x60
>>    ima_update_kexec_buffer+0x265/0x280
>>    ...
>>    blocking_notifier_call_chain+0x88/0xb0
>>    kernel_restart_prepare+0x18/0x40
>>    kernel_kexec+0xe4/0x130
>> 
>> Limit the dump to the smaller value between the scratch size and the
>> installed image segment size. Update the IMA mapping only after
>> machine_kexec_post_load() succeeds.
>> 
>> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to 
>> execute")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> 
> Thank you for the report. I agree with Mike that the 
> machine_kexec_post_load()
> reordering should be a separate patch.
> 
> For the overflow, rather than clamping at execute time, how about not 
> changing
> ima_kexec_file.size for an image that isn't installed?
> 
>   1. Set ima_kexec_file.size only in ima_kexec_post_load(), from
>      image->ima_buffer_size, and stop ima_free_kexec_file_buf() from
>      resetting it.
> 
>   2. Reuse the buffer if size >= segment_size, instead of only if they
>      are equal, so the buffer is never smaller than size. The buffer no
>      longer tracks size, and with staging the list can shrink.
> 
> Please don't remove the "segment size can't change between kexec load 
> and
> execute" comments. They are still correct.

Dear Mimi and Mike,

Thank you both for your feedback. I tried to took them into 
consideration
for the v2 I have just sent. As requested, I split the fixes into 
different
commits, and try to address the bigger problem in this new version.

Best regards,
Jérémy

