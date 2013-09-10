Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJWoR-0004Vl-69
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 22:53:35 +0000
Message-ID: <522FA2A8.8080703@zytor.com>
Date: Tue, 10 Sep 2013 15:52:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com

On 09/10/2013 02:44 PM, Vivek Goyal wrote:
> Currently kexec does not enables EFI and its tables in second kernel. Hence
> acpi rsdp root pointer is passed on command line. But secureboot does not trust
> acpi_rsdp on command line as kernel can execute some of the code as retrieved
> by following acpi_rsdp and root can modify command line. So in secureboot
> mode we ignore acpi_rsdp on command line.
> 
> Start passing it in bootparams for the time being. kexec-tools will prepare
> the bootparams and put acpi_rsdp pointer there.
> 
> Peter Jones suggested that scan all ACPI memory for acpi_rsdp if EFI is
> not enabled. This probably is a better fix and most likely this patch will
> change and adopt that approach down the line.
> 
> In fact if we figure out how to make UEFI run time calls in second kernel,
> we will not need acpi_rsdp at all.
> 

Borislav Petkov has been working on a fixed mapping of UEFI memory,
which should allow UEFI runtime calls across kexec.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
