Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6uhF-0001mW-HX
 for kexec@lists.infradead.org; Fri, 13 Apr 2018 09:08:43 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3D97Vpk096482
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2018 05:08:29 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2has4usdcu-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2018 05:08:28 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Fri, 13 Apr 2018 10:08:25 +0100
Date: Fri, 13 Apr 2018 11:08:20 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
In-Reply-To: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Message-Id: <20180413110820.662d4879@ThinkPad>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

Hi Bjorn,

in recent patches AKASHI [1] and I [2] made some changes to the declarations
you are touching and already removed some of the weak statements. The patches
got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
should prepare for some merge conflicts. Nevertheless three weak statements
still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
patch still makes totally sense.

Thanks
Philipp

[1] https://lkml.org/lkml/2018/3/6/201
[2] https://lkml.org/lkml/2018/3/21/278

On Thu, 12 Apr 2018 13:23:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> "Weak" annotations in header files are error-prone because they make
> every definition weak.  Remove them from include/linux/kexec.h.
> 
> These were introduced in two separate commits, so this is in two
> patches so they can be easily backported to stable kernels (some of
> them date back to v4.3 and one only goes back to v4.10).
> 
> ---
> 
> Bjorn Helgaas (2):
>       kexec: Remove "weak" from kexec_file function declarations
>       kexec: Remove "weak" from arch_kexec_walk_mem() declaration
> 
> 
>  include/linux/kexec.h |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
