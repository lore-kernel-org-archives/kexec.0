Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TR4cE-0005q2-4x
 for kexec@lists.infradead.org; Wed, 24 Oct 2012 17:19:39 +0000
Date: Wed, 24 Oct 2012 13:19:26 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with signed images
Message-ID: <20121024171926.GD1821@redhat.com>
References: <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <20121023154123.GA30730@srcf.ucam.org>
 <87d309xhmc.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d309xhmc.fsf_-_@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kasatkin, Dmitry" <dmitry.kasatkin@intel.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Tue, Oct 23, 2012 at 09:44:59AM -0700, Eric W. Biederman wrote:
> Matthew Garrett <mjg@redhat.com> writes:
> 
> > On Tue, Oct 23, 2012 at 10:59:20AM -0400, Vivek Goyal wrote:
> >
> >> But what about creation of a new program which can call kexec_load()
> >> and execute an unsigned kernel. Doesn't look like that will be
> >> prevented using IMA.
> >
> > Right. Trusting userspace would require a new system call that passes in 
> > a signature of the userspace binary, and the kernel would then have to 
> > verify the ELF object in memory in order to ensure that it 
> > matches the signature. Verifying that the copy on the filesystem is 
> > unmodified isn't adequate - an attacker could simply have paused the 
> > process and injected code. 
> 
> Verifying the copy on the filesystem at exec time is perfectly adequate
> for gating extra permissions.  Certainly that is the model everywhere
> else in the signed key chain.
> 
> Where IMA falls short is there is no offline signing capability in IMA
> itself.  I think EVM may fix that.

[ CCing lkml. I think it is a good idea to open discussion to wider
audience. Also CCing IMA/EVM folks ]

Based on reading following wiki page, looks like EVM also does not allow
offline signing capability. And EVM is protecting IMA data to protect
against offline attack. If we can assume that unisgned kernels can't be
booted on the platform, then EVM might not be a strict requirement in
this case.

So as you said, one of the main problem with IMA use to verify /sbin/kexec
is that IMA does not provide offline signing capability.

> 
> > Realistically, the only solution here is for 
> > the kernel to verify that the kernel it's about to boot is signed and 
> > for it not to take any untrusted executable code from userspace.
> 
> Hogwash.  The kernel verifing a signature of /sbin/kexec at exec time is
> perfectly reasonable, and realistic.  In fact finding a way to trust
> small bits of userspace even if root is compromised seems a far superior
> model to simply solving the signing problem for /sbin/kexec.
> 
> Although I do admit some part of the kexec process will need to verify
> keys on the images we decide to boot.

It should be an option, isn't it? Either /sbin/kexec can try to verify the
integrity of kernel or we extend try to extend kexec() system call to also
pass the signature of kernel and let kernel verify it (as you mentioned
previously).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
