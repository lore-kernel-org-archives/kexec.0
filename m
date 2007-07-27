Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IESRR-0005fp-MV
	for kexec@lists.infradead.org; Fri, 27 Jul 2007 12:13:26 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6RGDN8r012563
	for <kexec@lists.infradead.org>; Fri, 27 Jul 2007 12:13:23 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l6RGDN3w021460
	for <kexec@lists.infradead.org>; Fri, 27 Jul 2007 12:13:23 -0400
Received: from redhat.com (crash.boston.redhat.com [172.16.80.17])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l6RGDMF3005993
	for <kexec@lists.infradead.org>; Fri, 27 Jul 2007 12:13:22 -0400
Message-ID: <46AA1AC0.2040702@redhat.com>
Date: Fri, 27 Jul 2007 12:18:08 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.1.5: Xen support
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
To: kexec@lists.infradead.org


> Changelog:
> o Add a new feature that extracting the part of xen hypervisor and
>   domain-0 from /proc/vmcore. In most cases under xen environment,
>   it is enough to analyze a cause of system crash.
>   The patch was provided by Itsuro Oda.
>   Usage:
>     # makedumpfile -E --xen-syms xen-syms /proc/vmcore dumpfile

Can you verify that the dumpfile created above is usable as both a
hypervisor dumpfile as well as a dom0 vmlinux dumpfile?  In other
words, can both of the following sessions be accomplished with the
resultant dumpfile?

  # crash xen-syms dumpfile

and:

  # crash vmlinux dumpfile

Thanks,
   Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
