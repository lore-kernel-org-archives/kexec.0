Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0MPV-0008Ja-0O
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 07:19:18 +0000
Date: Mon, 26 Mar 2018 09:19:03 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: leverage kexec_file_load support
Message-ID: <20180326071903.r2ce5tigwgc3o4tm@verge.net.au>
References: <152010365000.15494.15072043690885225651.stgit@hbathini.in.ibm.com>
 <87y3inhp14.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y3inhp14.fsf@morokweng.localdomain>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Geoff Levand <geoff@infradead.org>, Kexec-ml <kexec@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>

On Mon, Mar 19, 2018 at 03:57:11PM -0300, Thiago Jung Bauermann wrote:
> 
> Hello Hari,
> 
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> 
> > PPC64 kernel now supports kexec_file_load system call. Leverage it by
> > enabling that support here. Note that loading crash kernel with this
> > system call is not yet supported in the kernel and trying to load one
> > will fail with '-ENOTSUPP' error.
> >
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > ---
> >  kexec/arch/ppc64/kexec-elf-ppc64.c |   84 ++++++++++++++++++++++++++++++++++++
> >  kexec/kexec-syscall.h              |    3 +
> >  2 files changed, 87 insertions(+)
> 
> Thanks for implementing this! Looks good to me, just one nit below.
> Regardless of that:
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> > diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> > index ddd3de8..2742cd6 100644
> > --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> > +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> 
> <snip>
> 
> > @@ -117,6 +196,9 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
> >  	uint32_t my_run_at_load;
> >  	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
> >
> > +	if (info->file_mode)
> > +		return elf_ppc64_load_file(argc, argv, info);
> > +
> >  	/* See options.h -- add any more there, too. */
> >  	static const struct option options[] = {
> >  		KEXEC_ARCH_OPTIONS
> 
> This is placing executable code between variable declarations. It may be
> fine for gcc but it's more idiomatic C to put it after all variable
> declarations. But perhaps the kexec-tools style is fine with it?

I'd rather we avoid proliferating this style in the kexec code.
Hari, could you respin this patch?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
