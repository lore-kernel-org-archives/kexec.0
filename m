Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOLsp-0001gr-3y
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 07:18:35 +0000
Date: Mon, 1 Sep 2014 09:18:11 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Fix dmesg format after crash utility
Message-ID: <20140901091811.63482e89@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97251481@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE97250ADB@BPXM01GP.gisp.nec.co.jp>
 <20140829102151.1ecff317@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE97251481@BPXM01GP.gisp.nec.co.jp>
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

On Mon, 1 Sep 2014 06:36:55 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Petr,
> 
> >On Fri, 29 Aug 2014 01:43:31 +0000
> >Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> >
> >> Hello,
> >
> >Hello Kumagai-san,
> >
> >> I made a trivial patch for v1.5.7.
> >> This isn't essential but it's better than nothing.
> >>[...]
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index b4b6eca..632daba 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -3950,6 +3950,7 @@ dump_log_entry(char *logptr, int fp)
> >>  {
> >>  	char *msg, *p, *bufp;
> >>  	unsigned int i, text_len;
> >> +	unsigned int indent_len;
> >>  	unsigned long long ts_nsec;
> >>  	char buf[BUFSIZE];
> >>  	ulonglong nanos;
> >> @@ -3965,6 +3966,7 @@ dump_log_entry(char *logptr, int fp)
> >>
> >>  	bufp = buf;
> >>  	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> >> +	indent_len = strlen(buf);
> >>
> >>  	for (i = 0, p = msg; i < text_len; i++, p++) {
> >>  		/* 6bytes = "\\x%02x" + '\n' + '\0' */
> >> @@ -3974,7 +3976,9 @@ dump_log_entry(char *logptr, int fp)
> >>  			bufp = buf;
> >>  		}
> >>
> >> -		if (isprint(*p) || isspace(*p))
> >> +		if (*p == '\n')
> >> +			bufp += sprintf(bufp, "\n%-*s", indent_len, "");
> >> +		else if (isprint(*p) || isspace(*p))
> >
> >If you do this, you'll have to adjust the condition for growing the buffer above:
> >
> >	if (bufp - buf >= sizeof(buf) - 6) {
> 
> Yeah, I missed this.
> 
> >Let me send a cleanup patch for the "magic constant", which was never a
> >good idea, it seems.
> 
> I've written the v2 patch based on your cleanup.

This one looks perfect. Good job!

Petr Tesarik
SUSE L3 Team 1

> Thanks
> Atsushi Kumagai
> 
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Mon, 1 Sep 2014 14:23:01 +0900
> Subject: [PATCH v2] Fix dmesg format after crash utility.
> 
> Add some spaces before a new line as much as the length
> of the timestamp like crash utility as:
> 
>     $ diff -u  current.dmesg fixed.dmesg
>     --- current.dmesg       2014-08-28 17:39:53.000000000 +0900
>     +++ fixed.dmesg 2014-08-27 16:46:09.000000000 +0900
>     @@ -150,8 +150,8 @@
>      [    0.015251] Disabled fast string operations
>      [    0.015285] mce: CPU supports 10 MCE banks
>      [    0.015402] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
>     -Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>     -tlb_flushall_shift: 6
>     +               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>     +               tlb_flushall_shift: 6
>      [    0.015535] Freeing SMP alternatives memory: 20K (ffffffff81964000 - ffffffff81969000)
>      [    0.018265] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>      [    0.028286] smpboot: CPU0: Intel QEMU Virtual CPU version (cpu64-rhel6) (fam: 06, model: 0d, stepping: 03)
>     $
> 
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
>  makedumpfile.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 37dea37..0a50175 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3949,7 +3949,7 @@ static int
>  dump_log_entry(char *logptr, int fp)
>  {
>  	char *msg, *p, *bufp;
> -	unsigned int i, text_len, buf_need;
> +	unsigned int i, text_len, indent_len, buf_need;
>  	unsigned long long ts_nsec;
>  	char buf[BUFSIZE];
>  	ulonglong nanos;
> @@ -3965,9 +3965,10 @@ dump_log_entry(char *logptr, int fp)
>  
>  	bufp = buf;
>  	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +	indent_len = strlen(buf);
>  
>  	/* How much buffer space is needed in the worst case */
> -	buf_need = sizeof("\\xXX\n");
> +	buf_need = MAX(sizeof("\\xXX\n"), sizeof("\n") + indent_len);
>  
>  	for (i = 0, p = msg; i < text_len; i++, p++) {
>  		if (bufp - buf >= sizeof(buf) - buf_need) {
> @@ -3976,7 +3977,9 @@ dump_log_entry(char *logptr, int fp)
>  			bufp = buf;
>  		}
>  
> -		if (isprint(*p) || isspace(*p))
> +		if (*p == '\n')
> +			bufp += sprintf(bufp, "\n%-*s", indent_len, "");
> +		else if (isprint(*p) || isspace(*p))
>  			*bufp++ = *p;
>  		else
>  			bufp += sprintf(bufp, "\\x%02x", *p);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
