Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC3DC5AC80
	for <kexec@archiver.kernel.org>; Sun,  9 Aug 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGps4MOcSrgLaFu/fkgq+RUAkbvSHqTgXNmvCcr5foI=; b=PwLskDW/z4g+zefr2Vb8uAdhPT
	vnr1n846w4aE3l0rK9APMrdJHbl6Z4K8LwBH+EKdBi3Vo2RpJghIJcIH62FMmD4hQ39Bllf8nkIJ6
	GbTMU2YQFy5ydEAD+54ajViTHel3tbW3zjU8MTH3aNoFeu/G01yfnMmkEhWl0FUqbgjmCtkyxfF5l
	DJmfUXvz4hL/GVgPKL20T97SKlV0s8+5M5yvd9U6hzUs5J88X+4+UQqlvCh9JRQKIAD1i5UP/+Hc2
	uUB0rYVcVFd+znIo4reMJuVSVLioJOWbE1usXUHmQMNkOzgyDw0CcuT+tvi3zw9rPSltB0H1kJ4eN
	uBddBgVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt29X-0000000AGT1-0iqv;
	Sun, 09 Aug 2026 11:57:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt29U-0000000AGSd-2ZXJ
	for kexec@lists.infradead.org;
	Sun, 09 Aug 2026 11:57:17 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679937lT2477197;
	Sun, 9 Aug 2026 11:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YGps4M
	OcSrgLaFu/fkgq+RUAkbvSHqTgXNmvCcr5foI=; b=nTB3dV5we5LL+RtR3OCpzw
	jIxtpvKYm3NHOu3MtsT4TXMSkeQZYKrEjIKCCwJ+YmPF1egIw1EhyYC8XUEvESjw
	/OX7LfdrplN2V7iPY8L3LbvpT6yBITCxOJpf1wM+8rNWcaCbQD8NN1aHVMgz5nLX
	wiFtdiuid2FIUPkJxxI1TEFt+5fj0GNync7biJ/dBBP8nYaKevRAwjoV2p8Bzbv6
	j0boGBQGcW42Q68viNUEkWsqtS+K4sWPMqZXQeGt2SkMi61y6uw0Oj2Qyj6rdA2m
	zRBJY0W1sAjfiU9I8AULm5TOyn8PolUHaDnRWmROpwMzJk90O3Kt2liLyLKgtSXQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2ktx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 11:57:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679BuKeO027937;
	Sun, 9 Aug 2026 11:57:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vsajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 11:57:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679Bv6ow24314512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 11:57:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19ECB20040;
	Sun,  9 Aug 2026 11:57:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2208720043;
	Sun,  9 Aug 2026 11:57:03 +0000 (GMT)
Received: from [9.39.25.10] (unknown [9.39.25.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 11:57:02 +0000 (GMT)
Message-ID: <91f569f4-c370-49f1-8656-245f35793199@linux.ibm.com>
Date: Sun, 9 Aug 2026 17:26:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] crash_dump: Disallow writing to dm-crypt
 configfs during kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-4-coiby.xu@gmail.com>
 <3010bbe1-844f-4513-9941-f4e92e581769@linux.ibm.com> <anQVIaMHXEx8hvep@Rk>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <anQVIaMHXEx8hvep@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a786b15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=zrT50iyv3olL9t5bMM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x9-rDdUqDJlV8rtRGkQdzsEpCjBBLY20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDEwMiBTYWx0ZWRfX/jAzcV/xcWFD
 KBPbJo2IJY5cu5COOJ1RxUQL7kCHnZHUY6shV4cR8bFAwBMrAis8eO/c4a9j5YdvclF6wGVoIFV
 5OKI+yeB4j/4n8YnKOntVKrQLbXaNHSWRN3fYrY6pNTh2JnNOBWKxzJi7V9X/zgNeZSs/X8P/9Z
 wtI/W4SLJlF4UbeEXWFmXLRIiB/jMCTtLTlp46uAWYSgU1KI6Gsds9Dr0larJJQrZ1Ak57RSomW
 KHVzweJHZBI5y/a2ZG65kSvK9G6Qs4lSq0Z3tIaGvmfZ8LombmqcunG3kU3+uIhmSFkT1P5ChjE
 0tp1ad+lVlc90pGzK5agbT8TfRlTOKlQO4+eBVP+M+vdD2ne+B6wbfMUzhVxJEgzLQES0nOMLAX
 uHHdWdRBM2RiekRMry79sqVCyMGWCTVZ8n7+N7w5FtnJccPLyM4z2IszmcfIKC0VyOIHqI2WLwW
 lpebYon+6K1WygTTsaw==
X-Proofpoint-ORIG-GUID: lkcyhgmkE8tJw3pcVRjqftByT8wz0ifo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDEwMiBTYWx0ZWRfX/H9fjLg4A/2v
 +3WeDuc1FN0SpuBmdBig9TRt0g4Bn1HprRW+l1ood+BnaDQHz5KCyEScPvllsMguLa7O6YOw+Fm
 QW+6c9o7gHBTCAT44Er/Xsoze5uaFdI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_045716_804625_5DBC330C 
X-CRM114-Status: GOOD (  37.25  )
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

Hello Coiby,

On 06/08/26 10:50, Coiby Xu wrote:
> On Wed, Aug 05, 2026 at 04:00:51PM +0530, Sourabh Jain wrote:
>>
>>
>> On 29/07/26 09:06, Coiby Xu wrote:
>>> If writing to the configfs group happens concurrently during
>>> kexec_file_load syscall, it may lead to the following issues,
>>>   - buffer overflow if dm-crypt keys are added after allocation
>>>   - stale total_keys if dm-crypt keys are removed during iteration
>>>   - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>>     set true
>>>
>>> So hold config_keys_subsys.su_mutex for the entire sequence during the
>>> kexec_file_load syscall to ensure a consistent snapshot.
>>>
>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>> reserved memory")
>>> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>> ---
>>>  kernel/crash_dump_dm_crypt.c | 23 +++++++++++++++++++++--
>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c 
>>> b/kernel/crash_dump_dm_crypt.c
>>> index 4335b6cb1fc4..d2e66c6fe6f3 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -293,6 +293,7 @@ static ssize_t config_keys_reuse_show(struct 
>>> config_item *item, char *page)
>>>  static ssize_t config_keys_reuse_store(struct config_item *item,
>>>                         const char *page, size_t count)
>>>  {
>>> +    struct mutex *lock;
>>>      bool val;
>>>      int r;
>>> @@ -302,8 +303,12 @@ static ssize_t config_keys_reuse_store(struct 
>>> config_item *item,
>>>          return -EINVAL;
>>>      }
>>> +    lock = &to_config_group(item)->cg_subsys->su_mutex;
>>> +    mutex_lock(lock);
>>
>> Is this lock only protecting against races between key reuse and 
>> kexec_file_load(),
>
> The lock here is to protect against races between key reuse and
> kexec_file_load.
>
>> or does it also handle the case where a new key is added during key 
>> reuse or
>> kexec_file_load() is running?
>
> For the cases where a key is added/deleted, configfs will automatically
> take care of them because it will acquire mutex lock automatically.
>
>>
>> If it is only intended to protect key reuse versus kexec_file_load(), 
>> why can't we use
>> the kexec lock instead?
>>
>> The reason I'm asking is that, in upcoming patches, the key reuse 
>> path accesses
>> kexec_crash_image properties and the crash reserved region directly. 
>> Doing so
>> without taking the kexec lock (using kexec_trylock()) could lead to 
>> race conditions.
>
> After comparing the kexec lock approach with the configfs mutex lock
> approach, I think the latter is a simpler solution because
> 1. the kexec lock is non-blocking and we have to repeatedly try until the
>    lock get acquired. So it means user space has to make changes as
>    well.
>
> 2. configfs already acquires the mutex lock automatically for
>    creating/deleting configfs items. So if we use configfs mutex lock,
>    it means one less place to use the lock.
>
> In config_keys_reuse_store, kexec_crash_image will be checked before
> accessing its properties and the crash reserved region. Can you
> elaborate on what the race conditions are? Will acquiring the lock
> before accessing kexec_crash_image properties and the crash reserved
> region help protect against these races?
>
> In theory, the kexec lock can be a more robust approach. But considering
> only root can write to the crash dm-crypt keys configfs and load kdump
> image, I'm not sure it's necessary to adopt a bit more complex solution.

The reuse function accesses the kexec crash image properties and crashkernel
memory without taking the kexec lock. This could lead to race conditions or
other problems.

Since we need to take the kexec lock anyway, my suggestion is: can we 
use the
kexec lock instead of cg_subsys->su_mutex if the purpose of the mutex is 
only
to synchronize reuse with kexec_file_load?

As we know, kexec_file_load already runs under the kexec lock. So using the
same lock should provide the required synchronization.

- Sourabh Jain


>
>
>>
>> - Sourabh Jain
>>> +
>>> +    r = -EINVAL;
>>>      if (kstrtobool(page, &val) || !val)
>>> -        return -EINVAL;
>>> +        goto unlock;
>>
>> The jump above skips setting count, causing the function to return 
>> count instead of -EINVAL.
>> Is this really intended?
>
> Thanks for catching this issue! In the end of the function, r instead of
> count should be returned.
>
>>
>>>      if (is_dm_key_reused) {
>>>          pr_info("Already got dm-crypt keys, please continue with 
>>> kexec_file_load syscall\n");
>>> @@ -311,11 +316,15 @@ static ssize_t config_keys_reuse_store(struct 
>>> config_item *item,
>>>          r = get_keys_from_kdump_reserved_memory();
>>>          if (r) {
>>>              pr_warn("Failed to get dm-crypt keys from reserved 
>>> memory\n");
>>> -            return r;
>>> +            goto unlock;
>>>          }
>>>          is_dm_key_reused = true;
>>>      }
>>> +    r = count;
>>> +
>>> +unlock:
>>> +    mutex_unlock(lock);
>>>      return count;
>>>  }
>>> @@ -421,6 +430,8 @@ static int build_keys_header(void)
>>>      return 0;
>>>  }
>>> +static bool mutex_acquired;
>>> +
>>>  int crash_load_dm_crypt_keys(struct kimage *image)
>>>  {
>>>      struct kexec_buf kbuf = {
>>> @@ -432,6 +443,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>      };
>>>      int r = 0;
>>> +    mutex_lock(&config_keys_subsys.su_mutex);
>>> +    mutex_acquired = true;
>>> +
>>>      if (key_count <= 0) {
>>>          kexec_dprintk("No dm-crypt keys\n");
>>>          return 0;
>>> @@ -481,6 +495,11 @@ void 
>>> kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>>          kfree_sensitive(keys_header);
>>>          keys_header = NULL;
>>>      }
>>> +
>>> +    if (mutex_acquired) {
>>> +        mutex_unlock(&config_keys_subsys.su_mutex);
>>> +        mutex_acquired = false;
>>> +    }
>>>  }
>>>  static int __init configfs_dmcrypt_keys_init(void)
>>
>


