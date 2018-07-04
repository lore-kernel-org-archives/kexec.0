Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fagzv-0000VJ-5v
 for kexec@lists.infradead.org; Wed, 04 Jul 2018 12:35:05 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BA00DFD3
 for <kexec@lists.infradead.org>; Wed,  4 Jul 2018 12:34:51 +0000 (UTC)
Received: from [10.10.121.14] (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29DDF7C53
 for <kexec@lists.infradead.org>; Wed,  4 Jul 2018 12:34:51 +0000 (UTC)
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: makedumpfile-1.6.4: Add support for 5-level paging
Message-ID: <eea629e2-86ba-ff1a-3db0-599eb40e53ab@redhat.com>
Date: Wed, 4 Jul 2018 08:34:50 -0400
MIME-Version: 1.0
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

makedumpfile version 1.6.4 is released.
Your comments/patches are welcome.

I took over the maintainer role from Tachibana-san. Thank you so much
for development and maintenance of makedumpfile for a long time!
And I'm pleased to work on makedumpfile with everyone here. The maintainer
changed to me, but there is no need to change your way of contribution.

Main new features:
o 5-level paging support
  - 5-level paging on x86_64 system is supported from this version.

o --mem-usage support for arm64
  - The makedumpfile --mem-usage option is now supported on arm64 system.
    And the option was also tested on ppc64 and s390x by Bhupesh Sharma.

o Support new kernels
  - The supported kernel is updated to 4.17.0 in this version.

Changelog:
o New feature
  - [PATCH v2 0/3] arm64: Add '--mem-usage' support (Bhupesh Sharma) f49ca13
  - [PATCH v2 1/3] Add a new helper file 'tools.c' that provides some useful APIs (Bhupesh Sharma) 4d86cc7
  - [PATCH v2 2/3] arm64: Add support to read symbols like _stext from '/proc/kallsyms' (Bhupesh Sharma) d1e7805
  - [PATCH v2 3/3] Documentation: Update documentation regarding --mem-usage' option (Bhupesh Sharma) 8449bda
  - [PATCH 0/4] Add 5-level paging support (Baoquan He) 342fdab
  - [PATCH 2/4] Add pgtable_l5_enabled to number_table (Baoquan He) 8ae6f36
  - [PATCH 3/4] Add a new function check_5level_paging() (Baoquan He) 33ca808
  - [PATCH 4/4] arch/x86_64: Add 5-level paging support (Dou Liyang) 30a3214
  - [PATCH] handle mem_section as either a pointer or an array (Thadeu Lima de Souza Cascardo) 14876c4
  - [PATCH] ppc64: Increase the VA range (Hari Bathini) bd1ae9c

o Bugfix
  - [PATCH] sadump: Fix a problem of PTI enabled kernel (Takao Indoh) 38de12a
  - [PATCH] Fix a bug when multi-threads feature meets enospace (Zhou Wenjian) 63b05c9
  - [PATCH] Fix array index out of bound exception (Lianbo Jiang) e5f96e7
  - [PATCH] fix for hugepages filtering (Hari Bathini) 246801c
  - [PATCH v2] Use integer arithmetics for the progress bar (Petr Tesarik) c6b79cb
  - [PATCH 2/2] Check PG_swapbacked for swap cache pages (Petr Tesarik) ca1f31e
  - [PATCH] Fix -g for change of mem_section (Kazuhito Hagio) f3c87e0
  - [PATCH] Fix -i for KASLR (Kazuhito Hagio) 08db98c
  - [PATCH] Fix validate_mem_section() (Kazuhito Hagio) 8f1aafa
  - [PATCH] arm64: Fix calculation of page_offset in case we are running cases other than mem-usage
      (Bhupesh Sharma) cb7af5f

o Cleanup
  - [PATCH v2] Always use bigger SECTION_MAP_MASK (Petr Tesarik) 6c6789f
  - [PATCH 1/2] Add is_cache_page() helper to check if a page belongs to the cache (Petr Tesarik) 694f28c
  - [PATCH 1/4] arch/x86_64: Cleanup the address translation of the 4-level page tables (Dou Liyang) acab2a2
  - [PATCH] Fix some compilation warnings on x86 system (Kazuhito Hagio) 2148e43
  - [PATCH] Update maintainers (Masaki Tachibana) bc7420b

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile from the following URL.
  Details of the change are written on the git page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-x.y.z.tar.gz"
  2. "cd makedumpfile-x.y.z"
  3. "make; make install"

Usage:
  makedumpfile [-c|-l|-p] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.

  # makedumpfile -c -d 31 /proc/vmcore dumpfile


Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
