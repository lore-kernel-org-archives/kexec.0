Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgDXj-000872-VJ
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 06:30:56 +0000
Date: Mon, 31 Mar 2008 15:30:54 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: [PATCH 1/4] extract vmcoreinfo from /proc/vmcore for Xen
In-Reply-To: <20080331052826.GC13693@verge.net.au>
References: <20080331131512.DDCD.ODA@valinux.co.jp>
	<20080331052826.GC13693@verge.net.au>
Message-Id: <20080331145815.DDDB.ODA@valinux.co.jp>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

Hi,

On Mon, 31 Mar 2008 14:28:26 +0900
Simon Horman <horms@verge.net.au> wrote:

> On Mon, Mar 31, 2008 at 01:25:19PM +0900, Itsuro ODA wrote:
> > This patch is for xen-3.2.0.
> > 
> > --- common/kexec.c.org	2008-03-25 09:29:39.000000000 +0900
> > +++ common/kexec.c	2008-03-28 12:50:33.000000000 +0900
> > @@ -43,6 +43,9 @@
> 
> [snip]
> 
> > +void vmcoreinfo_append_str(const char *fmt, ...)
> > +{
> > +    va_list args;
> > +    char buf[0x50];
> > +    int r;
> > +    size_t note_size = sizeof(Elf_Note) + ELFNOTE_ALIGN(strlen(VMCOREINFO_NOTE_NAME) + 1);
> > +
> > +    va_start(args, fmt);
> > +    r = vsnprintf(buf, sizeof(buf), fmt, args);
> > +    va_end(args);
> > +
> > +    if (r + vmcoreinfo_size + note_size > VMCOREINFO_BYTES)
> > +	r = VMCOREINFO_BYTES - vmcoreinfo_size - note_size;
> > +
> > +    memcpy(&vmcoreinfo_data[note_size + vmcoreinfo_size], buf, r);
> > +
> > +    vmcoreinfo_size += r;
> > +}
> 
> Hi Oda-san,
> 
> It looks like it is possible for both vsnprintf() and
> the "if (r + vmcoreinfo_size + note_size > VMCOREINFO_BYTES)" logic
> to truncate a feild. Is this likely to be a problem in practice,
> or is the code just guarding against malformed input?

just guarding against malformed input.

> Also, this code looks like it will be need to up-ported due to changes
> that I recently made to common/kexec.c and the range fetching portion of
> the hypercall in unstable.  This shouldn't be a big deal, just something
> that is worth mentioning.

I see.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
