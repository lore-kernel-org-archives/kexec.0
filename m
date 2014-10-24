Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XhaM0-0002wr-A1
 for kexec@lists.infradead.org; Fri, 24 Oct 2014 08:36:14 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9O8ZmZu004758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Fri, 24 Oct 2014 04:35:48 -0400
Message-ID: <1414118726.7717.21.camel@serendib>
Subject: Re: [PATCH] makedumpfile.8: "cache without private" column of the
 table for -d appears to be incorrect
From: Harshula Jayasuriya <harshula@redhat.com>
Date: Fri, 24 Oct 2014 13:45:26 +1100
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D5675E@BPXM01GP.gisp.nec.co.jp>
References: <1413269123.514.72.camel@serendib>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D564D0@BPXM01GP.gisp.nec.co.jp>
 <1413510540.514.175.camel@serendib>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D5675E@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Minoru Usui <usui@mxm.nes.nec.co.jp>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 2014-10-17 at 07:37 +0000, Atsushi Kumagai wrote:
> >Hi,
> >
> >On Fri, 2014-10-17 at 01:02 +0000, Atsushi Kumagai wrote:
> >> Hello,
> >>
> >> >Hi,
> >> >
> >> >The makedumpfile man page contains a table explaining the usage of -d.
> >> >The "cache without private" column implies that -d 4 would exclude "cache
> >> >without private" pages. However, a -d 4 should only exclude "cache with
> >> >private".
> >>
> >> "cache with private" includes "cache without private" because the latter
> >> doesn't mean leaving private cache pages, just mean excluding cache pages
> >> except private pages. Meanwhile, "cache with private" means excluding both
> >> cache pages (private and non-private). So "with private" meets "without private"
> >> in this feature, they aren't exclusive.
> >> This style is for diskdump compatibility, but now I suspect it may be
> >> bit confusing.
> >
> >Ahhh I see! ;-)
> >
> >> I don't want to change the behavior of the page filtering, but I guess
> >> changing the column names might be meaningful.
> >
> >Would the following help?
> >
> >a) s/cache without private/non-private cache/
> >
> >b) s/cache with private/all cache/
> 
> Thanks for your suggestion, but now I think each column should
> be exclusive to make the rule consistent. Actually, other columns
> (zero page, user data, free page) are exclusive.
> 
> So let's name the two like below:
> 
>  a) non-private cache
>  b) private cache
> 
>                      |      |non-   |       |      |
>                 dump | zero |private|private| user | free
>                level | page |cache  |cache  | data | page
>               -------+------+-------+-------+------+------
>                  ...
>                    4 |      |   X   |   X   |      |
>                    5 |  X   |   X   |   X   |      |
> 
> then marking the both columns for level 4 will be natural.
> I'll post a patch later if there is no objection.

Looks good to me!

cya,
#

> Thanks,
> Atsushi Kumagai
> 
> >cya,
> >#
> >
> >> I'm curious to know what everyone thought of the two columns. This can
> >> be a good opportunity to make the manual easier to understand.
> >>
> >>
> >> Thanks,
> >> Atsushi Kumagai
> >>
> >> >makedumpfile.h:
> >> >------------------------------------------------------------
> >> > #define DL_EXCLUDE_CACHE        (0x002) /* Exclude Cache Pages
> >> >                                            without Private Pages */
> >> >------------------------------------------------------------
> >> >
> >> >makedumpfile.8:
> >> >------------------------------------------------------------
> >> >                     |      |cache  |cache  |      |
> >> >                dump | zero |without|with   | user | free
> >> >               level | page |private|private| data | page
> >> >              -------+------+-------+-------+------+------
> >> >                   0 |      |       |       |      |
> >> >                   1 |  X   |       |       |      |
> >> >                   2 |      |   X   |       |      |
> >> >                   3 |  X   |   X   |       |      |
> >> >                   4 |      |   X   |   X   |      |
> >> >                   5 |  X   |   X   |   X   |      |
> >> >                   6 |      |   X   |   X   |      |
> >> >                   7 |  X   |   X   |   X   |      |
> >> >                   8 |      |       |       |  X   |
> >> >------------------------------------------------------------
> >> >
> >> >Signed-off-by: Harshula Jayasuriya <harshula@redhat.com>
> >> >---
> >> > makedumpfile.8 | 16 ++++++++--------
> >> > 1 file changed, 8 insertions(+), 8 deletions(-)
> >> >
> >> >diff --git a/makedumpfile.8 b/makedumpfile.8
> >> >index 9cb12c0..382c6ee 100644
> >> >--- a/makedumpfile.8
> >> >+++ b/makedumpfile.8
> >> >@@ -174,32 +174,32 @@ by dump_level 11, makedumpfile retries it by dump_level 31.
> >> >      1 |  X   |       |       |      |
> >> >      2 |      |   X   |       |      |
> >> >      3 |  X   |   X   |       |      |
> >> >-     4 |      |   X   |   X   |      |
> >> >-     5 |  X   |   X   |   X   |      |
> >> >+     4 |      |       |   X   |      |
> >> >+     5 |  X   |       |   X   |      |
> >> >      6 |      |   X   |   X   |      |
> >> >      7 |  X   |   X   |   X   |      |
> >> >      8 |      |       |       |  X   |
> >> >      9 |  X   |       |       |  X   |
> >> >     10 |      |   X   |       |  X   |
> >> >     11 |  X   |   X   |       |  X   |
> >> >-    12 |      |   X   |   X   |  X   |
> >> >-    13 |  X   |   X   |   X   |  X   |
> >> >+    12 |      |       |   X   |  X   |
> >> >+    13 |  X   |       |   X   |  X   |
> >> >     14 |      |   X   |   X   |  X   |
> >> >     15 |  X   |   X   |   X   |  X   |
> >> >     16 |      |       |       |      |  X
> >> >     17 |  X   |       |       |      |  X
> >> >     18 |      |   X   |       |      |  X
> >> >     19 |  X   |   X   |       |      |  X
> >> >-    20 |      |   X   |   X   |      |  X
> >> >-    21 |  X   |   X   |   X   |      |  X
> >> >+    20 |      |       |   X   |      |  X
> >> >+    21 |  X   |       |   X   |      |  X
> >> >     22 |      |   X   |   X   |      |  X
> >> >     23 |  X   |   X   |   X   |      |  X
> >> >     24 |      |       |       |  X   |  X
> >> >     25 |  X   |       |       |  X   |  X
> >> >     26 |      |   X   |       |  X   |  X
> >> >     27 |  X   |   X   |       |  X   |  X
> >> >-    28 |      |   X   |   X   |  X   |  X
> >> >-    29 |  X   |   X   |   X   |  X   |  X
> >> >+    28 |      |       |   X   |  X   |  X
> >> >+    29 |  X   |       |   X   |  X   |  X
> >> >     30 |      |   X   |   X   |  X   |  X
> >> >     31 |  X   |   X   |   X   |  X   |  X
> >> >
> >> >--
> >> >1.9.3
> >



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
