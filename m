Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFoNU-0008BS-6j
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 05:51:07 -0400
Date: Tue, 31 Jul 2007 11:51:01 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Message-ID: <20070731095101.GA1774@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1184483639.1898.99.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> This patch implement the functionality of jumping from kexeced kernel
> to original kernel.
> 
> A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> trigger the jumping to (executing) the new kernel or jumping back to
> the original kernel.

Could we get two reboot commands? Exec loaded kernel seems to be quite
different operation than "jump back".

How do I test these patches? kexec -p <bzImage>, then kexec -j?


> +static unsigned long kexec_backup_addr = ~0UL;
> +
> +/* kexec_backup= specifies the location of backuped 0~640k memory of
> + * crashed kernel.
> + */
> +static int __init parse_kexec_backup(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	kexec_backup_addr = memparse(arg, &arg);
> +	return 0;
> +}
> +early_param("kexec_backup", parse_kexec_backup);

New kernel parameters should be documented. (Plus I do not know how to
use this one, please help :-).


> +int kexec_flags;
> +
> +static unsigned long kexec_jump_buf_pfn;
> +
> +static int __init parse_kexec_jump_buf_pfn(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	kexec_jump_buf_pfn = memparse(arg, &arg);
> +	kexec_flags |= KEXEC_FLAGS_IS_KEXECED_KERNEL;
> +	return 0;
> +}
> +early_param("kexec_jump_buf_pfn", parse_kexec_jump_buf_pfn);

This one should be documented, too, I'd guess. (Is that internal,
kernel-to-kernel communication?)

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
