Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ULQIN-00055b-N5
 for kexec@lists.infradead.org; Fri, 29 Mar 2013 03:48:04 +0000
Date: Fri, 29 Mar 2013 12:47:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: i386: Add cmdline_add_memmap_internal() to reduce
 the code duplication
Message-ID: <20130329034754.GA13429@verge.net.au>
References: <51544127.5080502@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51544127.5080502@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 28, 2013 at 09:09:59PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Functions:
> - cmdline_add_memmap()
> - cmdline_add_memmap_acpi()
> - cmdline_add_memmap_reserved()
> is kind of similar, So add a new function cmdline_add_memmap_internal() to
> hold the common codes, reducing the duplication.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kexec/arch/i386/crashdump-x86.c |   74 +++++++++++++++++---------------------
>  1 files changed, 33 insertions(+), 41 deletions(-)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
