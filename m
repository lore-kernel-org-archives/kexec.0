Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBVQi-0007cU-Mb
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 13:53:01 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5PDqxxH012008
	for <kexec@lists.infradead.org>; Wed, 25 Jun 2008 09:52:59 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	m5PDqx5s017875
	for <kexec@lists.infradead.org>; Wed, 25 Jun 2008 09:52:59 -0400
Received: from [10.16.18.219] (dhcp-100-18-219.bos.redhat.com [10.16.18.219])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id
	m5PDqwwH002734
	for <kexec@lists.infradead.org>; Wed, 25 Jun 2008 09:52:58 -0400
Message-ID: <48624DBA.8000307@redhat.com>
Date: Wed, 25 Jun 2008 09:52:58 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
References: <mailman.1873.1214398996.2802.kexec@lists.infradead.org>
In-Reply-To: <mailman.1873.1214398996.2802.kexec@lists.infradead.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

> It seems that I now need the crash utility also to be cross compiled.
> I dont see any cross-compile support in the crash-4.0-6.3 pkg.

You got that right...

> Any suggestions for how to cross compile the crash-4.0-6.3 for x86_64
> on an x86 system.

Like Bernhard suggested, try tinkering with the compilations in the
top-level Makefile, as well as passing --host and --target arguments
to the embedded gdb's configure command when it gets built.

I'm unaware of anybody who's ever attempted it...

Dave




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
