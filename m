Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QssFE-0005bj-IB
	for kexec@lists.infradead.org; Mon, 15 Aug 2011 08:10:01 +0000
Date: Mon, 15 Aug 2011 14:54:51 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [UPDATED PATCH v2 8/8] makedumpfile: Add erase information in
	ELF formatted dumpfile
Message-Id: <20110815145451.44f9d605.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110715091602.GA719@in.ibm.com>
References: <20110517200715.12740.67863.stgit@mars.in.ibm.com>
	<20110715091602.GA719@in.ibm.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Fri, 15 Jul 2011 14:46:02 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> @@ -4647,6 +4650,15 @@ write_cache_bufsz(struct cache_data *cd)
>  }
>  
>  int
> +write_cache_zero(struct cache_data *cd, size_t size)
> +{
> +	memset(cd->buf + cd->buf_size, 0, size);
> +	cd->buf_size += size;
> +
> +	return write_cache_bufsz(cd);
> +}

if cd->buf_size is a little smaller than cd->cache_size and
the argument "size" is bigger than info->page_size, the above
a SIGSEGV happens at the above memset().

Previous write_cache_bufsze() call will avoid that :
---
 int
 write_cache_zero(struct cache_data *cd, size_t size)
 {
+	if (!write_cache_bufsz(cd))
+		return FALSE;

	memset(cd->buf + cd->buf_size, 0, size);
	cd->buf_size += size;

	return write_cache_bufsz(cd);
 }
---

>  /*
> + * ELF note section for erase information
> + *
> + * According to elf.h the unused values are 0x15(21) through 0xff. The value
> + * range 0x1XX, 0x2XX and 0x3XX is been used for PPC, i386 and s390
> + * respectively.
> + *
> + * Using 0xff to be on safer side so that any new Elf Note addition in elf.h
> + * after 0x15 value would not clash.
> + */
> +#ifndef NT_ERASE_INFO
> +#define NT_ERASE_INFO (0xff)	/* Contains erased information. */
> +#endif
> +#define ERASEINFO_NOTE_NAME		"ERASEINFO"
> +#define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))

I feel NT_ERASE_INFO(0xff) is not safe and we can use ERASEINFO_NOTE_NAME
instead.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
