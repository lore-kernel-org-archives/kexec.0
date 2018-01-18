Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec0Rp-0006iB-BK
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 03:01:02 +0000
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
 <20180118014705.GA1812@dhcp-128-65.nay.redhat.com>
 <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
From: Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <2f4f1e37-2be0-4609-0e7b-33d67815bd30@linux.intel.com>
Date: Wed, 17 Jan 2018 19:00:47 -0800
MIME-Version: 1.0
In-Reply-To: <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Young <dyoung@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

> Does anybody have any other ideas?

the only other weird case that comes to mind; what happens if there's a line dirty in the caches,
but the memory is now mapped uncached. (Which could happen if kexec does muck with  MTRRs, CR0 or other similar
things in weird ways)... not sure what happens in CPU, a machine check for cache inclusion violations
is not beyond the imagination and might be lethal

this would explain a kexec specific angle versus general normal (but rare) use of wbinvd.


other weird case could be cached mmio (not common, but some gpus and the like can do it)
with iommu/VT-D in the middle, and during kexec VT-D shutting
down the iommu before the wbinvd. This would be... highly odd... but this report already is in highly odd space.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
