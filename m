Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB41CD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NoW4dBQJTYBFlHQW00nNPl6/h/gKlMcg1Uc0OmFwUL0=; b=KfojI/lAnhLQvly/LGmGSq3j5t
	epjM2fNakiDNXKAcNKjJH4i6seIE+eJqkk3SIraQ0qGWgXFGua/BZDMhjcM7ZyLDkfEs4OFjIbkcq
	KkM0XLsd9Yt/oRfWqDFBC2De4FTx1bxipCgdNsyqzOMLMER/H2PKwHjNtr91GbE7bTenBobyqZaNC
	FVMT9Vu210qUhRmMQl9P6ig6uMqrTNNiCt6sUiM/DJIT+7/qjNAfx+H+oUgjrZEGa3srVWlicMQbj
	yW3SxAEXMIg65i1OB+O7vwZRVKb/u2qdjQD6TYo+zOMdB6+ZldbNHom1Q3nR/YsVghloWwfHNo0+S
	MsRLTwnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQTNY-0000000BVLn-1wWK;
	Fri, 22 May 2026 17:09:44 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQTNT-0000000BVLJ-24GY
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 17:09:40 +0000
Received: from [10.0.5.46] (unknown [70.37.26.63])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B1BB20B7167;
	Fri, 22 May 2026 10:09:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B1BB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779469768;
	bh=NoW4dBQJTYBFlHQW00nNPl6/h/gKlMcg1Uc0OmFwUL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ij7RtZIAj0kZfgBbD0zhqr0g6ehQuFJYxpD1a4BemU3OM1r7F9z4cj4gBt/KbWAqi
	 7FYCg7qgI2wXOpj9F3zU9bs3mkZSWe8uv1u7S/tyns+yP9LoayMzE04AGgTaXjs2lG
	 HhzZbF9Dv2ptfh7bKVAnv5LcSKP9bouafTxEVEn0=
Message-ID: <577e2cc5-490b-42dd-855a-8ca6780df14f@linux.microsoft.com>
Date: Fri, 22 May 2026 11:09:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: restore functionality to preserve fd xattrs for
 uncompressed kernel images
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
References: <20260507215417.2674568-1-alhe@linux.microsoft.com>
 <20260519094153.GA227450@horms.kernel.org>
Content-Language: en-US
From: Alejandro Hernandez <alhe@linux.microsoft.com>
In-Reply-To: <20260519094153.GA227450@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_100939_568912_C4D90EF4 
X-CRM114-Status: GOOD (  23.26  )
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


On 5/19/2026 3:41 AM, Simon Horman wrote:
> On Thu, May 07, 2026 at 09:54:17PM +0000, Alejandro Hernandez wrote:
>> Since commit 714fa115 xattrs attached to a kernel image file (such as IMA
>> signatures) are not being preserved, do_kexec_file_load() was modified to use
>> memfd_create() which now passes an anonymous file descriptor to
>> kexec_file_load(). This change eliminated the filesystem inode identity of the
>> original kernel file, hence attributes are no longer visible to the kernel IMA
>> appraisal handler during kexec_file_load, causing IMA policy enforcement to fail
>> even for validly signed kernel images.
>>
>> This patch attempts to restore such behavior although, only does it for
>> uncompressed kernel images. To do this, we first figure out if the image file is
>> compressed or not and call each method accordingly.
>>
>> Compressed images continue to use memfd and cannot carry forward the original fd
>> security attributes, since their decompressed bytes do not match the signed
>> artifact. Proper handling of compressed images with IMA would require either
>> signing the decompressed artifact or kernel-side support for decompression
>> within the kexec_file_load path.
>>
>> Signed-off-by: Alejandro Hernandez Samaniego <alhe@linux.microsoft.com>
> Hi Alejandro,
>
> Thanks for the patch.
>
> Overall this looks good to me. But I'm wondering if you could spin a v2
> to address a minor code-style issue I have noted inline.

Hey Simon,

Thanks for the review, sure thing, I will send a v2


Alejandro


>
>> ---
>>   kexec/kexec.c | 42 +++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index 08edfca..a388762 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -1328,17 +1328,41 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>>   
>>   	kernel = argv[fileind];
>>   
>> -	/* slurp in the input kernel */
>> +        /* Hold original fd with its xattrs */
>> +	kernel_fd = open(kernel, O_RDONLY);
>> +	if (kernel_fd == -1) {
>> +		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
>> +				strerror(errno));
>> +		return EFAILED;
>> +	}
>> +
>> +	/* Compressed vs Uncompressed */
>> +	struct stat kernel_stat;
>> +	off_t kernel_file_size = -1;
> I would prefer if we stuck to declaring local variables
> at the top of this function.
>
>> +	if (fstat(kernel_fd, &kernel_stat) == 0)
>> +		kernel_file_size = kernel_stat.st_size;
>> +
>> +        /* slurp in the input kernel */
>>   	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
>>   	if (!kernel_buf) {
>>   		fprintf(stderr, "Failed to decompress file %s:%s\n", kernel,
>>   				strerror(errno));
>> +		close(kernel_fd);
>>   		return EFAILED;
>>   	}
> ...

