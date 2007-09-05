Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ISjUs-0002NI-D5
	for kexec@lists.infradead.org; Tue, 04 Sep 2007 21:16:01 -0400
Subject: Re: [patch] makedumpfile: update/clarify README
In-reply-to: <20070904133618.6a23df52.rdunlap@xenotime.net>
Message-Id: <20070905101607oomichi@mail.jp.nec.com>
References: <20070904133618.6a23df52.rdunlap@xenotime.net>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 5 Sep 2007 10:16:07 +0900
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
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>


Hi Randy,

2007/09/04 13:36:18 -0700, Randy Dunlap <rdunlap@xenotime.net> wrote:
>On Mon, 3 Sep 2007 16:57:08 +0900 tachibana@mxm.nes.nec.co.jp wrote:
>
>> Makefile installs ld command etc. and they influence kernel build.
>> We installed elfutils-0.125 not by 'make install' but by procedure 
>> written at README of makedumpfile-1.1.6 in RHEL5.0 environment.
>> Please uninstall elfutils-0.125 and elfutils-0.128 and try the above
>> procedure.
>
>Hi tachibana-san,
>
>Thanks for that info.  I completely missed that in the README file.
>Please update the README file with this patch.


Thank you for the patch.
That sounds good, I will merge the patch into the next release.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
