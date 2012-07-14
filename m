Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SpuQJ-0006YL-BP
 for kexec@lists.infradead.org; Sat, 14 Jul 2012 04:57:45 +0000
Received: by wibhm11 with SMTP id hm11so927781wib.0
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 21:57:22 -0700 (PDT)
Date: Sat, 14 Jul 2012 05:54:50 +0100
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
From: Keir Fraser <keir.xen@gmail.com>
Message-ID: <CC26BA2A.38974%keir.xen@gmail.com>
In-Reply-To: <20120713202003.GA20972@aepfle.de>
Mime-version: 1.0
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
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, Daniel Kiper <dkiper@net-space.pl>

On 13/07/2012 21:20, "Olaf Hering" <olaf@aepfle.de> wrote:

> On Tue, Jul 10, Keir Fraser wrote:
> 
>> On 10/07/2012 19:09, "Olaf Hering" <olaf@aepfle.de> wrote:
>>> I'm not sure, most likely the gfn will just disappear from the guest,
>>> like a ballooned page disappears. Accessing it will likely cause a
>>> crash.
>> 
>> Best thing to do, is possible, is map the shared-info page in the
>> xen-platform pci device's BAR memory range. Then it will not conflict with
>> any RAM.
>> 
>> If you do map it over the top of an existing RAM page, you will have to
>> repopulate that RAM page before kexec, using populate_physmap hypercall. The
>> good news is that the populate_physmap hypercall will have the side effect
>> of unmapping the shared-info page, reayd to be mapped wherever the new
>> kernel would like it to reside :)
> 
> Keir,
> 
> is this a safe thing to do in a SMP guest?
> If arch/x86/xen/enlighten.c:xen_hvm_init_shared_info() allocates a page
> (backed by mfn M and pfn A) and assigns *HYPERVISOR_shared_info and
> *xen_vcpu then everything will reference these pointers.

So pfn A now points at shared_info, and mfn M is lost (freed back to Xen).
Xen_vcpu doesn't come into it, you'd have that mapped at yet another pfn.

> If drivers/xen/platform-pci.c:platform_pci_init would also do a
> XENMAPSPACE_shared_info call with pfn B, isnt there a small window where
> pfn A is not backed by a mfn because mfn M is now connected to pfn C? As
> a result other code paths which access *HYPERVISOR_shared_info and
> *xen_vcpu between the hypercall and the update of the pointers will read
> 0xff.

Don't really understand this. After the XENMAPSPACE_shared_info_call:
 * PFN B points at shared_info, mfn M_B it previously mapped is lost (freed
back to Xen).
 * PFN A maps nothing, reads return all-1s.

Yes, obviously you can't atomically update the mapping of shinfo from A->B,
ad update your pointer in the kernel at exactly the same time. Presumably
you do this early during boot, or late during kexec, or otherwise at a time
when other processors are not expected to touch shinfo.

> 
> If I read the hypercall code of XENMEM_add_to_physmap correctly the mfn
> backing *HYPERVISOR_shared_info will remain the same, so there is no need
> to copy data from the old to the new *HYPERVISOR_shared_info.

That is correct.

> What do you think, is that race real?

I suppose it is. I didn't imagine it would be a troublesome one though.

 -- Keir

> Olaf



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
