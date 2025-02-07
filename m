Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA31C02196
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EoLJ5bDNcw7tjbOauCSXGT8dabn5ExzMhG8BNOChz24=; b=SxyxH8uHBECylaiouooWG5sFv8
	uG/sq6OIqAdHEtikdwGjUVdT6Y/9CUQ/TFg6JxB2nWbnZyyl5tlt3uwhlW2u7zFufPOTEdM/Y0QOR
	/h69gazc71rp+xNrJlGhQUKFh4xUY2Hy44wJdL9qnd+CeRivZ2QmeWSn4LZsc6HPwlizl5yNDDNUe
	QGCV8pB/1C0qxXdp6pQJfi95tDjWS42nsIgaFVM2jYmsSlLLgYxguWvYUOl6UiFBs+WlhJybQUosJ
	Cv7VTT5s3DeOcZTGiG1QVFVm2bnyj2mHE2uAvvZFvSdNtlo0Tajuv/obvt50U7AC2ox+9AhLmMd9G
	/i3vFI8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTx2-0000000AtEt-0lZM;
	Fri, 07 Feb 2025 19:23:44 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTwz-0000000AtE6-3mZz
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:23:43 +0000
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id E824C2107306;
	Fri,  7 Feb 2025 11:23:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E824C2107306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956221;
	bh=EoLJ5bDNcw7tjbOauCSXGT8dabn5ExzMhG8BNOChz24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SecTTOrVqBTCGw1QtsfbKYSD8/AKM3u4XWP9VnYyhnpNG2jq8PnFZ05QgzdGccqpv
	 dBn2vSJyxccAuqWT+pCEBT4JRo5B7YiQ+f6KHckUL0StzoAhdounj//tkI+iSDZ2t2
	 HmtpqiRdXARRKV5yAYk5GqVKe/kFGkdjo+bcU8ag=
Message-ID: <ba702678-e1a3-49b5-9c5e-76329e83c812@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:23:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-2-chenste@linux.microsoft.com>
 <1a7e9cf84715386b7ac3dc2103fd38ba180dd216.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <1a7e9cf84715386b7ac3dc2103fd38ba180dd216.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_112341_990262_9CD9827E 
X-CRM114-Status: GOOD (  23.47  )
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

On 2/7/2025 11:10 AM, Mimi Zohar wrote:
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Carrying the IMA measurement list across kexec requires allocating a
>> buffer and copying the measurement records.  Separate allocating the
>> buffer and copying the measurement records into separate functions in
>> order to allocate the buffer at kexec 'load' and copy the measurements
>> at kexec 'execute'.
>>
>> This patch includes the following changes:
>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>     a local static to the file, so that it can be accessed from
>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>     there is enough memory for the entire measurement record.
>>   - Copy as many measurement events as possible.
>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>     the above two functions.
>>   - Compared the memory size allocated with memory size of the entire
>>     measurement record. If there is not enough memory, it will copy as many
>>     IMA measurement records as possible, and this situation will result
>>     in a failure of remote attestation.
>>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |   1 +
>>   security/integrity/ima/ima_kexec.c | 105 +++++++++++++++++++++--------
>>   security/integrity/ima/ima_queue.c |   4 +-
>>   3 files changed, 80 insertions(+), 30 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 3c323ca213d4..447a6eb07c2d 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc
>> *ima_template);
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>>   int ima_measurements_show(struct seq_file *m, void *v);
>> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
>>   unsigned long ima_get_binary_runtime_size(void);
>>   int ima_init_template(void);
>>   void ima_init_template_list(void);
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index 52e00332defe..b60a902460e2 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,62 +15,99 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +static struct seq_file ima_kexec_file;
>> +
>> +static void ima_reset_kexec_file(struct seq_file *sf)
>> +{
>> +	sf->buf = NULL;
>> +	sf->size = 0;
>> +	sf->read_pos = 0;
>> +	sf->count = 0;
>> +}
>> +
>> +static void ima_free_kexec_file_buf(struct seq_file *sf)
>> +{
>> +	vfree(sf->buf);
>> +	ima_reset_kexec_file(sf);
>> +}
>> +
>> +static int ima_alloc_kexec_file_buf(size_t segment_size)
>> +{
>> +	/*
>> +	 * kexec 'load' may be called multiple times.
>> +	 * Free and realloc the buffer only if the segment_size is
>> +	 * changed from the previous kexec 'load' call.
>> +	 */
>> +	if (ima_kexec_file.buf &&
>> +		(ima_kexec_file.size == segment_size)) {
>> +		goto out;
>> +	}
> Nice cleanup from v5.  The line doesn't doesn't need to be split.  Both the
> parenthesis and the brackets can be removed.
>
> In the future, before posting patches, please use scripts/checkpatch.pl.
>
> CHECK: Unnecessary parentheses around 'ima_kexec_file.size == segment_size'
> #82: FILE: security/integrity/ima/ima_kexec.c:41:
> +	if (ima_kexec_file.buf &&
> +		(ima_kexec_file.size == segment_size)) {
>
> CHECK: Alignment should match open parenthesis
> #83: FILE: security/integrity/ima/ima_kexec.c:42:
> +	if (ima_kexec_file.buf &&
> +		(ima_kexec_file.size == segment_size)) {
>
> Or simply join the two lines.
>
> thanks,
>
> Mimi
>
>> +
>> +	ima_free_kexec_file_buf(&ima_kexec_file);
>> +
>> +	/* segment size can't change between kexec load and execute */
>> +	ima_kexec_file.buf = vmalloc(segment_size);
>> +	if (!ima_kexec_file.buf)
>> +		return -ENOMEM;
>> +
>> +	ima_kexec_file.size = segment_size;
>> +
>> +out:
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space
>> */
>> +
>> +	return 0;
>> +}
>>
Thanks, Mimi, will update in the next release


