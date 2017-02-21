Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cgEEF-0000cP-5s
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 17:27:58 +0000
Date: Tue, 21 Feb 2017 18:27:03 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170221172703.sy7d2mexo4naxj52@pd.tnic>
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
 <58AC3481.80000@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58AC3481.80000@redhat.com>
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
To: xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Tue, Feb 21, 2017 at 08:37:21PM +0800, Xunlei Pang wrote:
> -    /* If this CPU is offline, just bail out. */
> -    if (cpu_is_offline(smp_processor_id())) {
> +    /*
> +     * Cases to bail out to avoid rendezvous process timeout:
> +     * 1)If crashing_cpu was set, e.g. entering kdump,
> +     *   we need to skip cpus remaining in 1st kernel.
> +     * 2)If this CPU is offline.
> +     */
> +    if (crashing_cpu != -1 ||
> +        cpu_is_offline(smp_processor_id())) {

You're still not letting the crashing_cpu enter the #MC handler. You
need to handle the MCE no matter how short the window is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
