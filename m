Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eP9NT-0001UC-DY
 for kexec@lists.infradead.org; Wed, 13 Dec 2017 15:55:25 +0000
Date: Wed, 13 Dec 2017 23:57:46 +0800
From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: Regression: kexec/kdump boot hangs with x86/vector commits
Message-ID: <20171213155746.GA29572@yu-chen.sh.intel.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, kexec@lists.infradead.org, mingo@kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Wed, Dec 13, 2017 at 10:52:56AM +0800, Dave Young wrote:
> Hi,
> 
> Kexec reboot and kdump has broken on my laptop for long time with
> 4.15.0-rc1+ kernels. With the patch below an early panic been fixed:
> https://patchwork.kernel.org/patch/10084289/
> 
> But still can not get a successful reboot, it looked like graphic
> issue, but after bisecting the kernel, I got below:
> 
> [dyoung@dhcp-*-* linux]$ git bisect good
> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> 2db1f959d9dc16035f2eb44ed5fdb2789b754d6a
> 4900be83602b6be07366d3e69f756c1959f4169a
> We cannot bisect more!
> 
> These two commits can no be reverted because of code conflicts, thus
> I reverted the whole series from Thomas (below commits), with those
> x86/vector changes reverted, kexec reboot works fine.
> 
> Could you help to take a look, any thoughts?  I can do the test
> if you have some debug patch to try.
Is it possible that the "second" kernel runs on non-zero CPU? If yes,
what if some irqs are only delivered to cpu0? (use cpumask_of(0)
directly)

Thanks,
	Yu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
