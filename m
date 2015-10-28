Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrKVX-0000EP-GV
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 06:46:52 +0000
Date: Wed, 28 Oct 2015 14:46:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
 <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
 <20151027133520.30653ba3@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151027133520.30653ba3@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: stefan.roscher@de.ibm.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Hi, Michael

> @@ -552,11 +563,18 @@ char *slurp_file(const char *filename, o
>  		if (err < 0)
>  			die("Can not seek to the begin of file %s: %s\n",
>  					filename, strerror(errno));
> +		buf = slurp_fd(fd, filename, size, &nread, use_mmap);
>  	} else {
>  		size = stats.st_size;
> +		if (use_mmap) {
> +			buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +				   MAP_PRIVATE, fd, 0);
> +			nread = stats.st_size;
> +		} else {
> +			buf = slurp_fd(fd, filename, size, &nread, 0);
> +		}
>  	}

Drop above changes and replace below lines with an extra use_mmap argument
should be enough?

-	buf = slurp_fd(fd, filename, size, &nread);
[snip]

Otherwise I'm fine with the patch.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
