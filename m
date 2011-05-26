Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPfyC-00064h-Vs
	for kexec@lists.infradead.org; Thu, 26 May 2011 19:11:57 +0000
Date: Thu, 26 May 2011 15:10:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110526191008.GF29496@redhat.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
	<20110526174447.GC29496@redhat.com>
	<20110526180931.GF4065@one.firstfloor.org>
	<20110526182618.GD29496@redhat.com>
	<20110526185838.GG4065@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526185838.GG4065@one.firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>

On Thu, May 26, 2011 at 08:58:38PM +0200, Andi Kleen wrote:
> > If we are just extracting and saving MCE registers from vmcore, then
> > reboot time does not increase. It increases only if user decides to
> > extract and save extra data from vmcore.
> 
> Hmm I was thinking of user space usually saving the dump first
> before analyzing it. But yes it could probably do some minimal
> analysis first.

In RHEL, now we filter out the dump by default until and unless user
decides to no filter the dump with the help of config options. 

So I think in this case we can just introduce an extra filtering
option in "makedumpfile" and ask it to save only MCE registers
if it notices that there is NT_MCE type of ELF note in vmcore.

I can very well imaging that extracting dmesg along with MCE registers
can be useful. If nothing else, it can give us useful information about
the system configuration.

Zeroing out all the other ELF headers in vmcore takes away the
capability to extract log buffers in case of MCE and I think
it probably is not the best idea.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
