Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeHvA-0005yh-Dz
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 07:55:40 +0000
Date: Fri, 11 Mar 2016 15:55:06 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] [PATCH 1/2] Introduce new macros min_lt and max_lt
 for comparing with larger type
Message-ID: <20160311075506.GB8337@dhcp-128-65.nay.redhat.com>
References: <20160311062953.571397512@redhat.com>
 <CAHz2CGXmo87ZNha-Kzy_1Vk8vuWg_9CY5oYqtNGdw1iat1F_5A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHz2CGXmo87ZNha-Kzy_1Vk8vuWg_9CY5oYqtNGdw1iat1F_5A@mail.gmail.com>
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
To: Jianyu Zhan <nasa4836@gmail.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, d.hatayama@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

Hi, Jianyu

On 03/11/16 at 03:19pm, Jianyu Zhan wrote:
> On Fri, Mar 11, 2016 at 2:21 PM,  <dyoung@redhat.com> wrote:
> > A useful use case for min_t and max_t is comparing two values with larger
> > type. For example comparing an u64 and an u32, usually we do not want to
> > truncate the u64, so we need use min_t or max_t with u64.
> >
> > To simplify the usage introducing two more macros min_lt and max_lt,
> > 'lt' means larger type.
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  include/linux/kernel.h |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > --- linux.orig/include/linux/kernel.h
> > +++ linux/include/linux/kernel.h
> > @@ -798,6 +798,19 @@ static inline void ftrace_dump(enum ftra
> >         type __max2 = (y);                      \
> >         __max1 > __max2 ? __max1: __max2; })
> >
> > +/*
> > + * use type of larger size in min_lt and max_lt
> > + */
> > +#define min_lt(x, y) ({                        \
> > +       int sx = sizeof(typeof(x));             \
> > +       int sy = sizeof(typeof(y));             \
> > +       sx > sy ? min_t(typeof(x), x, y) : min_t(typeof(y), x, y); })
> > +
> > +#define max_lt(x, y) ({                        \
> > +       int sx = sizeof(typeof(x));             \
> > +       int sy = sizeof(typeof(y));             \
> > +       sx > sy ? max_t(typeof(x), x, y) : max_t(typeof(y), x, y); })
> > +
> >  /**
> >   * clamp_t - return a value clamped to a given range using a given type
> >   * @type: the type of variable to use
> >
> >
> 
> No no!
> 
> C standard has defined "usual arithmetic conversions" rules[1], which
> decides the type promotion rules in binary operators.
> 
> The interfaces in this patch just bluntly overrides this rule to
> choose the bigger type size
> for operation.  Most of time it might work well, because most time the
> operands used in min_t()/max_t() in Linux kernel
> have same sign'ness and this rule works.
> 
> But if two operands have same size type but have different different
> sign'ness,  this interfaces will exhibit Undefind Behavior,
> i.e.  you choose the typeof(y) as the final type to use in operation
> when they have the same type size,  so it might be signed
> or unsigned, depending on the type of y.

Oops, brain dead, I obviously missed the case, it is definitely a problem.

> 
> So,  in this /proc/fs/vmcore case you should rather just explicit cast
> the operand to avoid truncation.

Sure, will resend a fix

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
