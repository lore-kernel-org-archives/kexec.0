Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok2p6-00008k-6Y
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 22:34:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Fri, 13 Aug 2010 15:33:56 -0700
Subject: RE: [PATCH][EFI] Run EFI in physical mode
Message-ID: <987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<4C65C630.4070008@zytor.com>
In-Reply-To: <4C65C630.4070008@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>, Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

> does this affect ia64 in any way?

I remember Eric complaining that set_virtual_address_map() was a one
way trap door with no way to get back to physical mode ... and thus
this was a big problem to support kexec on ia64. And yet we still call
it, and ia64 can do kexec. So some other work around must have been
found. Can't immediately remember what it was though.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
