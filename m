Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vaboo-0000RD-Gv
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 01:40:35 +0000
Date: Mon, 28 Oct 2013 09:39:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131028013949.GA10444@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
 <20131028003908.GH849@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028003908.GH849@verge.net.au>
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
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On 10/28/13 at 09:39am, Simon Horman wrote:
> On Sun, Oct 27, 2013 at 12:04:39PM +0800, dyoung@redhat.com wrote:
> > Removing code to pass acpi_rsdp because this
> > patch series will support efi runtime, it's not
> > necessary any more. EFI initialization code will
> > take the functionality.
> 
> I wonder if it would make more sense to make this the
> last patch in the series or squash it into the last patch
> of the series.
> 

Sure, logiclly it should be the last one.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
