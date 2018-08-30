Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fvNi0-0002Nn-A4
 for kexec@lists.infradead.org; Thu, 30 Aug 2018 14:14:05 +0000
Date: Thu, 30 Aug 2018 22:13:49 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel
 reservation
Message-ID: <20180830141349.GB14702@192.168.1.2>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-4-bhe@redhat.com>
 <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On 08/30/18 at 04:50pm, Kirill A. Shutemov wrote:
> On Wed, Aug 29, 2018 at 10:16:24PM +0800, Baoquan He wrote:
> > Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
> > jumping may be from 5-level to 4-level, and the kdump kernel is put
> > above 64TB in 5-level kernel, then the jumping will fail. And the
> > crashkernel reservation is done during the 1st kernel bootup, there's
> > no way to detect the paging mode of kdump kernel at that time.
> > 
> > Hence change the upper limmit of crashkernel reservation to 64TB
> 
> s/limmit/limit/

Thanks, will change.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
