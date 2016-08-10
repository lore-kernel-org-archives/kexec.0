Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXT54-00087v-9u
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 12:58:00 +0000
From: Martin Wilck <mwilck@suse.de>
Subject: [PATCH 0/3] makedumpfile: fix segfault with -X in XEN environment
Date: Wed, 10 Aug 2016 14:56:55 +0200
Message-Id: <20160810125658.23366-1-mwilck@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: Martin Wilck <mwilck@suse.de>, ptesarik@suse.de, kexec@lists.infradead.org

exclude_xen4_user_domain()i calls clear_bit_on_2nd_bitmap(pfn, NULL)
to exclude domU ranges. This resolves to

  set_bitmap(info->bitmap2, pfn, 0, NULL)
  -> set_bitmap_buffer(info->bitmap2, pfn, 0, NULL)  (because bitmap2->fd == 0)
     ==> segfault, set_bitmap_buffer can't handle NULL as cycle pointer.

If non-cyclic approach is used (always under XEN AFAICS), makedumpfile needs a 
bitmap fd to avoid this crash. But info->flag_cyclic can change after 
open_dump_bitmap() is called.

This patch series fixes that by moving the call to open_dump_bitmap() after
the call to initial(). Tested successfully on both Linux and XEN, x86_64.

Also submitted to https://sourceforge.net/p/makedumpfile/patches/215/

Martin Wilck (3):
  open_dump_bitmap: open bitmap file in non-cyclic case
  move call to open_dump_bitmap() to after call to initial()
  close_dump_bitmap: simplify logic

 makedumpfile.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.9.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
