Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XNHRp-0007Yo-BI
 for kexec@lists.infradead.org; Fri, 29 Aug 2014 08:22:18 +0000
Date: Fri, 29 Aug 2014 10:21:51 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Fix dmesg format after crash utility
Message-ID: <20140829102151.1ecff317@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97250ADB@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE97250ADB@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 29 Aug 2014 01:43:31 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello,

Hello Kumagai-san,

> I made a trivial patch for v1.5.7.
> This isn't essential but it's better than nothing.
>[...]
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b4b6eca..632daba 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3950,6 +3950,7 @@ dump_log_entry(char *logptr, int fp)
>  {
>  	char *msg, *p, *bufp;
>  	unsigned int i, text_len;
> +	unsigned int indent_len;
>  	unsigned long long ts_nsec;
>  	char buf[BUFSIZE];
>  	ulonglong nanos;
> @@ -3965,6 +3966,7 @@ dump_log_entry(char *logptr, int fp)
>  
>  	bufp = buf;
>  	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +	indent_len = strlen(buf);
>  
>  	for (i = 0, p = msg; i < text_len; i++, p++) {
>  		/* 6bytes = "\\x%02x" + '\n' + '\0' */
> @@ -3974,7 +3976,9 @@ dump_log_entry(char *logptr, int fp)
>  			bufp = buf;
>  		}
>  
> -		if (isprint(*p) || isspace(*p))
> +		if (*p == '\n')
> +			bufp += sprintf(bufp, "\n%-*s", indent_len, "");
> +		else if (isprint(*p) || isspace(*p))

If you do this, you'll have to adjust the condition for growing the buffer above:

	if (bufp - buf >= sizeof(buf) - 6) {

Let me send a cleanup patch for the "magic constant", which was never a
good idea, it seems.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
