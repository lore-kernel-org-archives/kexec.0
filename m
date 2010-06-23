Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OROHS-0002SN-0J
	for kexec@lists.infradead.org; Wed, 23 Jun 2010 11:38:10 +0000
Received: by bwz6 with SMTP id 6so1436599bwz.36
	for <kexec@lists.infradead.org>; Wed, 23 Jun 2010 04:38:08 -0700 (PDT)
Date: Wed, 23 Jun 2010 13:38:07 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
Message-ID: <20100623113806.GD5242@nowhere>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C21E3F8.9000405@linux.intel.com>
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
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <michael@ellerman.id.au>, Ian Munsie <imunsie@au1.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes@sipsolutions.net>, Roland McGrath <roland@redhat.com>, Dinakar Guniguntala <dino@in.ibm.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>

On Wed, Jun 23, 2010 at 12:37:44PM +0200, Andi Kleen wrote:
> , Frederic Weisbecker wrote:
>> On Wed, Jun 23, 2010 at 12:19:38PM +0200, Andi Kleen wrote:
>>> , Ian Munsie wrote:
>>>> From: Ian Munsie<imunsie@au1.ibm.com>
>>>>
>>>> This patch converts numerous trivial compat syscalls through the generic
>>>> kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.
>>>
>>> Why? This just makes the code look uglier and the functions harder
>>> to grep for.
>>
>>
>> Because it makes them usable with syscall tracing.
>
> Ok that information is missing in the changelog then.


Agreed, the changelog lacks the purpose of what it does.



> Also I hope the uglification<->usefullness factor is really worth it.
> The patch is certainly no slouch on the uglification side.


It's worth because the kernel's syscall tracing is not complete, we lack all
the compat part.

These wrappers let us create TRACE_EVENT() for every syscalls automatically.
If we had to create them manually, the uglification would be way much more worse.

Most syscalls use the syscall wrappers already, so the uglification
is there mostly. We just forgot to uglify a bunch of them :)


> It also has maintenance costs, e.g. I doubt ctags and cscope
> will be able to deal with these kinds of macros, so it has a
> high cost for everyone using these tools. For those
> it would be actually better if you used separate annotation
> that does not confuse standard C parsers.


I haven't heard any complains about existing syscalls wrappers.

What kind of annotations could solve that?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
