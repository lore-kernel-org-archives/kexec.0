Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XNore-0002cg-Bu
 for kexec@lists.infradead.org; Sat, 30 Aug 2014 20:03:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <54009E8A.4070809@linux.vnet.ibm.com> (Brian King's message of
 "Fri, 29 Aug 2014 10:38:50 -0500")
References: <53D6B270.5020403@linux.vnet.ibm.com>
 <53DF96E5.7000601@linux.vnet.ibm.com>
 <54009E8A.4070809@linux.vnet.ibm.com>
Date: Sat, 30 Aug 2014 15:02:10 -0500
Message-ID: <87wq9piw59.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] kexec: Export kexec_in_progress
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
To: Brian King <brking@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>, "James E.J. Bottomley" <JBottomley@parallels.com>

Brian King <brking@linux.vnet.ibm.com> writes:

> On 08/04/2014 09:21 AM, Brian King wrote:
>> On 07/28/2014 03:28 PM, Brian King wrote:
>>>
>>> Export kexec_in_progress for use by device drivers and other modules
>>> to optimize kexec boot.
>>>
>>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>>> ---
>>>
>>>  kernel/kexec.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
>>> --- linux/kernel/kexec.c~kexec_export_in_prog	2014-07-23 17:05:24.851887935 -0500
>>> +++ linux-bjking1/kernel/kexec.c	2014-07-23 17:05:24.856887970 -0500
>>> @@ -1716,3 +1716,5 @@ int kernel_kexec(void)
>>>  	mutex_unlock(&kexec_mutex);
>>>  	return error;
>>>  }
>>> +
>>> +EXPORT_SYMBOL_GPL(kexec_in_progress);
>> 
>> Eric,
>> 
>> Can I get an ack on this so we can take this entire series through the SCSI tree?
>
> Eric,
>
> Any issues with this patch?

No huge issues except that patch description is largely uniformitive and
actually wrong.  kexec_in_progress is never set at boot/kernel startup.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
