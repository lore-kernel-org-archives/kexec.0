Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGzh8-00074K-6P
 for kexec@lists.infradead.org; Tue, 02 Mar 2021 07:43:51 +0000
Date: Tue, 2 Mar 2021 15:43:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20210302074327.GC13714@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com>
 <20210225072426.GH3553@MiWiFi-R3L-srv>
 <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
 <m14khykfeq.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14khykfeq.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, rppt@kernel.org, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On 02/26/21 at 09:38am, Eric W. Biederman wrote:
> chenzhou <chenzhou10@huawei.com> writes:
> 
> > On 2021/2/25 15:25, Baoquan He wrote:
> >> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
> >>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
> >>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> >>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> >>>> function reserve_crashkernel() also used 1M alignment. So just
> >>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
> >>> [...]
> >>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
> >>>>  	} else {
> >>>>  		unsigned long long start;
> >>>>  
> >>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> >>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
> >>>>  						  crash_base + crash_size);
> >>>>  		if (start != crash_base) {
> >>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
> >>> There is a small functional change here for x86. Prior to this patch,
> >>> crash_base passed by the user on the command line is allowed to be 1MB
> >>> aligned. With this patch, such reservation will fail.
> >>>
> >>> Is the current behaviour a bug in the current x86 code or it does allow
> >>> 1MB-aligned reservations?
> >> Hmm, you are right. Here we should keep 1MB alignment as is because
> >> users specify the address and size, their intention should be respected.
> >> The 1MB alignment for fixed memory region reservation was introduced in
> >> below commit, but it doesn't tell what is Eric's request at that time, I
> >> guess it meant respecting users' specifying.
> 
> 
> > I think we could make the alignment unified. Why is the alignment system reserved and
> > user specified different? Besides, there is no document about the 1MB alignment.
> > How about adding the alignment size(16MB) in doc  if user specified
> > start address as arm64 does.
> 
> Looking at what the code is doing.  Attempting to reserve a crash region
> at the location the user specified.  Adding unnecessary alignment
> constraints is totally broken. 
> 
> I am not even certain enforcing a 1MB alignment makes sense.  I suspect
> it was added so that we don't accidentally reserve low memory on x86.
> Frankly I am not even certain that makes sense.
> 
> Now in practice there might be an argument for 2MB alignment that goes
> with huge page sizes on x86.  But until someone finds that there are
> actual problems with 1MB alignment I would not touch it.
> 
> The proper response to something that isn't documented and confusing is
> not to arbitrarily change it and risk breaking users.  Especially in
> this case where it is clear that adding additional alignment is total
> nonsense.  The proper response to something that isn't clear and
> documented is to dig in and document it, or to leave it alone and let it

Sounds reasonable. Then adding document or code comment around looks
like a good way to go further so that people can easily get why its
alignment is different than other reservation.

> be the next persons problem.
> 
> In this case there is no reason for changing this bit of code.
> All CRASH_ALIGN is about is a default alignment when none is specified.
> It is not a functional requirement but just something so that things
> come out nicely.
> 
> 
> Eric
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
