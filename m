Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt5bn-0003p3-UR
 for kexec@lists.infradead.org; Mon, 11 Feb 2019 07:02:30 +0000
Date: Mon, 11 Feb 2019 15:02:23 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RESEND 1/3] x86/boot: Add bit fields into xloadflags for
 5-level kernel checking
Message-ID: <20190211070223.GA2332@localhost>
References: <20190125022817.29506-1-bhe@redhat.com>
 <20190125022817.29506-2-bhe@redhat.com>
 <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

Thanks for reviewing. I was in vacation, sorry for late reply.

On 01/29/19 at 09:05pm, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Baoquan He wrote:
> 
> > Add two bit fields XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
> 
> These are not bit fields. These are simple bits.

Indeed, they are only xloadflags bits, will change. Thanks.

> 
> > Bit XLF_5LEVEL indicates if 5-level related code is contained
> > in this kernel.
> > Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.
> 
> I'm confused. 
> 
> > -			.word XLF0 | XLF1 | XLF23 | XLF4
> > +#ifdef CONFIG_X86_64
> > +#ifdef CONFIG_X86_5LEVEL
> > +#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
> > +#else
> > +#define XLF56 XLF_5LEVEL
> > +#endif
> > +#else
> > +#define XLF56 0
> > +#endif
> > +
> > +			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
> 
> So this actually stores the bits, but looking at the following patch which
> fixes the real issue:
> 
> > +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> > +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> > +		return ret;
> > +	}
> 
> So what is XLF_5LEVEL_ENABLED used for and why does it exist at all?

Yes, this is a little bit confusing. I explained it in the v1 cover
letter:
http://lists.infradead.org/pipermail/kexec/2018-August/021419.html

As told at above, XLF_5LEVEL marks the new kernel containing 5level
code, while XLF_5LEVEL_ENABLED marking the CONFIG_X86_5LEVEL option
enabling. Hence if XLF_5LEVEL is set, XLF_5LEVEL_ENABLED not, means it's
new kernel but can't be switched into 5-level.

For kexec_load and kexec_file_load, there's difference in loading
behaviour. kexec_load will search available area top down to put
kernel in system RAM, we need check if the kexec-ed kernel is in
leve-5 paging mode, and limit the loading postion below 64 TB if
not. But for kexec_file_load, it's searching area bottom up to put
kernel, most of time area found below 4G. We don't have worry about the
kexec_file_load interface which implements the loading functionality in
kernel. That's why the XLF_5LEVEL_ENABLED bit is not used in this kernel
patch set, I would like to post patch to kexec-tools for kexec_load
after these patches have been accepted.

I ever tried to unify the behavious of these two interfaces on loading
kernel, to make both kexec_load and kexec_file_load search and put
kernel top to down, but that involves many lines of code change, seems
people are worried about it and hesitated to offere ack, I just gave up.
Please check below link:

https://lore.kernel.org/lkml/20180718024944.577-1-bhe@redhat.com/T/#u

Sorry for the inconvenience because of my missing explanation.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
