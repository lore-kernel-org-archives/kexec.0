Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPeRG-0002uh-Fy
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:33:39 +0000
Date: Thu, 26 May 2011 19:32:57 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110526173257.GC4065@one.firstfloor.org>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526172305.GA18295@in.ibm.com>
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
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 26, 2011 at 10:53:05PM +0530, K.Prasad wrote:
> 
> slimdump: Capture slimdump for fatal MCE generated crashes
> 
> System crashes resulting from fatal hardware errors (such as MCE) don't need
> all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
> retains only essential information while discarding the old memory.

While this is a good idea, note there may be still poisoned lines
in memory that haven't resulted in a machine check yet, but could
still be fatal when read after a full crash dump for some other
reason.

So you still need 

http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commit;h=fe61906edce9e70d02481a77a617ba1397573dce
and
http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commit;h=cb58f049ae6709ddbab71be199390dc6852018cd

in addition.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
