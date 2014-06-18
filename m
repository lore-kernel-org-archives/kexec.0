Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WxFAz-0007rX-Ux
 for kexec@lists.infradead.org; Wed, 18 Jun 2014 12:41:18 +0000
Date: Wed, 18 Jun 2014 08:40:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140618124037.GB15327@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140612054203.GA3696@darkstar.nay.redhat.com>
 <20140617142419.GC28340@redhat.com>
 <20140618014510.GA2851@darkstar.nay.redhat.com>
 <20140618015246.GB2851@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140618015246.GB2851@darkstar.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, chaowang@redhat.com

On Wed, Jun 18, 2014 at 09:52:46AM +0800, Dave Young wrote:
[..]
> > > > Hi, Vivek
> > > > 
> > > > For efi ioremapping case, in 3.15 kernel efi runtime maps will not be saved
> > > > if efi=old_map is used. So you need detect this and fail the kexec file load.
> > > 
> > > Dave,
> > > 
> > > Instead of failing kexec load in case of efi=old_map, I think it will be
> > > better to just not pass runtime map in bootparams. That way user can
> > > pass "noefi" on commandline and kdump should still work.  (Like it works
> > > with user space implementation).
> 
> BTW, in kexec-tools in case old_map it just does not fill efi_info so 2nd kernel
> will automaticlly switch to noefi boot. So do same in kernel make sense as well.

Yep. If old_map is being used, I will not fill efi_info and I will also
not pass efi setup data structure. I think user space does the same.

> 
> In userspace tools we pass acpi_rsdp for kdump noefi case, do you want to add that
> in the kernel loader?

I will not do that in kernel. I will expect user space to pass in
acpi_rsdp=0x on command line.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
