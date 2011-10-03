Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RArNs-0007mO-BE
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 22:53:17 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Mon, 3 Oct 2011 15:53:09 -0700
Subject: RE: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <987664A83D2D224EAE907B061CE93D5301EE594D4C@orsmsx505.amr.corp.intel.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com> <m162k64c7w.fsf@fess.ebiederm.org>
In-Reply-To: <m162k64c7w.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, "prasad@linux.vnet.ibm.com" <prasad@linux.vnet.ibm.com>
Cc: "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, Andi Kleen <andi@firstfloor.org>, "anderson@redhat.com" <anderson@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

> It totally doesn't make sense to do this in the kernel when we can
> filter this from userspace just fine.

Patch 1 is the kernel part that provides the clue for user space
tools to do this filtering.  The other three parts are patches to
tools that see the hint and act on it.

Eric: Do you see a better way for the kernel that just crashed from
a machine check to communicate the reason for the crash to the
successor kernel?  The Elf-note in vmcore needs quite a bit of
code to set up - but is otherwise fairly succinct.  We don't want
the successor kernel to have to poke through too much memory from
the crashed kernel to figure this out - the more we look at, the
higher the probability that we step on the landmine that crashed
the original kernel.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
