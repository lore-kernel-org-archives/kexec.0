Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jb3Xc-0006NT-Dg
	for kexec@lists.infradead.org; Mon, 17 Mar 2008 00:49:28 +0000
Date: Mon, 17 Mar 2008 09:49:23 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86_64 purgatory Makefile typo fix.
Message-ID: <20080317004922.GC1433@verge.net.au>
References: <47DA428C.3040608@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47DA428C.3040608@in.ibm.com>
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
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Mar 14, 2008 at 02:47:00PM +0530, Sachin P. Sant wrote:
> While trying to test latest kexec tools git code on a x86_64
> box i ran into following issue. Kexec refused to load both
> kexec and kdump kernels.
>
> # ./build/sbin/kexec -l /boot/vmlinuz-2.6.25-rc5 
> --initrd=/boot/initrd-2.6.25-rc5 Symbol: entry32_regs not found cannot 
> get
>
> #
> # ./build/kexec -p /boot/vmlinux-kdump --initrd=/boot/initrd-kdump
> --append="...."
> Symbol: entry64_regs not found cannot get
>
> #
>
> It turns out that entry64.S file under purgatory/arch/x86_64 was not
> compiled. The original x86_64_PURGATORY_SRCS were being overwritten
> in the Makefile.
>
> Here is a patch to fix this issue. 

Ooops, sorry about that.

Perhaps this is worthy of a fresh release?

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
