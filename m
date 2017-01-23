Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([78.46.96.112])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cVfyG-0006De-0H
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 14:51:49 +0000
Date: Mon, 23 Jan 2017 15:50:56 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <588606B9.3070604@redhat.com>
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

On Mon, Jan 23, 2017 at 09:35:53PM +0800, Xunlei Pang wrote:
> One possible timing sequence would be:
> 1st kernel running on multiple cpus panicked
> then the crash dump code starts
> the crash dump code stops the others cpus except the crashing one
> 2nd kernel boots up on the crash cpu with "nr_cpus=1"
> some broadcasted mce comes on some cpu amongst the other cpus(not the crashing cpu)

Where does this broadcasted MCE come from?

The crash dump code triggered it? Or it happened before the panic()?

Are you talking about an *actual* sequence which you're experiencing on
real hw or is this something hypothetical?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
