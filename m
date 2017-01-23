Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([78.46.96.112])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cVj9x-0003Xt-Fn
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 18:16:07 +0000
Date: Mon, 23 Jan 2017 19:14:37 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123181437.xbjbsdjfcn7b67dh@pd.tnic>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <20170123174008.GA4945@intel.com>
 <20170123175130.l7c7mnmu74ln5v6h@pd.tnic>
 <20170123180153.GA5646@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170123180153.GA5646@intel.com>
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
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, xlpang@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Mon, Jan 23, 2017 at 10:01:53AM -0800, Luck, Tony wrote:
> will ignore the machine check on the other cpus ... assuming
> that "cpu_is_offline(smp_processor_id())" does the right thing
> in the kexec case where this is an "old" cpu that isn't online
> in the new kernel.

Nice. And kdump did do the dumping on one CPU, AFAIR. So we should be
good there.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
