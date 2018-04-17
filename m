Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8RJG-0001Vg-PL
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 14:10:17 +0000
Date: Tue, 17 Apr 2018 09:09:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180417140959.GG28657@bhelgaas-glaptop.roam.corp.google.com>
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
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

On Fri, Apr 13, 2018 at 11:08:20AM +0200, Philipp Rudo wrote:
> Hi Bjorn,
> 
> in recent patches AKASHI [1] and I [2] made some changes to the declarations
> you are touching and already removed some of the weak statements. The patches
> got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
> should prepare for some merge conflicts. Nevertheless three weak statements
> still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
> patch still makes totally sense.

Thanks, I see those changes in v4.17-rc1.  I'll update my patches and
post a v2.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
