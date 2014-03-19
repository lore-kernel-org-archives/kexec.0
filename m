Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQKl2-000357-CV
 for kexec@lists.infradead.org; Wed, 19 Mar 2014 17:58:28 +0000
Date: Wed, 19 Mar 2014 11:57:57 -0600
From: Linn Crosetto <linn@hp.com>
Subject: Re: [PATCH v4 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140319175757.GC31785@oranje.fc.hp.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com

On Wed, Mar 19, 2014 at 04:03:57PM +0800, WANG Chao wrote:
> Hi, All
> 
> When kaslr comes in and kdump is broken, it seems about the right time to use
> E820 instead of memmap=exactmap to pass memmap for kdump for the default memmap
> passing mechanism:
> http://lists.infradead.org/pipermail/kexec/2014-February/011048.html
> 
> Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> like the only one). So for backward compatibility, I'm introducing a new option
> --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> 
> Any comment is appreciate!
> 
> v3->v4:
> Linn: check return value of malloc (use xmalloc)
> me: fix dbgprintf_mem_range
> 
> v2->v3:
> Linn:
>  - do not free sd (setup_data) buffer
>  - reuse code in setup_e820 and setup_e820_ext
> 
> v1->v2:
> 
> Vivek:
>  - Use function instead of macro for dbgprint_mem_range
>  - Do not pass reserved memory range for kdump. It could addressed later
>    separately.
> 
> WANG Chao (4):
>   cleanup: add dbgprint_mem_range function
>   x86: Store memory ranges globally used for crash kernel to boot into
>   x86: add --pass-memmap-cmdline option
>   x86: Pass memory range via E820 for kdump
> 
>  kexec/arch/i386/crashdump-x86.c        | 157 ++++++++++++++++--------------
>  kexec/arch/i386/crashdump-x86.h        |   6 +-
>  kexec/arch/i386/include/arch/options.h |   2 +
>  kexec/arch/i386/kexec-x86-common.c     |   6 +-
>  kexec/arch/i386/kexec-x86.c            |   4 +
>  kexec/arch/i386/kexec-x86.h            |   1 +
>  kexec/arch/i386/x86-linux-setup.c      | 171 ++++++++++++++++++++++-----------
>  kexec/arch/i386/x86-linux-setup.h      |   1 +
>  kexec/arch/x86_64/kexec-x86_64.c       |   5 +
>  kexec/kexec.c                          |  10 ++
>  kexec/kexec.h                          |   1 +
>  11 files changed, 231 insertions(+), 133 deletions(-)

Thanks for the patches. Tested (adding a fix provided by Dave Young for
http://lists.infradead.org/pipermail/kexec/2014-March/011262.html) and
successful with both kexec and kdump, both with and without
--pass-memmap-cmdline.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
