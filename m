Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC5FC61DB9
	for <kexec@archiver.kernel.org>; Sun, 30 Aug 2026 05:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2I2ajYWCqKEQ9Cd+CeMHNLEbWOrhmNEJMlpAnHbushI=; b=289Dnh/54SWWr67cDmDPtVISSG
	nIjr69TCIIUmipI78rOe2GXWYMWHV6OPVFuFsYNuPKdfconvVri4nsMhtQsswOVBXmzj8ZQboMi42
	DFUMe8+D2E+4+XA30trjl4GRKTiqG/urn4QVK51wuLEj+UC0k951bg6vKtgv49V7ZM7sRjcQH2rI0
	JI+2cJXapI9oOMYzB6+KmnpLRuwr+v8o+7fkFaz+vCDvs/TdzxB6cdSTz6gsE+5wRj/RT5zeENj75
	jM2pQRcAT1PWBzWJjLoY00pZbfxMN7IVzK/z8lmSBBnRbp0yauAQJV3zLOU9OyHpGULzSaDRegdrf
	pyNO+kSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0YEq-00000007Vb0-3FYu;
	Sun, 30 Aug 2026 05:37:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0YEl-00000007Vad-46Zi
	for kexec@lists.infradead.org;
	Sun, 30 Aug 2026 05:37:49 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67U2VgQj2400412;
	Sun, 30 Aug 2026 05:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2I2ajY
	WCqKEQ9Cd+CeMHNLEbWOrhmNEJMlpAnHbushI=; b=OJw5zDp5xewtqTZiC3YOmZ
	tTYz/HMEs/r+OA6YRSQXIZvDiAZsYA4mMkW+Om89XUfCWBtb+47GJM93DYllGCsT
	Qx8FkRyaNxAJaMjt0B/vN08AWRXuX7h7Dxui6azNRj8+aUMl2Rl+Fftb90g/0K2q
	Qi6I01bJHS28F8xCEqUfF2HItk5TZhaOmjVhFWdKrSdS2JDs/Lhbp5Zk/w7fNddi
	8ycukp2BENTPIVrICgFrDU/Yx3wZ7em0xmdiMcmoGlDdUPmTi+i4KVHrgiKb3u9u
	DrKJ6AJTWshuPSgQyWPYxRRsrhBbBBvLEsYqTmdxFvsXTsXTwbA3/uiY4yhMnZcA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx53nct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 05:37:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67U5QItJ020171;
	Sun, 30 Aug 2026 05:37:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjrgeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 05:37:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67U5bbEJ35783086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Aug 2026 05:37:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E2B020043;
	Sun, 30 Aug 2026 05:37:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2306720040;
	Sun, 30 Aug 2026 05:37:33 +0000 (GMT)
Received: from [9.67.21.115] (unknown [9.67.21.115])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Aug 2026 05:37:32 +0000 (GMT)
Message-ID: <ccf3c0ae-f04b-4d81-b09e-daa5c785ec10@linux.ibm.com>
Date: Sun, 30 Aug 2026 11:07:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-3-coiby.xu@gmail.com>
 <86f3b10d-6fc2-4dbc-a20b-5d2365601be2@linux.ibm.com> <apLKk_P9wHc9uSZQ@Rk>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <apLKk_P9wHc9uSZQ@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a93c1a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=zrT50iyv3olL9t5bMM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mkVsZ8SwpwOXGIyRlQt0mIzvuPJlsdri
X-Proofpoint-ORIG-GUID: xzYwBCdw7OZSbcWKYxgx9bhkX4Tcjt3O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDA0NCBTYWx0ZWRfX/JqsCKTFy3uX
 g7VNxjk+7UuR/yP1AD7kTgDm/j1VxUDRQI9UP3XDe115XOZZUpDISiKMrxclbvZZG6kMgF/dDN5
 6UDOaOe9aYYrmmFOj66c9o9Yyg7R4tQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDA0NCBTYWx0ZWRfX1mO7/atKZcVY
 E00wR+Q6vSPuAYmr88LHeujqzuQEfH+ByF1EATmvswwV109k4EjZCAa43nFYThodlKwRF6lfZXN
 ylikOYt4bwFPHi47vYObkpOPiQ+2pH8jep9IfcQAqkTYOUcp0Ktw81g+4pNK1GUgvRk7sxviBAE
 drG3/Lxoh89/629YaTDZnmlLKSypbRlsjD1KxFpZgKX3JZtD3XZDNk84fBPySWzJh/dk2vRQLxe
 E2PQRmduMcGyVhOJNVrEWOjwJpaWcoe9g3w2MDZNLl7x0pp0g4qptEzeUl56SlRCAES3GJU/lDu
 vQomvfhmsgjMhF7uIdoHryWQe+ifhm/S0P31t/KWCB3+xm2GRBzcl3Y78I94Rf+cq31WBjHedhg
 Qsftm+CxCSvnpGHQ+uSu5yuxLW1zPac/OvxRh8rBvaCn8/sAHhXEoT36koGipNqRhw3NSKc76Rw
 wGCHBIiLNTShFp8IwLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608300044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260829_223748_036253_644FE1E3 
X-CRM114-Status: GOOD (  29.19  )
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



On 29/08/26 17:47, Coiby Xu wrote:
> On Sat, Aug 29, 2026 at 12:32:46PM +0530, Sourabh Jain wrote:
>>
>>
>> On 28/08/26 14:18, Coiby Xu wrote:
>>> If writing to the configfs group happens concurrently during
>>> kexec_file_load syscall, it may lead to the following issues,
>>>   - buffer overflow if dm-crypt keys are added after allocation
>>>   - stale total_keys if dm-crypt keys are removed during iteration
>>>   - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>>     set true
>>>
>>> So hold config_keys_subsys.su_mutex for the entire sequence during the
>>> kexec_file_load syscall to ensure a consistent snapshot. To have serial
>>> access to config/crash_dm_crypt_key/reuse, use the kexec lock as we 
>>> also
>>> need to access kexec_crash_image serially.
>>>
>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>> reserved memory")
>>> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>> ---
>>>  kernel/crash_dump_dm_crypt.c | 28 ++++++++++++++++++++++++----
>>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c 
>>> b/kernel/crash_dump_dm_crypt.c
>>> index 4335b6cb1fc4..026c7de4ad85 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -7,6 +7,7 @@
>>>  #include <linux/configfs.h>
>>>  #include <linux/module.h>
>>>  #include <linux/sysfs.h>
>>> +#include "kexec_internal.h"
>>>  #define KEY_NUM_MAX 128    /* maximum dm crypt keys */
>>>  #define KEY_SIZE_MAX 256    /* maximum dm crypt key size */
>>> @@ -296,14 +297,20 @@ static ssize_t config_keys_reuse_store(struct 
>>> config_item *item,
>>>      bool val;
>>>      int r;
>>> +    if (!kexec_trylock()) {
>>> +        r = -EBUSY;
>>> +        goto unlock;
>>
>>
>> Are we unlocking a lock that we didn't acquire? How about returning 
>> -EBUSY directly instead?
>
> Ah, thanks for catching my mistake! And also thanks for prioritizing
> reviewing my patch!

No worries at all! Happy to help, and thanks for the patch.


>
>>
>>
>>> +    }
>>> +
>>> +    r = -EINVAL;
>>>      if (!kexec_crash_image || 
>>> !kexec_crash_image->dm_crypt_keys_addr) {
>>>          kexec_dprintk(
>>>              "dm-crypt keys haven't be saved to crash-reserved 
>>> memory\n");
>>> -        return -EINVAL;
>>> +        goto unlock;
>>>      }
>>>      if (kstrtobool(page, &val) || !val)
>>> -        return -EINVAL;
>>> +        goto unlock;
>>>      if (is_dm_key_reused) {
>>>          pr_info("Already got dm-crypt keys, please continue with 
>>> kexec_file_load syscall\n");
>>> @@ -311,12 +318,15 @@ static ssize_t config_keys_reuse_store(struct 
>>> config_item *item,
>>>          r = get_keys_from_kdump_reserved_memory();
>>>          if (r) {
>>>              pr_warn("Failed to get dm-crypt keys from reserved 
>>> memory\n");
>>> -            return r;
>>> +            goto unlock;
>>>          }
>>>          is_dm_key_reused = true;
>> [...]
>>>      }
>>> -    return count;
>>> +    r = count;
>>> +unlock:
>>> +    kexec_unlock();
>>> +    return r;
>>>  }
>>>  CONFIGFS_ATTR(config_keys_, reuse);
>>> @@ -421,6 +431,8 @@ static int build_keys_header(void)
>>>      return 0;
>>>  }
>>> +static bool mutex_acquired;
>>> +
>>>  int crash_load_dm_crypt_keys(struct kimage *image)
>>>  {
>>>      struct kexec_buf kbuf = {
>>> @@ -432,6 +444,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>      };
>>>      int r = 0;
>>> +    mutex_lock(&config_keys_subsys.su_mutex);
>>> +    mutex_acquired = true;
>>> +
>>>      if (key_count <= 0) {
>>>          kexec_dprintk("No dm-crypt keys\n");
>>>          return 0;
>>> @@ -481,6 +496,11 @@ void 
>>> kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>
>> I explored the kexec_file_load syscall entry path and noticed
>> that there is a path where the call to
>> kimage_file_post_load_cleanup() can be skipped.
>>
>> For example, if kexec_file_load is called and everything goes well
>> but kexec_post_load() fails, we skip
>> kimage_file_post_load_cleanup(), and consequently
>> kexec_file_post_load_cleanup_dm_crypt() as well.
>>
>> If that happens, the config_keys_subsys.su_mutex remains locked,
>> which could cause problems with the next kexec load, right?
>
> Thanks for exploring the kexec_file_load syscall entry path! I took a
> further look at it. Even though kimage_file_post_load_cleanup can be
> skipped, kimage_free will be called regardless which will in turn call
> kimage_file_post_load_cleanup.

Ah yes, I missed that. That said, we are calling
kimage_file_post_load_cleanup() twice for every kexec_file_load, so this
needs to be looked into separately.

>     // kernel/kexec_core.c
>     void kimage_free(struct kimage *image)
>     {
>         /*
>          * Free up any temporary buffers allocated. This might hit if
>          * error occurred much later after buffer allocation.
>          */
>         if (image->file_mode)
>             kimage_file_post_load_cleanup(image);
>     }
>
> But I realize by using kexec lock to ensure serial access to
> is_dm_key_reused, we can actually release the mutex lock at the end of
> crash_load_dm_crypt_keys function which can make the code simpler and
> potentially more robust. Thanks for inspiring me to find a better
> way!

That will be good. Lock ownership will be with just one function, which 
will make
things easier to manage.

- Sourabh Jain

>>
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


