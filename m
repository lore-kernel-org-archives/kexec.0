Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhqrf-0000hL-Ve
 for kexec@lists.infradead.org; Tue, 24 Jul 2018 06:32:09 +0000
Date: Tue, 24 Jul 2018 08:31:54 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/2] Add capability to dump fdt blob for arm64 platforms
Message-ID: <20180724063110.lclgpne27o5xbws3@verge.net.au>
References: <1529576678-14615-1-git-send-email-bhsharma@redhat.com>
 <20180709071107.GT28220@linaro.org>
 <d2102b2d-b3bb-4d5d-19d9-51a7f3eed7a7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2102b2d-b3bb-4d5d-19d9-51a7f3eed7a7@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, dyoung@redhat.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, james.morse@arm.com

On Tue, Jul 17, 2018 at 02:13:42AM +0530, Bhupesh Sharma wrote:
> Hi Akashi,
> 
> On 07/09/2018 12:41 PM, AKASHI Takahiro wrote:
> > Bhupesh, Simon,
> > 
> > #I'm afraid that I gonna rehash the old discussion.
> > 
> > Looking into ppc's kexec-tools code, I found that ppc version of
> > this tool has a similar feature and it saves a new dtb into a file,
> > named "debug.dtb."
> > See save_fixed_up_dtb() in kexec/arch/ppc/fixup_dtb.c
> > 
> > Even if it is a debug feature, we'd better go in the same way
> > (if possible).
> 
> Thanks for sharing the same.
> 
> I had a look earlier also at the ppc - "debug.dtb" code in kexec-tools, but
> this is again fails to fulfill the same purpose that we are trying to
> resolve for early primary kernel crash(es) on arm64 machines, because of
> which we are not able to reach the command prompt with the primary kernel
> itself.
> 
> We would need to either reach the command prompt to dump out/save the
> "debug.dtb" file when we are running the primary kernel (which is
> unfortunately not always possible wit latest kernels on some of the arm64
> machines), or use some initramfs scriptware to dump out the same to some
> secondary storage device (nfs server or usb stick).
> 
> So, I would still suggest to stick with the approach I proposed for now (and
> we can take a similar approach as ppc for arm64 later on) once we have
> kexec, kdump and other user-space utilities (which rely on the kexec kernel
> framework) working stably on arm64 machines (with latest upstream kernels).

That sounds like a reasonable argument to me.

Akashi, what do you think?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
