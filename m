Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDmYw-0000hV-Uh
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 00:20:47 +0000
Date: Wed, 12 Oct 2011 02:20:32 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111012002032.GF14482@one.firstfloor.org>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
	<20111011184434.GB32316@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111011184434.GB32316@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, Nick Bowler <nbowler@elliptictech.com>, "Luck,
	Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

> So, in any case we may not be able to disable machine-check exceptions
> (MCEs) only within the context of kexec'ed kernel. Let me know if I've
> missed something here.

You can disable signalling in the main machine check register,
then you won't get any machine check interrupts. No need to mess
with any CPU specific banks.

See the old mce tree that kernel.org ate for a patch that just did that
during the kcore copy.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
