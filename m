Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WC45s-0001qF-Nx
 for kexec@lists.infradead.org; Sat, 08 Feb 2014 09:21:01 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [v3 0/3] Introduce struct cycle to store cyclic region and clean up
Date: Sat,  8 Feb 2014 17:19:25 +0800
Message-Id: <1391851168-6431-1-git-send-email-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>

v1->v2:
    In first_cycle(), start_pfn assignation is not aligned to info->pfn_cyclic.
    Now in v2 change this. Accordingly the pfn in write_elf_header() and
    write_elf_pages_cyclic() need be adjusted to the real beginning of a
    load segment, but not the cycle->start_pfn which may be lower after alignment.

v2->v3:
    Astushi and HATAYAMA found removing the pfn check in set_bitmap_cyclic will
introduce bugs. So it's better to add the pfn checking back, though there's
a little influence on perforcemance.

Baoquan He (3):
  makedumpfile: introduce struct cycle to store the cyclic region
  makedumpfile: use struct cycle to update cyclic region and clean up
  makedumpfile: remove member variables representing cyclic pfn region
    in struct DumpInfo

 makedumpfile.c | 498 ++++++++++++++++++++++++++++-----------------------------
 makedumpfile.h |  21 +--
 sadump_info.c  |   4 +-
 3 files changed, 261 insertions(+), 262 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
