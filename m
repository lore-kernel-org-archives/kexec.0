Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBVVj-0004ff-1k
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 17:44:04 +0000
Date: Wed, 5 Oct 2011 19:43:58 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005174358.GE18592@gere.osrc.amd.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004143012.GB28306@redhat.com>
	<20111005074116.GC2235@in.ibm.com>
	<20111005154011.GD30146@redhat.com>
	<987664A83D2D224EAE907B061CE93D5301EE62D58D@orsmsx505.amr.corp.intel.com>
	<20111005171007.GF30146@redhat.com>
	<20111005172036.GD18592@gere.osrc.amd.com>
	<20111005172912.GI30146@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005172912.GI30146@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "Luck,
	Tony" <tony.luck@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, Andi Kleen <andi@firstfloor.org>, "anderson@redhat.com" <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

On Wed, Oct 05, 2011 at 01:29:12PM -0400, Vivek Goyal wrote:
> As long as you can get to your struct page arrays, one should be able
> to filter out poisoned pages without saving the whole dump.

Ok, this sounds good.

So, maybe the tool should be taught to always skip poisoned pages due to
danger of follow-up MCEs and, when kexec has rebooted due to an MCE, to
warn before doing a vmcore dump that the dump might not contain useful
information or that the dumping itself could result in further MCEs and
whether the user still wants to proceed.

Or something to that effect.

Thanks.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
