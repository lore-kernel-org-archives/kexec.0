Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZIbf-0002q8-6t
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 09:53:04 +0000
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 02:53:02 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id AE0CF3E4003C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:52:57 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAG9qvjm250892
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:52:57 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAG9qtp0030343
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:52:57 -0700
Message-ID: <50A60CF2.6010309@linux.vnet.ibm.com>
Date: Fri, 16 Nov 2012 15:22:50 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com>
In-Reply-To: <20121115155557.GF2529@redhat.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com



On 2012-11-15 21:25, Vivek Goyal wrote:

> On Thu, Nov 15, 2012 at 09:27:45AM -0500, Dave Anderson wrote:
> 
> [..]
>>> Yes, makedumpfile needs to be linked against eppic library for filtering
>>> data and this will increase makedumpfile size and initramfs size too.
>>
>> Just to clarify -- your example indicates that the vmlinux file is required
>> for this facility to work, correct?
>>  
>>> makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore
>>
>> Clearly distros won't be putting the vmlinux file in the initramfs -- that's
>> the whole reasoning behind vmcoreinfo.  So the 99% of users that aren't
>> interested in scrubbing will have to pay the penalty of the larger makedumpfile
>> binary.
> 
> That's a good point Dave. We will never put debug compiled vmlinux in 
> initramfs. Following two alternatives come to my mind.


As I mentioned, we don't need vmlinux in initramfs as filtering is done
during post processing only.

> 
> - Either makedumpfile provides some kind of library to parse/read/write
>   dump files and we can write another stand alone utility for scrubbing
>   dump files (say, scrub-vmcore),  and it can link against makedumpfile
>   libraries to take advantage of existing code.
> 
> - Or, we just identify what we want to scrube and make that code part
>   of makedumpfile. Export relevant data structures from kernel using
>   vmcoreinfo.
> 
> I prefer to keep things simple and like second option better.
> 
> Thanks
> Vivek
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
