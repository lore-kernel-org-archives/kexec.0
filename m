Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1510EC36005
	for <kexec@archiver.kernel.org>; Tue, 25 Mar 2025 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yu+zl6twDuJmGCQvb+BJhKb1ZJUDVREmR4BMuDWngzo=; b=dyU2lB4/W86zReCDUknjAJDpxx
	2Dy7qoOYzfXbyXgLOCIIQteptXgHmxe+/3fwYSs9wnW75NCt4UHKvDZLe9Hipt6ZM7fGO7K/q//5K
	Lgx3GcqMFkfTM0qx5TVfvzR7TyKhwwb6W2wr9LCA4opV4P3LTpAozvwESGu0QfhtRNVBs6DiwAi+W
	UO6LFf3Jvu99tjDU1xFryp7eXmzLoG48ZSFbBRAT1YJpiXAUldX4vUANEe0/MymhPUJnrlkRbIODi
	jUvFnaQZAx5GHhuTwxP2+fJsvVALWYHuUBX8GHJ+69Qt9ShhfWfeop6sPgbk98ZeQ19vBCCYHDS/I
	hnW5P5UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txCkO-00000007AeS-3LQW;
	Tue, 25 Mar 2025 22:27:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txCkN-00000007Adu-0MKe
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 22:27:48 +0000
Received: from [10.17.64.173] (unknown [131.107.8.109])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AD04204E596;
	Tue, 25 Mar 2025 15:27:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AD04204E596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742941665;
	bh=yu+zl6twDuJmGCQvb+BJhKb1ZJUDVREmR4BMuDWngzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ys7MDF98d7F6l7lO9UCnXF/KFQKz7cXYNKkmxX7+w/ntWkDq23pjCzvFEabp0ldlI
	 yZr6ADwe2o1JSR5oVDNsw3uMxSyxVLVT+h+iKf2UIUheJgaUP+FqcD3CVAFghPZ4WW
	 GBj5l4/HREsMBvqHdkzChu8fcboRIvH/w57jXdeU=
Message-ID: <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
Date: Tue, 25 Mar 2025 15:27:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_152747_156052_1A9FF82B 
X-CRM114-Status: GOOD (  10.67  )
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

On 3/24/2025 4:00 AM, Baoquan He wrote:
> On 03/21/25 at 09:23am, steven chen wrote:
>> On 3/19/2025 7:06 PM, Baoquan He wrote:
>>> On 03/17/25 at 06:04pm, steven chen wrote:
>>> ...snip...
>>>> ---
>>>>    kernel/kexec_file.c                | 10 ++++++
>>>>    security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>>>>    2 files changed, 40 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index 606132253c79..ab449b43aaee 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>>>>    }
>>>>    #endif
>>>> +static void kimage_file_post_load(struct kimage *image)
>>>> +{
>>>> +#ifdef CONFIG_IMA_KEXEC
>>>> +	ima_kexec_post_load(image);
>>>> +#endif
>>>> +}
>>>> +
>>>>    /*
>>>>     * In file mode list of segments is prepared by kernel. Copy relevant
>>>>     * data from user space, do error checking, prepare segment list
>>>> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    	kimage_terminate(image);
>>>> +	if (!(flags & KEXEC_FILE_ON_CRASH))
>>>> +		kimage_file_post_load(image);
>>> machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
>>> we should use it to do things post load, but not introducing another
>>> kimage_file_post_load().
>> Hi Baoquan,
>>
>> Could you give me more detail about this?
> I mean machine_kexec_post_load() is the place where post load operations
> are done, including kexec_load and kexec_file_load. There's no need to
> specifically introduce a kimage_file_post_load() to do post load
> operaton for kexec_file_load.

Hi Baoquan,

Updating the machine_kexec_post_load() API to carry flags would indeed 
require changes to multiple files. This approach involves the condition 
check if (!(flags & KEXEC_FILE_ON_CRASH)) and ensuring that the flags 
are properly passed and handled across the relevant file

if just adding a API kimage_file_post_load() here, it is much easy and 
clean, right?

How do you think?

Thanks,

Steven


