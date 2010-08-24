Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OniE4-0000P5-S3
	for kexec@lists.infradead.org; Tue, 24 Aug 2010 01:22:57 +0000
Date: Tue, 24 Aug 2010 10:22:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: extend KCORE_ELF_HEADERS_SIZE for large memory
Message-ID: <20100824012246.GA16675@verge.net.au>
References: <E1OneP7-0008Vq-K8@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1OneP7-0008Vq-K8@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Mon, Aug 23, 2010 at 04:18:05PM -0500, Cliff Wickman wrote:
> 
> A customer has seen the kexec command exhaust its buffer for the ELF headers
> from /proc/kcore.  It found 147 program headers, which requires a buffer of
> over 8k.
> (This overflow was on an SGI UV with an extremely large memory, hence
>  many ram ranges.)
> The default buffer size of 4k is configured in KCORE_ELF_HEADERS_SIZE.
> 
> The easy solution would probably be to increase the buffer to 16k.
> That is room for 291 entries, on x86_64.
> 
> You might want to make the command dynamically enlarge the buffer when
> it is found to be too small, but I don't think this command's use of a
> little more memory is of concern.  So there is probably no reason to
> change the program logic in this area.

Thanks Cliff,

applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
