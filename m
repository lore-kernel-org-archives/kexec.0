Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHuZg-0004qS-4Y
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 11:19:25 +0000
Date: Tue, 19 Mar 2013 07:19:17 -0400
From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: [PATCH 10/12] acpi: Ignore acpi_rsdp kernel parameter in a
 secure boot environment
Message-ID: <20130319111916.GI11243@hansolo.jdub.homelinux.org>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <1363642353-30749-10-git-send-email-matthew.garrett@nebula.com>
 <5148261F.3030806@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5148261F.3030806@redhat.com>
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org

On Tue, Mar 19, 2013 at 04:47:27PM +0800, Dave Young wrote:
> On 03/19/2013 05:32 AM, Matthew Garrett wrote:
> > From: Josh Boyer <jwboyer@redhat.com>
> > 
> > This option allows userspace to pass the RSDP address to the kernel.  This
> > could potentially be used to circumvent the secure boot trust model.
> > We ignore the setting if we don't have the CAP_COMPROMISE_KERNEL capability.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@redhat.com>
> > ---
> >  drivers/acpi/osl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 586e7e9..0ef63f1 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -245,7 +245,7 @@ early_param("acpi_rsdp", setup_acpi_rsdp);
> >  acpi_physical_address __init acpi_os_get_root_pointer(void)
> >  {
> >  #ifdef CONFIG_KEXEC
> > -	if (acpi_rsdp)
> > +	if (acpi_rsdp && capable(CAP_COMPROMISE_KERNEL))
> >  		return acpi_rsdp;
> >  #endif
> >  
> > 
> 
> This does not work because capable is not usable at this early point.

Right.

> Josh, could you update your fix here?

I have.  Twice.  Matthew sent out a stale patch.

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
