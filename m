Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ti1eW-00069p-7K
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 11:36:05 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 10 Dec 2012 06:36:02 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2A0266E803A
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2012 06:35:58 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBABZwYP236848
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2012 06:35:58 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBABZvcS022015
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2012 09:35:58 -0200
Message-ID: <50C5C918.4040708@linux.vnet.ibm.com>
Date: Mon, 10 Dec 2012 17:05:52 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
 <50C18718.40902@linux.vnet.ibm.com>
 <C14DE2E60140984C9CEB63D47F21D9D40499579E@s2exchange2.hq.s2sys.com>
 <20121207215930.GE4928@redhat.com> <50C58FF3.20905@linux.vnet.ibm.com>
In-Reply-To: <50C58FF3.20905@linux.vnet.ibm.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, Luc Chouinard <LChouinard@s2sys.com>, tachibana@mxm.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, buendgen@de.ibm.com



On 2012-12-10 13:02, Aravinda Prasad wrote:

> 
> 
> On 2012-12-08 03:29, Vivek Goyal wrote:
> 
>> On Fri, Dec 07, 2012 at 08:46:33AM -0500, Luc Chouinard wrote:
>>
>> [..]
>>>> This is what I am planning.
>>>>
>>>> A new extension_eppic.c file will be created under makedumpfile source
>>>> directory. This file is equivalent to applications/crash/eppic.c in
>>> upstream eppic
>>>> repository. A new target will be added to the Makefile of makedumpfile
>>> to build
>>>> the shared library and to build this shared library libeppic.a would
>>> be required.
>>>> The makedumpfile specific shared library will be named different - say
>>>> eppic_mkdumpfile.so to avoid conflict with crash specific libeppic.so.
>>>>
>>>> The reason for including extension_eppic.c under makedumpfile source
>>> is
>>>> because it will be dependent on other functions in makedumpfile code
>>> like dwarf
>>>> related calls etc. People modifying those functions should be aware of
>>> the
>>>> callers in extension_eppic.c and if this is included in upstream eppic
>>> code, it will
>>>> be easily overlooked (or may not be aware of its existence).
>>>
>>> The same reasons exists for applications/crash/eppic.c. It only ended up
>>> on eppic's git for two reasons. To provide for a complete example of
>>> integration into a tool and, because I originally wrote it,  I could
>>> support it from there without having to send a patch Dave's way.
>>>  
>>> I expect other applications to own their glue/integration file(s) and
>>> only grab libeppic from the git. These applications, will comply to
>>> libeppic's APIs and only fixes or new functions will be added to
>>> libeppic to support these applications and valid new requirements they
>>> may have. Like we did for mkdumpfile.
>>>
>>> Same libeppic.so and same libeppic Makefile for all.
>>
>> I am lost here. Can somebody explain this thing in layman's terms with
>> simple example. (We have a function foo() in libeppic which makeudmpfile
>> wants to call. Now what?)
>>
>> Few questions come to my mind.
>>
>> - What is glue logic and why do we need application specific glue
>>   logic to use this library.
> 
> 
> Consider this simple eppic macro, which prints the value of the global
> kernel variable "modules":
> 
> smod()
> {
> 	struct list_head *mod;
> 
> 	mod = (struct list_head *)modules;
> 	printf("Modules = %p \n", mod);
> }
> 
> Eppic has logic to interpret this C program, but needs some help in
> resolving the actual value of "modules" (as well as members of struct
> list_head) and defines few call-back functions to help it. This generic
> logic forms libeppic.a. The glue logic implements these call back
> function to help libeppic.a.
> 
> Eg: whenever libeppic.a encounters struct list_head, it calls
> apimember("list_head") call back function to learn about the details of
> the members of the structure. Glue logic implement this call-back
> function and calls libeppic.a calls with information -
> eppic_member_sname("list_head", "next"), eppic_member_sname("list_head",
> "prev") etc., inside apimember("list_head").
> 
> In crash, the glue logic contains gdb related calls and in makedumpfile
> it contains dwarf related calls to get the structure members, value of
> global variables etc. However, libeppic.a does not care what calls we
> use in the background. It just needs the data. This makes it very
> generic and powerful.
> 
> Now the glue logic along with libeppic.a makes the shared library *.so
> (named eppic.so for crash, planning to name eppic_makedumpfile.so for
> makedumpfile), which applications can dlopen().
> 
> Hope this helps.
> 
>>
>> - Assuming we need glue logic and assuming it is small enough, will
>>   it make sense to build statically build glue logic in application
>>   and build actual libeppic as shared object and do dlopen() on it.
>>
> 
> 
> Glue logic is 450K lines of code (all of them in extension_eppic.c) and


Correction: it is just 450 lines of code not 450K !!

> calls lot of eppic library calls, making this glue logic static requires
> libeppic.a to be statically included, which was our first approach.
> 
> 
>> Thanks
>> Vivek
>>
> 
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
