Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 23 Jun 2010 08:41:07 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
Message-ID: <20100623124106.GA13200@infradead.org>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com> <20100623113806.GD5242@nowhere>
	<4C21FF9A.2040207@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C21FF9A.2040207@linux.intel.com>
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
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <michael@ellerman.id.au>, Ian Munsie <imunsie@au1.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes@sipsolutions.net>, Roland McGrath <roland@redhat.com>, Dinakar Guniguntala <dino@in.ibm.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>

On Wed, Jun 23, 2010 at 02:35:38PM +0200, Andi Kleen wrote:
> >I haven't heard any complains about existing syscalls wrappers.
> 
> At least for me they always interrupt my grepping.
> 
> >
> >What kind of annotations could solve that?
> 
> If you put the annotation in a separate macro and leave the original
> prototype alone. Then C parsers could still parse it.

I personally hate the way SYSCALL_DEFINE works with passion, mostly
for the grep reason, but also because it looks horribly ugly.

But there is no reason not to be consistent here.  We already use
the wrappers for all native system calls, so leaving the compat
calls out doesn't make any sense.  And I'd cheer for anyone who
comes up with a better scheme for the native and compat wrappers.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
