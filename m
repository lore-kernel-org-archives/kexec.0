Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2GBT-0002dG-Tn
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 07:09:45 +0000
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 00:09:40 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B52321FF003F
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 00:09:35 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1479axb275082
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:09:36 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r147Bw33027740
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:11:58 -0700
Subject: [PATCH v4 0/9] makedumpfile security key filtering with eppic
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 12:39:31 +0530
Message-ID: <20130204070724.9292.6640.stgit@aravinda>
MIME-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

makedumpfile security key filtering enhancement - Add Eppic language
support (formerly known as SIAL) to specify rules to scrub data in a
dumpfile. Eppic was previously part of crash source code repository.

The following series of patches enhance the makedumpfile to provide
a more powerful way to specify rules and commands to traverse and
erase complex data structures in a dump file by integrating Embeddable
Pre-Processor and Interpreter for C (eppic).

Eppic is an interpreter that facilitates access to the symbol and type
information stored in an executable image or a dump file. Eppic defines
a language semantic which is similar to C. Eppic macros can be used to
specify rules/commands to erase data in an image file. makedumpfile
will interpret the rules/commands provided by eppic macros with the
help of eppic library and will suitably erase the required data in a
dump file. Eppic provides a lot of language constructs like conditional
statements, logical and arithmetic operators, nested loops, functions,
etc., to traverse nested lists and trees and conditionally erase data
in the dump file, enabling users to literally erase any data in the
dump file which is accessible through global symbols.

The series of patches integrates eppic with makdumpfile. These patches
require eppic library libeppic.a and eppic_api.h header file. The
libeppic.a library can be built from the eppic source code available
at the following URL:

http://code.google.com/p/eppic/

TODO:

  - Currently, works only for symbols in vmlinux, extend it to module
    symbols
  - Functionality support:
    - Implement the following callback functions.
      - apialignment
      - apigetenum
      - apigetdefs
    - Other functionalities specified in the code with TODO tag
  - Support specifying eppic macros in makedumpfile.conf file
  - Update erase info

Changelog from v3 to v4:

  - Incorporated review comments from Atsushi
    - Removed obsolete symbol _init().
    - Changed to explicit initialization of dlopen library
    - Added missing -ltinfo in Makefile
  - Additional 8th patch, a hack to workaround the limitation when
    makedumpfile is compiled with "-static" flag
  - Additional 9th patch which includes man page updates

Changelog from v2 to v3:
  - Re-based to v1.5.1
  - Removed EPPIC=on option from Makefile.
  - Dynamically loads eppic shared object instead of statically linking
    - Based on the discussion in the mailing list
    - http://lists.infradead.org/pipermail/kexec/2012-December/007450.html
    - Only patches 1 and 2 are modified

Changelog from v1 to v2:

  - Re-based to v1.5.0
  - Introduced EPPIC=on in makefile, and hence eppic is now optional
  - Incorporated review comments from Atsushi
  - Minor formatting changes

Regards,
Aravinda
---

Aravinda Prasad (9):
      Initialize and setup eppic
      makedumpfile and eppic interface layer
      Eppic call back functions to query a dump image
      Implement apigetctype call back function
      Implement apimember and apigetrtype call back functions
      Extend eppic built-in functions to include memset function
      Support fully typed symbol access mode
      Hack for the limitation when compiled with -static
      Update Documentation


 Makefile          |    5 -
 dwarf_info.c      |  367 +++++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |   18 ++
 erase_info.c      |  116 +++++++++++++-
 erase_info.h      |   17 ++
 extension_eppic.c |  452 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   95 +++++++++++
 makedumpfile.8    |   18 ++
 makedumpfile.c    |    7 +
 makedumpfile.h    |    6 +
 print_info.c      |   13 +-
 11 files changed, 1105 insertions(+), 9 deletions(-)
 create mode 100644 extension_eppic.c
 create mode 100644 extension_eppic.h

-- 
Aravinda Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
