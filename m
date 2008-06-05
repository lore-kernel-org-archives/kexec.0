Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K4AeE-0002Ik-Dx
	for kexec@lists.infradead.org; Thu, 05 Jun 2008 08:16:38 +0000
Date: Thu, 5 Jun 2008 17:16:35 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kdump regression: /proc/vmcore is 0 after kdump
Message-ID: <20080605081633.GA6713@verge.net.au>
References: <3877989d0806050058u3159e7b5x3113f63b3e0f3d8f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3877989d0806050058u3159e7b5x3113f63b3e0f3d8f@mail.gmail.com>
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
To: Luming Yu <luming.yu@gmail.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, linux-ia64@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Roland McGrath <roland@redhat.com>

On Thu, Jun 05, 2008 at 03:58:40PM +0800, Luming Yu wrote:
> On Tue, Jun 3, 2008 at 2:02 PM, Luming Yu <luming.yu@gmail.com> wrote:
> >> I'm trying upstream kdump to get more detailed data for help analysis
> >> the scenario..
> > Upstream kdump doesn't work! don't know what cause the regression,
> > possibly kexec-tools...
> > Need investigation here!
> >
> 
> I tested mainline kernel from 2.6.20 to 2.6.26-rc4 on my tiger4..
> whatever I try, /proc/vmcore is always 0 !
> 
> Then I managed to get Nan hai's original patch against 2.6.19..
> http://marc.info/?l=linux-ia64&m=116521104831321&w=2
> This patch doesn't have zero-vmcore problem.
> 
> Given the age of the kdump feature and so many upstream releases since
> 2.6.20, I'm in doubt why I don't see this kind of bug report on ia64
> mailing list before?
> 
> PS. Now I can start to capture info for the strace problem with 2.6.19
> kernel +Nahai's 2.6.19 kdump patch, hope the problem is still
> reproducible.

Which version of kexec-tools are you using?
If you haven't done so already, could you try the latest version, 20080324.

http://www.eu.kernel.org/pub/linux/kernel/people/horms/kexec-tools/

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
