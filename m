Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74FCD484E
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFCCsDLEOgAMO6tGt9iY9s0ku8mMhuEh+J3wG25mLZM=; b=uV1to38TbFRpjU9/MV3/vSy9cl
	wNkXRXKyTei3R/SVEoj+pwa6C5XvItgI2fVCozVrGZWM5REUaFzbJ5sova3MBDispiOghlMzuiPQK
	Pq7w0p7mQXNw0yCA3n0yPJva0p2t4Du+9TJlw5ap5fJRQGvu7vTFDDze9ZLj5J/GeE3q1HQT2F3z0
	GcW46tRvBgT5TcEYj+ANJvuHbGTmM7yB+EbFdD2LBH/ofTAqgtzznUPCCaHY4t//tGbJLU/FHQVMa
	7ubreKP8A1ivrAgmDjZWJG4HBmAshklqBC7P13hxsKNYx4KJf21ub1jrsJf3AHGKmTcYujmHw2Y1v
	Bu11DGCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMft6-0000000FgJu-0kfc;
	Tue, 12 May 2026 05:42:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMft3-0000000FgJ7-1pqb
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 05:42:34 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7BjX3179810;
	Tue, 12 May 2026 05:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FFCCsD
	LEOgAMO6tGt9iY9s0ku8mMhuEh+J3wG25mLZM=; b=pzsOhlfCGweR0/sur6lf3T
	wooNIUDu1ES2xnhXS64a6mwCFVoEnWuI5ycmXXHXcjbJUYgDRKb4nwKbVO/VRA8x
	2eyuC83AANjL4gvhBtI7o11KCwCWHOfLdKMYqSAGO3wpljE0KiwkxWUaaRTtF2K6
	uqCYVIPFh6SP8jFNjPcmS7DMlWKT2mKshYSnzMjVY0N8KtPI6L1guga1MZgiOZEQ
	NBOlPQdJ2qP1F/QKJ1uoMCyelm8zfeGHsr8KGThVbYgNZBUUfyp+A3RBA5U3jQna
	7KMF7fk50RVqeWejjWvNyLh66Zthd46bxzsnct8UuIlW1SK7Sw3b+5704qzSU29Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6hfxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 05:42:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C5dZmo019809;
	Tue, 12 May 2026 05:42:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfghsq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 05:42:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C5gMJq51970356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 05:42:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C42E02004F;
	Tue, 12 May 2026 05:42:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 838E820040;
	Tue, 12 May 2026 05:42:18 +0000 (GMT)
Received: from [9.124.208.212] (unknown [9.124.208.212])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 05:42:18 +0000 (GMT)
Message-ID: <54a27f47-a7cd-458c-9b27-7b84949aa453@linux.ibm.com>
Date: Tue, 12 May 2026 11:12:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-3-coiby.xu@gmail.com>
 <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com> <af3RQa8aU_F79XOw@Rk>
 <e460f764-997e-4a63-be7d-1ceb5a503d32@linux.ibm.com> <af_JKzEAwp9r-ZSS@Rk>
Content-Language: en-US
In-Reply-To: <af_JKzEAwp9r-ZSS@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a02bdc1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bCPfndkRAAAA:20
 a=VLc2VSdLAAAA:20 a=VnNF1IyMAAAA:8 a=kIIyVDrox-PJfdVzT40A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: daGrJjsCzVweiSsNvQluvQUSPCGGhlyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1MiBTYWx0ZWRfX7R2t85ZBEbsb
 91S+aV7h/D9NomY68iawTsJXV6sdrQDKXFBcP8YWLNDN6w3hDLC63tJBbhGHWlz9hx2TLk7Pozy
 /6mwuLYG7lRHpWQn2hop9PDbo/aGPzCLEQQtymj176Opg8Xu1hbaqV01hAUo30+nB1+EGM5+tGR
 /Ge/cA6YAwSs6E3oB5jxej0NntHHvShKG18nuGUH+x5aM+ixpEf1eg0hwYwrrKP/zpIL9e8v61P
 +t8zVTDbwK3KHk9nKMHQwfMm+y9zgCEGHZ5w7PB7tezooEIbLz76a2wecrrAXrbZTe+Buwzenra
 9fwxGuMPKxMkA/TRP/hMzhWr45SG1BXm+aKnGJFIkbehC6/+ZwqXVQyQVq1hfC73DtxDT2WRuIs
 /zlXwTpNbLKBJtciKLDrFejPVZJHtOeeTn1gXu5gSWtIcC2Q+1taKB8KBPgOzjKlKBQlJ9dtnPS
 PYmGNGZMJmPbVT61Y8w==
X-Proofpoint-ORIG-GUID: lg4H75jvVm6PogADkUn2Zh3kRdjK3qkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_224233_607750_A137F8F8 
X-CRM114-Status: GOOD (  45.65  )
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



On 10/05/26 05:44, Coiby Xu wrote:
> On Sat, May 09, 2026 at 01:36:59AM +0530, Sourabh Jain wrote:
>>
>>
>> On 08/05/26 18:03, Coiby Xu wrote:
>>> On Wed, May 06, 2026 at 05:58:31PM +0530, Sourabh Jain wrote:
>>>> Hello Coiby,
>>>
>>> Hi Sourabh,
>>>
>>> Thanks for reviewing the patch!
>>>
>>>>
>>>> On 02/05/26 05:13, Coiby Xu wrote:
>>>>> If kexec_add_buffer somehow fails, keys_header will be freed. 
>>>>> Depending
>>>>> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>>> following two problems if the kexec_file_load syscall is called 
>>>>> again,
>>>>>   1. Double free of keys_header if reuse=false
>>>>>   2. UAF of keys_header if reuse=true
>>>>>
>>>>> To address these problems and also make it easier to reason about the
>>>>> code, keep two invariants,
>>>>>   1. keys_header will always be freed at the end of kexec_file_load
>>>>>      syscall except during kdump image unloading for CPU/memory
>>>>>      hot-plugging support
>>>>>   2. There will always be valid keys_header if reuse=true
>>>>>
>>>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>>>> reserved memory")
>>>>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for 
>>>>> CPU/memory hot-plugging")
>>>>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> [...]
>>>
>>>>
>>>>
>>>>
>>>>>          kexec_dprintk(
>>>>>              "dm-crypt keys haven't be saved to crash-reserved 
>>>>> memory\n");
>>>>>          return -EINVAL;
>>>>>      }
>>>>> -    if (kstrtobool(page, &is_dm_key_reused))
>>>>> +    if (kstrtobool(page, &val) || !val)
>>>>>          return -EINVAL;
>>>>
>>>> Why can’t we allow the user to set is_dm_key_reused = false and 
>>>> free the
>>>> key_header? That way, the next kdump kernel load will recreate the
>>>> For example, a user may add more keys and want the new keys to be 
>>>> included
>>>> in the kdump image from next kdump kernel load.
>>>
>>> Personally, I want to limit the reuse configfs API to the case of
>>> CPU/memory hotplug thus to make the code simpler. And for the case of a
>>> user adding more keys, I don't think there is a need for using the 
>>> reuse
>>> API.
>>
>>
>> Yes, there is no need for it, but I think the user is forced to use
>> key_reuse because once it is set to true, it cannot be set back to 
>> false.
>>
>> For example, the kdump kernel is loaded using the kexec_load system call
>> and reuse is set to true. The user may later add a couple of new keys 
>> and
>> want to include them in the kdump image.
>>
>> I think the next kdump kernel load will reuse the key_headers even 
>> though
>> the user does not want it. Hence I see a problem here.
>>
>> Well user can load kdump kernel a second time, and at that point the
>> keys will get updated. But do we really want this behavior?
>
> key_reuse won't be set to true automatically unless an user explicitly
> does so. Thus I don't think it's forcing users to use it. And by design
> key_reuse is set only for the hotplug case.

Oh, I got it now. So, on kdump kernel load, key reuse will always be
set to false.

And when the user wants to reuse the key, they can just set the key reuse to
true and reload the kdump kernel. After the reload, key reuse will be set to
false again by the kernel itself.

Thanks for clearing up my doubts.

>
> For the cause of loading kdump kernel again, I don't see the need to set
> key_reuse.
>
> I also had the urge to allow writing false to the reuse API and even
> implemented it. But later I deleted the code to avoid over-engineering
> because I'm not sure how it is supposed to be used. Besides this reuse
> API already makes it much harder to reason about the code. Shall all
> architectures implement CONFIG_CRASH_HOTPLUG, I'll delete it immediately
> so crash_dump_dm_crypt.c can be much easier to maintain.
>
>>
>>
>>>
>>>>
>>>>
>>>>> -    if (is_dm_key_reused)
>>>>> -        get_keys_from_kdump_reserved_memory();
>>>>> +    if (is_dm_key_reused) {
>>>>> +        pr_info("Already got dm-crypt keys, please continue with 
>>>>> kexec_file_load syscall\n");
>>>>> +    } else {
>>>>> +        r = get_keys_from_kdump_reserved_memory();
>>>>> +        if (r) {
>>>>> +            pr_warn("Failed to get dm-crypt keys from reserved 
>>>>> memory\n");
>>>>> +            return r;
>>>>> +        }
>>>>> +        is_dm_key_reused = true;
>>>>> +    }
>>>>>      return count;
>>>>>  }
>>>>> @@ -366,9 +384,6 @@ static int build_keys_header(void)
>>>>>      struct config_key *key;
>>>>>      int i, r;
>>>>> -    if (keys_header != NULL)
>>>>> -        kvfree(keys_header);
>>>>> -
>>>>>      keys_header = kzalloc(get_keys_header_size(key_count), 
>>>>> GFP_KERNEL);
>>>>>      if (!keys_header)
>>>>>          return -ENOMEM;
>>>>> @@ -412,7 +427,7 @@ int crash_load_dm_crypt_keys(struct kimage 
>>>>> *image)
>>>>>          .top_down = false,
>>>>>          .random = true,
>>>>>      };
>>>>> -    int r;
>>>>> +    int r = 0;
>>>>>      if (key_count <= 0) {
>>>>> @@ -421,14 +436,15 @@ int crash_load_dm_crypt_keys(struct kimage 
>>>>> *image)
>>>>>      }
>>>>>      if (!is_dm_key_reused) {
>>>>> -        image->dm_crypt_keys_addr = 0;
>>>>>          r = build_keys_header();
>>>>> -        if (r) {
>>>>> -            pr_err("Failed to build dm-crypt keys header, 
>>>>> ret=%d\n", r);
>>>>> -            return r;
>>>>> -        }
>>>>> +        if (r)
>>>>> +            goto out;
>>>>>      }
>>>>> +    /*
>>>>> +     * keys_header will be copied to reserver memory later and 
>>>>> then be
>>>>> +     * cleaned up at the end of kexec_file_load syscall
>>>>> +     */
>>>>>      kbuf.buffer = keys_header;
>>>>>      kbuf.bufsz = get_keys_header_size(key_count);
>>>>> @@ -438,18 +454,33 @@ int crash_load_dm_crypt_keys(struct kimage 
>>>>> *image)
>>>>>      r = kexec_add_buffer(&kbuf);
>>>>>      if (r) {
>>>>>          pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>>>> -        kvfree((void *)kbuf.buffer);
>>>>> -        return r;
>>>>> +        goto out;
>>>>>      }
>>>>> +
>>>>>      image->dm_crypt_keys_addr = kbuf.mem;
>>>>>      image->dm_crypt_keys_sz = kbuf.bufsz;
>>>>>      kexec_dprintk(
>>>>>          "Loaded dm crypt keys to kexec_buffer bufsz=0x%lx 
>>>>> memsz=0x%lx\n",
>>>>>          kbuf.bufsz, kbuf.memsz);
>>>>> +out:
>>>>> +    is_dm_key_reused = false;
>>>>>      return r;
>>>>>  }
>>>>> +void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>>>> +{
>>>>> +    /*
>>>>> +     * For CPU/memory hot-plugging, the kdump image will be 
>>>>> reloaded. Prevent
>>>>> +     * keys_header from being cleaned up during unloading when
>>>>> +     * is_dm_key_reused=true
>>>>> +     */
>>>>> +    if (!is_dm_key_reused) {
>>>>> +        kfree_sensitive(keys_header);
>>>>> +        keys_header = NULL;
>>>>
>>>> Since crash_load_dm_crypt_keys() sets is_dm_key_reused = false, 
>>>> keys_header will
>>>> always be released here, right? Then why is the above free under an 
>>>> if condition?
>>>
>>> Thanks for raising the question! This is to prevent "kexec -u" from
>>> cleaning up keys_headers because kexec_file_post_load_cleanup_dm_crypt
>>> will also be called during "kexec -u". Without the if condition,
>>> keys_headers will not be available during reloading.
>>
>> Agree. But do we really run kexec -u and then kexec -p to reload the 
>> kdump
>> kernel on hotplug events? I am under the impression that the udev rule
>> simply reloads the kdump kernel using kexec -p without explicitly 
>> running
>> kexec -u.
>
> Yes, "kdumpctl reload" will be called during hotplug events 
> https://github.com/rhkdump/kdump-utils/blob/main/kdump-udev-throttler#L51
> So there is explicitly unloading first and then reloading.

Oh ok, then it makes sense.

BTW, I got the impression about not using kexec -u on kdump service reload
from the repo below:

https://github.com/openSUSE/kdump/blob/master/70-kdump.rules.in [Udev Rule]
https://github.com/openSUSE/kdump/blob/00979dc621ba35285b85bf55917a5b0dfd273114/init/load-once.sh#L22 
[Wrapper to load once for multiple hotplug]
https://github.com/openSUSE/kdump/blob/00979dc621ba35285b85bf55917a5b0dfd273114/init/load.sh#L312 
[load kdump script]


- Sourabh Jain
>
>>
>> And if that is the case, I think we should clean key_headers on kexec 
>> -u.
>
> Most of the cases is_dm_key_reused is false thus keys_header will be
> cleaned on kexec -u.
>
>>
>> - Sourabh Jain
>>
>>
>>>
>>>>
>>>> IIUC, for the case where CONFIG_CRASH_HOTPLUG is not enabled, this 
>>>> is how key
>>>> restore works:
>>>>
>>>> After loading the kdump kernel for the first time, the state of the 
>>>> variables is:
>>>>
>>>> is_dm_key_reused = false
>>>> keys_header = NULL
>>>>
>>>> For example, if 2 CPUs are hot-removed and kdump is reloaded twice:
>>>>
>>>> Then the sequence of operations needed to ensure the loaded keys 
>>>> can be reused is:
>>>>
>>>> Udev rule triggered on the 1st CPU hotplug:
>>>> echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>>> Restore the key header from the reserved area
>>>> Reload the kdump service/kernel
>>>>
>>>> Udev rule triggered on the 2nd CPU hotplug:
>>>> echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>>> Restore the key header from the reserved area
>>>> Reload the kdump service/kernel
>>>>
>>>> What I don’t understand is the need to restore the key header from 
>>>> crashkernel
>>>> memory for every hotplug operation.
>>>
>>> I think there is no easy way to tell if there is another hotplug and
>>> considering hotplug is a rare event. So I guess it's OK to restore the
>>> key headers for every hotplug operation.
>>
>>
>


