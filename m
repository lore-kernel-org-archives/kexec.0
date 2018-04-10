Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5pSZ-0007ND-RE
 for kexec@lists.infradead.org; Tue, 10 Apr 2018 09:21:05 +0000
Date: Tue, 10 Apr 2018 11:12:23 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RESEND PATCH] arm64: fix an issue with kaslr-enabled vmlinux
Message-ID: <20180410091223.p4xppjp6nrqcwv4m@verge.net.au>
References: <20180406024528.32124-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180406024528.32124-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: kexec@lists.infradead.org

On Fri, Apr 06, 2018 at 11:45:28AM +0900, AKASHI Takahiro wrote:
> Normally vmlinux for arm64 is of ET_EXEC type, while if built with
> CONFIG_RANDAMIZE_BASE (that is KASLR), it will be of ET_DYN type.
> Meanwhile, physical address field of segments in vmlinux has actually
> the same value as virtual address field.
> 
> Accordingly, in this case, it totally makes no sense to check for
> validity of segments against physical memory ranges and, if necessary,
> relocate them in elf_exec_load() on arm64.
> 
> This patch allows to unconditionally skip the check on arm64.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
