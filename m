Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X0H7C-0003si-0k
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 21:21:55 +0000
Date: Thu, 26 Jun 2014 23:21:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 00/15][V4] kexec: A new system call to allow in kernel
 loading
Message-ID: <20140626212122.GD1284@pd.tnic>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <20140626135811.37c10ff327bea8a9d2e3894e@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140626135811.37c10ff327bea8a9d2e3894e@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com, hpa@zytor.com
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, chaowang@redhat.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Thu, Jun 26, 2014 at 01:58:11PM -0700, Andrew Morton wrote:
> Well, this is an absolute ton of new code, much of it pretty complex.
> And I believe the entire point of this work is to enable image
> signature checking, but that hasn't been implemented yet?
>
> In which case I'm thinking it would be unwise to merge these parts
> into mainline - if signature checking doesn't work or fails review or
> if you get hit by a bus then we'd be left with a large lump of rather
> useless code?
>
> In which case I'm inclined to put this series into -next and keep it
> there pending completion of the signature checking part.

Before we rush these in, it'd be nice if someone more experienced would
take a look at the general approach of the whole handling with the
purgatory and such. I certainly tried to give my best while reviewing
but I'm too inexperienced in kexec and the whole booting of another
kernel and all the intricacies of the process. It'll be optimal if Eric
Biederman would find some free time for those.

AFAIK, hpa wanted to take a look too so can we please slow down a bit
here first?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
