Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnui-0002Aw-90
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:34 +0000
Subject: A few patches to consider
Message-Id: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

I am submitting 6 patches that I have found helpful in speeding the dump
process or clarifying the progress report.
They are not a series, and should not be interdependent.  But if you
find any dependencies I apply them in this order:
[PATCH] makedumpfile: reverse -c and -p if using snappy compression
[PATCH] makedumpfile: use non-cyclic when possible
[PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
[PATCH] makedumpfile: shorten cyclic unnecessary-page scans
[PATCH] makedumpfile: show needed memory
[PATCH] makedumpfile: search for a debug vmlinux

The last one (search for a debug vmlinux) is useful in identifying huge
pages with the PG_head/PG-tail flags.  There was a patch from Petr Tesarik
that enables that huge page filtering. I don't think you are taking that one
as-is, but are reworking it. Seems like Hatayama-san was doing that work.
That one is very important and I need to include Petr's version in any
makedumpfile that we use in a very large system.  I hope that one is coming
along for inclusion in the next release.

-Cliff Wickman

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
