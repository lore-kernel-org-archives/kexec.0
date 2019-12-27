Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikfZt-0004fh-Bp
 for kexec@lists.infradead.org; Fri, 27 Dec 2019 02:42:15 +0000
Date: Fri, 27 Dec 2019 10:41:58 +0800
From: "'bhe@redhat.com'" <bhe@redhat.com>
Subject: Re: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Message-ID: <20191227024158.GD3355@MiWiFi-R3L-srv>
References: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <20191225065914.GC3355@MiWiFi-R3L-srv>
 <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
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
To: "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'ebiederm@xmission.com'" <ebiederm@xmission.com>, "'dyoung@redhat.com'" <dyoung@redhat.com>, "'mingo@kernel.org'" <mingo@kernel.org>, "'vgoyal@redhat.com'" <vgoyal@redhat.com>

On 12/26/19 at 09:22am, d.hatayama@fujitsu.com wrote:
> 
> > -----Original Message-----
> > 
> > Hi HATAYAMA,
> > 
> > On 12/25/19 at 04:26am, d.hatayama@fujitsu.com wrote:
> > > Currently, reservation of crashkernel low memory sometimes fails due
> > > to a sparse memory caused by physical kaslr with the following
> > > message:
> > >
> > >     Cannot reserve 256MB crashkernel low memory, please try smaller size.
> > 
> > I don't understand, may not get your point. KASLR will randomize the
> > position of kernel image. However, kernel image usually takes up 50M
> > memory. Under low 4G memory, how come it can't reserve 256M crashkernel
> > low memory. Do you have the boot log of the failed case?
> 
> Thanks for your comments and sorry for the insufficient explanation.
> 
> Low 4GB memory in our system is considerably limited. The size of the largest
> contiguous free physical pages at the timing when kernel attempts at
> reserving low memory for crash kernel is less than 512MB. Hence, if physical
> kaslr inserts kernel image into the center of the chunk, every remaining
> chunks have less than 256M size. Then, the failure occurs.

OK, this is truly extreme case, thanks for sharing.

Then I have several questions about it:

1) Can we use crashkernel=high, crashkernel=low, to fix this issue?
I believe in this system you told, it must be a high-end server, should
have hardware iommu depolyed. It doesn't need 256M low memory actually,
maybe 128M, even 64M is enough?

Asking this is because the 256M is default setting, default value only
covers general cases.

2) What if the system becomes more extreme, like the largest contiguous
free physical pages is less than 256M, even less than 128M?

Even though kernel image is limited to above 4G, whose fault is it? and
how can we fix it in this case?

3) If we really add limitation, maybe add kaslr_high to limit KASLR to
only put kernel image above 4G? 

 
> > 
...
 
> > Someone ever told that some systems may not have low 4G memory since
> > they own hardware iommu. In real life, I never see such kind of system,
> > and most of them can give 256M crashkernel memory a satisfactory result.
> > Unless you reserve more than 1G under low 4G, it could fail because of
> > kinds of complicated memory reservations there.
> 
> I'm surprised to hear such system without low 4GB memory and I wonder
> how such system works well without restriction of memory access range
> in early runtime mode on x86 such as real mode.

I think they meant almost no low memory, and it's a prototype machine to
experiment. Can't remember the detail.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
