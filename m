Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQWcI-00004q-Eg
 for kexec@lists.infradead.org; Fri, 01 Nov 2019 13:05:28 +0000
Subject: Re: [Crash-utility] crash and makedumpfile with 5.3 missing memory in
 dump
References: <20191101014837.lxmqee5jyic7lk4d@two.firstfloor.org>
 <1684529127.9771679.1572612525461.JavaMail.zimbra@redhat.com>
From: John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <1593ae18-e75d-0023-5895-04e3bcdb1950@Oracle.com>
Date: Fri, 1 Nov 2019 08:05:20 -0500
MIME-Version: 1.0
In-Reply-To: <1684529127.9771679.1572612525461.JavaMail.zimbra@redhat.com>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, "Discussion list for crash utility usage, maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org

On 11/1/19 7:48 AM, Dave Anderson wrote:

SEE BELOW
> 
> 
> ----- Original Message -----
>> Hi,
>>
>> [I'm not sure if that is a crash or mkdumpfile problem]
>>
>> I'm trying to use crash to read a makedumpfile vmcore from 5.3, but I always
>> end up with an error when opening the dump.
>>
>> I'm using the latest github crash
>>
>> crash 7.2.7++
>> ...
>>   crash: page excluded: kernel virtual address: ffffffff82110370  type:
>>   "possible"
>>   WARNING: cannot read cpu_possible_map
>>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
>>   "present"
>>   WARNING: cannot read cpu_present_map
>>   crash: page excluded: kernel virtual address: ffffffff82110368  type:
>>   "online"
>>   WARNING: cannot read cpu_online_map
>>   crash: page excluded: kernel virtual address: ffffffff82110358  type:
>>   "active"
>>   WARNING: cannot read cpu_active_map
>>   crash: page excluded: kernel virtual address: ffffffff82011544  type:
>>   "init_uts_ns"
>>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
>>   "cpu_present_map"
>>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
>>   "cpu_present_map"
>>   WARNING: ORC unwinder: cannot read lookup_num_blocks
>>   crash: seek error: kernel virtual address: ffff88822dffb000  type:
>>   "memory section root table"
>>
>> The dump is created with the latest makedumpfile release
>>
>> makedumpfile: version 1.6.6 (released on 27 Jun 2019)
>>
>> It complains that it doesn't support the kernel
>>
>> Any ideas?
>>
>> -Andi
>>
> 
> Yeah, I'm not sure either.  I've tested the github crash on kernels up to 5.4-rc5,
> but only running on a live system.  Given that the errors indicate "page excluded",
> it looks like makedumpfile 1.6.6 may not cover 5.4 kernels.  The makedumpfile git
> log's master branch shows these as the last two commits:
> 
>    commit 0a8b504102dbdb952b2e2e3ce15ae706165eba4e
>    Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>    Date:   Thu Jun 27 08:42:40 2019 -0400
> 
>      [v1.6.6] Update version
>      
>      Update makedumpfile to version 1.6.6.
>      
>      Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> 
>    commit 8c21fc7e7c52a2c3e0299e50a8b37becadfa77b4
>    Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>    Date:   Thu Jun 13 15:32:55 2019 -0400
> 
>      [PATCH] Support newer kernels up to v5.1
>      
>      A new makedumpfile supports newer kernels:
>      
>        - 4.20, 5.0, 5.1  (x86 FLATMEM)
>        - 4.20, 5.0, 5.1  (x86 SPARSEMEM)
>        - 4.20, 5.0, 5.1  (x86_64 SPARSEMEM)
>      
>      Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> 
> Dave
> 
> 
> 
> 


Hello,


Kazuhito Hagio asked me to share my test results on this patch for 
makedumpfile :


https://urldefense.proofpoint.com/v2/url?u=https-3A__sourceforge.net_p_makedumpfile_code_ci_7bdb468c2c99dd780c9a5321f93c79cbfdce2527_&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=RRTWEGpecudcCrNL7TSmV5r2eIO7t_VrYruNXGGFhUE&s=BlcGeqwro6opkCKG9utpl8jfwoHMehRzt_V0nGz1fk4&e= 


And I was successfully able to get vmcore dumps on vmlinuz-5.3.6 and 
5.4.0-rc3 Intel ( x86-64) kernels.

Also I was able to use crash

   7.2.6-2.el8

to review the dump.  I didn't do a lot of crash comamnds but it did 
process the vmcore



> 
> 
> 
>> --
>> Crash-utility mailing list
>> Crash-utility@redhat.com
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.redhat.com_mailman_listinfo_crash-2Dutility&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=9yL0dKr8YPcdyw8vhjxi5rc_RZGNuf0lc0WRWsTNSlo&s=pVuyiNdvWTttmzeUYAUiduUcsdeYChqP6s1XzM3OxX4&e=
>>
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_kexec&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=9yL0dKr8YPcdyw8vhjxi5rc_RZGNuf0lc0WRWsTNSlo&s=csTpNCSCrSAX9v0u0oSf00VFC7TzIABjI6cYaDBk6v0&e=
> 


-- 
Thank You,
John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
