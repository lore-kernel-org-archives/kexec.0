Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo1T2-0007zi-KL
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 01:41:33 +0000
Date: Wed, 4 Dec 2013 09:41:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 6/6] kexec: Support for Kexec on panic using new system
 call
Message-ID: <20131204014105.GB3298@localhost.localdomain>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-7-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384969851-7251-7-git-send-email-vgoyal@redhat.com>
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
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On 11/20/13 at 12:50pm, Vivek Goyal wrote:
> This patch adds support for loading a kexec on panic (kdump) kernel usning
> new system call.
> +int load_crashdump_segments(struct kimage *image)
> +{
> +	unsigned long src_start, src_sz;
> +	unsigned long elf_addr, elf_sz;
> +	int ret;
> +
> +	/*
> +	 * Determine and load a segment for backup area. First 640K RAM
> +	 * region is backup source
> +	 */
> +
> +	ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> +				image, determine_backup_region);
> +
> +	/* Zero of postive return values are ok */
                ^
Here I guess it is "or".

> +	if (ret < 0)
> +		return ret;
> +
> +	src_start = image->arch.backup_src_start;
> +	src_sz = image->arch.backup_src_sz;
> +
> +	/* Add backup segment. */
> +	if (src_sz) {
> +		ret = kexec_add_buffer(image, __va(src_start), src_sz, src_sz,
> +					PAGE_SIZE, 0, -1, 0,
> +					&image->arch.backup_load_addr);
> +		if (ret)
> +			return ret;
> +	}
> +


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
