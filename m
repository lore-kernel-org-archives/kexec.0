Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikPLS-00028g-ER
 for kexec@lists.infradead.org; Thu, 26 Dec 2019 09:22:16 +0000
From: "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: RE: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Date: Thu, 26 Dec 2019 09:22:02 +0000
Message-ID: <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
References: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <20191225065914.GC3355@MiWiFi-R3L-srv>
In-Reply-To: <20191225065914.GC3355@MiWiFi-R3L-srv>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "'bhe@redhat.com'" <bhe@redhat.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'ebiederm@xmission.com'" <ebiederm@xmission.com>, "'dyoung@redhat.com'" <dyoung@redhat.com>, "'mingo@kernel.org'" <mingo@kernel.org>, "'vgoyal@redhat.com'" <vgoyal@redhat.com>


> -----Original Message-----
> 
> Hi HATAYAMA,
> 
> On 12/25/19 at 04:26am, d.hatayama@fujitsu.com wrote:
> > Currently, reservation of crashkernel low memory sometimes fails due
> > to a sparse memory caused by physical kaslr with the following
> > message:
> >
> >     Cannot reserve 256MB crashkernel low memory, please try smaller size.
> 
> I don't understand, may not get your point. KASLR will randomize the
> position of kernel image. However, kernel image usually takes up 50M
> memory. Under low 4G memory, how come it can't reserve 256M crashkernel
> low memory. Do you have the boot log of the failed case?

Thanks for your comments and sorry for the insufficient explanation.

Low 4GB memory in our system is considerably limited. The size of the largest
contiguous free physical pages at the timing when kernel attempts at
reserving low memory for crash kernel is less than 512MB. Hence, if physical
kaslr inserts kernel image into the center of the chunk, every remaining
chunks have less than 256M size. Then, the failure occurs.

> 
> >
> > Kdump needs low memory, memory area less than 4GB, e.g. for swiotlb.
> > Its size is 256MB for low memory by default. OTOH, physical kaslr
> > loads kernel images in a random physical address for
> > security. Physical kaslr sometimes choose low memory and sparse
> > there and as a result, reservation of crash kernel low memory could fail.
> >
> > This failure seldom occurs on systems with large memory. For example,
> > on our system with 128GB, the issue occurs once in hundreds of
> > reboots. Although it doesn't occur frequently and can be avoided in
> > practice simply by rebooting the system, it definitely occurs once in
> > hundreds of reboots. Once the issue occurs, it's difficult for ordinary
> > users to understand why it failed. I'd like to fix this current behavior.
> >
> > I'm now coming up two ideas but don't know what is best. Please
> > discuss how to fix the issue in better way.
> >
> > 1) Add a kernel parameter to make physical kaslr to avoid specified
> >    memory area
> >
> >   This is the simplest idea I came up with first just like
> >    kaslr_mem_avoid=4GB-0, which is similar syntax to memap=, meaning
> >    that kaslr, please avoid to load kernel image into the region [0,
> >    4GB).
> >
> >   It looks to me that this can be implemented easily by taking
> >    advantage of the existing code about mem_avoid mechanism in
> >    arch/x86/boot/compressed/kaslr.c.
> >
> >   This mechanism doesn't lose security provided by physical kaslr if
> >    system memory is large enough.
> >
> >   Demerit of this is that users need configuration. Automatic way is
> >    better if possible.
> >
> > 2) Add special handling for crashkernel= low in physical kaslr
> >
> >   The second idea I came up with is to add special handling for
> >    crashkernel= low in physical kaslr, i.e. physical kaslr recognizes
> >    crashkernel= in kernel parameters and keep enough memory for
> >    crashkenrel.
> >
> >   To guarantee that the memory area kept by the special handling in
> >    physical kaslr is used for crashkernel, it is necessary to mark the
> >    area to indicate to the crashkernel code executed after kernel
> >    runs. To implement this, I imagine introducing a new type of memory
> >    a kind of E820_CRASHKERNEL_LOW.
> >
> >   My concern on this idea is whether its worth implementing such
> >    special handling in physical kaslr simply because I don't find such
> >    code in physical kaslr now.
> >
> > 3) Any other better ideas?
> 
> Someone ever told that some systems may not have low 4G memory since
> they own hardware iommu. In real life, I never see such kind of system,
> and most of them can give 256M crashkernel memory a satisfactory result.
> Unless you reserve more than 1G under low 4G, it could fail because of
> kinds of complicated memory reservations there.

I'm surprised to hear such system without low 4GB memory and I wonder
how such system works well without restriction of memory access range
in early runtime mode on x86 such as real mode.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
