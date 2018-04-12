Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6Y7D-0007WR-Tb
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 09:02:01 +0000
Date: Thu, 12 Apr 2018 11:01:33 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: makedumpfile filters out wrong pages
Message-ID: <20180412110133.6d6958fc@ezekiel.suse.cz>
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

Hello,

I've just hit a nasty bug in makedumpfile when page cache is filtered
out (dump level bitmap includes 2 or 4). In short, makedumpfile checks
PG_swapcache, but since commit 6326fec1122cde256bd2a8c63f2606e08e44ce1d
this bit is an alias for PG_owner_priv_1. This bit is also used by
filesystem code (PG_checked) and Xen (PG_pinned and PG_foreign).

FTR I haven't hit an issue with the filsystem usage in practice, but
all my Xen dumps are unusable, because PG_pinned is by design set for
all page table pages.

Anyway, it appears that PG_swapcache is valid only if PG_swapbacked is
set. I have already submitted a patch to the Linux kernel to export the
value of PG_swapbacked in VMCOREINFO:

http://ozlabs.org/~akpm/mmotm/broken-out/kexec-export-pg_swapbacked-to-vmcoreinfo.patch

I plan to make the corresponding makedumpfile change soon. However, it
seems to me that PG_swapbacked alone should determine whether a page
should be kept in the dump file, or filtered out. Why do we check
PG_swapcache instead? PG_swapbacked first appeared in kernel 2.6.28,
i.e. much later than makedumpfile. Is it simply that nobody has
reviewed the logic since then?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
