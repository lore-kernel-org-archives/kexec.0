Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TflLe-0000sQ-KO
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 05:47:15 +0000
Date: Tue, 4 Dec 2012 14:47:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 0/5] kexec: put bzImage and ramdisk above 4G for x86
 64bit
Message-ID: <20121204054709.GB15969@verge.net.au>
References: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Hi Everyone,

there was some healthy discussion around the previous versions
of this series, but so far none on this version. Have we reached
consensus?

On Wed, Nov 28, 2012 at 02:09:49PM -0800, Yinghai Lu wrote:
> Now we have limit kdump reserved under 896M, because kexec has the limitation.
> and also bzImage need to stay under 4g.
> 
> kernel parts changes could be found at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-boot
> 
> here patches are for kexec tools to load bzImage and ramdisk above 4G
> acccording to new added boot header fields.
> 
> -v3: address review from Eric to use locate_hole at first.
>      use xloadflags instead.
> -v4: remove the restriction about bzImage not crossing GB boundary.
>      add real-mode fix for bzImage.
>      add --entry-32bit and --real-mode for skip bzImage64.
> -v5: use USE_EXT_BOOT_PARAMS bit in xloadflags.
> 
> Yinghai Lu (5):
>   kexec, x86: add boot header member for version 2.12
>   kexec, x86: clean boot_params area for entry-32bit path
>   kexec, x86: Fix bzImage real-mode booting
>   kexec, x86: put ramdisk/cmd_line above 4G for 64bit bzImage
>   kexec, x86_64: Load bzImage64 above 4G
> 
>  include/x86/x86-linux.h                |   32 +++-
>  kexec/arch/i386/include/arch/options.h |    4 +-
>  kexec/arch/i386/kexec-bzImage.c        |   80 +++++++--
>  kexec/arch/i386/x86-linux-setup.c      |   26 ++-
>  kexec/arch/x86_64/Makefile             |    1 +
>  kexec/arch/x86_64/kexec-bzImage64.c    |  335 ++++++++++++++++++++++++++++++++
>  kexec/arch/x86_64/kexec-x86_64.c       |    1 +
>  kexec/arch/x86_64/kexec-x86_64.h       |    5 +
>  8 files changed, 462 insertions(+), 22 deletions(-)
>  create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c
> 
> -- 
> 1.7.7
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
