Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFG3y-0005gq-6D
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 07:57:51 +0000
Date: Fri, 9 Dec 2016 08:57:23 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/6] Kexec fixes and updates for MIPS platforms
Message-ID: <20161209075723.GA30610@verge.net.au>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
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
To: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>

On Fri, Dec 02, 2016 at 10:49:05AM +0100, Marcin Nowakowski wrote:
> This patch series tries to bring the support for MIPS up to date and make it more
> generic (fix little-endian support, simplify code for 32/64 bit handling), as well
> as to clean up some existing incorrect code (patches 1-4).
> 
> Patches 5 & 6 add new functionality - passing external DTBs and initrd, especially
> the DTB support is required for platforms that use a recently introduced generic
> kernel infrastructure.
> 
> Note that patch 5 (and 6, as it depends on patch 5) require changes in the kernel
> that are currently pending review:
> https://patchwork.linux-mips.org/patch/14615/
> 
> Core dump support is currently broken on all MIPS kernels and is also pending
> review:
> https://patchwork.linux-mips.org/patch/14587/
> https://patchwork.linux-mips.org/patch/14586/
> 
> Patches 1-4 can be safely added without waiting for kernel patches to be merged,
> but patches 5-6 should be held until the kernel patches are accepted in case changes
> are requested.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
