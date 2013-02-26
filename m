Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAGhQ-0002w1-8Z
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 09:19:49 +0000
Message-ID: <512C7E02.8050602@redhat.com>
Date: Tue, 26 Feb 2013 17:18:58 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 0/7] kexec: put bzImage and ramdisk above 4G for x86
 64bit
References: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On 02/22/2013 12:07 PM, Yinghai Lu wrote:
> Now we have limit kdump reserved under 896M, because kexec has the limitation.
> and also bzImage need to stay under 4g.

I think the kernel patches has been merged in linus tree, I got a crash
memory address above 4G during my test, kexec tools need this patchset
to load the 2nd kernel..

BTW, Simon, do you have plan to release the 2.0.4?

> 
> kernel parts changes get merged to linus tree already.
> 
> here patches are for kexec tools to load bzImage and ramdisk above 4G
> acccording to new added boot header fields.
> 
> it will only load high with 64bit kernel with 2.12 setup header.
> 
> -v3: address review from Eric to use locate_hole at first.
>      use xloadflags instead.
> -v4: remove the restriction about bzImage not crossing GB boundary.
>      add real-mode fix for bzImage.
>      add --entry-32bit and --real-mode for skip bzImage64.
> -v5: use USE_EXT_BOOT_PARAMS bit in xloadflags.
> -v6: use sentinel instead of USE_EXT_BOOT_PARAMS.
>      add crashkernel_low support
> -v7: Separate bootloader id setting in another patch
> -v8: update for CAN_BE_LOADED_ABOVE_4G is changed to bit1.
>      also make it appliable to current kexec-tools devel tree.
> -v9: only copy setup_header when it is not with real_mode_entry.
> 
> Yinghai Lu (7):
>   kexec, x86: set booloader id in setup_header
>   kexec, x86: add boot header member for version 2.12
>   kexec, x86: clean boot_params area for entry-32bit path
>   kexec, x86: Fix bzImage real-mode booting
>   kexec, x86: put ramdisk/cmd_line above 4G for 64bit bzImage
>   kexec, x86_64: Load bzImage64 above 4G
>   kexec, x86: handle Crash low kernel range
> 
>  include/x86/x86-linux.h                |   27 ++-
>  kexec/arch/i386/crashdump-x86.c        |   21 +++
>  kexec/arch/i386/include/arch/options.h |    4 +-
>  kexec/arch/i386/kexec-bzImage.c        |   76 ++++++--
>  kexec/arch/i386/x86-linux-setup.c      |   38 ++--
>  kexec/arch/i386/x86-linux-setup.h      |   15 +-
>  kexec/arch/x86_64/Makefile             |    1 +
>  kexec/arch/x86_64/kexec-bzImage64.c    |  304 ++++++++++++++++++++++++++++++++
>  kexec/arch/x86_64/kexec-x86_64.c       |    1 +
>  kexec/arch/x86_64/kexec-x86_64.h       |    5 +
>  10 files changed, 460 insertions(+), 32 deletions(-)
>  create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c
> 


-- 
Thanks
Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
