Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMV4l-0035E0-O6
 for kexec@lists.infradead.org; Wed, 17 Mar 2021 12:15:02 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Miscellaneous 32-bit fixes
Date: Wed, 17 Mar 2021 13:14:47 +0100
Message-Id: <20210317121450.2556349-1-geert+renesas@glider.be>
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
To: Simon Horman <horms@verge.net.au>
Cc: Varad Gautam <vrd@amazon.de>, John Ogness <john.ogness@linutronix.de>, kexec@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon,

This patch series fixes several compile warnings when building for a
32-bit platform.  All but the last one are real bugs, from a functional
point of view.

Thanks for your comments!

Geert Uytterhoeven (3):
  kexec: Use %llu/%llx and casts to format uint64_t
  printk: Use ULL suffix for 64-bit constants
  printk: Use %zu to format size_t

 kexec/kexec.c       | 3 ++-
 util_lib/elf_info.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
