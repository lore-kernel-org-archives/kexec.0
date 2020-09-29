Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNIMv-0000jE-Nu
 for kexec@lists.infradead.org; Tue, 29 Sep 2020 16:20:46 +0000
Date: Tue, 29 Sep 2020 18:20:42 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm64: Add purgatory printing
Message-ID: <20200929162042.GG7355@vergenet.net>
References: <20200923104802.17964-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923104802.17964-1-matthias.bgg@kernel.org>
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
To: matthias.bgg@kernel.org
Cc: geoff@infradead.org, bhupesh.linux@gmail.com, kexec@lists.infradead.org, Matthias Brugger <mbrugger@suse.com>

On Wed, Sep 23, 2020 at 12:48:02PM +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Add option to allow purgatory printing on arm64 hardware
> by passing the console name which should be used.
> Based on a patch by Geoff Levand.
> 
> Cc: Geoff Levand <geoff@infradead.org>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

...

> +/**
> + * find_purgatory_sink - Find a sink for purgatory output.
> + */
> +
> +static uint64_t find_purgatory_sink(const char *console)
> +{
> +	int fd, ret;
> +	char device[255], mem[255];
> +	struct stat sb;
> +	char buffer[10];
> +	uint64_t iomem = 0x0;
> +
> +	if (!console)
> +		return 0;
> +
> +	snprintf(device, sizeof(device), "/sys/class/tty/%s", console);
> +	if (stat(device, &sb) || !S_ISDIR(sb.st_mode)) {
> +		fprintf(stderr, "kexec: %s: No valid console found for %s\n",
> +			__func__, device);
> +		return 0;
> +	}

As per "[PATCH] kexec: Fix snprintf related compilation warning",
I think we should be checking the output of snprintf.

> +
> +	snprintf(mem, sizeof(mem), "%s%s", device, "/iomem_base");
> +	printf("console memory read from %s\n", mem);
> +
> +	fd = open(mem, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "kexec: %s: No able to open %s\n",
> +			__func__, mem);
> +		return 0;
> +	}

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
