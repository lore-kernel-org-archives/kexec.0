Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1039DC36005
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1nD5dBAblQuNZ9vwCHQrc+0rDQkVy0Dn4/k8PPkSg8=; b=ZTs3djllS2SGTieevrSja7QzFh
	7fgUWP/vg3OrZxjRVREEkc6bebt6G8qf9Y1IRaxfviAcjPiOA8HwW4zUs6+VA7D28DJOhLaF9fQwZ
	xO7fOnhpCtA4cEuOUJ9FmeoHTcjwkEy0ETooD+LjGWeT5xI8leroYc14JG3lPFj2zsWP3ISpUxb/Y
	GzO9V/ATJFnfgOp1LXJFSXZ6f3ZDg78Abr4Ccsiv5BJLBKbr5+Odeb6ByxLBWsKdig/zcmxmwjPHn
	A8ZvJNX+pezy23+uZt1fbLOBLW3QSnc/S7oOelDW7qe60Bm6Sr99a9j+ERh6UXylVe3G+n/gvVXQ/
	NHUHbQ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf3l-0000000FSt3-2hrZ;
	Fri, 21 Mar 2025 16:17:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf3K-0000000FSlO-1n71
	for kexec@bombadil.infradead.org;
	Fri, 21 Mar 2025 16:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R1nD5dBAblQuNZ9vwCHQrc+0rDQkVy0Dn4/k8PPkSg8=; b=MOJrwYXuLI2hgmP8rCJo0plj/F
	F31WOs0f4GeLqfhfhK3bYGs+wjFI7+R2jAO/nJLiHdISOe69TCUFoRVZvGPP+66iYEdTN5EVwx2Lz
	GSbJDXlPSXJziBhyKAGlLy83u6Sg+Ff4wLfaCQMMFpARYUohulVh+gr7QIpwi2iueG9rbh/wXHoLP
	LkdMYIA7pt6Eo6ZjZCcgMD7aVMGMmmHx3PRXC7JhGhQEudxoJPXu/vDtcQDNBsr7dw6BC8AgnO7aA
	/S6oAgA/YArQoeoTsVrO3c825YUwY9uR7g2OtpeX/Vjc147wWpd3dquj5W8zsnIT368sj7vZN7ueZ
	3dVzPb7A==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf3H-00000004S4r-0tyO
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 16:16:57 +0000
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 07F52202537E;
	Fri, 21 Mar 2025 09:16:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07F52202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573810;
	bh=R1nD5dBAblQuNZ9vwCHQrc+0rDQkVy0Dn4/k8PPkSg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VXCPZao7zvdMcq+p5QAf2NTnAQSKSj1jGH57/DoHd8DBvMhknS0QK93UGTaai0LcJ
	 gys+d3sy6s/OMLq5IyV3YRm6PUSXyyeeTu0RQrqLHpbWu8E9OkcSkYhU7KG0sw7Vwg
	 NZ7ofHMq8wQCv3++xbQjEadUjMVD4S4tGyUHt/7s=
Message-ID: <4340a887-f0d1-481f-b47f-cd0226adf869@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:16:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <255e75954d9418e2658a6eba6879804c31b3713f.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <255e75954d9418e2658a6eba6879804c31b3713f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_161655_734051_2FB75FAD 
X-CRM114-Status: GOOD (  25.43  )
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

On 3/19/2025 6:42 AM, Mimi Zohar wrote:
> Fix spelling: set_file
>
>
> On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
>> The name of the local variable "file" of type seq_file defined in the
>> ima_dump_measurement_list function is too generic. To better reflect the
>> purpose of the variable, rename it to "ima_kexec_file". This change will
>> help improve code readability and maintainability by making the variable's
>> role more explicit.
> The reason for making the variable name change is the variable scope.
>
> -> Before making the function local seq_file "file" variable global, rename it
> to ima_kexec_file.
>
>> The variable ima_kexec_file is indeed the memory allocated for copying IMA
>> measurement records. The ima_dump_measurement_list function calculates the
>> actual memory occupied by the IMA logs and compares it with the allocated
>> memory. If there is enough memory, it copies all IMA measurement records;
>> otherwise, it does not copy any records, which would result in a failure
>> of remote attestation.
> This paragraph is not applicable to the patch change.
>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>>   1 file changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 9d45f4d26f73..8567619889d1 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,33 +15,41 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +/*
>> + * Copy the measurement list to the allocated memory
>> + * compare the size of IMA measurement list with the size of the allocated memory
>> + *    if the size of the allocated memory is not less than the size of IMA measurement list
>> + *        copy the measurement list to the allocated memory.
>> + *    else
>> + *        return error
>> + */
> Please minimize patch changes.  Before posting, please look at the patch(s) and
> remove anything not applicable to it.  In this case, the comment is not
> applicable to the variable name change.
>
> thanks,
>
> Mimi
>    
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>>   {
>> +	struct seq_file ima_kexec_file;
>>   	struct ima_queue_entry *qe;
>> -	struct seq_file file;
>>   	struct ima_kexec_hdr khdr;
>>   	int ret = 0;
>>   
>>   	/* segment size can't change between kexec load and execute */
>> -	file.buf = vmalloc(segment_size);
>> -	if (!file.buf) {
>> +	ima_kexec_file.buf = vmalloc(segment_size);
>> +	if (!ima_kexec_file.buf) {
>>   		ret = -ENOMEM;
>>   		goto out;
>>   	}
>>   
>> -	file.file = NULL;
>> -	file.size = segment_size;
>> -	file.read_pos = 0;
>> -	file.count = sizeof(khdr);	/* reserved space */
>> +	ima_kexec_file.file = NULL;
>> +	ima_kexec_file.size = segment_size;
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>>   
>>   	memset(&khdr, 0, sizeof(khdr));
>>   	khdr.version = 1;
>>   	/* This is an append-only list, no need to hold the RCU read lock */
>>   	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>> -		if (file.count < file.size) {
>> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>>   			khdr.count++;
>> -			ima_measurements_show(&file, qe);
>> +			ima_measurements_show(&ima_kexec_file, qe);
>>   		} else {
>>   			ret = -EINVAL;
>>   			break;
>> @@ -55,23 +63,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   	 * fill in reserved space with some buffer details
>>   	 * (eg. version, buffer size, number of measurements)
>>   	 */
>> -	khdr.buffer_size = file.count;
>> +	khdr.buffer_size = ima_kexec_file.count;
>>   	if (ima_canonical_fmt) {
>>   		khdr.version = cpu_to_le16(khdr.version);
>>   		khdr.count = cpu_to_le64(khdr.count);
>>   		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>>   	}
>> -	memcpy(file.buf, &khdr, sizeof(khdr));
>> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>>   
>>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
>> -			     file.buf, file.count < 100 ? file.count : 100,
>> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
>> +			     ima_kexec_file.count : 100,
>>   			     true);
>>   
>> -	*buffer_size = file.count;
>> -	*buffer = file.buf;
>> +	*buffer_size = ima_kexec_file.count;
>> +	*buffer = ima_kexec_file.buf;
>>   out:
>>   	if (ret == -EINVAL)
>> -		vfree(file.buf);
>> +		vfree(ima_kexec_file.buf);
>>   	return ret;
>>   }
>>   

Hi Mimi,

I will update in next version.

Thanks,

Steven


