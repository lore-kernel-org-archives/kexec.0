Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZw5w-0006QS-MB
 for kexec@lists.infradead.org; Wed, 17 Aug 2016 08:21:05 +0000
Date: Wed, 17 Aug 2016 16:20:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 1/2] kexec: Introduce "/sys/kernel/kexec_crash_low_size"
Message-ID: <20160817082034.GA11837@dhcp-128-65.nay.redhat.com>
References: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, yinghai@kernel.org, Vivek Goyal <vgoyal@redhat.com>

On 08/17/16 at 09:50am, Xunlei Pang wrote:
> "/sys/kernel/kexec_crash_size" only handles crashk_res, it
> is fine in most cases, but sometimes we have crashk_low_res.
> For example, when "crashkernel=size[KMG],high" combined with
> "crashkernel=size[KMG],low" is used for 64-bit x86.
> 
> Like crashk_res, we introduce the corresponding sysfs file
> "/sys/kernel/kexec_crash_low_size" for crashk_low_res.
> 
> So, the exact total reserved memory is the sum of the two.
> 
> crashk_low_res can also be shrunk via this new interface,
> and users should be aware of what they are doing.

Cc Yinghai Lu for review since he introduced the ,high and ,low logic.

> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  include/linux/kexec.h |  4 ++--
>  kernel/kexec_core.c   | 23 ++++++++++++-----------
>  kernel/ksysfs.c       | 25 +++++++++++++++++++++++--
>  3 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d743777..4f271fc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -304,8 +304,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
> -int crash_shrink_memory(unsigned long new_size);
> -size_t crash_get_memory_size(void);
> +int crash_shrink_memory(struct resource *res, unsigned long new_size);
> +size_t crash_get_memory_size(struct resource *res);
>  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
>  
>  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..707d18e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -925,13 +925,13 @@ void crash_kexec(struct pt_regs *regs)
>  	}
>  }
>  
> -size_t crash_get_memory_size(void)
> +size_t crash_get_memory_size(struct resource *res)
>  {
>  	size_t size = 0;
>  
>  	mutex_lock(&kexec_mutex);
> -	if (crashk_res.end != crashk_res.start)
> -		size = resource_size(&crashk_res);
> +	if (res->end != res->start)
> +		size = resource_size(res);
>  	mutex_unlock(&kexec_mutex);
>  	return size;
>  }
> @@ -945,7 +945,7 @@ void __weak crash_free_reserved_phys_range(unsigned long begin,
>  		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
>  }
>  
> -int crash_shrink_memory(unsigned long new_size)
> +int crash_shrink_memory(struct resource *res, unsigned long new_size)
>  {
>  	int ret = 0;
>  	unsigned long start, end;
> @@ -958,8 +958,9 @@ int crash_shrink_memory(unsigned long new_size)
>  		ret = -ENOENT;
>  		goto unlock;
>  	}
> -	start = crashk_res.start;
> -	end = crashk_res.end;
> +
> +	start = res->start;
> +	end = res->end;
>  	old_size = (end == 0) ? 0 : end - start + 1;
>  	if (new_size >= old_size) {
>  		ret = (new_size == old_size) ? 0 : -EINVAL;
> @@ -975,17 +976,17 @@ int crash_shrink_memory(unsigned long new_size)
>  	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
>  	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
>  
> -	crash_free_reserved_phys_range(end, crashk_res.end);
> +	crash_free_reserved_phys_range(end, res->end);
>  
> -	if ((start == end) && (crashk_res.parent != NULL))
> -		release_resource(&crashk_res);
> +	if ((start == end) && (res->parent != NULL))
> +		release_resource(res);
>  
>  	ram_res->start = end;
> -	ram_res->end = crashk_res.end;
> +	ram_res->end = res->end;
>  	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  	ram_res->name = "System RAM";
>  
> -	crashk_res.end = end - 1;
> +	res->end = end - 1;
>  
>  	insert_resource(&iomem_resource, ram_res);
>  
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index ee1bc1b..3336fd5 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -105,10 +105,30 @@ static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
>  }
>  KERNEL_ATTR_RO(kexec_crash_loaded);
>  
> +static ssize_t kexec_crash_low_size_show(struct kobject *kobj,
> +				       struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%zu\n", crash_get_memory_size(&crashk_low_res));
> +}
> +static ssize_t kexec_crash_low_size_store(struct kobject *kobj,
> +				   struct kobj_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	unsigned long cnt;
> +	int ret;
> +
> +	if (kstrtoul(buf, 0, &cnt))
> +		return -EINVAL;
> +
> +	ret = crash_shrink_memory(&crashk_low_res, cnt);
> +	return ret < 0 ? ret : count;
> +}
> +KERNEL_ATTR_RW(kexec_crash_low_size);
> +
>  static ssize_t kexec_crash_size_show(struct kobject *kobj,
>  				       struct kobj_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%zu\n", crash_get_memory_size());
> +	return sprintf(buf, "%zu\n", crash_get_memory_size(&crashk_res));
>  }
>  static ssize_t kexec_crash_size_store(struct kobject *kobj,
>  				   struct kobj_attribute *attr,
> @@ -120,7 +140,7 @@ static ssize_t kexec_crash_size_store(struct kobject *kobj,
>  	if (kstrtoul(buf, 0, &cnt))
>  		return -EINVAL;
>  
> -	ret = crash_shrink_memory(cnt);
> +	ret = crash_shrink_memory(&crashk_res, cnt);
>  	return ret < 0 ? ret : count;
>  }
>  KERNEL_ATTR_RW(kexec_crash_size);
> @@ -218,6 +238,7 @@ static struct attribute * kernel_attrs[] = {
>  #ifdef CONFIG_KEXEC_CORE
>  	&kexec_loaded_attr.attr,
>  	&kexec_crash_loaded_attr.attr,
> +	&kexec_crash_low_size_attr.attr,
>  	&kexec_crash_size_attr.attr,
>  	&vmcoreinfo_attr.attr,
>  #endif
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
