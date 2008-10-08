Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnhBB-0008P6-M5
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 22:06:51 +0000
Date: Thu, 9 Oct 2008 09:06:47 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] kexec/kdump: read crash memory ranges from drconf
	memory
Message-ID: <20081008220646.GH16178@verge.net.au>
References: <200809241719.07464.chandru@in.ibm.com>
	<20081008014055.GA22396@verge.net.au>
	<20081008015622.GB22396@verge.net.au> <48ECD2D5.6080307@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48ECD2D5.6080307@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chandru <chandru@in.ibm.com>
Cc: kexec@lists.infradead.org

On Wed, Oct 08, 2008 at 09:03:41PM +0530, Chandru wrote:
> Simon Horman wrote:
>
>> On Wed, Oct 08, 2008 at 12:40:57PM +1100, Simon Horman wrote:
>>
>> [snip]	
>>
>>   
>>>> --- kexec-tools-orig/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-24  
>>>> 14:46:55.000000000 +0530
>>>> +++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-16  
>>>> 19:18:57.000000000 +0530
>>>> @@ -28,4 +28,7 @@ extern uint64_t crash_size;
>>>>  extern unsigned int rtas_base;
>>>>  extern unsigned int rtas_size;
>>>>  +uint64_t lmb_size;
>>>> +unsigned int num_of_lmbs;
>>>> +
>>>>       
>>> I am a little confused about why these variables need to be global
>>> as they only seem to be used inside get_crash_memory_ranges().
>>> I am also a little confused about how they are initialised.
>>>     
>>
>> Ok, looking further I see that these are also used
>> by code introduced in patch 2 and are initialised in
>> code added by patch 3. It would be nicer have them
>> intitalised in this patch as I'm not sure that
>> the code will work sensibly with just this patch
>> or just this patch and patch 2 applied, which may
>> be important for bisection in the future.
>>
>>   
> Hello Simon,
>
> Thanks for reviewing the patch. The reference to lmb_size and  
> num_of_lmbs exists in all the three patches. Either all these patches  
> have to be applied together or they will have to be removed completely  
> if we were to bisect the code. We could have one big patch from all  
> these patches instead of three. Pls let me know if that makes it easier  
> to locate any problems in the future. Also the 'static' scope on cstart  
> and cend and memory_ranges could be removed in crashdump-ppc64.c. They  
> can be let to have a program scope. Pls let me know, I will send the  
> same patch removing these scopes.

Hi Chandru,

thanks for the clafification. I will just apply the patches as-is,
I don't think that the problem that I raised is too much of a big deal.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
