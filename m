Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y71xB-00055w-L1
 for kexec@lists.infradead.org; Fri, 02 Jan 2015 13:07:46 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t02D7Llx030995
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Fri, 2 Jan 2015 08:07:21 -0500
Message-ID: <54A69808.4010401@redhat.com>
Date: Fri, 02 Jan 2015 08:07:20 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec, remove panic_on_warn kernel parameter from kdump
 situations
References: <1419951471-19765-1-git-send-email-prarit@redhat.com>
 <20150102125423.GA18785@redhat.com>
In-Reply-To: <20150102125423.GA18785@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>



On 01/02/2015 07:54 AM, Vivek Goyal wrote:
> On Tue, Dec 30, 2014 at 09:57:51AM -0500, Prarit Bhargava wrote:
>> panic_on_warn kernel parameter will cause the kernel to panic when a
>> WARN() is hit in the kernel.  This is not a good situation for the kdump
>> kernel because then it would be possible for the kdump kernel to panic in
>> a non-fatal WARN().
>>
>> This patch removes panic_on_warn as a kernel parameter for the kdump
>> kernel.
>>
> 
> I think modifying kexec-tools is not best place for this. It probably is better to take care of this in distribution specific scripts.
> 
> In the past we have learnt that it is best that kexec-tools does least
> amount of manipulation with command line.

Well .. here's the question to think about: what does adding panic_on_warn to
the kdump kernel get you?  AFAICT, nothing.

If panic_on_warn is specified, the only thing that will happen is that kdump
will fail (which is always bad IMO).  There is no real difference in the stack
trace between the WARN() and panic situations so there is no information loss.

So I disagree -- we should never specify panic_on_warn on kdump kernel.

P.

> 
> Thanks
> Vivek
> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: WANG Chao <chaowang@redhat.com>
>> ---
>>  kexec/kexec.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index b088916..323cafb 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -1048,8 +1048,10 @@ char *get_command_line(void)
>>  	line[strlen(line) - 1] = '\0';
>>  
>>  	remove_parameter(line, "BOOT_IMAGE");
>> -	if (kexec_flags & KEXEC_ON_CRASH)
>> +	if (kexec_flags & KEXEC_ON_CRASH) {
>>  		remove_parameter(line, "crashkernel");
>> +		remove_parameter(line, "panic_on_warn");
>> +	}
>>  
>>  	return line;
>>  }
>> -- 
>> 1.7.9.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
