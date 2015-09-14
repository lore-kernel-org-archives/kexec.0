Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZbOXo-0003FL-SR
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 07:51:21 +0000
Received: by padhy16 with SMTP id hy16so136761042pad.1
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 00:50:59 -0700 (PDT)
Date: Mon, 14 Sep 2015 15:50:56 +0800
From: Minfei Huang <mnfhuang@gmail.com>
Subject: Re: [PATCH] kexec: Add prefix "kexec" to output message
Message-ID: <20150914075056.GA13324@t440s.lenovo>
References: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com>
 <87fv2il0rq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fv2il0rq.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, linux-kernel@vger.kernel.org

On 09/13/15 at 11:52am, Eric W. Biederman wrote:
> Minfei Huang <mnfhuang@gmail.com> writes:
> 
> > kexec output message misses the prefix "kexec", when Dave Young split
> > the kexec code. To keep the same format, add the prefix "kexec" to
> > output message.
> 
> What of kexec_core? What of the messages that already have a prefix?
> 

Hi, Eric.

Last commit(2965fa), Dave Young (dyoung@redhatcom) split the previous
kernel/kexec.c into three pieces(kexec_core.c, kexec_file.c, kexec.c).
The common functions used by both kexec and kexec_file are placed in
file kernel/kexec_core.c.

The format of the output message likes "kexec: SYSC_kexec_load: hello,
world" previously. Due to the missing prefix "kexec", now it like
"SYSC_kexec_load: hello, world".

Dave Young misses the Macro pr_fmt to define the prefix output message
in file kexec.c and kexec_file.c. I think the previous Macro was moved
into the file kexec_core.c when Dave did the splitting.

Thanks
Minfei

> > Following is the format of output message now.
> > [  140.290795] SYSC_kexec_load: hello, world
> >
> > Ideally, the format of output message likes below.
> > [  140.291534] kexec: sanity_check_segment_list: hello, world
> >
> > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > ---
> >  kernel/kexec.c      | 2 ++
> >  kernel/kexec_file.c | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 4c5edc3..15351ba 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -6,6 +6,8 @@
> >   * Version 2.  See the file COPYING for more details.
> >   */
> >  
> > +#define pr_fmt(fmt)	"kexec: " fmt
> > +
> >  #include <linux/capability.h>
> >  #include <linux/mm.h>
> >  #include <linux/file.h>
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 6a9a3f2..b1ad01b 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -9,6 +9,8 @@
> >   * Version 2.  See the file COPYING for more details.
> >   */
> >  
> > +#define pr_fmt(fmt)	"kexec: " fmt
> > +
> >  #include <linux/capability.h>
> >  #include <linux/mm.h>
> >  #include <linux/file.h>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
