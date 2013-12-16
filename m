Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsZnw-0005MI-Kz
 for kexec@lists.infradead.org; Mon, 16 Dec 2013 15:09:58 +0000
Date: Mon, 16 Dec 2013 15:09:29 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v6 08/14] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131216150929.GA3873@console-pimps.org>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-9-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387186235-15972-9-git-send-email-dyoung@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On Mon, 16 Dec, at 05:30:29PM, Dave Young wrote:
> @@ -899,6 +928,11 @@ void __init efi_enter_virtual_mode(void)
>  		return;
>  	}
>  
> +#ifdef CONFIG_EFI_RUNTIME_MAP
> +	efi_runtime_map_setup(efi_runtime_map, nr_efi_runtime_map,
> +			      boot_params.efi_info.efi_memdesc_size);
> +#endif

[...]

> @@ -167,6 +167,12 @@ static int __init efisubsys_init(void)
>  		goto err_unregister;
>  	}
>  
> +#ifdef CONFIG_EFI_RUNTIME_MAP
> +	error = efi_runtime_map_init(efi_kobj);
> +	if (error)
> +		goto err_remove_group;
> +#endif

[...]

> @@ -876,4 +876,9 @@ int efivars_sysfs_init(void);
>  
>  #endif /* CONFIG_EFI_VARS */
>  
> +#ifdef CONFIG_EFI_RUNTIME_MAP
> +int efi_runtime_map_init(struct kobject *);
> +void efi_runtime_map_setup(void *, int, u32);
> +#endif

I was thinking more along the lines of...

---

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 120086820654..fd5a0aad1fff 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -928,10 +928,8 @@ void __init efi_enter_virtual_mode(void)
 		return;
 	}
 
-#ifdef CONFIG_EFI_RUNTIME_MAP
 	efi_runtime_map_setup(efi_runtime_map, nr_efi_runtime_map,
 			      boot_params.efi_info.efi_memdesc_size);
-#endif
 
 	BUG_ON(!efi.systab);
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4109dca787dc..4753bac65279 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -167,11 +167,9 @@ static int __init efisubsys_init(void)
 		goto err_unregister;
 	}
 
-#ifdef CONFIG_EFI_RUNTIME_MAP
 	error = efi_runtime_map_init(efi_kobj);
 	if (error)
 		goto err_remove_group;
-#endif
 
 	/* and the standard mountpoint for efivarfs */
 	efivars_kobj = kobject_create_and_add("efivars", efi_kobj);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98eb0621583..e64540746c63 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -875,6 +875,14 @@ int efivars_sysfs_init(void);
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_runtime_map_init(struct kobject *);
 void efi_runtime_map_setup(void *, int, u32);
+#else
+static inline int efi_runtime_map_init(struct kobject *kobj)
+{
+	return 0;
+}
+
+static inline void
+efi_runtime_map_setup(void *map, int nr_entries, u32 desc_size) {}
 #endif
 
 #endif /* _LINUX_EFI_H */

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
