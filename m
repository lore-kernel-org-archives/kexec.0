Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBTs3-0002Bf-9Y
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 15:58:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Wed, 5 Oct 2011 08:58:53 -0700
Subject: RE: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <987664A83D2D224EAE907B061CE93D5301EE62D58D@orsmsx505.amr.corp.intel.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com> <20111004143012.GB28306@redhat.com>
	<20111005074116.GC2235@in.ibm.com> <20111005154011.GD30146@redhat.com>
In-Reply-To: <20111005154011.GD30146@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, Andi Kleen <andi@firstfloor.org>, "anderson@redhat.com" <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, "crash-utility@redhat.com" <crash-utility@redhat.com>

> > The plan is to pass-down the list of poisoned memory pages to the second
> > kernel using an elf-note so that these pages are left untouched during
> > dump capture. I'm working on an implementation of the same and should
> > have patches soon.
>
> I would say let us first figure out what happens while reading a poisoned
> page and is this a problem before working on a solution.

If the page is poisoned because of a real uncorrectable error in memory
(reported as SRAO machine check today, or by SRAR real-soon-now). Then
accessing the page from the processor while taking a memory dump will
result in a machine check.

Note that a large memory system that had been running for a long time
may have built up a small stash of these land-mine pages - and we need
to worry about them even in the case where the panic is not machine
check related (in fact especially in this case ... we are in a case
where we actually do want the dump to diagnose the cause of the panic,
and we don't want to risk losing the crash dump because we aborted when
touching a page that the OS had safely avoided for days/weeks/months).

So passing a list of poisoned pages from the old kernel to the new kernel
is a good idea - and is independent of the cause of the crash (except that
in the fatal machine check case due to memory error the list is guaranteed
to be non-empty).

Passing some crash signature data - so the new kernel/dump-tools can make
a choice whether to even try to take a full dump is also interesting (but
independent from the bad page list).

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
