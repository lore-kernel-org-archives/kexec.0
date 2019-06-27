Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hgUlf-00046p-5f
 for kexec@lists.infradead.org; Thu, 27 Jun 2019 13:48:53 +0000
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5RDmkSv029785
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Thu, 27 Jun 2019 22:48:46 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5RDmkL5012338
 for <kexec@lists.infradead.org>; Thu, 27 Jun 2019 22:48:46 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5RDmk7G015904
 for <kexec@lists.infradead.org>; Thu, 27 Jun 2019 22:48:46 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [ANNOUNCE] makedumpfile 1.6.6 is released
Date: Thu, 27 Jun 2019 13:47:40 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035794EF@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

I'm pleased to announce the release of makedumpfile 1.6.6.
Your comments/patches are welcome.

Main new features:
o Support for AMD Secure Memory Encryption
o Exclude pages that are logically offline
o Support new kernels
  - The supported kernel is updated to 5.1.9 in this version.

Changelog since v1.6.5:
0a8b504102db [v1.6.6] Update version (Kazuhito Hagio)
8c21fc7e7c52 [PATCH] Support newer kernels up to v5.1 (Kazuhito Hagio)
3222d4ad04c6 [PATCH] x86_64: fix get_kaslr_offset_x86_64() to return kaslr_offset correctly (Kazuhito Hagio)
d222b01e516b [PATCH] x86_64: Add support for AMD Secure Memory Encryption (Lianbo Jiang)
1743c7370868 [PATCH] exclude pages that are logically offline (David Hildenbrand)
feee755900e0 [PATCH] ppc64: fix a typo for checking the file pointer for null (Nisha Parrakat)
2f007b48c581 [PATCH v2] honor the CFLAGS from environment variables (Kairui Song)
b9da17259ef5 [PATCH] Some improvements of debugging messages (Kazuhito Hagio)
f349b51f6211 [PATCH] ppc64: increase MAX_PHYSMEM_BITS to 2PB (Hari Bathini)

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  The latest makedumpfile can be downloaded from the following URL.
  https://sourceforge.net/projects/makedumpfile/

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
