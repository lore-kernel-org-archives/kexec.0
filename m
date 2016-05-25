Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5Z0A-0007KZ-M3
 for kexec@lists.infradead.org; Wed, 25 May 2016 13:37:35 +0000
Date: Wed, 25 May 2016 09:37:13 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Kdump maintainers update
Message-ID: <20160525133713.GA2590@redhat.com>
References: <20160525131616.GB27291@redhat.com>
 <1464182650.16344.6.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1464182650.16344.6.camel@perches.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

On Wed, May 25, 2016 at 06:24:10AM -0700, Joe Perches wrote:
> On Wed, 2016-05-25 at 09:16 -0400, Vivek Goyal wrote:
> > I am proposing following updates to kdump maintainership. I have got
> > busy in other things and not getting time to spend on kdump.=A0
> > =

> > Removed Haren Myneni as he has not participated in kdump development for
> > a long time now.
> > =

> > Proposing adding the names of Dave and Baoquan as kdump maintainers as
> > they have been contributing to kdump for a long time now and they are in
> > a much better position to spend time on this than me.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -6189,8 +6189,9 @@ F:	Documentation/kbuild/kconfig-language.txt
> > =A0F:	scripts/kconfig/
> > =A0
> > =A0KDUMP
> > +M:	Dave Young <dyoung@redhat.com>
> > +M:	Baoquan He <bhe@redhat.com>
> > =A0M:	Vivek Goyal <vgoyal@redhat.com>
> =

> You could mark yourself as an "R:" reviewer
> instead of an "M:" maintainer.

That's a good idea. I updated the patch and marked myself reviewer.

Removed Haren Myneni as he has not participated in kdump development for
a long time now.

Proposing adding the names of Dave and Baoquan as kdump maintainers as
they have been working on it for quite some time on it upstream and
they are in a much better position to spend time on this than me.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c567a4..5792ec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6189,8 +6189,9 @@ F:	Documentation/kbuild/kconfig-language.txt
 F:	scripts/kconfig/
 =

 KDUMP
-M:	Vivek Goyal <vgoyal@redhat.com>
-M:	Haren Myneni <hbabu@us.ibm.com>
+M:	Dave Young <dyoung@redhat.com>
+M:	Baoquan He <bhe@redhat.com>
+R:	Vivek Goyal <vgoyal@redhat.com>
 L:	kexec@lists.infradead.org
 W:	http://lse.sourceforge.net/kdump/
 S:	Maintained
-- =

2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
