Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC89C369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LC7pkHihs4T9XyOd3vElvpj55QuaAXTM1TekQVBmxmM=; b=rqmvCjW0bhQBLF1cvHlBE0K2Lb
	xBTGyy2EPC+mAyqHJ5W63Wpf1+w+B6UcahwNepyS8JsBHkrROSKBrqw7h/7PdL9BPGgaZctQW5S5X
	AoBR6aAaeK0NPrQiNJImKeQRdBIUtgwfrvH8b5A39bV2aYW7ujUhog4qXI6l8f+Ch+gMAgNAPBwsx
	9yGzNayHOYBiYK7HIzRQ6TY6LDSwBOzJkYg3hiz19UPCaxBy1meVR+ii0Jhx/+gK2I+mxcuEYK+5P
	usSZg3YdjUDbrEanRtT1UkJ0RZq08f1UHukt6ChuPmLqUNUMo/hqphVs6ozgCGS5Ud1L1itS1TC7U
	2EQ8p7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e89-0000000BMp7-0hsI;
	Wed, 23 Apr 2025 17:43:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7c2n-0000000AyKt-2pXE
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 15:29:50 +0000
Received: from [100.70.64.216] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A9E6211308D;
	Wed, 23 Apr 2025 08:29:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A9E6211308D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745422188;
	bh=LC7pkHihs4T9XyOd3vElvpj55QuaAXTM1TekQVBmxmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VKe3aNkWdbI858tuCCCibH52jv6/KugZ24rss+dWKHRXrezKFC7/K1lhGJbWzMwlP
	 h7CQC44Hl5LjBE4wXv/dNphwSp55Nt50mVpImBvZw0JVs8TH7j3dS1RpMVoxu4TEYs
	 OVmQHglqmVS7WgCKhYndQ95NNmWxb5ogldgZJYiM=
Message-ID: <99e18151-2866-4646-8532-3d10d63279b9@linux.microsoft.com>
Date: Wed, 23 Apr 2025 08:29:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/9] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-4-chenste@linux.microsoft.com>
 <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_082949_758950_23236528 
X-CRM114-Status: GOOD (  16.27  )
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

On 4/22/2025 5:29 PM, Mimi Zohar wrote:
> On Mon, 2025-04-21 at 15:25 -0700, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> gathers the source pages within the specified address range, and maps them
>> to a contiguous virtual address range.
>>
>> This is a preparation for later usage.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Checkpatch.pl is complaining that the Signed-off-by tag does not matches the
> "From:" line only on this patch.  I've updated your Signed-off-by tag to match
> the "From:" line above.
>
>> Acked-by: Baoquan He <bhe@redhat.com>
> Missing from v13 is Stefan's Tested-by tag.  As the code hasn't changed, I've
> added it.  In the future, please don't forget to add the tags.
>
> Stefen Berger spent quite a bit of time reviewing this patch set, but with v13
> most of his Reviewed-by tags are missing. Stefan?
>
> For now the patch set is staged in the next-integrity-testing branch.
>
> thanks,
>
> Mimi

Hi Mimi,

Could you help to add
Tested-by tag for this patch set: "Tested-by: Stefan Berger 
<stefanb@linux.ibm.com> # ppc64/kvm"
Reviewed-by tags "Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>" to 
patch 1, 5, 6, 9.

Thanks a lot.

Hi Stefen,

Thanks for your help all the time and sorry missing tags to show your work.

Sorry again,

Steven


