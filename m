Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8RUc-0002FB-8k
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 14:21:59 +0000
Date: Tue, 17 Apr 2018 22:21:25 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180417142125.GE1750@localhost.localdomain>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
 <20180413092908.GB2119@localhost.localdomain>
 <20180417140714.GF28657@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180417140714.GF28657@bhelgaas-glaptop.roam.corp.google.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

On 04/17/18 at 09:07am, Bjorn Helgaas wrote:
> On Fri, Apr 13, 2018 at 05:29:08PM +0800, Baoquan He wrote:
> > Hi Bjorn,
> > 
> > There are changes I have made to solve 5-level conflict with
> > kexec/kdump and also interface unification task, they will involve x86
> > 64 only changes on these functions, I don't think we need remove them if
> > without any obvious impact or error reported.
> 
> Removing the weak attribute from the declaration in the header file
> does not prevent you from defining a weak function later in the .c
> file.

OK, sounds good to me. Then I have no concern to this, thanks.
Will see if other people have comments.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
