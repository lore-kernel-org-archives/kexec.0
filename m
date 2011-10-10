Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RD9xT-0000Md-2W
	for kexec@lists.infradead.org; Mon, 10 Oct 2011 07:07:31 +0000
Date: Mon, 10 Oct 2011 09:07:25 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111010070725.GB11577@liondog.tnic>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111007161218.GA2297@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Fri, Oct 07, 2011 at 09:42:19PM +0530, K.Prasad wrote:
> The problem, as pointed out by Borislav Petkov in a different mail, is that
> we might end up capturing a vmcore containing corrupted data when the
> same is not required for analysing the cause of the crash.
> 
> Of course, all this is assuming that reading the faulty memory with MCE
> disabled is harmless. However, the effect of a read operation in this
> case is undefined.

Frankly, I don't think that it is undefined - you basically should be
able to read DRAM albeit with the corrupted data in it. However, you
probably best disable the whole DRAM error detection first by clearing
a couple of bits in MC4_CTL_MASK (at least on AMD that should work, I
dunno how Intel does that).

But, regardless, according to Vivek, the "makedumpfile" tool should be
able to jump over poisoned pages and you don't need all the hoopla above
at all, right?

Thanks.

-- 
Regards/Gruss,
    Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
