Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xyq7y-0004Vr-LM
 for kexec@lists.infradead.org; Wed, 10 Dec 2014 22:53:03 +0000
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <brking@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 15:52:40 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1A0E41FF001C
 for <kexec@lists.infradead.org>; Wed, 10 Dec 2014 15:41:22 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAMqbhP42795074
 for <kexec@lists.infradead.org>; Wed, 10 Dec 2014 15:52:37 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAMqaZO027976
 for <kexec@lists.infradead.org>; Wed, 10 Dec 2014 15:52:37 -0700
Message-ID: <5488CEB4.5000005@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 16:52:36 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND 2/5] kexec: Export kexec_in_progress
References: <201412021847.sB2Ilfvc002145@d01av04.pok.ibm.com>
 <547E09B7.7030507@linux.vnet.ibm.com>	<5486148F.6020208@linux.vnet.ibm.com>
 <87vbllstye.fsf@x220.int.ebiederm.org>
In-Reply-To: <87vbllstye.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, anton@samba.org, hch@lst.de

On 12/08/2014 03:38 PM, Eric W. Biederman wrote:
> Brian King <brking@linux.vnet.ibm.com> writes:
> 
>> On 12/02/2014 12:49 PM, Brian King wrote:
>>> On 12/02/2014 12:47 PM, Brian King wrote:
>>>> A kexec boot for some ipr SAS adapters was seen to take ~20 seconds
>>>> just doing ipr adapter initialization. This is due to the fact that
>>>> a kexec invokes the driver's shutdown handler which places the adapter
>>>> into a state that requires a hard reset and resulting firmware initialization
>>>> to be usable again, which takes significant time. By exporting kexec_in_progress,
>>>> this process can be optimized significantly in the driver by essentially
>>>> placing the adapter into a state where this hardware reset and re-initialization
>>>> can be bypassed, eliminating this delay in kexec boot.
>>>>
>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> Cc: kexec <kexec@lists.infradead.org>
>>>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>>  kernel/kexec.c |    2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
>>>> --- scsi-queue/kernel/kexec.c~kexec_export_in_prog	2014-12-02 12:13:22.820325731 -0600
>>>> +++ scsi-queue-bjking1/kernel/kexec.c	2014-12-02 12:13:22.825325687 -0600
>>>> @@ -2768,3 +2768,5 @@ int kernel_kexec(void)
>>>>  	mutex_unlock(&kexec_mutex);
>>>>  	return error;
>>>>  }
>>>> +
>>>> +EXPORT_SYMBOL_GPL(kexec_in_progress);
>>>> _
>>>>
>>>
>>> Eric,
>>>
>>> Can I get your ack on this so this can go through the scsi tree? The last time I sent this
>>> out you had some issues with the patch description.
>>
>> Eric - can I get your ack here?
> 
> You can have my nack.
> 
> We really shouldn't need to special case things for kexec here.  Why do
> you do the full shutdown that is so slow to get out of?  Does it really
> make reboots more reliable?  If you need it for a reboot why don't you
> need it for a kexec reboot?  You certainly need to stop all dma in
> both cases.
> 
> If it really matters to device drivers we need to refactor and make the
> callbacks make sense, be maintainable.  Right now caring that it is
> kexec vs reboot seems broken.
> 
> Now maybe I am wrong here, and there are some good really good reasons
> for wanting to do a much stronger shutdown on reboot but at least
> skimming through the change longs of the associated patches I am not
> seeing the reason for making all of these changes conditional on kexec.
> 
> What I am seeing is driver code getting really complicated possibly
> beyond the ability of anyone to sanely test.

The difference between an actual reboot and a kexec reboot is that for an
actual reboot, the system / platform will end up hard resetting the adapter
across the reboot. Due to this impending hard reset, some drivers may want
to take additional actions before a full system reboot occurs.

In the case of ipr, prior to a full system reset the key thing I want to ensure
happens is to tell the adapter to quiesce any outstanding I/O to the disks.
I/O that can be occurring at this time is either data being destaged from the
non volatile write cache, RAID rebuilds, etc. The only firmware interface available
to initiate this quiesce currently places the adapter into a state where the only
way back out of it to a state where the host can begin to issue I/O again is
to hard reset the adapter, as it is expected to only occur prior to system
shutdown or system reboot. This reset and then the firmware initialization
that follows can take a bit of time.

If this pending I/O is not quiesced prior to a hard reset of the adapter the
subsequent boot can then take even longer and, in some cases, may require
additional actions to recover from.

I can look at implementing this in a driver unique way so that we don't need
this kexec patch, but this seemed the most straight forward.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
