Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RDhTr-0006Hv-Pw
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 18:55:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Tue, 11 Oct 2011 11:55:05 -0700
Subject: RE: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <987664A83D2D224EAE907B061CE93D5301EE794AE3@orsmsx505.amr.corp.intel.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com> <20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com> <20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
In-Reply-To: <20111010070725.GB11577@liondog.tnic>
Content-Language: en-US
MIME-Version: 1.0
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
To: Borislav Petkov <bp@alien8.de>, "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, Andi Kleen <andi@firstfloor.org>, "anderson@redhat.com" <anderson@redhat.com>, "Eric W.
	Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

> Frankly, I don't think that it is undefined - you basically should be
> able to read DRAM albeit with the corrupted data in it. However, you
> probably best disable the whole DRAM error detection first by clearing
> a couple of bits in MC4_CTL_MASK (at least on AMD that should work, I
> dunno how Intel does that).

Intel is the same - disable machine check in CR4, and you can read
corrupted memory (multi-bit ECC error) without getting a machine check
(or any indication that you just got garbage).

Pages that were marked as poisoned can then be handled with appropriate
suspicion by your crash dump analysis tools.

Of course if there are any other memory errors that haven't been seen
yet - the pages won't be marked as poison - so the crash dump tool will
have no idea that it is looking at invalid data.  This could be a problem
if whatever caused the memory problem affected more than a single location.

So if you do disable machine check in order to get a crash dump - you should
be conservative and mark the whole file as "possibly garbage".

-Tony
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
