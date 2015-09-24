Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0Ej-0002Ka-FI
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:42:34 +0000
Date: Thu, 24 Sep 2015 08:41:58 +0200
From: Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v2] Load crash kernel high on x86
Message-ID: <20150924084158.5a11c942@hananiah.suse.cz>
In-Reply-To: <20150924032942.GC6217@dhcp-128-28.nay.redhat.com>
References: <20150923065655.3ecd3c1b@hananiah.suse.cz>
 <20150924032942.GC6217@dhcp-128-28.nay.redhat.com>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Thu, 24 Sep 2015 11:29:42 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 09/23/15 at 06:56am, Petr Tesarik wrote:
> >  kexec/arch/i386/crashdump-x86.c    | 21 +++++++--------------
> >  kexec/arch/i386/kexec-x86-common.c |  4 ++--
> >  kexec/kexec.h                      |  2 +-
> >  3 files changed, 10 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 63959b7..9d866cc 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -1026,24 +1026,17 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  	return 0;
> >  }
> >  
> > -int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
> > +/* On x86, the kernel may make a low reservation in addition to the
> > + * normal reservation. However, the kernel refuses to load the panic
> > + * kernel to low memory, so always choose the highest range.
> > + */
> > +int get_crash_kernel_range(uint64_t *start, uint64_t *end)
> 
> How about get_crash_kernel_load_range? In kernel crashk_res and
> crashk_low_res are all named as "Crash kernel", but only crashk_res is
> used to load kernel/initrd stuffs.

I'm glad this patch is getting a bikeshedding kind of discussion. ;-)
I don't mind calling the function whatever you like. So let's make it get_crash_kernel_load_range. Wait for v3. ;-)

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
