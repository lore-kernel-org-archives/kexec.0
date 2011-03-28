Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4KmF-0008Jm-BO
	for kexec@lists.infradead.org; Mon, 28 Mar 2011 22:19:12 +0000
Date: Tue, 29 Mar 2011 07:19:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] kexec, x86: fix kexec when
	boot_params.hardware_subarch != 0
Message-ID: <20110328221904.GA18357@verge.net.au>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
	<20110328215011.30400.91252.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110328215011.30400.91252.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: kexec@lists.infradead.org

On Mon, Mar 28, 2011 at 02:50:11PM -0700, Chris Leech wrote:
> kexec needs to keep the subarch setting the same as the running kernel
> in the boot parameters, or the kernel will die in early setup.  I ran
> into this with X86_SUBARCH_MRST, but it should apply to CE4100 and any
> future subarch that uses non-default early setup code.
> 
> This patch requires debugfs mounted at /sys/kernel/debug, as that's
> the only way I know of to get at the running kernels boot_params.
> Without debugfs mounted it falls back to the current behavior of
> assuming subarch 0.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
