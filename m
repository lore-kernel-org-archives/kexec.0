Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from etrn.xmission.com ([198.60.22.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgNqj-0007Bg-3C
 for kexec@lists.infradead.org; Sat, 25 May 2013 23:26:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <51A02E50.5020507@gmail.com>
Date: Sat, 25 May 2013 16:25:21 -0700
In-Reply-To: <51A02E50.5020507@gmail.com> (Zhang Yanfei's message of "Sat, 25
 May 2013 11:21:52 +0800")
Message-ID: <87mwri8wwu.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:

> /dev/oldmem provides the interface for us to access the "old memory" in
> the dump-capture kernel. Unfortunately, no one actually uses this interface.
>
> And this interface could actually cause some real problems if used on ia64
> where the cached/uncached accesses are mixed. See the discussion from
> the link: https://lkml.org/lkml/2013/4/12/386.
>
> So Eric suggested that we should remove /dev/oldmem as an unused piece of
> code.
>
> Besides, we used a global variable saved_max_pfn to let the capture kernel
> know the amount of memory that the previous kernel used. And for almost all
> architectures (except x86. In x86, saved_max_pfn is used by detect_calgary()),
> the only user of this variable is the read_oldmem interface of /dev/oldmem, so
> also remove the setting for saved_max_pfn in those architectures.

Except for the devices.txt update.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Zhang Yanfei (7):
>   /dev/oldmem: Remove this interface
>   Documentation/devices.txt: Remove /dev/oldmem description
>   Documentation/kdump/kdump.txt: Remove /dev/oldmem description
>   mips: Remove savemaxmem parameter setup
>   powerpc: Remove savemaxmem parameter setup
>   ia64: Remove setting for saved_max_pfn
>   s390: Remove setting for saved_max_pfn
>
>  Documentation/devices.txt        |    2 -
>  Documentation/kdump/kdump.txt    |   31 +++++--------------------
>  arch/ia64/kernel/efi.c           |    5 ----
>  arch/mips/kernel/crash_dump.c    |   10 --------
>  arch/powerpc/kernel/crash_dump.c |   10 --------
>  arch/s390/kernel/setup.c         |    4 ---
>  drivers/char/mem.c               |   47 --------------------------------------
>  7 files changed, 6 insertions(+), 103 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
