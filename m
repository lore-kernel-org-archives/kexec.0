Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VazBW-0007Xq-0V
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 02:37:35 +0000
Date: Tue, 29 Oct 2013 10:36:36 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131029023636.GC5185@dhcp-16-126.nay.redhat.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, Vivek Goyal <vgoyal@redhat.com>

On 10/29/13 at 11:04am, Simon Horman wrote:
> On Mon, Oct 28, 2013 at 12:10:40PM -0400, Vivek Goyal wrote:
> > On Mon, Oct 28, 2013 at 10:51:19AM +0000, Matthew Garrett wrote:
> > > On Mon, Oct 28, 2013 at 06:45:32PM +0800, Dave Young wrote:
> > > > On 10/28/13 at 10:39am, Matthew Garrett wrote:
> > > > > On Mon, Oct 28, 2013 at 06:34:12PM +0800, Dave Young wrote:
> > > > > > On 10/28/13 at 10:12am, Matthew Garrett wrote:
> > > > > > > Right, but previously acpi_rsdp was passed automatically and now it 
> > > > > > > won't be?
> > > > > > 
> > > > > > Yes, it was. I'm removing them in kexec-tools patches for efi runtime support.
> > > > > 
> > > > > If I upgrade kexec-tools and try to launch an old kernel, I now need to 
> > > > > add an extra parameter?
> > > > 
> > > > Yes, it should work by passing the acpi_rsdp= via --append
> > > 
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

Kernel has a rule of not breaking userspace, does kexec-tools also have the
policy? Maybe user or distribution carry that will be slight better so upstream
kexec code will be cleaner..

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
