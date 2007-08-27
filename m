Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPmAw-000130-Ln
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 17:31:18 -0400
Date: Mon, 27 Aug 2007 23:31:34 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation: kexec restore
Message-ID: <20070827213134.GE3398@elf.ucw.cz>
References: <1188177296.3247.38.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1188177296.3247.38.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> This patch adds writing support for /dev/oldmem. This is used to
> restore the memory contents of hibernated system.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>

> +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> +			  size_t csize, unsigned long offset, int userbuf)

Hmm, int userbuf is only ever set to one... Does it make sense to have
write_oldmem_page in the separate file? The onl user is mem.c, perhaps
it should go there?

> +
> +/*
> + * Write memory corresponding to the old kernel.
> + */
> +static ssize_t write_oldmem(struct file *file, const char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	unsigned long pfn, offset;
> +	size_t write = 0, csize;
> +	int rc = 0;
> +
> +	while (count) {
> +		pfn = *ppos / PAGE_SIZE;
> +		if (pfn > saved_max_pfn)
> +			return write;
> +
> +		offset = (unsigned long)(*ppos % PAGE_SIZE);
> +		if (count > PAGE_SIZE - offset)
> +			csize = PAGE_SIZE - offset;
> +		else
> +			csize = count;
> +		rc = write_oldmem_page(pfn, buf, csize, offset, 1);
> +		if (rc < 0)
> +			return rc;
> +		buf += csize;
> +		*ppos += csize;
> +		write += csize;
> +		count -= csize;
> +	}
> +	return write;
> +}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
