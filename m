Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgbzq-0007xv-ER
 for kexec@lists.infradead.org; Wed, 22 Feb 2017 18:50:39 +0000
Date: Wed, 22 Feb 2017 10:50:16 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v3] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170222185015.GA6141@intel.com>
References: <1487736674-2058-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487736674-2058-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Wed, Feb 22, 2017 at 12:11:14PM +0800, Xunlei Pang wrote:
> +	/*
> +	 * Cases to bail out to avoid rendezvous process timeout:
> +	 * 1)If this CPU is offline.
> +	 * 2)If crashing_cpu was set, e.g. entering kdump,
> +	 *   we need to skip cpus remaining in 1st kernel.
> +	 */
> +	if (cpu_is_offline(cpu) ||
> +	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
>  		u64 mcgstatus;
>  
>  		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);


I think we should document the remaining race conditions. I don't
think there is any good way to eliminate them, and they are already
pretty small windows.

I think the sequence of events looks like:

     1	Panic occurs
     2	nmi_shootdown_cpus() sets crashing_cpu
     3	send NMI to everyone else
     4	wait up to a second for other CPUs to take NMI
     5	go to kexec code
     6	start new kernel
     7	new kernel establishes #MC handler

If one of the other cpus triggers a machine check while
getting to, or in, the NMI handler ... then that cpu will
skip processing (if RIPV is set).

Between '2' and '5' if crashing_cpu gets a machine check it
will execute in the old kernel handler, and do the right thing.

There's a fuzzy area between '6' and '7' where a machine check
might not end up in the right code.

From '7' onwards the kexec kernel will handle and machine
checks caused by kdump.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
