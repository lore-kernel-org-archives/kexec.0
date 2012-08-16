Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1tWw-0005RL-1l
 for kexec@lists.infradead.org; Thu, 16 Aug 2012 06:26:07 +0000
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 16 Aug 2012 02:26:02 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 77EECC90026
 for <kexec@lists.infradead.org>; Thu, 16 Aug 2012 02:25:59 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7G6Pxkm29294770
 for <kexec@lists.infradead.org>; Thu, 16 Aug 2012 02:25:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7G6PwGB001891
 for <kexec@lists.infradead.org>; Thu, 16 Aug 2012 02:25:59 -0400
Message-ID: <502C9273.30504@linux.vnet.ibm.com>
Date: Thu, 16 Aug 2012 11:55:55 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] makedumpfile security key filtering with eppic
References: <20120606095709.12534.63967.stgit@aravinda>
 <20120611174432.114cdead.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120611174432.114cdead.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: mahesh@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, ananth@in.ibm.com, buendgen@de.ibm.com



On Monday 11 June 2012 02:14 PM, Atsushi Kumagai wrote:

> Hello Aravinda,
> 
> On Wed, 06 Jun 2012 15:34:23 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> makedumpfile security key filtering enhancement - Add Eppic language
>> support (formerly known as SIAL) to specify rules to scrub data in a
>> dumpfile. Eppic was previously part of crash source code repository.
>>
>> The following series of patches enhance the makedumpfile to provide
>> a more powerful way to specify rules and commands to traverse and
>> erase complex data structures in a dump file by integrating Embeddable
>> Pre-Processor and Interpreter for C (eppic).
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
> 
> Thank you for your work.
> 
> I'm afraid that I'm working on the cyclic processing feature,
> so I will start to review your patches in the middle of July or later.


Hello Kumagai-san,

Did you get a chance to review the makedumpfile security key enhancement
patches?

- Aravinda

> 
> 
> Thanks
> Atsushi Kumagai
> 
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
>>  Makefile          |    6 -
>>  dwarf_info.c      |  338 ++++++++++++++++++++++++++++++++++++++++
>>  dwarf_info.h      |   18 ++
>>  erase_info.c      |   72 ++++++++-
>>  erase_info.h      |    3 
>>  extension_eppic.c |  446 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  extension_eppic.h |   78 +++++++++
>>  makedumpfile.c    |    7 +
>>  makedumpfile.h    |    6 +
>>  9 files changed, 967 insertions(+), 7 deletions(-)
>>  create mode 100644 extension_eppic.c
>>  create mode 100644 extension_eppic.h
>>
>> -- 
>> Aravinda Prasad
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
