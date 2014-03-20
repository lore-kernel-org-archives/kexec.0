Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQV6b-0002z8-Tx
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 05:01:26 +0000
Date: Thu, 20 Mar 2014 13:00:49 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v4 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140320050049.GE24486@dhcp-17-89.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <20140319175757.GC31785@oranje.fc.hp.com>
 <20140320035012.GC10601@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140320035012.GC10601@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Linn Crosetto <linn@hp.com>, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 03/20/14 at 12:50pm, Simon Horman wrote:
> On Wed, Mar 19, 2014 at 11:57:57AM -0600, Linn Crosetto wrote:
> > On Wed, Mar 19, 2014 at 04:03:57PM +0800, WANG Chao wrote:
> > > Hi, All
> > > 
> > > When kaslr comes in and kdump is broken, it seems about the right time to use
> > > E820 instead of memmap=exactmap to pass memmap for kdump for the default memmap
> > > passing mechanism:
> > > http://lists.infradead.org/pipermail/kexec/2014-February/011048.html
> > > 
> > > Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> > > like the only one). So for backward compatibility, I'm introducing a new option
> > > --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> > > 
> > > Any comment is appreciate!
> > > 
> > > v3->v4:
> > > Linn: check return value of malloc (use xmalloc)
> > > me: fix dbgprintf_mem_range
> > > 
> > > v2->v3:
> > > Linn:
> > >  - do not free sd (setup_data) buffer
> > >  - reuse code in setup_e820 and setup_e820_ext
> > > 
> > > v1->v2:
> > > 
> > > Vivek:
> > >  - Use function instead of macro for dbgprint_mem_range
> > >  - Do not pass reserved memory range for kdump. It could addressed later
> > >    separately.
> > > 
> > > WANG Chao (4):
> > >   cleanup: add dbgprint_mem_range function
> > >   x86: Store memory ranges globally used for crash kernel to boot into
> > >   x86: add --pass-memmap-cmdline option
> > >   x86: Pass memory range via E820 for kdump
> > > 
> > >  kexec/arch/i386/crashdump-x86.c        | 157 ++++++++++++++++--------------
> > >  kexec/arch/i386/crashdump-x86.h        |   6 +-
> > >  kexec/arch/i386/include/arch/options.h |   2 +
> > >  kexec/arch/i386/kexec-x86-common.c     |   6 +-
> > >  kexec/arch/i386/kexec-x86.c            |   4 +
> > >  kexec/arch/i386/kexec-x86.h            |   1 +
> > >  kexec/arch/i386/x86-linux-setup.c      | 171 ++++++++++++++++++++++-----------
> > >  kexec/arch/i386/x86-linux-setup.h      |   1 +
> > >  kexec/arch/x86_64/kexec-x86_64.c       |   5 +
> > >  kexec/kexec.c                          |  10 ++
> > >  kexec/kexec.h                          |   1 +
> > >  11 files changed, 231 insertions(+), 133 deletions(-)
> > 
> > Thanks for the patches. Tested (adding a fix provided by Dave Young for
> > http://lists.infradead.org/pipermail/kexec/2014-March/011262.html) and
> > successful with both kexec and kdump, both with and without
> > --pass-memmap-cmdline.
> 

Hi, Simon. I'll answer the questions below.

> Is the patch a pre-requisite for this series?

No. That's a separate problem of EFI. Old kexec-tools also needs the
patch.

> If so, has it been posted formally?

Dave Young has sent to patch to kexec mail list. The subject is as
follow:

[PATCH] kexec-tools: handle 64bit efi memmap address correctly

> If so, could you point it out to me?

Dave's patch:
http://lists.infradead.org/pipermail/kexec/2014-March/011303.html

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
