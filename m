Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPfHH-0004xt-7x
	for kexec@lists.infradead.org; Thu, 26 May 2011 18:27:24 +0000
Date: Thu, 26 May 2011 14:26:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110526182618.GD29496@redhat.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
	<20110526174447.GC29496@redhat.com>
	<20110526180931.GF4065@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526180931.GF4065@one.firstfloor.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>

On Thu, May 26, 2011 at 08:09:31PM +0200, Andi Kleen wrote:
> On Thu, May 26, 2011 at 01:44:47PM -0400, Vivek Goyal wrote:
> > On Thu, May 26, 2011 at 10:53:05PM +0530, K.Prasad wrote:
> > > 
> > > slimdump: Capture slimdump for fatal MCE generated crashes
> > > 
> > > System crashes resulting from fatal hardware errors (such as MCE) don't need
> > > all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
> > > retains only essential information while discarding the old memory.
> > > 
> > 
> > Why to enforce zeroing out of rest of the vmcore data in kernel. Why not
> > leave it to user space. 
> 
> I think it's a good default to not do a full dump on MCE.
> It's very unlikely to be useful for anything, and will just waste
> reboot time (aka nines).

If we are just extracting and saving MCE registers from vmcore, then
reboot time does not increase. It increases only if user decides to
extract and save extra data from vmcore.

> 
> That said including the dmesg too may be a good idea.

dmesg is already part of vmcore and user space tools can easily find
it. 

I can easily imagine a default policy of a distro in user space where
in case of MCE crash, we just extract dmesg and MCE registers (from vmcore
notes section) reboot. This will be fast and will reduce the amount of code
in kernel.

IMHO, we should not introduce any additional notion of slimdump as such in
kernel. A better thing would be to just read MCE registers and export to
user space through ELF notes and then let user space automate the rest of
it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
