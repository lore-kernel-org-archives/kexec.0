Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbLGm-00082a-I6
 for kexec@lists.infradead.org; Wed, 20 May 2020 09:44:15 +0000
Date: Wed, 20 May 2020 17:43:59 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add files related to kdump
Message-ID: <20200520094359.GV5029@MiWiFi-R3L-srv>
References: <20200520080557.13260-1-bhe@redhat.com>
 <20200520091440.GA5052@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520091440.GA5052@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On 05/20/20 at 05:14pm, Dave Young wrote:
> Hi Baoquan,
> On 05/20/20 at 04:05pm, Baoquan He wrote:
> > Kdump is implemented based on kexec, however some files are only
> > related to crash dumping and missing, add them to KDUMP entry.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 83cf5c43242a..2f9eefd33114 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9251,6 +9251,11 @@ L:	kexec@lists.infradead.org
> >  S:	Maintained
> >  W:	http://lse.sourceforge.net/kdump/
> >  F:	Documentation/admin-guide/kdump/
> > +F:	fs/proc/vmcore.c
> > +F:	include/linux/crash_core.h
> > +F:	include/linux/crash_dump.h
> > +F:	include/uapi/linux/vmcore.h
> > +F:	kernel/crash.*
> 
> ls kernel/crash.*
> ls: cannot access 'kernel/crash.*': No such file or directory
> 
> But ls kernel/crash*
> kernel/crash_core.c  kernel/crash_dump.c

Is below patten ok? Surely kernel/crash* is also OK to me. Thanks.

F:	kernel/crash_*.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
