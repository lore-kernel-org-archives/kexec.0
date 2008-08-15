Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTykd-00041z-6F
	for kexec@lists.infradead.org; Fri, 15 Aug 2008 12:49:55 +0000
Date: Fri, 15 Aug 2008 14:49:38 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -v3 6/7] kexec jump: __ftrace_enabled_save/restore
Message-ID: <20080815124938.GB24663@elte.hu>
References: <1218510876.24951.45.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218510876.24951.45.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>


* Huang Ying <ying.huang@intel.com> wrote:

> +/* Ftrace disable/restore without lock. Some synchronization mechanism
> + * must be used to prevent ftrace_enabled to be changed between
> + * disable/restore. */

use the proper comment style please:

/*
 *
 */

> +static inline int __ftrace_enabled_save(void)
> +{
> +#ifdef CONFIG_FTRACE
> +	int saved_ftrace_enabled = ftrace_enabled;
> +	ftrace_enabled = 0;
> +	return saved_ftrace_enabled;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline void __ftrace_enabled_restore(int enabled)
> +{
> +#ifdef CONFIG_FTRACE
> +	ftrace_enabled = enabled;
> +#endif
> +}

hm, what is this used for?

also, instead of such an ugly inline, why not create a proper 
kernel/trace/* function for this. That would also give it access to all 
the proper locking mechanisms - instead of relying on some extral 
mechanism.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
