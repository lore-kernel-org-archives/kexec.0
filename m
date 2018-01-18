Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebzMJ-0001EU-Nk
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 01:51:17 +0000
Date: Thu, 18 Jan 2018 09:50:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
Message-ID: <20180118015052.GB1812@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <7d75928d-1aeb-90d6-7053-e26420b11628@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d75928d-1aeb-90d6-7053-e26420b11628@amd.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, bhe@redhat.com, kexec@lists.infradead.org, mingo@kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, torvalds@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 01/17/18 at 09:06am, Tom Lendacky wrote:
> On 1/17/2018 1:22 AM, Dave Young wrote:
> > [Modify the subject since this is a new problem, original io vector
> > issue has been fixed with one commit from Thomas]
> > 
> > Add more cc according to below old discussion:
> > https://lkml.org/lkml/2017/7/27/574
> > 
> > Tom, I'm not sure why you finally did not dynamically run wbinvd?
> 
> That discussion was aimed at the wbinvd that was being performed
> in arch/x86/kernel/relocate_kernel_64.S, which is dynamically
> run based on a flag.

Oh, I did not notice that, sorry for referring a wrong discussion.

[snip]

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
