Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TyfGm-0006AL-Nf
 for kexec@lists.infradead.org; Fri, 25 Jan 2013 09:08:21 +0000
Date: Fri, 25 Jan 2013 18:08:18 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v7 0/7] kexec: put bzImage and ramdisk above 4G for x86
 64bit
Message-ID: <20130125090818.GF30990@verge.net.au>
References: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
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

On Thu, Jan 24, 2013 at 12:44:17PM -0800, Yinghai Lu wrote:
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
> -v6: use sentinel instead of USE_EXT_BOOT_PARAMS.
>      add crashkernel_low support
> -v7: Separate bootloader id setting in another patch

Hi Yinghai, Hi All,

my current thinking with regards to this is that I would like to take
these changes into the kexec-tools tree once there is consensus and
kernel portions have been accepted. If that makes sense please let me know
when those conditions have been met. Otherwise lets discuss a different
strategy.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
