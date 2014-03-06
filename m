Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLNsy-0007xa-8n
 for kexec@lists.infradead.org; Thu, 06 Mar 2014 02:18:13 +0000
Date: Thu, 6 Mar 2014 11:17:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: PATCH: bug in locate_hole()
Message-ID: <20140306021747.GG13581@verge.net.au>
References: <CAMBSHm_fvPTjdEwgVdyMGPi=3et+JEP-G5TNV986yXWYw35YYw@mail.gmail.com>
 <CAMBSHm89oxceGi=cSwSMLRtaVwQ=oX=BZeBtCg_-trN+1HShkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMBSHm89oxceGi=cSwSMLRtaVwQ=oX=BZeBtCg_-trN+1HShkg@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matthew Fleming <mdf356@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 04, 2014 at 06:52:17PM -0800, Matthew Fleming wrote:
> On Mon, Mar 3, 2014 at 4:34 PM, Matthew Fleming <mdf356@gmail.com> wrote:
> > In upgrading to kexec-tools 2.0.5 I first got the error "Overlapping
> > memory segments at 0xbeff000"
> >
> > Adding some debugging I found locate_hole was returning incorrect
> > values.  The below is from the debug I added:
> >
> > XXXMDF: look for hole size 100000, cur range [52b3000, bffffff] size 6d4cfff
> > XXXMDF: look for hole memsz=100000, found beff000
> >
> > Hmm, if we wanted 0x100000 bytes ending at 0xbffffff, that should be
> > 0xbf00000, not 0xbef000.  Continuing to the second invocation:
> >
> > XXXMDF: look for hole size 1000, cur range [52b3000, befefff] size 6c4bfff
> > XXXMDF: look for hole size 1000, cur range [bfff000, bffffff] size fff
> > XXXMDF: look for hole memsz=1000, found bffe000
> >
> > Now we die with overlapping ranges, since the 0x100000 bytes at
> > 0xbeff000 overlaps 0x1000 bytes at 0xbffe000.
> >
> > The attached patch fixes the off-by-one that causes the later overlap.
> 
> Fix an off-by-one in locate_hole() that can cause it to return a range
> that was previously allocated.
> 
> Signed-off-by: Matthew Fleming <mdf356@gmail.com>

Thanks. I have applied the following:


From: Matthew Fleming <mdf356@gmail.com>

Fix an off-by-one in locate_hole()

Fix an off-by-one in locate_hole() that can cause it to return a range
that was previously allocated.

In upgrading to kexec-tools 2.0.5 I first got the error "Overlapping
memory segments at 0xbeff000"

Adding some debugging I found locate_hole was returning incorrect
values.  The below is from the debug I added:

XXXMDF: look for hole size 100000, cur range [52b3000, bffffff] size 6d4cfff
XXXMDF: look for hole memsz=100000, found beff000

Hmm, if we wanted 0x100000 bytes ending at 0xbffffff, that should be
0xbf00000, not 0xbef000.  Continuing to the second invocation:

XXXMDF: look for hole size 1000, cur range [52b3000, befefff] size 6c4bfff
XXXMDF: look for hole size 1000, cur range [bfff000, bffffff] size fff
XXXMDF: look for hole memsz=1000, found bffe000

Now we die with overlapping ranges, since the 0x100000 bytes at
0xbeff000 overlaps 0x1000 bytes at 0xbffe000.

Signed-off-by: Matthew Fleming <mdf356@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 703d524..382f86a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -275,7 +275,7 @@ unsigned long locate_hole(struct kexec_info *info,
 				hole_base = start;
 				break;
 			} else {
-				hole_base = _ALIGN_DOWN(end - hole_size,
+				hole_base = _ALIGN_DOWN(end - hole_size + 1,
 					hole_align);
 			}
 		}
-- 
1.8.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
