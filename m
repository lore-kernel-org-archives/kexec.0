Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vb9Kx-0006N6-Ka
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 13:28:00 +0000
Date: Tue, 29 Oct 2013 09:27:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131029132723.GA11174@redhat.com>
References: <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
 <20131028094223.GA2335@srcf.ucam.org>
 <20131028095459.GE25527@dhcp-16-126.nay.redhat.com>
 <20131028101256.GA3226@srcf.ucam.org>
 <20131028103412.GG25527@dhcp-16-126.nay.redhat.com>
 <20131028103929.GA4407@srcf.ucam.org>
 <20131028104532.GA29133@dhcp-16-126.nay.redhat.com>
 <20131028105119.GA4822@srcf.ucam.org>
 <20131028161040.GE1659@redhat.com>
 <20131029020428.GC21262@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131029020428.GC21262@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, kexec@lists.fedoraproject.org

On Tue, Oct 29, 2013 at 11:04:28AM +0900, Simon Horman wrote:

[..]
> > > Yes, that's my point. You're breaking old configurations by requiring 
> > > the user to pass an additional argument.
> > 
> > Yes this is a problem. Of course solution is easy by always passing
> > acpi_rsdp on command line. But in long term this is a problem. In the
> > sense, I am not sure how to cleanup the kexec-tools code as things improve.
> > Now we will support the EFI properly and still pass acpi_rsdp always in
> > an effort to matain backward compatibility.
> > 
> > For a very long time kexec-tools were not automatically appending
> > acpi_rsdp and user were supposed to add it on command line. We were
> > carrying this change in kdump scripts and pushed this change into
> > kexec-tools. In hindsight, it looks like that hardcoding parameters
> > in kexec-tools is a bad idea. It is hard to get rid of them in future.
> 
> I tend to agree.  However, if the parameters end up being hard coded
> elsewhere, for example in widely used wrapper scripts, then I think that
> the same problem still exists. Just outside of kexec-tools itself.

I think getting rid of them in vendor scripts is easier beacause control
the range of kexec-tools and kernel version which will be used in a
particular release life cycle. So when we know that we are not going to
support other kernels than vendor shipped kernel, we can remove parameters
from scripts.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
