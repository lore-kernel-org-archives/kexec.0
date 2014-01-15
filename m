Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-yh0-x231.google.com ([2607:f8b0:4002:c01::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3EZG-0006LM-JI
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 00:42:51 +0000
Received: by mail-yh0-f49.google.com with SMTP id b6so343667yha.22
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 16:42:28 -0800 (PST)
Date: Tue, 14 Jan 2014 16:42:24 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v3]
In-Reply-To: <1389727273-27817-1-git-send-email-prarit@redhat.com>
Message-ID: <alpine.DEB.2.02.1401141642020.3375@chino.kir.corp.google.com>
References: <1389727273-27817-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: toshi.kani@hp.com, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com, kosaki.motohiro@gmail.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>

On Tue, 14 Jan 2014, Prarit Bhargava wrote:

> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index b9e9bd8..ea93f75 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -343,6 +343,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			no: ACPI OperationRegions are not marked as reserved,
>  			no further checks are performed.
>  
> +	acpi_no_memhotplug [ACPI] Disable memory hotplug.  Useful for kexec
> +			   and kdump kernels.
> +
>  	add_efi_memmap	[EFI; X86] Include EFI memory map in
>  			kernel's map of available physical RAM.
>  
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 551dad7..4a0fa94 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -361,7 +361,19 @@ static void acpi_memory_device_remove(struct acpi_device *device)
>  	acpi_memory_device_free(mem_device);
>  }
>  
> +static bool acpi_no_memhotplug;
> +

I think this should be annotated with __initdata.

>  void __init acpi_memory_hotplug_init(void)
>  {
> +	if (acpi_no_memhotplug)
> +		return;
> +
>  	acpi_scan_add_handler_with_hotplug(&memory_device_handler, "memory");
>  }
> +
> +static int __init disable_acpi_memory_hotplug(char *str)
> +{
> +	acpi_no_memhotplug = true;
> +	return 1;
> +}
> +__setup("acpi_no_memhotplug", disable_acpi_memory_hotplug);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
