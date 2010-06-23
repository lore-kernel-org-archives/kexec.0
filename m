Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1ORNER-0006a6-4u
	for kexec@lists.infradead.org; Wed, 23 Jun 2010 10:31:00 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o5NAUqkQ006236 for <kexec@lists.infradead.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 23 Jun 2010 19:30:53 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C84045DE56
	for <kexec@lists.infradead.org>; Wed, 23 Jun 2010 19:30:52 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A8C245DE50
	for <kexec@lists.infradead.org>; Wed, 23 Jun 2010 19:30:52 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 456081DB8014
	for <kexec@lists.infradead.org>; Wed, 23 Jun 2010 19:30:52 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id E2B951DB8016
	for <kexec@lists.infradead.org>; Wed, 23 Jun 2010 19:30:48 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
In-Reply-To: <4C21DFBA.2070202@linux.intel.com>
References: <1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com>
Message-Id: <20100623192930.B5A9.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Date: Wed, 23 Jun 2010 19:30:47 +0900 (JST)
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>, kosaki.motohiro@jp.fujitsu.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <michael@ellerman.id.au>, Ian Munsie <imunsie@au1.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes@sipsolutions.net>, Roland McGrath <roland@redhat.com>, Dinakar Guniguntala <dino@in.ibm.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>

> , Ian Munsie wrote:
> > From: Ian Munsie<imunsie@au1.ibm.com>
> >
> > This patch converts numerous trivial compat syscalls through the generic
> > kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.
> 
> Why? This just makes the code look uglier and the functions harder
> to grep for.

I guess trace-syscall feature need to override COMPAT_SYSCALL_DEFINE. but
It's only guess...



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
