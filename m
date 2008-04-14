Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JlPwh-0007u4-FK
	for kexec@lists.infradead.org; Mon, 14 Apr 2008 14:46:11 +0000
Date: Mon, 14 Apr 2008 16:46:34 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 0/2] add new notifier function ,take3
Message-ID: <20080414164634.190e3e0e@strauss.suse.de>
In-Reply-To: <20080414144228.GD1193@hmsendeavour.rdu.redhat.com>
References: <47FF190B.6030406@ah.jp.nec.com>
	<20080411210751.e4a468b2.akpm@linux-foundation.org>
	<20080414134622.GB6941@redhat.com>
	<20080414144228.GD1193@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: nickpiggin@yahoo.com.au, k-miyoshi@cb.jp.nec.com, greg@kroah.com, kdb@oss.sgi.com, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, "Eric W.  Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

* Neil Horman [2008-04-14 10:42]:
>
> I know it doesn't particularly relate to this patch, but FWIW, for cases like
> failover, I've inserted infrastrucutre in the userspace part of kdump for
> Fedora/RHEL to support this sort of thing.  We can run arbitrary scripts righte
> before and after a capture so that notifications can be sent to remote nodes in
> a much safer fashion than using the notifier chain after a panic.

But that doesn't help if you want to use a debugger (KDB, KGDB).


	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
