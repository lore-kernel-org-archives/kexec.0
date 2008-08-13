Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT6OD-0002E8-1i
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 02:47:09 +0000
Date: Wed, 13 Aug 2008 12:47:04 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec jump: fix code size checking
Message-ID: <20080813024701.GA19201@verge.net.au>
References: <1218589475.24951.59.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218589475.24951.59.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Wed, Aug 13, 2008 at 09:04:35AM +0800, Huang Ying wrote:
> Fix building issue when CONFIG_KEXEC=n. Thanks to Vivek Goyal for his
> reminding.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  include/asm-x86/kexec.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/include/asm-x86/kexec.h
> +++ b/include/asm-x86/kexec.h
> @@ -43,6 +43,9 @@
>  
>  #ifdef CONFIG_X86_32
>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
> +# ifndef CONFIG_KEXEC
> +#  define kexec_control_code_size	0
> +# endif
>  #endif
>  
>  #ifndef __ASSEMBLY__

Is it impossible to skip the linker check in the !CONFIG_KEXEC case?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
