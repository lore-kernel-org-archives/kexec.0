Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGSW-00Cel4-Ti
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 09:51:23 +0000
Date: Fri, 2 Apr 2021 11:51:07 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] MIPS: Add '--reuse-cmdline' optional parameter support
Message-ID: <20210402095104.GD7320@vergenet.net>
References: <1614144581-5456-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1614144581-5456-1-git-send-email-tangyouling@loongson.cn>
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org

On Wed, Feb 24, 2021 at 01:29:41PM +0800, Youling Tang wrote:
> This patch adds an option "--reuse-cmdline" for people that are lazy
> in typing --append="$(cat /proc/cmdline)", which will directly use the
> command line of the currently running system.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kexec/arch/mips/include/arch/options.h | 12 +++++++-----
>  kexec/arch/mips/kexec-mips.c           |  4 ++++

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
