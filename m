Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6v1M-00045N-4P
 for kexec@lists.infradead.org; Fri, 13 Apr 2018 09:29:29 +0000
Date: Fri, 13 Apr 2018 17:29:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180413092908.GB2119@localhost.localdomain>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180413110820.662d4879@ThinkPad>
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
To: Bjorn Helgaas <helgaas@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

Hi Bjorn,

There are changes I have made to solve 5-level conflict with
kexec/kdump and also interface unification task, they will involve x86
64 only changes on these functions, I don't think we need remove them if
without any obvious impact or error reported.

Thanks
Baoquan

On 04/13/18 at 11:08am, Philipp Rudo wrote:
> Hi Bjorn,
> 
> in recent patches AKASHI [1] and I [2] made some changes to the declarations
> you are touching and already removed some of the weak statements. The patches
> got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
> should prepare for some merge conflicts. Nevertheless three weak statements
> still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
> patch still makes totally sense.
> 
> Thanks
> Philipp
> 
> [1] https://lkml.org/lkml/2018/3/6/201
> [2] https://lkml.org/lkml/2018/3/21/278
> 
> On Thu, 12 Apr 2018 13:23:29 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > "Weak" annotations in header files are error-prone because they make
> > every definition weak.  Remove them from include/linux/kexec.h.
> > 
> > These were introduced in two separate commits, so this is in two
> > patches so they can be easily backported to stable kernels (some of
> > them date back to v4.3 and one only goes back to v4.10).
> > 
> > ---
> > 
> > Bjorn Helgaas (2):
> >       kexec: Remove "weak" from kexec_file function declarations
> >       kexec: Remove "weak" from arch_kexec_walk_mem() declaration
> > 
> > 
> >  include/linux/kexec.h |   24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
