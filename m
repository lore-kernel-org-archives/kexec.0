Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpcZ-0006x0-3n
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:38:27 +0000
Date: Wed, 27 Mar 2013 21:38:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 06/13] kexec: i386: multiboot: fix memory leak caused by
 get_command_line
Message-ID: <20130327123824.GS17248@verge.net.au>
References: <51506758.4070902@gmail.com>
 <51506921.60807@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51506921.60807@gmail.com>
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

On Mon, Mar 25, 2013 at 11:11:29PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Since get_command_line returns dynamically allocated memory, it is
> easy for the caller to forget freeing the memory. Here fixes a
> memory leak caused by this function.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kexec/arch/i386/kexec-multiboot-x86.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
