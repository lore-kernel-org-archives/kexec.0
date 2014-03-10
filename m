Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WN1pf-0000zA-KE
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 15:09:36 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v3 0/4] kexec-tools, x86: E820 memmap pass for kdump
Date: Mon, 10 Mar 2014 23:09:05 +0800
Message-Id: <1394464149-30384-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Hi, All

When kaslr comes in and kdump is broken, it seems about the right time to use
E820 instead of memmap=exactmap to pass memmap for kdump for the default memmap
passing mechanism:
http://lists.infradead.org/pipermail/kexec/2014-February/011048.html

Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
like the only one). So for backward compatibility, I'm introducing a new option
--pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.

Any comment is appreciate!

v2->v3:
Linn: do not free sd (setup_data) buffer

v1->v2:

Vivek:
 - Use function instead of macro for dbgprint_mem_range
 - Do not pass reserved memory range for kdump. It could addressed later
   separately.

WANG Chao (4):
  cleanup: add dbgprint_mem_range function
  x86: Store memory ranges globally used for crash kernel to boot into
  x86: add --pass-memmap-cmdline option
  x86: Pass memory range via E820 for kdump

 kexec/arch/i386/crashdump-x86.c        | 157 ++++++++++++++++--------------
 kexec/arch/i386/crashdump-x86.h        |   6 +-
 kexec/arch/i386/include/arch/options.h |   2 +
 kexec/arch/i386/kexec-x86-common.c     |   6 +-
 kexec/arch/i386/kexec-x86.c            |   4 +
 kexec/arch/i386/kexec-x86.h            |   1 +
 kexec/arch/i386/x86-linux-setup.c      | 171 ++++++++++++++++++++++-----------
 kexec/arch/i386/x86-linux-setup.h      |   1 +
 kexec/arch/x86_64/kexec-x86_64.c       |   5 +
 kexec/kexec.c                          |  10 ++
 kexec/kexec.h                          |   1 +
 11 files changed, 231 insertions(+), 133 deletions(-)

-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
