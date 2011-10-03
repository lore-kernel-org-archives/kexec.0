Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RAfU7-0003sB-V1
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 10:11:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
Date: Mon, 03 Oct 2011 03:10:43 -0700
In-Reply-To: <20111003073203.GA22694@in.ibm.com> (K. Prasad's message of "Mon, 
	3 Oct 2011 13:02:03 +0530")
Message-ID: <m162k64c7w.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
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
To: prasad@linux.vnet.ibm.com
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> There are certain types of crashes induced by faulty hardware in which
> capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> dangerous).
>
> A case in point, is unrecoverable memory errors (resulting in fatal machine
> check exceptions) in which reading from the faulty memory location from the
> kexec'ed kernel will cause double fault and system reset (leaving no
> information for the user).

It does make plenty of sense, and I capture the all of the time.
It totally doesn't make sense to do this in the kernel when we can
filter this from userspace just fine.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I thought we already had this discussion.  Why is this silliness coming
back?

I especially dislike the notion of hardcoding policy in the kernel like this.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
