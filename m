Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TVR9E-0004CP-7h
 for kexec@lists.infradead.org; Mon, 05 Nov 2012 18:11:44 +0000
Date: Mon, 5 Nov 2012 13:11:41 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121105181141.GD28720@redhat.com>
References: <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019175301.GG27052@redhat.com> <87bofu9pj9.fsf@xmission.com>
 <50943CCB.5080504@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50943CCB.5080504@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Fri, Nov 02, 2012 at 02:36:11PM -0700, H. Peter Anvin wrote:
> On 10/22/2012 02:15 PM, Eric W. Biederman wrote:
> >>
> >> This is like re-designing the kexec/kdump and I really wish there is
> >> an easier way to handle the case signed kernels.
> > 
> > Yes.  Which is why either a signed puragtory or a signed /sbin/kexec
> > look very attractive.
> > 
> 
> Signed purgatory sounds like The Right Thing.  Doing relocation in
> purgatory should be quite trivial; I'd be happy to work with people if
> they need pointers how to do it.

So we sign purgatory and do the relocations in kernel later after
signature verification?

I have few questions though.

- We modify purgatory (update symbol values) in user space. That allows
  us to build single purgatory and chagne its behavior based on user
  options to kexec-tools (like 16bit vs 32bit entry, updating location
  of backup region etc). In fact purgatory to kernel jump location is
  decided at run time and purgatory is updated accordingly. That means
  we can't sign the purgatory.

  So apart from relocation, user space modification of purgatory code
  is also an issue. 

- Even if we come up with a way to avoid that, so will we not sign
  /sbin/kexec in that case? What happens to other unsigned segments
  loaded by /sbin/kexec. (boot_params, command line, elf headers etc).
  Can these be trusted without any signature.

So I am not sure that just signing the purgatory will solve the issue.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
