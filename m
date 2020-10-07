Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ3Nm-000177-Gt
 for kexec@lists.infradead.org; Wed, 07 Oct 2020 06:57:03 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 0/3] makedumpfile: Clean up unused code
Date: Wed,  7 Oct 2020 08:56:49 +0200
Message-Id: <20201007065652.28160-1-ptesarik@suse.com>
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
To: Kazuhito Hagio <k-hagio-ab@nec.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

I have noticed that some code in makedumpfile is either unused, or
not really needed for correct operation. I suggest to remove that
code, so other people don't have to waste time wondering why it is
there.

Petr Tesarik (3):
  Cleanup: Remove a superfluous seek to physical address 0
  Cleanup: Remove unused elf_info.c functions
  Cleanup: Remove offset_pt_load_memory

 elf_info.c     | 83 --------------------------------------------------
 elf_info.h     |  4 ---
 makedumpfile.c | 11 -------
 3 files changed, 98 deletions(-)

-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
