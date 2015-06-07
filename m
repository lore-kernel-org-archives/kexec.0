Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z1bjC-0005N3-EP
 for kexec@lists.infradead.org; Sun, 07 Jun 2015 14:39:11 +0000
Date: Sun, 7 Jun 2015 16:38:39 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/3 v3] Fix kdump failures with crashkernel=high
Message-ID: <20150607143839.GC30691@pd.tnic>
References: <1433500202-25531-1-git-send-email-joro@8bytes.org>
 <20150605132736.GF3679@pd.tnic> <20150607134136.GA27512@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150607134136.GA27512@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: jroedel@suse.de, Baoquan He <bhe@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Jun 07, 2015 at 03:41:36PM +0200, Ingo Molnar wrote:
> Modulo a couple of typos it all looks sane.

Ah yes, I caught a few while applying. I'll send you the final result
tomorrow.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
