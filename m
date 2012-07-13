Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SpmLy-0007vd-Ro
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 20:20:49 +0000
Date: Fri, 13 Jul 2012 22:20:03 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120713202003.GA20972@aepfle.de>
References: <20120710180953.GB20075@aepfle.de>
 <CC223C2F.3817C%keir.xen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CC223C2F.3817C%keir.xen@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Keir Fraser <keir.xen@gmail.com>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, Daniel Kiper <dkiper@net-space.pl>

On Tue, Jul 10, Keir Fraser wrote:

> On 10/07/2012 19:09, "Olaf Hering" <olaf@aepfle.de> wrote:
> > I'm not sure, most likely the gfn will just disappear from the guest,
> > like a ballooned page disappears. Accessing it will likely cause a
> > crash.
> 
> Best thing to do, is possible, is map the shared-info page in the
> xen-platform pci device's BAR memory range. Then it will not conflict with
> any RAM.
> 
> If you do map it over the top of an existing RAM page, you will have to
> repopulate that RAM page before kexec, using populate_physmap hypercall. The
> good news is that the populate_physmap hypercall will have the side effect
> of unmapping the shared-info page, reayd to be mapped wherever the new
> kernel would like it to reside :)

Keir,

is this a safe thing to do in a SMP guest?
If arch/x86/xen/enlighten.c:xen_hvm_init_shared_info() allocates a page
(backed by mfn M and pfn A) and assigns *HYPERVISOR_shared_info and
*xen_vcpu then everything will reference these pointers.

If drivers/xen/platform-pci.c:platform_pci_init would also do a
XENMAPSPACE_shared_info call with pfn B, isnt there a small window where
pfn A is not backed by a mfn because mfn M is now connected to pfn C? As
a result other code paths which access *HYPERVISOR_shared_info and
*xen_vcpu between the hypercall and the update of the pointers will read
0xff.


If I read the hypercall code of XENMEM_add_to_physmap correctly the mfn
backing *HYPERVISOR_shared_info will remain the same, so there is no need
to copy data from the old to the new *HYPERVISOR_shared_info.

What do you think, is that race real?

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
