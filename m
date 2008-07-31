Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOa6O-00056T-ML
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 15:30:05 +0000
Date: Thu, 31 Jul 2008 17:29:26 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/5] x86: Define elfcorehdr_addr in arch dependent section
Message-ID: <20080731152926.GA20909@elte.hu>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
	<20080728211156.GB9985@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080728211156.GB9985@redhat.com>
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
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Terry Loftin <terry.loftin@hp.com>, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>


* Vivek Goyal <vgoyal@redhat.com> wrote:

> o Move elfcorehdr_addr definition in arch dependent crash dump file. This is
>   equivalent to defining elfcorehdr_addr under CONFIG_CRASH_DUMP instead of
>   CONFIG_PROC_VMCORE. This is needed by is_kdump_kernel() which can be
>   used irrespective of the fact whether CONFIG_PROC_VMCORE is enabled or
>   not.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
> 
>  arch/x86/kernel/crash_dump_32.c |    3 +++
>  arch/x86/kernel/crash_dump_64.c |    3 +++
>  arch/x86/kernel/setup.c         |    8 +++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)

the x86 bits look fine to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
