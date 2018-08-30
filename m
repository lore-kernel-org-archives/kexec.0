Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fvNLb-00015F-F6
 for kexec@lists.infradead.org; Thu, 30 Aug 2018 13:50:56 +0000
Received: by mail-pf1-x444.google.com with SMTP id i26-v6so3898839pfo.12
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2018 06:50:44 -0700 (PDT)
Date: Thu, 30 Aug 2018 16:50:37 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel
 reservation
Message-ID: <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180829141624.13985-4-bhe@redhat.com>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Wed, Aug 29, 2018 at 10:16:24PM +0800, Baoquan He wrote:
> Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
> jumping may be from 5-level to 4-level, and the kdump kernel is put
> above 64TB in 5-level kernel, then the jumping will fail. And the
> crashkernel reservation is done during the 1st kernel bootup, there's
> no way to detect the paging mode of kdump kernel at that time.
> 
> Hence change the upper limmit of crashkernel reservation to 64TB

s/limmit/limit/

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
