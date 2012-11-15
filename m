Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYzU2-0001jR-18
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 13:27:54 +0000
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 15 Nov 2012 08:27:50 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 31D6038C8047
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 08:27:48 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAFDRlun294000
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 08:27:47 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAFDRl0n025680
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 08:27:47 -0500
Message-ID: <50A4EDCC.9070004@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2012 18:57:40 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <229199866.31780089.1352924500787.JavaMail.root@redhat.com>
In-Reply-To: <229199866.31780089.1352924500787.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com



On 2012-11-15 01:51, Dave Anderson wrote:

> 
> 
> ----- Original Message -----
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
>>
>>>
>>> - Is this supposed to work from kdump initramfs or it is supposed to be
>>>   used on already saved dump (later during post processing).
>>
>>
>> For the time being, it is only during post processing.
> 
> By post-processing, I understand you to say that the system would be
> configured to do a full ELF vmcore dump, save it somewhere, and then
> somebody would do the post-processing at a later time?


Yes exactly.

> 
> Or is it possible to run makedumpfile again on a compressed kdump that
> was previously created at dump-time?


Yes, it is possible to run makedumpfile with eppic again and again on
compressed kdump, dump which excludes unnecessary pages and dumpfile
which is already filtered by eppic.

> 
>>>
>>>   Given the fact that it does not reduce the size of core file
>>>   significantly, I would think that it is better to post process vmcore
>>>   to wipe out some symbols.
>>
>>
>> The main intention is to remove confidential information from the dump
>> file, like ssh keys etc., which could be just few bytes, hence, may not
>> reduce the size of the dump significantly.
> 
> So this would require you to first do a crash analysis on the unfiltered dumpfile,
> find out what you want to filter, write a script, and then run makedumpfile
> on the vmcore, correct?


Need not be always. If users know what to erase in advance they can skip
the crash analysis part. I had mentioned an example in my previous reply
to Vivek on how to erase keyring data from struct key.

> 
> Dave
> 
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
