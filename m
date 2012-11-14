Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYRbd-0002d0-2m
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 01:17:31 +0000
Date: Wed, 14 Nov 2012 10:15:10 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-Id: <20121114101510.fb18ea7444731379828a7efc@mxc.nes.nec.co.jp>
In-Reply-To: <20121108133554.28410.99763.stgit@aravinda>
References: <20121108133554.28410.99763.stgit@aravinda>
Mime-Version: 1.0
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
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hello Aravinda,

On Thu, 08 Nov 2012 19:07:52 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> makedumpfile security key filtering enhancement - Add Eppic language
> support (formerly known as SIAL) to specify rules to scrub data in a
> dumpfile. Eppic was previously part of crash source code repository.
> 
> The following series of patches enhance the makedumpfile to provide
> a more powerful way to specify rules and commands to traverse and
> erase complex data structures in a dump file by integrating Embeddable
> Pre-Processor and Interpreter for C (eppic).
> 
> Eppic is an interpreter that facilitates access to the symbol and type
> information stored in an executable image or a dump file. Eppic defines
> a language semantic which is similar to C. Eppic macros can be used to
> specify rules/commands to erase data in an image file. makedumpfile
> will interpret the rules/commands provided by eppic macros with the
> help of eppic library and will suitably erase the required data in a
> dump file. Eppic provides a lot of language constructs like conditional
> statements, logical and arithmetic operators, nested loops, functions,
> etc., to traverse nested lists and trees and conditionally erase data
> in the dump file, enabling users to literally erase any data in the
> dump file which is accessible through global symbols.
> 
> The series of patches integrates eppic with makdumpfile. These patches
> require eppic library libeppic.a and eppic_api.h header file. The
> libeppic.a library can be built from the eppic source code available
> at the following URL:
> 
> http://code.google.com/p/eppic/

Thank you for re-sending your patches, I'll merge them into v1.5.1-rc.
And thanks for sending your test script, it's helpful for understanding
how to use eppic macro.


Atsushi Kumagai

> 
> TODO:
> 
>   - Currently, works only for symbols in vmlinux, extend it to module
>     symbols
>   - Functionality support:
>     - Implement the following callback functions.
>       - apialignment
>       - apigetenum
>       - apigetdefs
>     - Other functionalities specified in the code with TODO tag
>   - Support specifying eppic macros in makedumpfile.conf file
>   - Update erase info
> 
> Changelog from v1 to v2:
> 
>   - Re-based to v1.5.0
>   - Introduced EPPIC=on in makefile, and hence eppic is now optional
>   - Incorporated review comments from Atsushi
>   - Minor formatting changes
> 
> Regards,
> Aravinda
> ---
> 
> Aravinda Prasad (7):
>       Initialize and setup eppic
>       makedumpfile and eppic interface layer
>       Eppic call back functions to query a dump image
>       Implement apigetctype call back function
>       Implement apimember and apigetrtype call back functions
>       Extend eppic built-in functions to include memset function
>       Support fully typed symbol access mode
> 
> 
>  Makefile          |    7 +
>  dwarf_info.c      |  367 +++++++++++++++++++++++++++++++++++++++++++
>  dwarf_info.h      |   18 ++
>  erase_info.c      |   83 +++++++++-
>  erase_info.h      |    5 +
>  extension_eppic.c |  451 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  extension_eppic.h |   78 +++++++++
>  makedumpfile.c    |    7 +
>  makedumpfile.h    |    6 +
>  9 files changed, 1018 insertions(+), 4 deletions(-)
>  create mode 100644 extension_eppic.c
>  create mode 100644 extension_eppic.h
> 
> -- 
> Aravinda Prasad
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
