Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OhXY7-000744-PS
	for kexec@lists.infradead.org; Sat, 07 Aug 2010 00:46:08 +0000
Subject: Re: [patch] MAINTAINERS: kexec-tools has moved
References: <20100729041641.GA32220@verge.net.au>
	<20100806233203.GA10040@verge.net.au> <4C5C9BC2.8020502@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Aug 2010 17:45:50 -0700
In-Reply-To: <4C5C9BC2.8020502@zytor.com> (H. Peter Anvin's message of "Fri\,
	06 Aug 2010 16\:33\:22 -0700")
Message-ID: <m1sk2rtflt.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 08/06/2010 04:32 PM, Simon Horman wrote:
>> On Thu, Jul 29, 2010 at 01:16:41PM +0900, Simon Horman wrote:
>>> Kexec tools has been moved to http://kernel.org/pub/linux/utils/kernel/kexec/
>>> as user-space code shouldn't be in /pub/linux/kernel
>>>
>>> Signed-off-by: Simon Horman <horms@verge.net.au>
>> 
>> Eric, ping.
>> 
>> What is your preferred path for this change to get merged?
>> 
>>>
>>> Index: linux-2.6/MAINTAINERS
>>> ===================================================================
>>> --- linux-2.6.orig/MAINTAINERS	2010-07-29 13:10:04.000000000 +0900
>>> +++ linux-2.6/MAINTAINERS	2010-07-29 13:11:40.000000000 +0900
>>> @@ -3334,7 +3334,7 @@ F:	drivers/s390/kvm/
>>>  
>>>  KEXEC
>>>  M:	Eric Biederman <ebiederm@xmission.com>
>>> -W:	http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
>>> +W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>>>  L:	kexec@lists.infradead.org
>>>  S:	Maintained
>>>  F:	include/linux/kexec.h
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>
> Eric is on vacation this week, AFAIK.

I am on vacation..  However having made the mistake of checking my email.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I guess I don't have a particular favorite path for something to make
it to MAINTAINERS.  But since we have move the location of the the
userspace repository merging this somehow seems like a good idea.

As I am on vacation I'm not motivated to push this to Linus, or much
of anywhere else, which sucks because the merge window is open right
now.  I think historically patches like this have gone through Andrew.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
