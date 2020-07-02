Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqxsB-0001do-Cl
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 11:59:24 +0000
Date: Thu, 2 Jul 2020 19:59:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
Message-ID: <20200702115907.GC21026@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
 <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
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
To: piliu <piliu@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

> > I'm confused about the "overlap with crashkernel memory", does that mean
> > those normal kernel used memory could be put in crashkernel reserved
> > memory range?  If so why can't just skip those areas while crashkernel
> > doing the reservation?
> I raised the same question in another mail. As Hari's answer, "kexec -p"
> skips these ranges in user space. And the same logic should be done in
> "kexec -s -p"

See it, thanks!  The confusion also applied to the userspace
implementation though.  Seems they have to be special cases because of 
the powerpc crashkernel reservation implemtation in kernel limitation

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
