Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QHiHe-0006eI-TJ
	for kexec@lists.infradead.org; Wed, 04 May 2011 20:02:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Wed, 4 May 2011 13:02:25 -0700
Subject: RE: [RFC] Kdump and memory error handling
Message-ID: <987664A83D2D224EAE907B061CE93D5301C53C9966@orsmsx505.amr.corp.intel.com>
References: <20110504193509.GA5342@in.ibm.com>
In-Reply-To: <20110504193509.GA5342@in.ibm.com>
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
To: "prasad@linux.vnet.ibm.com" <prasad@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andi Kleen <andi@firstfloor.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Your first suggestion of a "slim" dump makes the most sense. The
purpose of a crash dump is a research resource to find out why
the system crashed - but in the case of a machine check, we already
have the reasons for the crash captured by the machine check handler.

Perhaps you could include __log_buf[] in the slim crash dump? Assuming
that the machine check is not a result of an uncorrectable error
in this memory range.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
