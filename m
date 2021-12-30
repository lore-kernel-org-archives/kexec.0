Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
Date: Thu, 30 Dec 2021 18:14:59 +0800
MIME-Version: 1.0
In-Reply-To: <20211228132612.1860-2-thunder.leizhen@huawei.com>
Content-Language: en-US
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen
 Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>


Hi, Dave, Baoquan, Borislav:
  What do you think about the introduction of parse_crashkernel_high_low()? If everyone
doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
patches, see below. If there's any objection, I still strongly recommend removing the
parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().

How about splitting __parse_crashkernel() into two parts? One for parsing
"crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
suffixes in the future. So the parameter requirements are clear at the lowest level.


On 2021/12/28 21:26, Zhen Lei wrote:
> The bootup command line option crashkernel=Y,low is valid only when
> crashkernel=X,high is specified. Putting their parsing into a separate
> function makes the code logic clearer and easier to understand the strong
> dependencies between them.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/crash_core.h |  3 +++
>  kernel/crash_core.c        | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..2d3a64761d18998 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -83,5 +83,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size);
>  
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c900f..8966beaf7c4fd52 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -295,6 +295,41 @@ int __init parse_crashkernel_low(char *cmdline,
>  				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>  }
>  
> +/**
> + * parse_crashkernel_high_low - Parsing "crashkernel=X,high" and possible
> + *				"crashkernel=Y,low".
> + * @cmdline:	The bootup command line.
> + * @high_size:	Save the memory size specified by "crashkernel=X,high".
> + * @low_size:	Save the memory size specified by "crashkernel=Y,low" or "-1"
> + *		if it's not specified.
> + *
> + * Returns 0 on success, else a negative status code.
> + */
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size)
> +{
> +	int ret;
> +	unsigned long long base;
> +
> +	BUG_ON(!high_size || !low_size);
> +
> +	/* crashkernel=X,high */
> +	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	if (ret)
> +		return ret;
> +
> +	if (*high_size <= 0)
> +		return -EINVAL;
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	if (ret)
> +		*low_size = -1;
> +
> +	return 0;
> +}
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
