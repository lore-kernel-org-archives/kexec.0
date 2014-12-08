Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xy63Y-0000ol-7Z
 for kexec@lists.infradead.org; Mon, 08 Dec 2014 21:41:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <201412021847.sB2Ilfvc002145@d01av04.pok.ibm.com>
 <547E09B7.7030507@linux.vnet.ibm.com>
 <5486148F.6020208@linux.vnet.ibm.com>
Date: Mon, 08 Dec 2014 15:38:33 -0600
In-Reply-To: <5486148F.6020208@linux.vnet.ibm.com> (Brian King's message of
 "Mon, 08 Dec 2014 15:13:51 -0600")
Message-ID: <87vbllstye.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND 2/5] kexec: Export kexec_in_progress
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
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, anton@samba.org, hch@lst.de

Brian King <brking@linux.vnet.ibm.com> writes:

> On 12/02/2014 12:49 PM, Brian King wrote:
>> On 12/02/2014 12:47 PM, Brian King wrote:
>>> A kexec boot for some ipr SAS adapters was seen to take ~20 seconds
>>> just doing ipr adapter initialization. This is due to the fact that
>>> a kexec invokes the driver's shutdown handler which places the adapter
>>> into a state that requires a hard reset and resulting firmware initialization
>>> to be usable again, which takes significant time. By exporting kexec_in_progress,
>>> this process can be optimized significantly in the driver by essentially
>>> placing the adapter into a state where this hardware reset and re-initialization
>>> can be bypassed, eliminating this delay in kexec boot.
>>>
>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>> Cc: kexec <kexec@lists.infradead.org>
>>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>>> ---
>>>
>>>  kernel/kexec.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
>>> --- scsi-queue/kernel/kexec.c~kexec_export_in_prog	2014-12-02 12:13:22.820325731 -0600
>>> +++ scsi-queue-bjking1/kernel/kexec.c	2014-12-02 12:13:22.825325687 -0600
>>> @@ -2768,3 +2768,5 @@ int kernel_kexec(void)
>>>  	mutex_unlock(&kexec_mutex);
>>>  	return error;
>>>  }
>>> +
>>> +EXPORT_SYMBOL_GPL(kexec_in_progress);
>>> _
>>>
>> 
>> Eric,
>> 
>> Can I get your ack on this so this can go through the scsi tree? The last time I sent this
>> out you had some issues with the patch description.
>
> Eric - can I get your ack here?

You can have my nack.

We really shouldn't need to special case things for kexec here.  Why do
you do the full shutdown that is so slow to get out of?  Does it really
make reboots more reliable?  If you need it for a reboot why don't you
need it for a kexec reboot?  You certainly need to stop all dma in
both cases.

If it really matters to device drivers we need to refactor and make the
callbacks make sense, be maintainable.  Right now caring that it is
kexec vs reboot seems broken.

Now maybe I am wrong here, and there are some good really good reasons
for wanting to do a much stronger shutdown on reboot but at least
skimming through the change longs of the associated patches I am not
seeing the reason for making all of these changes conditional on kexec.

What I am seeing is driver code getting really complicated possibly
beyond the ability of anyone to sanely test.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
