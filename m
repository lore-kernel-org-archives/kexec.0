Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1Xx-00061T-1c
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:14:05 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
Date: Fri, 27 May 2011 11:14:00 -0700
In-Reply-To: <20110526172305.GA18295@in.ibm.com> (K. Prasad's message of "Thu, 
	26 May 2011 22:53:05 +0530")
Message-ID: <m1fwo08107.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
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
To: prasad@linux.vnet.ibm.com
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> slimdump: Capture slimdump for fatal MCE generated crashes
>
> System crashes resulting from fatal hardware errors (such as MCE) don't need
> all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
> retains only essential information while discarding the old memory.

Ugh.  You are changing the kernel to change userspace policy?

And because of how you have previous populated this we won't get the
notes to let us extract dmesg easily.

No thanks.  Let's change this in userspace instead.

You are going to an awful lot of work to avoid a problem that doesn't
happen to in practice.

Patching makedumpfile to key in on an mce note would be more appropriate.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
