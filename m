Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFClh-0002q4-BJ
 for kexec@lists.infradead.org; Tue, 01 Oct 2019 07:40:24 +0000
Date: Tue, 1 Oct 2019 15:40:12 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
Message-ID: <20191001074012.GK31919@MiWiFi-R3L-srv>
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
 <20190928000505.GJ31919@MiWiFi-R3L-srv>
 <875zldp2vj.fsf@x220.int.ebiederm.org>
 <20190928030910.GA5774@MiWiFi-R3L-srv>
 <87zhimks5j.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zhimks5j.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, Lianbo Jiang <lijiang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 09/30/19 at 05:14am, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> >> needs a little better description.  I know it is not a lot on modern
> >> systems but reserving an extra 1M of memory to avoid having to special
> >> case it later seems in need of calling out.
> >> 
> >> I have an old system around that I think that 640K is about 25% of
> >> memory.
> >
> > Understood. Basically 640K is wasted in this case. But we only do like
> > this in SME case, a condition checking is added. And system with SME is
> > pretty new model, it may not impact the old system.
> 
> The conditional really should be based on if we are reserving memory
> for a kdump kernel.  AKA if crash_kernel=XXX is specified on the kernel
> command line.
> 
> At which point I think it would be very reasonable to unconditionally
> reserve the low 640k, and make the whole thing a non-issue.  This would
> allow the kdump code to just not do anything special for any of the
> weird special case.
> 
> It isn't perfect because we need a page or so used in the first kernel
> for bootstrapping the secondary cpus, but that seems like the least of
> evils.  Especially as no one will DMA to that memory.
> 
> So please let's just change what memory we reserve when crash_kernel is
> specified.

Yes, makes sense, thanks for pointing it out.

> 
> >> How we interact with BIOS tables in the first 640k needs some
> >> explanation.  Both in the first kernel and in the crash kernel.
> >
> > Yes, totally agree.
> >
> > Those BIOS tables have been reserved as e820 reserved regions and will
> > be passed to kdump kernel for reusing. Memblock reserved 640K doesn't
> > mean it will cover the whole [0, 640K) region, it only searches for
> > available system RAM from memblock allocator.
> 
> Careful with that assumption.  My memory is that the e820 memory map
> frequently fails to cover areas like the real mode interrupt descriptor
> table at address 0.

OK, will think more about this. Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
