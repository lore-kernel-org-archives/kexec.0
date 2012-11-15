Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYyuL-0003oV-Rx
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 12:51:04 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 15 Nov 2012 05:50:57 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B753719D803E
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 05:50:53 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAFCooGc164298
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 05:50:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAFCoo6O017046
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 05:50:50 -0700
Message-ID: <50A4E524.8020702@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2012 18:20:44 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com> <50A3CFAD.6090008@linux.vnet.ibm.com>
 <20121114175304.GK20215@redhat.com>
In-Reply-To: <20121114175304.GK20215@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com



On 2012-11-14 23:23, Vivek Goyal wrote:

> On Wed, Nov 14, 2012 at 10:36:53PM +0530, Aravinda Prasad wrote:
>> Hi Vivek,
>>
>> On 2012-11-14 20:24, Vivek Goyal wrote:
>>
>>> On Thu, Nov 08, 2012 at 07:07:52PM +0530, Aravinda Prasad wrote:
>>>> makedumpfile security key filtering enhancement - Add Eppic language
>>>> support (formerly known as SIAL) to specify rules to scrub data in a
>>>> dumpfile. Eppic was previously part of crash source code repository.
>>>>
>>>> The following series of patches enhance the makedumpfile to provide
>>>> a more powerful way to specify rules and commands to traverse and
>>>> erase complex data structures in a dump file by integrating Embeddable
>>>> Pre-Processor and Interpreter for C (eppic).
>>>
>>> Hi Aravinda,
>>>
>>> Had few questions.
>>>
>>> - Which file will contain all the rules?
>>
>>
>> As of now rule files will not be provided by makedumpfile. However,
>> writing a rule file is very easy - it is a C program.
> 
> Can you give some details about how does it work and what's the
> correlation with makedumpfile.


struct key in include/linux/key.h holds "authentication token"/"access
credential"/"keyring". Suppose these entries should be scrubbed from the
dumpfile. Then the keyring_name_hash hash table should be scanned and
for each non-empty list, the entire list should be traversed and
payload.value (or any other data) in struct key should be cleared.

Now the EPPIC macro looks like this:

int
key()
{
    int i;
    struct list_head *head;
    struct list_head *next, *prev;

    head = (struct list_head *)keyring_name_hash;

    for (i = 0; i < 32; i++)
    {
        next = (struct list_head *) head[i].next;
        prev = (struct list_head *) head[i].prev;

        if (!next)
            continue;

        do
        {
            struct key *mykey, *off = 0;

            mykey = (struct key *)((unsigned long)(next)
                      - ((unsigned long)&(off->type_data)));

            memset((char *)mykey->payload.value, 'X', 0x8);

            next = *(struct list_head **) mykey->type_data.link.next;
        } while (next != prev);
    }
    return 1;
}

The data can be cleared by specifying:
makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore

makedumpfile with the help of eppic will interpret the macro key.c,
traverses all the hash chains and erases paylod.value of struct key.

> 
>>
>>>
>>> - What's the memory footprint of libeppic.a? Looks like this will be
>>>   linked statically with makedumpfile, and how much is the size bloat of
>>>   makedumpfile.
>>
>>
>> Memory footprint of libeppic.a is around 1MB. Yes, this will be
>> statically linked to makedumpfile. Users should specify EPPIC=on while
>> building the makedumpfile and hence linking libeppic.a is optional
> 
> How would distributions handle it. Will we continue to build makedumpfile
> without EPPIC=on. Any increase in initramfs size increase is frowned upon
> in general.


We would like distributions to build makedumpfile with EPPIC=on.

I am not sure, but do you think ~1MB is too much increase to go with?

> 
>>
>>>
>>> - Is this supposed to work from kdump initramfs or it is supposed to be
>>>   used on already saved dump (later during post processing).
>>
>>
>> For the time being, it is only during post processing.
> 
> Again, how distributions will handle it. If it is being integrated
> makedumpfile, as opposed to an stand alone utility, that means it
> makedumpfile needs to link against this library so that somebody can
> later filter out the symbols. And that means initramfs size bloat too?


Yes, makedumpfile needs to be linked against eppic library for filtering
data and this will increase makedumpfile size and initramfs size too.

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
