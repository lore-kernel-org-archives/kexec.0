Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6GYe-00030T-Nw
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 15:53:58 +0000
Subject: Re: [PATCH v5 0/7] kexec: add generic support for elf kernel images
References: <20190823194919.30916-1-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <22b40bb7-6f86-0a69-12b2-12d90124173d@gmx.de>
Date: Fri, 6 Sep 2019 17:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190823194919.30916-1-svens@stackframe.org>
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
To: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Hi all,

This kexec patch series is the groundwork for kexec on the parisc architecture.
Since we want kexec on parisc, I've applied it to my for-next-kexec tree [1],
and can push it to Linus in the next merge window through the parisc tree [2].

If someone has any objections, or if you prefer to take it through
a kexec or powerpc tree, please let me know.

Helge

[1] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next-kexec
[2] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next

On 23.08.19 21:49, Sven Schnelle wrote:
> Changes to v4:
>  - rebase on current powerpc/merge tree
>  - fix syscall name in commit message
>  - remove a few unused #defines in arch/powerpc/kernel/kexec_elf_64.c
>...
>  arch/Kconfig                                  |   3 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/powerpc/kernel/kexec_elf_64.c            | 545 +-----------------
>  include/linux/kexec.h                         |  23 +
>  kernel/Makefile                               |   1 +
>  .../kexec_elf_64.c => kernel/kexec_elf.c      | 394 +++----------
>  6 files changed, 115 insertions(+), 852 deletions(-)
>  copy arch/powerpc/kernel/kexec_elf_64.c => kernel/kexec_elf.c (50%)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
