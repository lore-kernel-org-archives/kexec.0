Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ADECFC28A
	for <kexec@archiver.kernel.org>; Tue, 15 Oct 2024 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=REytIl+RONTk+eiSOQccvGXxHOIgA4ffG0JfUyYnarA=; b=YXq5HN3uLTGwYE
	ajU0Sf1TD89tpQUSxmHnRA0pZYbYbhdt0rr7tXDp3bP26RSMvKG+X2wnOwdK8Hr5TNLdALiSu0Ojp
	qgq1hGo21ARAVutvvynD/gmWA6o2DSNYoZvRNMW/cm6QyqCi1eE28hbCggwVpDADLxW1o8O778KfG
	zF0QbRm8CYMlZGMtoUwQ3/gfQxDLELEjfRDJVcYnUlgz5epYEzlcjRZuuH7YCorl+3t10+EZuP+TL
	bOswqYwa2BhwEI4N8PN8d/76Rxa96zaXgV1m8gbcXG7/NlbBholt+qvaDME9mEPIGpAkfoy/JHSTY
	0RcBl4z+tZP+NMxFvlVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0fbe-00000007zlj-3dNu;
	Tue, 15 Oct 2024 11:20:50 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0fV3-00000007ylf-076n;
	Tue, 15 Oct 2024 11:14:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011011007;
	Tue, 15 Oct 2024 04:14:30 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A2A3F51B;
	Tue, 15 Oct 2024 04:13:57 -0700 (PDT)
Message-ID: <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
Date: Tue, 15 Oct 2024 12:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
 <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_041401_176178_EDE970A0 
X-CRM114-Status: GOOD (  20.04  )
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

On 15/10/2024 04:47, Baoquan He wrote:
> On 10/14/24 at 11:58am, Ryan Roberts wrote:
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
>>
>> Updated BUILD_BUG_ON() to test against limit.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  kernel/crash_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 63cf89393c6eb..978c600a47ac8 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
>>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
>>  	 * definitely will be in 2 pages with that.
>>  	 */
>> -	BUILD_BUG_ON(size > PAGE_SIZE);
>> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
> 
> This should be OK. While one thing which could happen is if selected size
> is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
> compiling while actual it's not a problem during running. 

PAGE_SIZE can only ever be bigger than PAGE_SIZE_MIN if compiling a "boot-time
page size" build. And in this case, you need to know that size is small enough
to work with any of the boot-time selectable page sizes. Since size
(=sizeof(note_buf_t)) is invariant to PAGE_SIZE, we can do this by checking
against PAGE_SIZE_MIN.

So I don't think this could ever lead to a false-positive.


Not sure if
> that could happen on arm64. Anyway, we can check the crash_notes to get
> why it's so big when it really happens. So,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks!

> 
>>  
>>  	crash_notes = __alloc_percpu(size, align);
>>  	if (!crash_notes) {
>> -- 
>> 2.43.0
>>
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
