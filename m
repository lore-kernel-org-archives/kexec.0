Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cflrU-0003P1-GJ
 for kexec@lists.infradead.org; Mon, 20 Feb 2017 11:10:36 +0000
Date: Mon, 20 Feb 2017 12:09:41 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
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
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Mon, Feb 20, 2017 at 02:10:37PM +0800, Xunlei Pang wrote:
> @@ -1128,8 +1129,9 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  	 */
>  	int lmce = 1;
>  
> -	/* If this CPU is offline, just bail out. */
> -	if (cpu_is_offline(smp_processor_id())) {
> +	/* If nmi shootdown happened or this CPU is offline, just bail out. */
> +	if (cpus_shotdown() ||

I don't like "cpus_shotdown" - it doesn't hint at all that this is
special-handling crash/kdump.

And more importantly, I want it to be obvious that we do let the
crashing CPU into the MCE handler.

Why?

If we didn't, you will not handle *any* MCE, even a fatal one, during
dumping memory so if that dump is corrupted from the MCE, you won't
know. And I don't want to be the one staring at the corrupted dump and
wondering why I'm seeing what I'm seeing.

IOW, if we get a fatal MCE during dumping then we should go and die.
This is much better than silently corrupting the dump and not even
saying anything about it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
