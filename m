Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HyZG7-0001NQ-Un
	for kexec@lists.infradead.org; Wed, 13 Jun 2007 16:16:09 -0400
Date: Wed, 13 Jun 2007 19:46:54 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [KJ PATCH] Replacing memcpy(dest, src,
	PAGE_SIZE) with copy_page(dest,
	src) in arch/i386/kernel/machine_kexec.c
Message-ID: <20070613194653.GA8273@ucw.cz>
References: <1181616342.2282.8.camel@shani-win>
	<m1vedtpwks.fsf@ebiederm.dsl.xmission.com>
	<466ECF37.6040303@zytor.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <466ECF37.6040303@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Shani Moideen <shani.moideen@wipro.com>

Hi!

> >> Replacing memcpy(dest,src,PAGE_SIZE) with copy_page(dest,src) in
> >> arch/i386/kernel/machine_kexec.c.
> > 
> > Please no.
> > 
> > People get creative in copy_page (especially mmx_copy_page),
> > and this code path need something simple and stupid, that
> > will work every time, especially when things are messed up
> > elsewhere.
> 
> memcpy() is pretty creative, too.  If you want something really dumb and
> robust, you should probably create an inline:
> 
> /*
>  * Eric sez: his code path need something simple and stupid, that
>  * will work every time, especially when things are messed up
>  * elsewhere.
>  */
> static inline void braindead_copy_page(void *dst, void *src)
> {
> 	unsigned long ctr = PAGE_SIZE >> 2;
> 
> 	asm volatile("cld; rep; movsl"
> 			: "+D" (dst), "+S" (src), "+c" (ctr)
> 			: : "memory");
> }
> 
> (FWIW, the "cld" is supposed to be redundant, as DF=0 is supposed to be
> guaranteed by the ABI.)

Actually, swsusp would be second user for that. We currently do it
with for loop in C, but...

...well, we'd probably need it for i386, ppc, x86-64, ppc64 and maybe
arm...

(But you should probably add a comment into kexec )
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
