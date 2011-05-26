Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPfmD-0006KM-Kq
	for kexec@lists.infradead.org; Thu, 26 May 2011 18:59:23 +0000
Date: Thu, 26 May 2011 20:58:38 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110526185838.GG4065@one.firstfloor.org>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
	<20110526174447.GC29496@redhat.com>
	<20110526180931.GF4065@one.firstfloor.org>
	<20110526182618.GD29496@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526182618.GD29496@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>

> If we are just extracting and saving MCE registers from vmcore, then
> reboot time does not increase. It increases only if user decides to
> extract and save extra data from vmcore.

Hmm I was thinking of user space usually saving the dump first
before analyzing it. But yes it could probably do some minimal
analysis first.

I guess most user spaces just won't change and will just continue
to DTWT though.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
