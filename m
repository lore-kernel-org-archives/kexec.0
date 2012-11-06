Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TVgBY-0001Sd-OY
 for kexec@lists.infradead.org; Tue, 06 Nov 2012 10:15:10 +0000
Date: Tue, 6 Nov 2012 19:01:04 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC] makedumpfile-1.5.1 beta
Message-Id: <20121106190104.2668fb1973c4bba3096d87a4@mxc.nes.nec.co.jp>
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
To: kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, d.hatayama@jp.fujitsu.com

Hello,

This is the makedumpfile version 1.5.1-beta.
Your comments/patches are welcome.

  http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/v1.5.1-beta

Changelog:
o New feature
   Commits related to "Support for Xen4"
    - [PATCH v3 1/9] Make max_pfn symbol optional for Xen dumps. (by Petr Tesarik) 23da549
    - [PATCH v3 2/9] Xen: Fix the offset of the _domain field in struct page_info. (by Petr Tesarik) 1ac5f1e
    - [PATCH v3 3/9] Read the Xen crash ELF note into memory at startup. (by Petr Tesarik) fef3d0b
    - [PATCH v3 4/9] Split Xen setup into early and late. (by Petr Tesarik) 10eaae3
    - [PATCH v3 5/9] Initialize phys_start during early Xen setup. (by Petr Tesarik) f10acb7
    - [PATCH v3 6/9] Fix domain pickled_id computation for xen-3.4+. (by Petr Tesarik) 82f8779
    - [PATCH v3 7/9] Support Xen4 virtuall address space layout. (by Petr Tesarik) 3c5f397
    - [PATCH v3 8/9] Add support for filtering out user pages under Xen4. (by Petr Tesarik) a98a2cc
    - [PATCH v3 9/9] Do not fail for symbols removed in Xen4. (by Petr Tesarik) c3b1c4b
    - [PATCH] Initialize Xen structures from initial(). (by Petr Tesarik) 825ac46

   Commits related to "Support for snappy compression"
    - [PATCH 1/8] Add dump header for snappy. (by HATAYAMA Daisuke) aee4c39
    - [PATCH 2/8] Add command-line processing for snappy. (by HATAYAMA Daisuke) 8f445cd
    - [PATCH 3/8] Add snappy build support. (by HATAYAMA Daisuke) eddab4f
    - [PATCH 4/8] Notify snappy unsupporting when disabled. (by HATAYAMA Daisuke) f700ffc
    - [PATCH 5/8] Add compression processing. (by HATAYAMA Daisuke) 6320708
    - [PATCH 6/8] Add uncompression processing. (by HATAYAMA Daisuke) c0ff6ab
    - [PATCH 7/8] Add help message. (by HATAYAMA Daisuke) dcd1ec0
    - [PATCH 8/8] Add manual description. (by HATAYAMA Daisuke) bba7e63

   Other commit
    - [PATCH] keep dumpfile pages in a cache. (by Petr Tesarik) d9b6413
    - [PATCH] Support for x86_64 1G pages. (by Petr Tesarik) 8389acb
    - [PATCH] Change dwarf analyzer to search also into named containers. (by Atsushi Kumagai) 9478aa1
    - [PATCH] s390x: Add 2GB frame support for page table walker. (by Michael Holzheu) f7aff3e

o Bugfix
    - [PATCH] add a missing return statement. (by Petr Tesarik) 0d3488d

> Now, I plan to do the two enhancement for performance, please see below.
>
>  in v1.5.1:
>    - Minimize the number of cycle
>      http://lists.infradead.org/pipermail/kexec/2012-October/006864.html
>
>  in v1.5.2:
>    - Improve the filtering logic
>      http://lists.infradead.org/pipermail/kexec/2012-June/006441.html

I said in another thread as above, but now I plan to include the later into
v1.5.1 too because I realized that it's important feature for many users by
some comments.

So as a next step, I'll merge the two enhancement above and the eppic support
onto v1.5.1-beta, it will be v1.5.1-rc and I will release it in Nov 16.

TODO for v1.5.1-rc:

  1. To minimize the number of cycle
     I'm doing this now.

  2. To add the mem_map array logic (Improve the filtering logic)
     Hatayama-san, would you re-send the mem_map array patchset
     based on v1.5.1-beta ?

  3. To add the eppic support for security key filtering
     Aravinda is making v2 patchset now, so I'm waiting for them.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
