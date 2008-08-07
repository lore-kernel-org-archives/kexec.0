Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1g4-0007VI-UI
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:21:01 +0000
Date: Thu, 7 Aug 2008 11:20:58 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/6] kexec jump: clean up #ifdef and comments
Message-ID: <20080807092058.GB372@atrey.karlin.mff.cuni.cz>
References: <1218099923.5164.32.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099923.5164.32.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

Hi!

> CONFIG_KEXEC_JUMP to make code looks cleaner.
> 
> Fix no longer correct comments of kernel_kexec().
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  kernel/kexec.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1427,8 +1427,6 @@ static int __init crash_save_vmcoreinfo_
>  module_init(crash_save_vmcoreinfo_init)
>  
>  /**
> - *	kernel_kexec - reboot the system
> - *
>   *	Move into place and start executing a preloaded standalone
>   *	executable.  If nothing was preloaded return an error.
>   */

If it is not kerneldoc, it should not be /** .

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
