Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec0Kq-0001AB-4o
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 02:53:50 +0000
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
Message-ID: <47fe0d37-93d9-1394-062a-f973a38daa16@linux.intel.com>
Date: Wed, 17 Jan 2018 18:53:34 -0800
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

> 
> Does anybody have any other ideas?

wbinvd is thankfully not common, but also not rare (MTRR setup and a bunch of other cases)
and in some other operating systems it happens even more than on Linux.. it's generally not totally broken like this.

I can only imagine a machine check case where a write back to a bad cell causes some parity error
or something...  but it's odd that no other machine checks are reported?
(can the user check for this please)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
