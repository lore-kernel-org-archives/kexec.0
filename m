Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X0Gkb-0001vG-W9
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 20:58:34 +0000
Date: Thu, 26 Jun 2014 13:58:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/15][V4] kexec: A new system call to allow in kernel
 loading
Message-Id: <20140626135811.37c10ff327bea8a9d2e3894e@linux-foundation.org>
In-Reply-To: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
Mime-Version: 1.0
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, chaowang@redhat.com

On Thu, 26 Jun 2014 16:33:29 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> This patch series does not do kernel signature verification yet. I plan
> to post another patch series for that. Now distributions are already signing
> PE/COFF bzImage with PKCS7 signature I plan to parse and verify those
> signatures.
> 
> Primary goal of this patchset is to prepare groundwork so that kernel
> image can be signed and signatures be verified during kexec load. This
> should help with two things.
> 
> - It should allow kexec/kdump on secureboot enabled machines.
> 
> - In general it can help even without secureboot. By being able to verify
>   kernel image signature in kexec, it should help with avoiding module
>   signing restrictions. Matthew Garret showed how to boot into a custom
>   kernel, modify first kernel's memory and then jump back to old kernel and
>   bypass any policy one wants to.
> 
> I hope these patches can be queued up for 3.17. Even without signature
> verification support, they provide new syscall functionality. But I
> wil leave it to maintainers to decide if they want signature verification
> support also be ready to merge before they merge this patchset.

Well, this is an absolute ton of new code, much of it pretty complex. 
And I believe the entire point of this work is to enable image
signature checking, but that hasn't been implemented yet?

In which case I'm thinking it would be unwise to merge these parts into
mainline - if signature checking doesn't work or fails review or if you
get hit by a bus then we'd be left with a large lump of rather useless
code?

In which case I'm inclined to put this series into -next and keep it
there pending completion of the signature checking part.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
