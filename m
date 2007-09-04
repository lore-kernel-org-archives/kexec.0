Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IShnS-0001bC-2j
	for kexec@lists.infradead.org; Tue, 04 Sep 2007 19:27:06 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Tue, 4 Sep 2007 16:26:53 -0700
Date: Tue, 4 Sep 2007 16:26:52 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
Message-Id: <20070904162652.15636f66.rdunlap@xenotime.net>
In-Reply-To: <20070903165708tachibana@mail.jp.nec.com>
References: <20070831104951.f88cc3ba.rdunlap@xenotime.net>
	<20070903165708tachibana@mail.jp.nec.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Mon, 3 Sep 2007 16:57:08 +0900 tachibana@mxm.nes.nec.co.jp wrote:

> Makefile installs ld command etc. and they influence kernel build.
> We installed elfutils-0.125 not by 'make install' but by procedure 
> written at README of makedumpfile-1.1.6 in RHEL5.0 environment.
> Please uninstall elfutils-0.125 and elfutils-0.128 and try the above
> procedure.


Hi tachibana-san,

I have makedumpfile filtering working now.  Much thanks.

Examples of filtering on a 1 GB x86_64 system, booted with
"crashkernel=64M@16M" and then crashed (sysrq-c).


Various makedumpfile -d values and their results:

makedumpfile -d 1 -E -i vmcore.info vmcore.002 dump002.omit.zero 
makedumpfile -d 17 -E -i vmcore.info vmcore.002 dump002.omit.zero.free
makedumpfile -d 23 -E -i vmcore.info vmcore.002 dump002.omit.zero.free.all.cache
makedumpfile -d 31 -E -i vmcore.info vmcore.002 dump002.omit.all

-r-------- 1 rddunlap users    970M Sep  4 12:36 vmcore.002 // dumpfile
-rw------- 1 rddunlap rddunlap 966M Sep  4 15:10 dump002.omit.zero
-rw------- 1 rddunlap rddunlap 661M Sep  4 15:29 dump002.omit.zero.free
-rw------- 1 rddunlap rddunlap 443M Sep  4 15:43 dump002.omit.zero.free.all.cache
-rw------- 1 rddunlap rddunlap 429M Sep  4 15:55 dump002.omit.all

Regards,
---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
