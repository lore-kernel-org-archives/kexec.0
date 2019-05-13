Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQ093-0006mJ-MR
 for kexec@lists.infradead.org; Mon, 13 May 2019 01:52:51 +0000
Date: Mon, 13 May 2019 09:52:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
Message-ID: <20190513015241.GA8515@dhcp-128-65.nay.redhat.com>
References: <20190510102051.25647-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190510102051.25647-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, Ganesh Goudar <ganeshgr@chelsio.com>

On 05/10/19 at 06:20pm, Kairui Song wrote:
> Device dump allow drivers to add device related dump data to vmcore as
> they want. This have a potential issue, the data is stored in memory,
> drivers may append too much data and use too much memory. The vmcore is
> typically used in a kdump kernel which runs in a pre-reserved small
> chunk of memory. So as a result it will make kdump unusable at all due
> to OOM issues.
> 
> So introduce new device_dump_limit= kernel parameter, and set the
> default limit to 0, so device dump is not enabled unless user specify
> the accetable maxiam memory usage for device dump data. In this way user
> will also have the chance to adjust the kdump reserved memory
> accordingly.

The device dump is only affective in kdump 2nd kernel, so add the
limitation seems not useful.  One is hard to know the correct size
unless one does some crash test.  If one did the test and want to eanble
the device dump he needs increase crashkernel= size in 1st kernel and
add the limit param in 2nd kernel.

So a global on/off param sounds easier and better, something like
vmcore_device_dump=on  (default is off) 

> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  fs/proc/vmcore.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..e28695ef2439 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
>  static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +/* Device Dump Limit */
> +static size_t vmcoredd_limit;
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Device Dump Size */
> @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
>  			    PAGE_SIZE);
>  
> +	if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
>  	/* Allocate buffer for driver's to write their dumps */
>  	buf = vmcore_alloc_buf(data_size);
>  	if (!buf) {
> @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return ret;
>  }
>  EXPORT_SYMBOL(vmcore_add_device_dump);
> +
> +static int __init parse_vmcoredd_limit(char *arg)
> +{
> +	char *end;
> +
> +	if (!arg)
> +		return -EINVAL;
> +	vmcoredd_limit = memparse(arg, &end);
> +	return end > arg ? 0 : -EINVAL;
> +
> +}
> +__setup("device_dump_limit=", parse_vmcoredd_limit);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Free all dumps in vmcore device dump list */
> -- 
> 2.20.1
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
