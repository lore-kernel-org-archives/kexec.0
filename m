Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ITAJ1-0007MB-8A
	for kexec@lists.infradead.org; Thu, 06 Sep 2007 06:53:35 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l865r43H008570
	for <kexec@lists.infradead.org>; Thu, 6 Sep 2007 01:53:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l865r4IN434022
	for <kexec@lists.infradead.org>; Wed, 5 Sep 2007 23:53:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l865r4RZ000300
	for <kexec@lists.infradead.org>; Wed, 5 Sep 2007 23:53:04 -0600
Date: Thu, 6 Sep 2007 11:23:10 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
Message-ID: <20070906055310.GE17336@in.ibm.com>
References: <20070831104951.f88cc3ba.rdunlap@xenotime.net>
	<20070903165708tachibana@mail.jp.nec.com>
	<20070904162652.15636f66.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070904162652.15636f66.rdunlap@xenotime.net>
Reply-To: vgoyal@in.ibm.com
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>

On Tue, Sep 04, 2007 at 04:26:52PM -0700, Randy Dunlap wrote:
> On Mon, 3 Sep 2007 16:57:08 +0900 tachibana@mxm.nes.nec.co.jp wrote:
> 
> > Makefile installs ld command etc. and they influence kernel build.
> > We installed elfutils-0.125 not by 'make install' but by procedure 
> > written at README of makedumpfile-1.1.6 in RHEL5.0 environment.
> > Please uninstall elfutils-0.125 and elfutils-0.128 and try the above
> > procedure.
> 
> 
> Hi tachibana-san,
> 
> I have makedumpfile filtering working now.  Much thanks.
> 
> Examples of filtering on a 1 GB x86_64 system, booted with
> "crashkernel=64M@16M" and then crashed (sysrq-c).
> 
> 
> Various makedumpfile -d values and their results:
> 
> makedumpfile -d 1 -E -i vmcore.info vmcore.002 dump002.omit.zero 
> makedumpfile -d 17 -E -i vmcore.info vmcore.002 dump002.omit.zero.free
> makedumpfile -d 23 -E -i vmcore.info vmcore.002 dump002.omit.zero.free.all.cache
> makedumpfile -d 31 -E -i vmcore.info vmcore.002 dump002.omit.all
> 
> -r-------- 1 rddunlap users    970M Sep  4 12:36 vmcore.002 // dumpfile
> -rw------- 1 rddunlap rddunlap 966M Sep  4 15:10 dump002.omit.zero
> -rw------- 1 rddunlap rddunlap 661M Sep  4 15:29 dump002.omit.zero.free
> -rw------- 1 rddunlap rddunlap 443M Sep  4 15:43 dump002.omit.zero.free.all.cache
> -rw------- 1 rddunlap rddunlap 429M Sep  4 15:55 dump002.omit.all
> 

Interesting. Even after filtering all, dump file size is 429 MB. Given this
system has got 1GB of memory, so file size reduction is about only 55%.
Wondering what kind of kernel data is in there. Can something else also be
filtered out.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
