Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfLVX-00028o-3r
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 05:25:19 +0000
Date: Fri, 25 Sep 2015 13:24:48 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V2] kexec: Use file name as the output message prefix
Message-ID: <20150925052448.GB11707@dhcp-129-149.nay.redhat.com>
References: <1443074860-18989-1-git-send-email-mnfhuang@gmail.com>
 <20150925050444.GA11707@dhcp-129-149.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150925050444.GA11707@dhcp-129-149.nay.redhat.com>
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, linux-kernel@vger.kernel.org

On 09/25/15 at 01:04pm, Dave Young wrote:
> On 09/24/15 at 02:07pm, Minfei Huang wrote:
> > kexec output message misses the prefix "kexec", when Dave Young split
> > the kexec code. Now, we use file name as the output message prefix.
> > 
> > Currectly, the format of output message:

s/Currectly/Currently

> > [  140.290795] SYSC_kexec_load: hello, world
> > [  140.291534] kexec: sanity_check_segment_list: hello, world
> > 
> > Ideally, the format of output message:
> > [   30.791503] kexec: SYSC_kexec_load, Hello, world
> > [   79.182752] kexec_core: sanity_check_segment_list, Hello, world
> > 
> > Remove the custom prefix "kexec" in output message.
> > 
> > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > ---
> > v2: Use KBUILD_MODNAME as prefix, instead of custom string "kexec"
> > ---
> >  kernel/kexec.c      | 2 ++
> >  kernel/kexec_core.c | 4 ++--
> >  kernel/kexec_file.c | 2 ++
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 4c5edc3..df772fc 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -18,6 +18,8 @@
> >  
> >  #include "kexec_internal.h"
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> 
> Move the micro to the top of the c file is better, ditto for other two files.

s/micro/macro

> 
> Otherwise:
> Acked-by: Dave Young <dyoung@redhat.com>
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
