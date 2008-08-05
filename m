Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KQJFd-0004ZM-1S
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 09:54:45 +0000
Date: Tue, 5 Aug 2008 02:54:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: kdump, ia64: always reserve elfcore header memory in crash kernel
Message-Id: <20080805025442.d4626d40.akpm@linux-foundation.org>
In-Reply-To: <20080805094825.GA9712@verge.net.au>
References: <20080805094825.GA9712@verge.net.au>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Tue, 5 Aug 2008 19:48:27 +1000 Simon Horman <horms@verge.net.au> wrote:

> elfcore header memory needs to be reserved in a crash kernel.
> This means that the relevant code should be protected
> by CONFIG_CRASH_DUMP rather than CONFIG_PROC_VMCORE.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> --- 
> Andrew, this patch fixes bug in the (unlikely) case where
> an ia64 crashdump kernel does not have CONFIG_PROC_FS set.
> I think it is worth including in 2.6.27. But breakage cases are
> likely to be minimal to non-existent, so I am comfortable
> with post 2.6.27 too.
> 
> This patch should be appended to the series,
> "is_kdump_kernel() cleanup and related patches".

hm, that means that we would need to apply a moderate-size seven patch
series to fix one little bug.

I think that if we want to fix this in 2.6.27 then the basic single
patch would be preferable.  Or we leave it until 2.6.28/



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
