Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3730C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IqCxcEZB3S2TzrdNMoz1yKiVMLsoGPup0Ea2UiTyPd0=; b=m+xUGUeUW/X+nQ
	KDqpVNtwzURjBr4OT+fYdHVHm7FSVVptUYGzMMx5mlrXwotbc6c22KiU3V3wkYMdfsN/m1hXBBi7f
	2fOVtt5OGDac6YPOb+20YmRk75QcgIp7SokSJtPgxE4T5218M+CjfmcA/8RXuOzid8S8CeH3rIxRh
	kD/WtFC9T3iNABwt7FPYMEXmH0SGkDmhht9fl+vn2TkYGLtHRPpsyF61I3JZpff5uKZU510BQ/NXO
	RlkHU8AIvDXkT+JrJuuphw/VsgL8xN/cUHc/dznZMjtFuwRCyO04l/kpqxIZpg+AQPY+WS7qB0m8Z
	BWiSDt/rqV2cR/VjMx4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r31wo-00GupN-1V;
	Tue, 14 Nov 2023 22:31:54 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r31wk-00Guov-1D
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 22:31:52 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9825A20B74C1;
	Tue, 14 Nov 2023 14:31:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9825A20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700001101;
	bh=QKlw4fetvSAHCZzeB9isVln5Gc8zxcv/QUeOvWVw2qY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ezm6Xd75FUvj0cJzppjB2Zrlt9M7P7WAbZkBJ5Oo5+sPebQnLqSR7MvbpFHVop5GG
	 cRYwLKIfXr0OH5bhPRGhMC6OqODoXR7yc2ki12WZYvT4FTsjxy5uWkIC1bEl6QEvEr
	 u6hai0NU0i4CaLLCrfef2SjbLasG4oQXQ/oAiY+E=
Message-ID: <fc666310-164f-487e-8dde-d3a1a3c70a5a@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:31:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_143150_529432_E35AC8A0 
X-CRM114-Status: GOOD (  36.60  )
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

Thanks a lot for reviewing this patch set Mimi.

On 10/26/23 13:16, Mimi Zohar wrote:
> Hi Tushar,
> 
> According to Documentation/process/submitting-patches.rst, the subject
> line should be between 70-75 characters.
> 
> Perhaps something like "ima: define and call ima_alloc_kexec_buffer()".
> 
Sure thing. I will shorten the subject line. Here and elsewhere.
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>> IMA allocates memory and dumps the measurement during kexec soft reboot
>> as a single function call ima_dump_measurement_list().  It gets called
>> during kexec 'load' operation.  It results in the IMA measurements
>> between the window of kexec 'load' and 'execute' getting dropped when the
>> system boots into the new Kernel.  One of the kexec requirements is the
>> segment size cannot change between the 'load' and the 'execute'.
>> Therefore, to address this problem, ima_dump_measurement_list() needs
>> to be refactored to allocate the memory at kexec 'load', and dump the
>> measurements at kexec 'execute'.  The function that allocates the memory
>> should handle the scenario where the kexec load is called multiple times
> 
> The above pragraph is unnecessary.
> 
Sounds good. I will remove the above paragraph.

>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
>> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>> function ima_dump_measurement_list() global, so that they can be accessed
>> from ima_alloc_kexec_buf().  Make necessary changes to the function
>> ima_add_kexec_buffer() to call the above two functions.
> 
> Fix the wording based on the suggested changes below.
> 
Will do.
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Before re-posting this patch set, verify there aren't any
> "checkpatch.pl --strict" issues.
> After applying each patch, compile the kernel and verify it still
> works.
> >> ---
>>   security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>>   1 file changed, 93 insertions(+), 33 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 419dc405c831..307e07991865 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,61 +15,114 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +struct seq_file ima_kexec_file;
> 
> Define "ima_kexec_file" as static since it only used in this file.
> Since the variable does not need to be global, is there still a reason
> for changing its name?   Minimize code change.
> 
>> +struct ima_kexec_hdr ima_khdr;
>> +
>> +void ima_clear_kexec_file(void)
> 
> The opposite of "set" is "clear" (e.g. set_git, clear_bit).  The
> opposite of "alloc" would be "free" (e.g. ima_alloc_kexec_buf,
> ima_free_kexec_buf)
> 
Agreed. Will make it ima_free_kexec_buf.
>> +{
>> +	vfree(ima_kexec_file.buf);
>> +	ima_kexec_file.buf = NULL;
>> +	ima_kexec_file.size = 0;
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = 0;
>> +}
>> +
>> +static int ima_alloc_kexec_buf(size_t kexec_segment_size)
>> +{
>> +	if ((kexec_segment_size == 0) ||
>> +	    (kexec_segment_size == ULONG_MAX) ||
>> +	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>> +		pr_err("%s: Invalid segment size for kexec: %zu\n",
>> +			__func__, kexec_segment_size);
>> +		return -EINVAL;
>> +	}
> 
> Please avoid code duplication.  If moving the test here, then remove it
> from its original place.
> 
Sure. Will do.
>> +
>> +	/*
>> +	 * If kexec load was called before, clear the existing buffer
>> +	 * before allocating a new one
>> +	 */
> 
>> +	if (ima_kexec_file.buf)
>> +		ima_clear_kexec_file();
> 
> Perhaps instead of always freeing the buffer, check and see whether the
> size has changed.  If it hasn't changed, then simply return.  If it has
> changed, perhaps use realloc().  Possible wording:
> 
> "Kexec may be called multiple times.  Free and re-alloc the buffer if
> the size changed."
> 
That's a good optimization. Thanks for the suggestion. Will do.
>> +
>> +	/* segment size can't change between kexec load and execute */
>> +	ima_kexec_file.buf = vmalloc(kexec_segment_size);
>> +	if (!ima_kexec_file.buf) {
>> +		pr_err("%s: No memory for ima kexec measurement buffer\n",
>> +			__func__);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ima_kexec_file.size = kexec_segment_size;
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
>> +
>> +	memset(&ima_khdr, 0, sizeof(ima_khdr));
>> +	ima_khdr.version = 1;
>> +
>> +	return 0;
>> +}
>> +
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>>   {
>>   	struct ima_queue_entry *qe;
>> -	struct seq_file file;
>> -	struct ima_kexec_hdr khdr;
>>   	int ret = 0;
>>   
>> -	/* segment size can't change between kexec load and execute */
>> -	file.buf = vmalloc(segment_size);
>> -	if (!file.buf) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> +	if (!ima_kexec_file.buf) {
>> +		pr_err("%s: Kexec file buf not allocated\n",
>> +			__func__);
>> +		return -EINVAL;
>>   	}
>>   
>> -	file.size = segment_size;
>> -	file.read_pos = 0;
>> -	file.count = sizeof(khdr);	/* reserved space */
>> +	/*
>> +	 * Ensure the kexec buffer is large enough to hold ima_khdr
>> +	 */
>> +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
>> +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
>> +			__func__);
>> +		ima_clear_kexec_file();
>> +		return -ENOMEM;
>> +	}
> 
> Is this necessary?
>   
Yeh. It's an overkill. Will remove.

>> -	memset(&khdr, 0, sizeof(khdr));
>> -	khdr.version = 1;
>> +	/*
>> +	 * If we reach here, then there is enough memory
>> +	 * of size kexec_segment_size in ima_kexec_file.buf
>> +	 * to copy at least partial IMA log.
>> +	 * Make best effort to copy as many IMA measurements
>> +	 * as possible.
>> +	 */
> 
> Suggestion:
> 
> /* Copy as many IMA measurements list records as possible */
> 
That's a much cleaner comment. Will update.

~Tushar

>>   	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>> -		if (file.count < file.size) {
>> -			khdr.count++;
>> -			ima_measurements_show(&file, qe);
>> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>> +			ima_khdr.count++;
>> +			ima_measurements_show(&ima_kexec_file, qe);
>>   		} else {
>> -			ret = -EINVAL;
>> +			ret = EFBIG;
>> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
>> +				__func__);
>>   			break;
>>   		}
>>   	}
>>   
>> -	if (ret < 0)
>> -		goto out;
>> -
>>   	/*
>>   	 * fill in reserved space with some buffer details
>>   	 * (eg. version, buffer size, number of measurements)
>>   	 */
>> -	khdr.buffer_size = file.count;
>> +	ima_khdr.buffer_size = ima_kexec_file.count;
>>   	if (ima_canonical_fmt) {
>> -		khdr.version = cpu_to_le16(khdr.version);
>> -		khdr.count = cpu_to_le64(khdr.count);
>> -		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>> +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
>> +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
>> +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
>>   	}
>> -	memcpy(file.buf, &khdr, sizeof(khdr));
>> +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
>>   
>>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
>> -			     file.buf, file.count < 100 ? file.count : 100,
>> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
>> +			     ima_kexec_file.count : 100,
>>   			     true);
>>   
>> -	*buffer_size = file.count;
>> -	*buffer = file.buf;
>> -out:
>> -	if (ret == -EINVAL)
>> -		vfree(file.buf);
>> +	*buffer_size = ima_kexec_file.count;
>> +	*buffer = ima_kexec_file.buf;
>> +
>>   	return ret;
>>   }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
