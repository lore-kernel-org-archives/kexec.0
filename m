Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-f177.google.com ([74.125.82.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sofnf-0001eE-6E
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 19:08:44 +0000
Received: by weyr3 with SMTP id r3so248623wey.36
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 12:08:29 -0700 (PDT)
Date: Tue, 10 Jul 2012 20:08:15 +0100
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
From: Keir Fraser <keir.xen@gmail.com>
Message-ID: <CC223C2F.3817C%keir.xen@gmail.com>
In-Reply-To: <20120710180953.GB20075@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Daniel Kiper <dkiper@net-space.pl>, xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@suse.com>

On 10/07/2012 19:09, "Olaf Hering" <olaf@aepfle.de> wrote:

>>> Are there more shared areas or is it just the shared info page?
>>> 
>>>> And I am kind of worried that moving it to the .data section won't
>>>> be completly safe - as the decompressor might blow away that part too.
>>> 
>>> The decompressor may just clear the area, but since there is no way to
>>> tell where the shared pages are its always a risk to allocate them at
>>> compile time.
>> 
>> Yeah, and with the hypervisor potentially still updating the "old"
>> MFN before the new kernel has registered the new MFN, we can end up
>> corrupting the new kernel. Ouch.
>> 
>> Would all of these issues disappear if the hypervisor had a hypercall
>> that would stop updating the shared info? or just deregister the MFN?
>> What if you ripped the GMFN out using 'decrease_reservation' hypercall?
>> Would that eliminate the pesky GMFN?
> 
> I'm not sure, most likely the gfn will just disappear from the guest,
> like a ballooned page disappears. Accessing it will likely cause a
> crash.

Best thing to do, is possible, is map the shared-info page in the
xen-platform pci device's BAR memory range. Then it will not conflict with
any RAM.

If you do map it over the top of an existing RAM page, you will have to
repopulate that RAM page before kexec, using populate_physmap hypercall. The
good news is that the populate_physmap hypercall will have the side effect
of unmapping the shared-info page, reayd to be mapped wherever the new
kernel would like it to reside :)

Hope this clears up some of the confusion. ;)

 -- Keir



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
