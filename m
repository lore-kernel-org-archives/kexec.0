Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TSmOa-0000rA-OT
 for kexec@lists.infradead.org; Mon, 29 Oct 2012 10:16:37 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 29 Oct 2012 04:16:32 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id ED41E1FF0042
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2012 04:15:41 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9TAFhCF224152
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2012 04:15:43 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9TAHPH7026288
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2012 04:17:26 -0600
Message-ID: <508E5749.7050408@linux.vnet.ibm.com>
Date: Mon, 29 Oct 2012 15:45:37 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] makedumpfile security key filtering with eppic
References: <20120606095709.12534.63967.stgit@aravinda>
 <20121029170641.40b19d2ba2635804dbf8eb31@mxc.nes.nec.co.jp>
In-Reply-To: <20121029170641.40b19d2ba2635804dbf8eb31@mxc.nes.nec.co.jp>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hi Atsushi,

Thanks for reviewing. I will work on your comments.

On 2012-10-29 13:36, Atsushi Kumagai wrote:

> Hello Aravinda,
> 
> Now, I have reviewed your patches to [PATCH 4/7], 
> so please give me a little more time.
>


sure...

 
> BTW, do you have any test case for this feature ?
> If you can give it to me, it's very helpful.
>


I have developed few semi-automated tests. I will automate it completely
and mail it to you in 2-3 days.

 
> 
> Thanks
> Atsushi Kumagai
> 
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
>>
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
