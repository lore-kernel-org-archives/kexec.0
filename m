Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSibD-0005fJ-7x
	for kexec@lists.infradead.org; Tue, 12 Aug 2008 01:22:59 +0000
Subject: Re: [PATCH -v2 7/8] kexec jump: ftrace_enabled_save/restore
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080811135136.GD28030@redhat.com>
References: <1218178368.22039.80.camel@caritas-dev.intel.com>
	<20080808141700.GF3840@redhat.com>
	<alpine.DEB.1.10.0808081026240.22796@gandalf.stny.rr.com>
	<1218417741.30464.23.camel@caritas-dev.intel.com>
	<20080811135136.GD28030@redhat.com>
Date: Tue, 12 Aug 2008 09:22:53 +0800
Message-Id: <1218504173.24951.7.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

Hi, Vivek,

On Mon, 2008-08-11 at 09:51 -0400, Vivek Goyal wrote:
[...]
> So you want to use a non-locked version from optimization point of view?
> So that we don't end up taking and release a lock?

Not from optimization point of view. machine_kexec() may be called from
crash_kexec(), where it is not permitted to take and release a lock.

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
