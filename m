Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([78.46.96.112])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cVe75-0008RX-Qd
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 12:52:50 +0000
Date: Mon, 23 Jan 2017 13:51:57 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
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

On Mon, Jan 23, 2017 at 04:01:51PM +0800, Xunlei Pang wrote:
> We met an issue for kdump: after kdump kernel boots up,
> and there comes a broadcasted mce in first kernel, the

How does that even happen?

Lemme try to understand this correctly: the first kernel gets an
MCE, kdump starts and boots a *whole* kernel and *then* you get the
broadcasted MCE? I have real hard time believing that.

What happened to the approach of clearing CR4.MCE before loading the
kdump kernel, in native_machine_shutdown() or wherever does the kdump
gets loaded...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
