Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F9CC369A8
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmfJAaDZRcuR0IspL/CV2qpL+dgL7BxJ5z1ZXihUDxU=; b=1KAVz3qXNocfXfDy4jbohoIktO
	mU7Rq/4Poq5v1aeC9dSSHToSF/3yb5C2FZNUacczmpHdalzmHodAgZpHeQ/mKfrGFiYHltUChZ5sg
	pr3ww72bOh1LXeKN/IUKXHtfpg7Q0bwmG+Ok9UCA+5lLplQjI3Z7PwGWhMBXtE8t3TMf542u21v8V
	EITiX0orhcpJR4YtmdEkcYGX4ZvjEfumFGcnwCC0eS7U6xigYZB0aQRPRO4m6cJIi/adgE1iT0J3v
	BT16E16Q62FH+TdaQmo+Qwkb4wx/qQQivdCzJZWgKpVAG0H3Va/Yjd2EzFv63hLtHT89Vx8gajDr5
	FdiR90Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2siM-0000000AoZg-0tLs;
	Thu, 10 Apr 2025 14:17:10 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2shB-0000000AoOQ-3eLp
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 14:15:59 +0000
Received: from [100.70.200.180] (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 680852113E88;
	Thu, 10 Apr 2025 07:15:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 680852113E88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294556;
	bh=XmfJAaDZRcuR0IspL/CV2qpL+dgL7BxJ5z1ZXihUDxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n7LJlLUTIHoUKqUDPHHPpZzH1WJi5CQ8KlXno+uTZvwvdN8pM4Z+WPo2tZqF/BKwG
	 0ktcd7KAKLp+gQVRrUeYUhJAPVHUk0l+0DtBVoLoHkF3BF8hLT8JYqFQ3Yui4nCDQg
	 sKieQ7MXh4X0Af+AcESsv9OuyreI5id5K4RRqudY=
Message-ID: <98c63e22-b9f7-40b9-90d0-aa67534f9107@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:15:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] ima: kexec: move IMA log copy from kexec load to
 execute
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-7-chenste@linux.microsoft.com>
 <96ae5a8efbcb894e096881f1dd7a4939ce0a9490.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <96ae5a8efbcb894e096881f1dd7a4939ce0a9490.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_071557_960602_92E9A6A3 
X-CRM114-Status: GOOD (  22.65  )
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

On 4/8/2025 9:17 AM, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot. Due to
>> missed measurements that only occurred after kexec 'load', this function
>> needs to be called during kexec 'execute'.
> Re-use the motivation from 5/9 (with tweak):
>
> The IMA log is currently copied to the new kernel during kexec 'load' using
> ima_dump_measurement_list(). However, the IMA measurement list copied at kexec
> 'load' may result in loss of IMA measurements records that only occurred after
> the kexec 'load'.
>
> And finish the paragraph with:
> Move the IMA measurement list log copy from kexec 'load' to 'execute'.
>
>> Make the kexec_segment_size variable a local static variable within the
>> file, so it can be accessed during both kexec 'load' and 'execute'.
>>   
>> Implement the kexec_post_load() function to be invoked after the new kernel
>> image has been loaded for kexec. Instead of calling machine_kexec_post_load()
>> directly from the kexec_file_load() syscall, call kexec_post_load(), which in
>> turn calls machine_kexec_post_load() to maintain the original image processing.
> Define kexec_post_load() as a wrapper for calling ima_kexec_post_load() and
> machine_kexec_post_load().  Replace the existing direct call to
> machine_kexec_post_load() with kexec_post_load().
>
>>   
>> Invoke ima_kexec_post_load() within the kexec_post_load() API only for kexec
>> soft reboot scenarios, excluding KEXEC_FILE_ON_CRASH.
> "Don't call ima_kexec_post_load() on KEXEC_FILE_ON_CRASH" would be listed in the
> Changelog if it changed, not here in the patch description.  Please remove.
>
>>   
>> Register a reboot notifier for the ima_update_kexec_buffer() API within
>> ima_kexec_post_load() to ensure it is called upon receiving a reboot
>> notification.
> Registering the reboot notifier was done in "[PATCH v11 5/9] ima: kexec: define
> functions to copy IMA log at soft boot", not here.  Please remove.
>
>>   
>> Move the ima_dump_measurement_list() call from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer() to copy the IMA log at the kexec 'execute' stage.
> This information was already stated in the first paragraph as part of the
> motivation for the patch.  Please remove.
>
>>   
>> When there is insufficient memory to copy all the measurement logs, copy as
>> much of the measurement list as possible.
> Is this comment still applicable to this patch?
>
> Please review your patch descriptions before posting, making sure that
> everything is still applicable.
>
> thanks,
>
> Mimi

Hi Mimi,

Thanks for your comments. I will update in next version.

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



