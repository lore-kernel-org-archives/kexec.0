Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqxhM-0007n6-U8
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 11:48:14 +0000
Date: Thu, 2 Jul 2020 19:47:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
Message-ID: <20200702114758.GA21026@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
 <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
 <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
 <0e145e84-a6cf-4da3-1a1a-331a7e1ac1fa@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e145e84-a6cf-4da3-1a1a-331a7e1ac1fa@linux.ibm.com>
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

On 07/02/20 at 12:01am, Hari Bathini wrote:
> 
> 
> On 01/07/20 1:16 pm, Dave Young wrote:
> > On 06/29/20 at 05:26pm, Hari Bathini wrote:
> >> Hi Petr,
> >>
> >> On 29/06/20 5:09 pm, Petr Tesarik wrote:
> >>> Hi Hari,
> >>>
> >>> is there any good reason to add two more functions with a very similar
> >>> name to an existing function? AFAICS all you need is a way to call a
> >>> PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> >>> you could add something like this:
> >>>
> >>> int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >>> {
> >>> 	return 0;
> >>> }
> >>>
> >>> Call this function from kexec_add_buffer where appropriate and then
> >>> override it for PPC64 (it roughly corresponds to your
> >>> kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> >>>
> >>> FWIW it would make it easier for me to follow the resulting code.
> >>
> >> Right, Petr.
> >>
> >> I was trying out a few things before I ended up with what I sent here.
> >> Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
> >> after sending out v1. Will take care of that in v2.
> > 
> > Another way is use arch private function to locate mem hole, then set
> > kbuf->mem, and then call kexec_add_buf, it will skip the common locate
> > hole function.
> 
> Dave, I did think about it. But there are a couple of places this can get
> tricky. One is ima_add_kexec_buffer() and the other is kexec_elf_load().
> These call sites could be updated to set kbuf->mem before kexec_add_buffer().
> But the current approach seemed like the better option for it creates a
> single point of control in setting up segment buffers and also, makes adding
> any new segments simpler, arch-specific segments or otherwise.
> 

Ok, thanks for the explanation.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
