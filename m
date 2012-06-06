Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScD6Q-0005Tr-EU
 for kexec@lists.infradead.org; Wed, 06 Jun 2012 10:04:35 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 06:04:32 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EC7516E8049
 for <kexec@lists.infradead.org>; Wed,  6 Jun 2012 06:04:28 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56A4S7Y181980
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 06:04:28 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56A4RS6004704
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 04:04:28 -0600
Subject: [PATCH 0/7] makedumpfile security key filtering with eppic
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2012 15:34:23 +0530
Message-ID: <20120606095709.12534.63967.stgit@aravinda>
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
To: kexec@lists.infradead.org
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com

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

---

Aravinda Prasad (7):
      Initialize and setup eppic
      makedumpfile and eppic interface layer
      Eppic call back functions to query a dump image
      Implement apigetctype call back function
      Implement apimember and apigetrtype call back functions
      Extend eppic built-in functions to include memset function
      Support fully typed symbol access mode


 Makefile          |    6 -
 dwarf_info.c      |  338 ++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |   18 ++
 erase_info.c      |   72 ++++++++-
 erase_info.h      |    3 
 extension_eppic.c |  446 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   78 +++++++++
 makedumpfile.c    |    7 +
 makedumpfile.h    |    6 +
 9 files changed, 967 insertions(+), 7 deletions(-)
 create mode 100644 extension_eppic.c
 create mode 100644 extension_eppic.h

-- 
Aravinda Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
