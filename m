Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J5ex1-0000t8-RI
	for kexec@lists.infradead.org; Fri, 21 Dec 2007 10:18:02 +0000
Date: Fri, 21 Dec 2007 11:17:10 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3 -mm] kexec jump -v8 : add write support to oldmem
	device
Message-ID: <20071221101710.GB10573@elf.ucw.cz>
References: <1198222420.1965.21.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1198222420.1965.21.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

Hi!

> This patch adds writing support for /dev/oldmem. This can be used to
> 
> - Communicate between original kernel and kexeced kernel through write
>   to some pages in original kernel.
> 
> - Restore the memory contents of hibernated system in kexec based
>   hibernation.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> +			  size_t csize, unsigned long offset, int
> userbuf)

> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -348,6 +348,37 @@ static ssize_t read_oldmem(struct file *
>  	}
>  	return read;
>  }
> +
> +/*
> + * Write memory corresponding to the old kernel.
> + */
> +static ssize_t write_oldmem(struct file *file, const char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
...
> +		rc = write_oldmem_page(pfn, buf, csize, offset, 1);

I believe this is going to break compilation on non-32bit
machines. Or is crashdump only supported on i386?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
