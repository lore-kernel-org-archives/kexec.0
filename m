From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 May 2022 18:09:49 +0800
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <2da2e67a-864e-246b-b9d0-673c7af937b4@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
 <2da2e67a-864e-246b-b9d0-673c7af937b4@oracle.com>
Message-ID: <20220511100949.GG122876@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/09/22 at 10:43am, Eric DeVolder wrote:
> 
> 
> On 5/6/22 02:12, Baoquan He wrote:
> > On 05/05/22 at 02:45pm, Eric DeVolder wrote:
> > ......
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 256cf6db573c..f197af50def6 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -9,12 +9,17 @@
> > >   #include <linux/init.h>
> > >   #include <linux/utsname.h>
> > >   #include <linux/vmalloc.h>
> > > +#include <linux/highmem.h>
> > 
> > Wondering where highmem.h is needed. Just curious.
> 
> Ahh, I missed that. At one point in time we moved map_crash_pages() into
> this file, which brought highmem.h along with it. But we have since moved
> map_crash_pages() into x86/crash.c. And I missed eliminating highmem.h at
> that time.
> 
> I have removed this for v9.

That's nice, and you can add my ack when repost.

Acked-by: Baoquan He <bhe@redhat.com>


