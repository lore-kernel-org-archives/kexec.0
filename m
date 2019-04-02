Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBIlP-0000lC-KF
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 12:43:41 +0000
Date: Tue, 2 Apr 2019 14:43:28 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190402124328.GG6826@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Tue, Apr 02, 2019 at 08:02:04PM +0800, lijiang wrote:
> These regions(E820_TYPE_{RESERVED_KERN,RAM,UNUSABLE}) are still marked as
> IORES_DESC_NONE and should not be mapped encrypted when using ioremap().

Seems to me like we're going in circles. You said here:

https://lkml.kernel.org/r/9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com

that the kernel doesn't pass the e820 reserved ranges to the second
kernel.

I suggested to use a special IORES descriptor for them -
IORES_DES_RESERVED.

Now you say that that is not enough and some of those you want passed,
are still marked as IORES_DESC_NONE.

Sounds to me like you need try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
