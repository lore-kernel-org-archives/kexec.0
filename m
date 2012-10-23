Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQhbL-0003rr-Px
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 16:45:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <20121023154123.GA30730@srcf.ucam.org>
Date: Tue, 23 Oct 2012 09:44:59 -0700
In-Reply-To: <20121023154123.GA30730@srcf.ucam.org> (Matthew Garrett's message
 of "Tue, 23 Oct 2012 16:41:24 +0100")
Message-ID: <87d309xhmc.fsf_-_@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC] Kdump with signed images
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
To: Matthew Garrett <mjg@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

Matthew Garrett <mjg@redhat.com> writes:

> On Tue, Oct 23, 2012 at 10:59:20AM -0400, Vivek Goyal wrote:
>
>> But what about creation of a new program which can call kexec_load()
>> and execute an unsigned kernel. Doesn't look like that will be
>> prevented using IMA.
>
> Right. Trusting userspace would require a new system call that passes in 
> a signature of the userspace binary, and the kernel would then have to 
> verify the ELF object in memory in order to ensure that it 
> matches the signature. Verifying that the copy on the filesystem is 
> unmodified isn't adequate - an attacker could simply have paused the 
> process and injected code. 

Verifying the copy on the filesystem at exec time is perfectly adequate
for gating extra permissions.  Certainly that is the model everywhere
else in the signed key chain.

Where IMA falls short is there is no offline signing capability in IMA
itself.  I think EVM may fix that.

> Realistically, the only solution here is for 
> the kernel to verify that the kernel it's about to boot is signed and 
> for it not to take any untrusted executable code from userspace.

Hogwash.  The kernel verifing a signature of /sbin/kexec at exec time is
perfectly reasonable, and realistic.  In fact finding a way to trust
small bits of userspace even if root is compromised seems a far superior
model to simply solving the signing problem for /sbin/kexec.

Although I do admit some part of the kexec process will need to verify
keys on the images we decide to boot.

Eric




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
