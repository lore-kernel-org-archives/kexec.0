Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YKhTP-00070z-Sc
 for kexec@lists.infradead.org; Mon, 09 Feb 2015 06:05:32 +0000
Date: Mon, 9 Feb 2015 14:03:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] ppc64: erase unnecessary segment info printing
Message-ID: <20150209060335.GA7909@dhcp-16-105.nay.redhat.com>
References: <1414570795-29258-1-git-send-email-bhe@redhat.com>
 <20150209055543.GA29385@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150209055543.GA29385@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 02/09/15 at 02:55pm, Simon Horman wrote:
> On Wed, Oct 29, 2014 at 04:19:55PM +0800, Baoquan He wrote:
> > In ppc64 loading, it will print the segment information. This is not
> > wanted since other Archs don't have this. People even think there's
> > something wrong. So erase it to make it be consistent with other Archs.
> > 
> > And if people really want to check these info, they can specify "-d"
> > option. They are printed in print_segments() too.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Thanks, applied.

Thanks, Simon.

> 
> > ---
> >  kexec/arch/ppc64/kexec-elf-ppc64.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> > index ce10367..4a1540e 100644
> > --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> > +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> > @@ -377,10 +377,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
> >  	dbgprintf("opal_base is %llx\n", (unsigned long long) my_opal_base);
> >  	dbgprintf("opal_entry is %llx\n", (unsigned long long) my_opal_entry);
> >  
> > -	for (i = 0; i < info->nr_segments; i++)
> > -		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
> > -			info->segment[i].mem, info->segment[i].memsz);
> > -
> >  	return 0;
> >  }
> >  
> > -- 
> > 1.9.0
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
