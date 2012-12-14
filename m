Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjRWw-0000IN-Bp
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 09:26:07 +0000
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 14 Dec 2012 02:26:03 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EAC6C1FF003E
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 02:25:52 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBE9PxMb165580
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 02:25:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBE9Pxt3013672
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 02:25:59 -0700
Subject: [PATCH v3 0/7] makedumpfile security key filtering with eppic
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 14 Dec 2012 14:55:53 +0530
Message-ID: <20121214092300.4854.30720.stgit@aravinda>
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
Cc: LChouinard@s2sys.com, mahesh@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

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

Aravinda Prasad (7):
      Initialize and setup eppic
      makedumpfile and eppic interface layer
      Eppic call back functions to query a dump image
      Implement apigetctype call back function
      Implement apimember and apigetrtype call back functions
      Extend eppic built-in functions to include memset function
      Support fully typed symbol access mode


 Makefile          |    5 -
 dwarf_info.c      |  367 +++++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |   18 ++
 erase_info.c      |   91 ++++++++++-
 erase_info.h      |    1 
 extension_eppic.c |  451 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   75 +++++++++
 makedumpfile.c    |    7 +
 makedumpfile.h    |    6 +
 9 files changed, 1016 insertions(+), 5 deletions(-)
 create mode 100644 extension_eppic.c
 create mode 100644 extension_eppic.h

-- 
Aravinda Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
