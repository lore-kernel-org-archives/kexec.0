Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZbE-0004Oq-DG
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:07:36 +0000
Date: Thu, 21 Nov 2013 11:07:10 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/6] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20131121190710.GD17070@kroah.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-6-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384969851-7251-6-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Wed, Nov 20, 2013 at 12:50:50PM -0500, Vivek Goyal wrote:
> This is loader specific code which can load bzImage and set it up for
> 64bit entry. This does not take care of 32bit entry or real mode entry
> yet.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  arch/x86/include/asm/kexec-bzimage.h |   12 +
>  arch/x86/include/asm/kexec.h         |   26 +++
>  arch/x86/kernel/Makefile             |    2 +
>  arch/x86/kernel/kexec-bzimage.c      |  375 ++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/machine_kexec_64.c   |    4 +-
>  arch/x86/kernel/purgatory_entry_64.S |  119 +++++++++++
>  6 files changed, 537 insertions(+), 1 deletions(-)
>  create mode 100644 arch/x86/include/asm/kexec-bzimage.h
>  create mode 100644 arch/x86/kernel/kexec-bzimage.c
>  create mode 100644 arch/x86/kernel/purgatory_entry_64.S

Wow, that's surprisingly small, nice job.

What do you mean by the "real mode entry"?  Do we need to care about
that because we aren't falling back to real mode when executing this,
are we?  Or does that just happen for 32bit kernels?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
