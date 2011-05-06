Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QIOyz-0001mF-Es
	for kexec@lists.infradead.org; Fri, 06 May 2011 17:38:30 +0000
Date: Fri, 6 May 2011 19:38:25 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Message-ID: <20110506173825.GK11636@one.firstfloor.org>
References: <20110506165412.GB2719@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110506165412.GB2719@in.ibm.com>
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
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, Vivek Goyal <vgoyal@redhat.com>

> Has anybody tested this before? Or have found kdump working when fatal
> MCEs have actually occurred?

Ying did some testing. mce-test has test cases for kdump.

My guess is you injected the error into some area used by the kexec
code or boot up path of the kexec kernel.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
