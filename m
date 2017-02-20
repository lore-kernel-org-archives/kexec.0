Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cfuYh-0005Sw-MK
 for kexec@lists.infradead.org; Mon, 20 Feb 2017 20:27:50 +0000
Date: Mon, 20 Feb 2017 21:26:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170220202654.kakjxgmxrlhak6q3@pd.tnic>
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
 <58AAEF34.9000303@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58AAEF34.9000303@redhat.com>
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

On Mon, Feb 20, 2017 at 09:29:24PM +0800, Xunlei Pang wrote:
> There is a small window between crash and kdump kernel boot, so
> if a SRAO comes within this window it will also cause the mce
> synchronization problem on the crashing cpu if we don't bail out the
> crashing cpu.

You mean, in the window between, kdump kernel starts writing out memory
and the second, kexec-ed kernel?

If so, please add that information to the place in do_machine_check()
where we check crashing_cpu so that we know why we're doing this
temporary ignore of #MC.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
