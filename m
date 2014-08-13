Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHVpy-00063k-1x
 for kexec@lists.infradead.org; Wed, 13 Aug 2014 10:31:23 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v3 0/2] PPC64: Add virtual to physical address
 translation support for vmalloc region
Date: Wed, 13 Aug 2014 10:29:37 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9724C642@BPXM01GP.gisp.nec.co.jp>
References: <20140808132231.11571.34725.stgit@localhost.localdomain>
In-Reply-To: <20140808132231.11571.34725.stgit@localhost.localdomain>
Content-Language: ja-JP
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
To: "hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>
Cc: Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>In makedumpfile tool, currently there is no support for virtual to physical
>address translation of vmalloc region  on PPC64 architecture. These patches
>add this support.  The patches have been tested by  erasing data in vmalloc
>region, verfying for eraseinfo in the resultant ELF dump and verifiying the
>resultant ELF dump for sanity using crash utility. Also, tested the patches
>successfully with eppic scripts.
>
>Changes in v3:
>Added the buffer to read page tables in DumpInfo structure and freeing it
>before exiting the tool

Thanks Hari, I'll merge this version into v1.5.7.


Atsushi Kumagai

>---
>
>Hari Bathini (2):
>      makedumpfile: Initialize for vmalloc address translation support in PPC64 arch
>      makedumpfile: vtop address translation support for vmalloc region in PPC64 arch
>
>
> arch/ppc64.c   |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
> makedumpfile.c |    9 +++
> makedumpfile.h |   83 +++++++++++++++++++++++++++
> 3 files changed, 249 insertions(+), 13 deletions(-)
>
>--
>- Hari
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
