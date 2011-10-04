Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RB5c7-0002vt-9n
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 14:04:56 +0000
Date: Tue, 4 Oct 2011 10:04:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111004140437.GA28306@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003073203.GA22694@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, crash-utility@redhat.com

On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> There are certain types of crashes induced by faulty hardware in which
> capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> dangerous).
> 
> A case in point, is unrecoverable memory errors (resulting in fatal machine
> check exceptions) in which reading from the faulty memory location from the
> kexec'ed kernel will cause double fault and system reset (leaving no
> information for the user).

Prasad,

I am just trying to remember what was wrong with Andi's approach of
disable MCE while copying the dump?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
