Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBLyf-000533-Aw
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 07:33:18 +0000
Date: Wed, 5 Oct 2011 09:33:13 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005073313.GB13478@liondog.tnic>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005071844.GB2235@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 12:48:44PM +0530, K.Prasad wrote:
> On Tue, Oct 04, 2011 at 10:04:37AM -0400, Vivek Goyal wrote:
> > On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> > > There are certain types of crashes induced by faulty hardware in which
> > > capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> > > dangerous).
> > > 
> > > A case in point, is unrecoverable memory errors (resulting in fatal machine
> > > check exceptions) in which reading from the faulty memory location from the
> > > kexec'ed kernel will cause double fault and system reset (leaving no
> > > information for the user).
> > 
> > Prasad,
> > 
> > I am just trying to remember what was wrong with Andi's approach of
> > disable MCE while copying the dump?
> >
> 
> Hi Vivek,
> 	The behaviour upon a read operation on an UC memory location is
> undefined and so we want to avoid it (previously discussed here:
> http://article.gmane.org/gmane.linux.kernel/1146799). When we disable
> MCE and copy the dump, we will invariably read the faulty memory
> location.

Right, from the message above:

"- To disable MCE exceptions as done by the patches cited above. However
  the result of a read operation on corrupted memory is unknown and the
  system behaviour is undefined. We're unsure if this is a safe thing to
  do."

Can you elaborate more on that? Are we talking poisoned memory here or
undetected and uncorrectable memory errors?

Thanks.

-- 
Regards/Gruss,
    Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
