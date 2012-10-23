Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQi7A-0000Ur-EI
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 17:18:05 +0000
Date: Tue, 23 Oct 2012 13:18:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121023171759.GE16496@redhat.com>
References: <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com> <87hapl6vae.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87hapl6vae.fsf@xmission.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Oct 23, 2012 at 08:51:53AM -0700, Eric W. Biederman wrote:

[..]
> > purgatory code is modified dynamically upon every invocation of kexec.
> > That means there needs to be a mechanism to sign it after we are done
> > with purgatory modification. But there are no signing keys available
> > on the system. All the signing happens externally during build time. So
> > we don't have the option of signing purgatory at run time.
> 
> Hogwash.
> 
> The only significant modification we make to purgatory is relocation
> processing.  That relocation processing is a convinience, not a
> necessity.  Potentially we could move the relocation processing into
> purgatory itself.

Apart from relocations, we also set some variable values.

- Like entry point of kernel.
- Like address of backup region etc.

And all this information is dynamic and varies based on where memory for
second kernel was reserved. So until and unless we figure out a way to
solve that problem, we can't sign purgatory at build time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
