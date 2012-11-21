Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbCBo-0003Xe-1v
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 15:26:13 +0000
Date: Wed, 21 Nov 2012 09:50:23 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
Message-ID: <20121121145023.GD13114@redhat.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353483098-14883-5-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, Nov 20, 2012 at 11:31:38PM -0800, Yinghai Lu wrote:

[..]
> +int bzImage64_probe(const char *buf, off_t len)
> +{
> +	const struct x86_linux_header *header;
> +	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
> +		if (probe_debug) {
> +			fprintf(stderr, "File is too short to be a bzImage!\n");
> +		}
> +		return -1;
> +	}
> +	header = (const struct x86_linux_header *)buf;
> +	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
> +		if (probe_debug) {
> +			fprintf(stderr, "Not a bzImage\n");
> +		}
> +		return -1;
> +	}
> +	if (header->boot_sector_magic != 0xAA55) {
> +		if (probe_debug) {
> +			fprintf(stderr, "No x86 boot sector present\n");
> +		}
> +		/* No x86 boot sector present */
> +		return -1;
> +	}
> +	if (header->protocol_version < 0x020C) {
> +		if (probe_debug) {
> +			fprintf(stderr, "Must be at least protocol version 2.12\n");
> +		}
> +		/* Must be at least protocol version 2.12 */
> +		return -1;
> +	}
> +	if ((header->loadflags & 1) == 0) {
> +		if (probe_debug) {
> +			fprintf(stderr, "zImage not a bzImage\n");
> +		}
> +		/* Not a bzImage */
> +		return -1;
> +	}
> +	if (!(header->xloadflags & 1)) {
> +		if (probe_debug) {
> +			fprintf(stderr, "Not a bzImage64\n");
> +		}
> +		/* Must be LOADED_ABOVE_4G */
> +		return -1;
> +	}

So how do I force a 16bit or 32bit entry using a bzImage64?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
