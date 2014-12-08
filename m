Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xy5dK-0000DJ-BI
 for kexec@lists.infradead.org; Mon, 08 Dec 2014 21:14:18 +0000
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <brking@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 14:13:57 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6411319D8039
 for <kexec@lists.infradead.org>; Mon,  8 Dec 2014 14:02:34 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB8LDslg53608454
 for <kexec@lists.infradead.org>; Mon, 8 Dec 2014 14:13:54 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB8LDrWx000653
 for <kexec@lists.infradead.org>; Mon, 8 Dec 2014 14:13:54 -0700
Message-ID: <5486148F.6020208@linux.vnet.ibm.com>
Date: Mon, 08 Dec 2014 15:13:51 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND 2/5] kexec: Export kexec_in_progress
References: <201412021847.sB2Ilfvc002145@d01av04.pok.ibm.com>
 <547E09B7.7030507@linux.vnet.ibm.com>
In-Reply-To: <547E09B7.7030507@linux.vnet.ibm.com>
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
To: ebiederm@xmission.com
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, anton@samba.org, hch@lst.de

On 12/02/2014 12:49 PM, Brian King wrote:
> On 12/02/2014 12:47 PM, Brian King wrote:
>> A kexec boot for some ipr SAS adapters was seen to take ~20 seconds
>> just doing ipr adapter initialization. This is due to the fact that
>> a kexec invokes the driver's shutdown handler which places the adapter
>> into a state that requires a hard reset and resulting firmware initialization
>> to be usable again, which takes significant time. By exporting kexec_in_progress,
>> this process can be optimized significantly in the driver by essentially
>> placing the adapter into a state where this hardware reset and re-initialization
>> can be bypassed, eliminating this delay in kexec boot.
>>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: kexec <kexec@lists.infradead.org>
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>>
>>  kernel/kexec.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
>> --- scsi-queue/kernel/kexec.c~kexec_export_in_prog	2014-12-02 12:13:22.820325731 -0600
>> +++ scsi-queue-bjking1/kernel/kexec.c	2014-12-02 12:13:22.825325687 -0600
>> @@ -2768,3 +2768,5 @@ int kernel_kexec(void)
>>  	mutex_unlock(&kexec_mutex);
>>  	return error;
>>  }
>> +
>> +EXPORT_SYMBOL_GPL(kexec_in_progress);
>> _
>>
> 
> Eric,
> 
> Can I get your ack on this so this can go through the scsi tree? The last time I sent this
> out you had some issues with the patch description.

Eric - can I get your ack here?

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
