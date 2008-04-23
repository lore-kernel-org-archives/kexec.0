Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Joe9T-0002eN-2B
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 12:32:43 +0000
Date: Wed, 23 Apr 2008 08:32:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3] add new notifier function ,take4
Message-ID: <20080423123233.GA23066@redhat.com>
References: <480F1957.2070609@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <480F1957.2070609@ah.jp.nec.com>
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
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, k-miyoshi@cb.jp.nec.com, greg@kroah.com, bwalle@suse.de, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Apr 23, 2008 at 08:11:19PM +0900, Takenori Nagano wrote:
> Hi,
> 
> changelog take3 -> take4
> 
> - Rebased 2.6.25-mm1
> - Add a document
> - Add kdump on panic_notifier
> 
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by control files.
> 
> And, third patch moves crash_kexec() to panic_notifier. It helps us to do
> something before taking a crash dump. It's useful for some RAS tools developer.

Hi Takenori,

What's the "something" which you want to do after panic and before kdump.
Can you please give a concrete example. We have talked about this quite
a few times but nothing concrete has come out so far, except a generic
statement that it helps "RAS tool developers".

The only thing we could think of was debuggers (kdb and kgdb) and one easy
solution is that debuggers/users can put a break point at panic() instead
of introducing this infrastructure.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
