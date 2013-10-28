Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VajXt-0000CZ-5f
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 09:55:37 +0000
Date: Mon, 28 Oct 2013 17:54:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131028095459.GE25527@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
 <20131028094223.GA2335@srcf.ucam.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028094223.GA2335@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

Hi,
Thanks for review.

On 10/28/13 at 09:42am, Matthew Garrett wrote:
> On Sun, Oct 27, 2013 at 12:04:39PM +0800, dyoung@redhat.com wrote:
> > Removing code to pass acpi_rsdp because this
> > patch series will support efi runtime, it's not
> > necessary any more. EFI initialization code will
> > take the functionality.
> 
> Won't this break kexec of old kernels that don't have the new UEFI setup 
> code?

For old kernels the efi setup_data esdata will be NULL, it wil switch to
old logic. Also for old kernel user need to pass acpi_rsdp in cmdline

Anyway I will do test with old/new kernel/userspace test results.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
