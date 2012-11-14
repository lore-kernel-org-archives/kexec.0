Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYgia-0001Mo-1q
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 17:25:42 +0000
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 14 Nov 2012 12:24:27 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A709E38C8C8B
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2012 12:08:26 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAEH8Pnq314050
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2012 12:08:25 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAEH7mWw005165
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2012 10:07:50 -0700
Message-ID: <50A3CFAD.6090008@linux.vnet.ibm.com>
Date: Wed, 14 Nov 2012 22:36:53 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com>
In-Reply-To: <20121114145445.GC20215@redhat.com>
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

Hi Vivek,

On 2012-11-14 20:24, Vivek Goyal wrote:

> On Thu, Nov 08, 2012 at 07:07:52PM +0530, Aravinda Prasad wrote:
>> makedumpfile security key filtering enhancement - Add Eppic language
>> support (formerly known as SIAL) to specify rules to scrub data in a
>> dumpfile. Eppic was previously part of crash source code repository.
>>
>> The following series of patches enhance the makedumpfile to provide
>> a more powerful way to specify rules and commands to traverse and
>> erase complex data structures in a dump file by integrating Embeddable
>> Pre-Processor and Interpreter for C (eppic).
> 
> Hi Aravinda,
> 
> Had few questions.
> 
> - Which file will contain all the rules?


As of now rule files will not be provided by makedumpfile. However,
writing a rule file is very easy - it is a C program.

> 
> - What's the memory footprint of libeppic.a? Looks like this will be
>   linked statically with makedumpfile, and how much is the size bloat of
>   makedumpfile.


Memory footprint of libeppic.a is around 1MB. Yes, this will be
statically linked to makedumpfile. Users should specify EPPIC=on while
building the makedumpfile and hence linking libeppic.a is optional

> 
> - Is this supposed to work from kdump initramfs or it is supposed to be
>   used on already saved dump (later during post processing).


For the time being, it is only during post processing.

> 
>   Given the fact that it does not reduce the size of core file
>   significantly, I would think that it is better to post process vmcore
>   to wipe out some symbols.


The main intention is to remove confidential information from the dump
file, like ssh keys etc., which could be just few bytes, hence, may not
reduce the size of the dump significantly.

> 
> Thanks
> Vivek 
> 
>>
>> Eppic is an interpreter that facilitates access to the symbol and type
>> information stored in an executable image or a dump file. Eppic defines
>> a language semantic which is similar to C. Eppic macros can be used to
>> specify rules/commands to erase data in an image file. makedumpfile
>> will interpret the rules/commands provided by eppic macros with the
>> help of eppic library and will suitably erase the required data in a
>> dump file. Eppic provides a lot of language constructs like conditional
>> statements, logical and arithmetic operators, nested loops, functions,
>> etc., to traverse nested lists and trees and conditionally erase data
>> in the dump file, enabling users to literally erase any data in the
>> dump file which is accessible through global symbols.
>>
>> The series of patches integrates eppic with makdumpfile. These patches
>> require eppic library libeppic.a and eppic_api.h header file. The
>> libeppic.a library can be built from the eppic source code available
>> at the following URL:
>>
>> http://code.google.com/p/eppic/
>>
>> TODO:
>>
>>   - Currently, works only for symbols in vmlinux, extend it to module
>>     symbols
>>   - Functionality support:
>>     - Implement the following callback functions.
>>       - apialignment
>>       - apigetenum
>>       - apigetdefs
>>     - Other functionalities specified in the code with TODO tag
>>   - Support specifying eppic macros in makedumpfile.conf file
>>   - Update erase info
>>
>> Changelog from v1 to v2:
>>
>>   - Re-based to v1.5.0
>>   - Introduced EPPIC=on in makefile, and hence eppic is now optional
>>   - Incorporated review comments from Atsushi
>>   - Minor formatting changes
>>
>> Regards,
>> Aravinda
>> ---
>>
>> Aravinda Prasad (7):
>>       Initialize and setup eppic
>>       makedumpfile and eppic interface layer
>>       Eppic call back functions to query a dump image
>>       Implement apigetctype call back function
>>       Implement apimember and apigetrtype call back functions
>>       Extend eppic built-in functions to include memset function
>>       Support fully typed symbol access mode
>>
>>
>>  Makefile          |    7 +
>>  dwarf_info.c      |  367 +++++++++++++++++++++++++++++++++++++++++++
>>  dwarf_info.h      |   18 ++
>>  erase_info.c      |   83 +++++++++-
>>  erase_info.h      |    5 +
>>  extension_eppic.c |  451 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  extension_eppic.h |   78 +++++++++
>>  makedumpfile.c    |    7 +
>>  makedumpfile.h    |    6 +
>>  9 files changed, 1018 insertions(+), 4 deletions(-)
>>  create mode 100644 extension_eppic.c
>>  create mode 100644 extension_eppic.h
>>
>> -- 
>> Aravinda Prasad
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
