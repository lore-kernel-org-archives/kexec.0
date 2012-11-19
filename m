Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaYsL-0003jZ-C3
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 21:27:30 +0000
Date: Mon, 19 Nov 2012 16:00:01 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/8] kexec: put bzImage and ramdisk above 4G for x86 64bit
Message-ID: <20121119210001.GI10035@redhat.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Nov 16, 2012 at 03:04:19PM -0800, Yinghai Lu wrote:
> Now we have limit kdump reseved under 896M, because kexec has the limitation.
> and also bzImage need to stay under 4g.
> 
> kernel parts changes could be found at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-boot
> 
> here patches are for kexec tools to load bzImage and ramdisk high acccording
> to new added boot header fields.

So does this allow me to load other segments also above 4G? (purgatory,
setup/bootparams, command line etc). I remember that purgaotry has
some 32bit relocations so had to be loaded below 2G. 

Thanks
Vivek

> 
> Yinghai Lu (8):
>   Add min/max macro
>   x86: add boot header member for version 2.12
>   add mem64_min/max control
>   Move out mem_min/max checking in locate_hole
>   seperate checking 64bit mem range
>   debug print out for add_buf
>   x86: put ramdisk high for 64bit bzImage
>   x86: put 64bit bzImage high
> 
>  include/x86/x86-linux.h           |   20 ++++++++++-
>  kexec/add_buffer.c                |    9 ++++-
>  kexec/arch/i386/kexec-bzImage.c   |   53 ++++++++++++++++++++++++++--
>  kexec/arch/i386/x86-linux-setup.c |   32 ++++++++++++-----
>  kexec/arch/ppc/include/types.h    |   12 ------
>  kexec/kexec.c                     |   69 +++++++++++++++++++++++++++++-------
>  kexec/kexec.h                     |   21 +++++++++++-
>  7 files changed, 175 insertions(+), 41 deletions(-)
> 
> -- 
> 1.7.7

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
