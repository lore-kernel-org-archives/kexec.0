Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHl5J-0003wG-Dc
 for kexec@lists.infradead.org; Thu, 14 Aug 2014 02:48:13 +0000
Date: Thu, 14 Aug 2014 10:46:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Provide an option to use new kexec system call
Message-ID: <20140814024629.GA12702@dhcp-16-105.nay.redhat.com>
References: <20140813150602.GA1062@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140813150602.GA1062@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On 08/13/14 at 11:06am, Vivek Goyal wrote:
> +/* New file based kexec system call related code */
> +static int do_kexec_file_load(int fileind, int argc, char **argv,
> +			unsigned long flags) {
> +
> +	char *kernel;

........

> +	kernel_fd = open(kernel, O_RDONLY);
> +	if (kernel_fd == -1) {
> +		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
> +				strerror(errno));
> +		return -1;
> +	}
> +
> +	/* slurp in the input kernel */
> +	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
> +
> +	for (i = 0; i < file_types; i++) {
> +		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
> +			break;
> +	}
> +
> +	if (i == file_types) {
> +		fprintf(stderr, "Cannot determine the file type " "of %s\n",
> +				kernel);
> +		return -1;
> +	}
> +
> +	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
> +	if (ret < 0) {
> +		fprintf(stderr, "Cannot load %s\n", kernel);
> +		return ret;
> +	}
> +
> +	if (!is_kexec_file_load_implemented()) {

Hi Vivek,

Can we put this check earlier, maybe before kernel file openning? Since
if this syscall is not implemented, we don't have to do the opening or
loading things.

Thanks
Baoquan


> +		fprintf(stderr, "syscall kexec_file_load not available.\n");
> +		return -1;
> +	}
> +
> +	/*
> +	 * If there is no initramfs, set KEXEC_FILE_NO_INITRAMFS flag so that
> +	 * kernel does not return error with negative initrd_fd.
> +	 */
> +	if (info.initrd_fd == -1)
> +		info.kexec_flags |= KEXEC_FILE_NO_INITRAMFS;
> +
> +	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line_len,
> +			info.command_line, info.kexec_flags);
> +	if (ret != 0)
> +		fprintf(stderr, "kexec_file_load failed: %s\n",
> +					strerror(errno));
> +	return ret;
> +}
> +
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
