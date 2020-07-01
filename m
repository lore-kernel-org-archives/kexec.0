Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqXSc-00013M-Fy
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 07:47:15 +0000
Date: Wed, 1 Jul 2020 15:46:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
Message-ID: <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
 <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

On 06/29/20 at 05:26pm, Hari Bathini wrote:
> Hi Petr,
> 
> On 29/06/20 5:09 pm, Petr Tesarik wrote:
> > Hi Hari,
> > 
> > is there any good reason to add two more functions with a very similar
> > name to an existing function? AFAICS all you need is a way to call a
> > PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> > you could add something like this:
> > 
> > int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > {
> > 	return 0;
> > }
> > 
> > Call this function from kexec_add_buffer where appropriate and then
> > override it for PPC64 (it roughly corresponds to your
> > kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> > 
> > FWIW it would make it easier for me to follow the resulting code.
> 
> Right, Petr.
> 
> I was trying out a few things before I ended up with what I sent here.
> Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
> after sending out v1. Will take care of that in v2.

Another way is use arch private function to locate mem hole, then set
kbuf->mem, and then call kexec_add_buf, it will skip the common locate
hole function.

But other than that I have some confusion about those excluded ranges.
Replied a question to patch 4.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
