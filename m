Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-3-arnd@arndb.de>
 <20200919053716.GJ30063@infradead.org>
In-Reply-To: <20200919053716.GJ30063@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 26 Sep 2020 23:10:05 +0200
Message-ID: <CAK8P3a27R1dSWXRJiLwpA-q6KLC8KVy=BXnXqif072kL+JcdPg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kexec: remove compat_sys_kexec_load syscall
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Sat, Sep 19, 2020 at 7:37 AM Christoph Hellwig <hch@infradead.org> wrote:

> > +             struct compat_kexec_segment __user *cs = (void __user *)segments;
> > +             struct compat_kexec_segment segment;
> > +             int i;
> > +             for (i=0; i< nr_segments; i++) {
>
> Missing empty line after the variable declarations and really strange
> indentation.
>
> > +                     copy_from_user(&segment, &cs[i], sizeof(segment));
>
> Missing return value check.
>
> > +                     if (ret)
> > +                             break;
> > +
> > +                     image->segment[i] = (struct kexec_segment) {
> > +                             .buf   = compat_ptr(segment.buf),
> > +                             .bufsz = segment.bufsz,
> > +                             .mem   = segment.mem,
> > +                             .memsz = segment.memsz,
> > +                     };
> > +             }
>
> I'd split the whole compat handling into a helper, and I'd probably
> use the unsafe_get/put user to optimize it a little more.
>
> > +     } else {
> > +             ret = copy_from_user(image->segment, segments, segment_bytes);
> > +     }
> >       if (ret)
> >               ret = -EFAULT;
>
> Why not just
>
>                 if (copy_from_user(image->segment, segments, segment_bytes))
>                         ret = -EFAULT;
>
> ?

Addressed all of these now, thanks for the suggestions!

I had already fixed the missing error handling after the kbuild bot
pointed that out. The separate function does improve the error
handling.

I ended up not using unsafe_get/put since I find the copy_from_user
based loop more readable and it should lead to smaller object code in
most cases as well. kexec is not performance critical, so readability
seems more important here.

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
