Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WzVNe-0005SI-Oy
 for kexec@lists.infradead.org; Tue, 24 Jun 2014 18:23:44 +0000
Date: Tue, 24 Jun 2014 20:23:14 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 11/13] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140624182314.GA15068@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-12-git-send-email-vgoyal@redhat.com>
 <20140615163515.GA17016@pd.tnic>
 <20140624173125.GA18045@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140624173125.GA18045@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, gong.chen@linux.intel.com, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Tue, Jun 24, 2014 at 01:31:25PM -0400, Vivek Goyal wrote:
> I think problem is that we shift 1 by 32 bits in this case (31 - 0 +
> 1) and that overflows the size of unsigned. So there is this corner
> case where it does not seem to work (or atleast outputs warning).

Right, that is a corner case which overflows the shift. The only thing I
can think of right now is:

#define GENMASK(h, l)           ((u32)GENMASK_ULL(h, l))

u32 because we're implicitly assuming we're dealing with 32-bit unsigned
quantities.

There might be a better solution though...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
