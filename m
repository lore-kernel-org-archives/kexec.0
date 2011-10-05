Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBTGJ-0001mz-7N
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 15:19:59 +0000
Date: Wed, 5 Oct 2011 11:19:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005151936.GA30146@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005070728.GA2235@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 12:37:28PM +0530, K.Prasad wrote:

[..]
> > Well, there are MCE types for which we need to panic but we don't
> > necessarily corrupt memory. Your approach is to unconditionally avoid
> > dumping core whenever we panic while you should look at the MCE
> > signature and decide then whether to capture crashed kernel memory or
> > not.
> > 
> > For example, if the MCE signature says UC DRAM error, then you can
> > be pretty sure that there is a landmine somewhere in the DRAM region
> > mapping the crashed kernel. If it is, say, a UC when doing data fills
> > from L2 to L1, that doesn't necessarily mean that DRAM is corrupted. But
> > even in the first case, you can evaluate the MCi_ADDR reported with the
> > UC DRAM error and simply skip that particular cacheline when dumping the
> > core instead of not capturing anything at all.
> > 
> 
> True. Like stated by me earlier, there could be two possible outcomes
> from capturing memory dump in such cases - they're either dangerous or
> doesn't make sense. It is best to avoid a normal kdump in both cases,
> although the elf-note doesn't distinguish between the two.

So what are your objectives here. If panic happened due to an MCE don't
capture a dump? If we try to capture the dump and lets say we run into
issues, anyway we will reboot and not capture the dump. 

So only thing you want to achieve with this patch is that you want
to give an explicit message that panic happened due to MCE hence we
did not capture the dump?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
