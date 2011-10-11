Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RDhYH-0006JR-Iu
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 18:59:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Tue, 11 Oct 2011 11:59:41 -0700
Subject: RE: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <987664A83D2D224EAE907B061CE93D5301EE794AEF@orsmsx505.amr.corp.intel.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com> <20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com> <20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
	<20111011184434.GB32316@in.ibm.com>
In-Reply-To: <20111011184434.GB32316@in.ibm.com>
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
To: "prasad@linux.vnet.ibm.com" <prasad@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "crash-utility@redhat.com" <crash-utility@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "anderson@redhat.com" <anderson@redhat.com>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Nick Bowler <nbowler@elliptictech.com>

> So, in any case we may not be able to disable machine-check exceptions
> (MCEs) only within the context of kexec'ed kernel. Let me know if I've
> missed something here.

Linux sets the CR4.MCE bit - look for "set_in_cr4(X86_CR4_MCE)" for places
where it does so.  You can ask it not to do that with "mce=off" argument.

So we can control this from the OS level.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
