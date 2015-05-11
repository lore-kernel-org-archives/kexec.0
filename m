Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhMz-0005bN-Dm
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:39:18 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6coKD006328
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:38:50 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6cnv07200 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:38:50 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6cnfH010664
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:38:49 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using bitmap
 file.
Date: Mon, 11 May 2015 06:13:51 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA325@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This is the patch set to avoid two pass filtering, it is the
finished version of the previous patch set below:

  http://lists.infradead.org/pipermail/kexec/2015-March/013497.html


cyclic mode has to take a two-pass approach for filtering to save on the
memory consumption, it's a disadvantage of the cyclic mode and it's basically
unavoidable. However, even the cyclic mode can avoid two-pass filtering if free
memory space is enough to store the whole 1st and 2nd bitmaps, but the current
version doesn't it.
The main purpose of this patch set is avoiding that useless filtering,
but before that, I merged non-cyclic mode into cyclic mode as code clean up 
because the codes are almost the same. Instead, I introduce another way to
guarantee one-pass filtering by using disk space.


MAJOR CHANGES

1. Introduce --work-dir option instead of --non-cyclic

  --non-cyclic option were used to choose the non-cyclic mode, it realizes
  one-pass filtering by creating a temporary bitmap file on TMPDIR.
  The new option "--work-dir" is used to specify a working directory
  to store the bitmap file, so this is the alternative to the combination of
  --non-cyclic and TMPDIR.

2. Remove extra page filtering

  If free memory space is enough to store the whole 1st and 2nd bitmaps
  (or --work-dir is specified), page filtering and creating bitmaps are
  done only once before writing process. Otherwise the bitmaps are created
  twice; to decide the offset of the page header region, and for actual
  page writing process, as usual.

INTERNAL CHANGE

  info->flag_cyclic indicated whether the internal mode is cyclic or non-cyclic.
  Now, since the two modes are merged, the flag means that filtering process will
  take multi cycles, i.e. it has to take a two-pass approach.


Atsushi Kumagai (13):
  Organize bitmap structure for cyclic logic.
  Add option to specify working directory for the bitmap.
  Integrate the entry point of is_dumpable().
  Integrate the main logic of writing kdump file.
  Communalize the function for creating 1st bitmap.
  Remove the old logic of writing kdump pages.
  Integrate filtering process for ELF path.
  Remove the old logic of writing ELF pages.
  Adjust --mem-usage path to the new code.
  Adjust --split/--reassemble path to the new code.
  Adjust refiltering path to the new code.
  Adjust sadump path to the new code.
  Remove --non-cyclic option.

 README         |   16 -
 makedumpfile.8 |   32 +-
 makedumpfile.c | 1624 ++++++++++++++++++--------------------------------------
 makedumpfile.h |   41 +-
 print_info.c   |   23 +-
 sadump_info.c  |    8 +-
 6 files changed, 588 insertions(+), 1156 deletions(-)

--
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
