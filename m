Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOLsD-0001MD-MB
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 07:17:58 +0000
Date: Mon, 1 Sep 2014 09:17:28 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] dump_log_entry: replace magic constant with a variable
Message-ID: <20140901091728.7f724ff2@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97251486@BPXM01GP.gisp.nec.co.jp>
References: <20140829103620.15aee556@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE97251486@BPXM01GP.gisp.nec.co.jp>
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

On Mon, 1 Sep 2014 06:37:10 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >If the buffer space requirements are changed, the magic constant is
> >hard to spot, and the failure is easily overlooked, because it may
> >fail only under special conditions.
> 
> Good change, I'll push it to devel soon.

Thank you!

Petr Tesarik

> Thanks
> Atsushi Kumagai
> 
> >Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> >---
> > makedumpfile.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index b4b6eca..37dea37 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -3949,7 +3949,7 @@ static int
> > dump_log_entry(char *logptr, int fp)
> > {
> > 	char *msg, *p, *bufp;
> >-	unsigned int i, text_len;
> >+	unsigned int i, text_len, buf_need;
> > 	unsigned long long ts_nsec;
> > 	char buf[BUFSIZE];
> > 	ulonglong nanos;
> >@@ -3966,9 +3966,11 @@ dump_log_entry(char *logptr, int fp)
> > 	bufp = buf;
> > 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> >
> >+	/* How much buffer space is needed in the worst case */
> >+	buf_need = sizeof("\\xXX\n");
> >+
> > 	for (i = 0, p = msg; i < text_len; i++, p++) {
> >-		/* 6bytes = "\\x%02x" + '\n' + '\0' */
> >-		if (bufp - buf >= sizeof(buf) - 6) {
> >+		if (bufp - buf >= sizeof(buf) - buf_need) {
> > 			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
> > 				return FALSE;
> > 			bufp = buf;
> >--


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
