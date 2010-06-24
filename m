Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1ORvov-0008AH-Np
	for kexec@lists.infradead.org; Thu, 24 Jun 2010 23:26:59 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5ONQqHK021266
	for <kexec@lists.infradead.org>; Fri, 25 Jun 2010 08:26:52 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id o5ONQqX11679 for kexec@lists.infradead.org;
	Fri, 25 Jun 2010 08:26:52 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5ONQpXX015225
	for <kexec@lists.infradead.org>; Fri, 25 Jun 2010 08:26:51 +0900 (JST)
Date: Fri, 25 Jun 2010 07:53:15 +0900 (JST)
Message-Id: <20100625.075315.135973515.igawa@mxs.nes.nec.co.jp>
Subject: makedumpfile-1.3.6: Use TMPDIR environment variable to avoid
	output files filling ramdisk
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
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

Hi,

makedumpfile version 1.3.6 is released.
Your comments/patches are welcome.

Changelog:
o New feature
  - Use TMPDIR environment variable to avoid output files filling ramdisk (by Cliff Wickman) 4d5bca2
    makedumpfile writes bitmap files to "/tmp/...". But these can be very large
    if the machine has lots of memory, and so writing the file can fail.
    (e.g. when you use tmpfs on /tmp)
    This feature is to avoid this failure. If a TMPDIR environment variable is set, 
    makedumpfile uses it for the bitmap file. If you do not set a TMPDIR environment
    variable, makedumpfile uses /tmp directory for the temporary bitmap file as a default.
  - [PATCH] Add linux-2.6.32 - 2.6.34 support. (by Masayuki Igawa) 69bbfaf

o Bugfix
  - [PATCH] Fix buffer overflow when writing dh->signature. (by Bernhard Walle) 4a16bd3
  - [PATCH] handle !SPARSEMEM_EX properly. (by Masayuki Igawa) 27b7156

o Code Cleanup
  - [PATCH] Fix 'struct kdump_sub_header' member in IMPLEMENTATION (by Masayuki Igawa) 7e50de2
  - [PATCH] fix typo in IMPLEMENTATION (by Masayuki Igawa) fad7bf0
  - [PATCH] add mainteners (by Masayuki Igawa) cc9afed
  - [PATCH] add TMPDIR description (by Masayuki Igawa) 45a60da
  - [PATCH] add .gitignore file (by Masayuki Igawa) 538528e
  - makedumpfile: works on 2.6.32 (by Cliff Wickman) 060be6f
  - [PATCH] Cleanup: the initialization method is operated if it is possible. (by Ken'ichi Ohmichi) ef86f0f

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
  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.

  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile

Thanks
Masayuki Igawa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
