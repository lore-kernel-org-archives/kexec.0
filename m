Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0Eo-0000EG-Az
 for kexec@lists.infradead.org; Fri, 25 Jan 2019 12:05:35 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so4489170plr.4
 for <kexec@lists.infradead.org>; Fri, 25 Jan 2019 04:05:33 -0800 (PST)
Date: Fri, 25 Jan 2019 15:05:27 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RESEND 0/3] Add restrictions for kexec/kdump jumping
 between 5-level and 4-level kernel
Message-ID: <20190125120527.3n6pqt5zzvczkct6@kshutemo-mobl1>
References: <20190125022817.29506-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125022817.29506-1-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Fri, Jan 25, 2019 at 10:28:14AM +0800, Baoquan He wrote:
> This is a RESEND post.
> 
> The original v1 post can be found here:
> http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com
> 
> It's trying to fix several corner case issues for kexec/kdump when
> dynamic switching of paging mode is enabled in x86_64. Please click 
> above link to check the details.
> 
> In v1, hpa raised concern that why the paging mode checking is not done
> before kexec jumping, the discussion can be found here:
> 
> http://lkml.kernel.org/r/alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de
> 
> As tglx said, it might be not doable for kdump since kdump kernel's
> reserved crashkernel region only owns a portion of memory, may
> be above 4G; and might be not safer to do paging mode checking and
> switching thing after crash.
> 
> So resend this patchset.

Changes look good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
