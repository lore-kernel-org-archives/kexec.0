Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IaSME-00021n-Pf
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 04:35:05 -0400
Date: Wed, 26 Sep 2007 10:34:53 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070926083453.GE11385@suse.de>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182258.175348676@strauss.suse.de>
	<E1IaHPU-00089b-Bc@flower>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IaHPU-00089b-Bc@flower>
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
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Oleg Verych <olecom@flower.upol.cz> [2007-09-25 22:53]:
> * Tue, 25 Sep 2007 20:22:58 +0200
> >
> > +++ b/include/linux/kexec.h
> > @@ -187,6 +187,8 @@ extern u32 vmcoreinfo_note[VMCOREINFO_NO
> >  extern size_t vmcoreinfo_size;
> >  extern size_t vmcoreinfo_max_size;
> >  
> > +int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> > +		unsigned long long *crash_size, unsigned long long *crash_base);
> 
> I still want to point out my consernes about `unsigned long long long'
> bloat.

What "concerns" (it's unsigned long long and not unsigned long long
long)? Is is common coding style in the Linux kernel to *not* use
unsigned long long? This type *is* used e.g. in
arch/i386/kernel/e820.c also for pysical memory values.

> #v+
> olecom@flower:/tmp$ grep '@offset' <extended-crashkernel-cmdline.mbox
>     crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> -       /* crashkernel=size@offset specifies the size to reserve for a crash
> +While the "crashkernel=size[@offset]" syntax is sufficient for most
> +    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +       crashkernel=range1:size1[,range2:size2,...][@offset]
> olecom@flower:/tmp$ grep '@base' <extended-crashkernel-cmdline.mbox
> + *     crashkernel=size[@base]
> olecom@flower:/tmp$ grep '@<base' <extended-crashkernel-cmdline.mbox
> + *   crashkernel=<ramsize-range>:<size>[,...][@<base>]
> olecom@flower:/tmp$ grep '@<offset' <extended-crashkernel-cmdline.mbox
> olecom@flower:/tmp$
> #v-

The patch below fixes this.

> > + *
> > + * The function returns 0 on success and -EINVAL on failure.
> > + */
> > +static int __init parse_crashkernel_mem(char 			*cmdline,
> > +					unsigned long long	system_ram,
> > +					unsigned long long	*crash_size,
> > +					unsigned long long	*crash_base)
> > +{
> > +	char *cur = cmdline;
> > +
> > +	/* for each entry of the comma-separated list */
> > +	do {
> > +		unsigned long long start = 0, end = ULLONG_MAX;
> > +		unsigned long long size = -1;
> 
> memparse(), as a wrapper for somple_strtoll(), always have a return value
> (zero by default).
> <http://article.gmane.org/gmane.linux.kernel/583426>

Next reply (because of a different patch).


---

Only use 'offset' and not 'base' for the address where the reserved area
starts.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kernel/kexec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1157,7 +1157,7 @@ module_init(crash_notes_memory_init)
 /*
  * This function parses command lines in the format
  *
- *   crashkernel=<ramsize-range>:<size>[,...][@<base>]
+ *   crashkernel=ramsize-range:size[,...][@offset]
  *
  * The function returns 0 on success and -EINVAL on failure.
  */
@@ -1222,7 +1222,7 @@ static int __init parse_crashkernel_mem(
 /*
  * That function parses "simple" (old) crashkernel command lines like
  *
- * 	crashkernel=size[@base]
+ * 	crashkernel=size[@offset]
  *
  * It returns 0 on success and -EINVAL on failure.
  */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
