Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JodpA-0006Jn-1w
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 12:11:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <480DD85C.7060200@ah.jp.nec.com> <480F1987.9010501@ah.jp.nec.com>
Date: Wed, 23 Apr 2008 05:11:26 -0700
In-Reply-To: <480F1987.9010501@ah.jp.nec.com> (Takenori Nagano's message of
	"Wed, 23 Apr 2008 20:12:07 +0900")
Message-ID: <m18wz4srdd.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] Move crash_kexec() into panic_notifier, take4
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, k-miyoshi@cb.jp.nec.com, greg@kroah.com, bwalle@suse.de, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

Takenori Nagano <t-nagano@ah.jp.nec.com> writes:

> This patch moves crash_kexec() into panic_notifier. If you want to use it,
> you have to set config option DUMP_ON_PANIC_NOTIFIER to Y. Its default value
> is N. If you set DUMP_ON_PANIC_NOTIFIER to N, kdump has no difference before.

NAK.  This patch is broken and does not accomplish what it
sets out to accomplish.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
