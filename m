Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1ORN3w-0001at-Cr
	for kexec@lists.infradead.org; Wed, 23 Jun 2010 10:20:08 +0000
Message-ID: <4C21DFBA.2070202@linux.intel.com>
Date: Wed, 23 Jun 2010 12:19:38 +0200
From: Andi Kleen <ak@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <michael@ellerman.id.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes@sipsolutions.net>, Roland McGrath <roland@redhat.com>, Dinakar Guniguntala <dino@in.ibm.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

, Ian Munsie wrote:
> From: Ian Munsie<imunsie@au1.ibm.com>
>
> This patch converts numerous trivial compat syscalls through the generic
> kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.

Why? This just makes the code look uglier and the functions harder
to grep for.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
