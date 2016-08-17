Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZvVj-0004pd-P7
 for kexec@lists.infradead.org; Wed, 17 Aug 2016 07:43:41 +0000
Subject: Re: [PATCH v2 2/2] kexec: Consider crashk_low_res in
 sanity_check_segment_list()
References: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
 <1471398657-20237-2-git-send-email-xlpang@redhat.com>
 <20160817072420.GD5498@dhcp-128-65.nay.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <57B415A5.60104@redhat.com>
Date: Wed, 17 Aug 2016 15:43:33 +0800
MIME-Version: 1.0
In-Reply-To: <20160817072420.GD5498@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On 2016/08/17 at 15:24, Dave Young wrote:
> Hi, Xunlei,
>
> On 08/17/16 at 09:50am, Xunlei Pang wrote:
>> We have crashk_res only in most cases, but sometimes we have
>> crashk_low_res.
>>
>> For example, on 64-bit x86 systems, when "crashkernel=32M,high"
>> combined with "crashkernel=128M,low" is used, so some segments
>> may have the chance to be loaded into crashk_low_res area. We
>> can't fail it as a memory violation in these cases.
>>
>> Thus, we add the case to regard the segment as valid if it is
>> within crashk_low_res.
> crashkernel low is meant for swiotlb, it can be reserved automaticlly
> in case there's only crashkernel high specified in cmdline, I'm not
> sure it is useful to use crashk_res_low for other purpose and
> likely kdump can fail in the case. 
>
> I'm not sure it is really necessary to add this check now, we may
> handle it only when there is an actual use case and bug report in
> the future.

Thanks for the review.
The reason I added this is that crashk_res is allowed to be shrunk, so the segment
will surely fall into crashk_low_res if crashk_res was shrunk to be a small range.

But yes, this should be a corner case, but seems it does no harm adding this check.
Anyway, if you think it's not necessary, let's simply ignore it :-)

Regards,
Xunlei

>
> Thanks
> Dave
>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>> ---
>>  kernel/kexec_core.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 707d18e..9012a60 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -248,9 +248,14 @@ int sanity_check_segment_list(struct kimage *image)
>>  			mstart = image->segment[i].mem;
>>  			mend = mstart + image->segment[i].memsz - 1;
>>  			/* Ensure we are within the crash kernel limits */
>> -			if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
>> -			    (mend > phys_to_boot_phys(crashk_res.end)))
>> -				return -EADDRNOTAVAIL;
>> +			if ((mstart >= phys_to_boot_phys(crashk_res.start)) &&
>> +			    (mend <= phys_to_boot_phys(crashk_res.end)))
>> +				continue;
>> +			if ((mstart >= phys_to_boot_phys(crashk_low_res.start)) &&
>> +			    (mend <= phys_to_boot_phys(crashk_low_res.end)))
>> +				continue;
>> +
>> +			return -EADDRNOTAVAIL;
>>  		}
>>  	}
>>  
>> -- 
>> 1.8.3.1
>>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
