Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XJOK4-0007vZ-AH
 for kexec@lists.infradead.org; Mon, 18 Aug 2014 14:54:12 +0000
Date: Mon, 18 Aug 2014 10:53:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: Provide an option to use new kexec system call
Message-ID: <20140818145347.GC4745@redhat.com>
References: <20140813150602.GA1062@redhat.com>
 <20140814024629.GA12702@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140814024629.GA12702@dhcp-16-105.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Thu, Aug 14, 2014 at 10:46:29AM +0800, Baoquan He wrote:
> On 08/13/14 at 11:06am, Vivek Goyal wrote:
> > +/* New file based kexec system call related code */
> > +static int do_kexec_file_load(int fileind, int argc, char **argv,
> > +			unsigned long flags) {
> > +
> > +	char *kernel;
> 
> ........
> 
> > +	kernel_fd = open(kernel, O_RDONLY);
> > +	if (kernel_fd == -1) {
> > +		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
> > +				strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	/* slurp in the input kernel */
> > +	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
> > +
> > +	for (i = 0; i < file_types; i++) {
> > +		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
> > +			break;
> > +	}
> > +
> > +	if (i == file_types) {
> > +		fprintf(stderr, "Cannot determine the file type " "of %s\n",
> > +				kernel);
> > +		return -1;
> > +	}
> > +
> > +	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
> > +	if (ret < 0) {
> > +		fprintf(stderr, "Cannot load %s\n", kernel);
> > +		return ret;
> > +	}
> > +
> > +	if (!is_kexec_file_load_implemented()) {
> 
> Hi Vivek,
> 
> Can we put this check earlier, maybe before kernel file openning? Since
> if this syscall is not implemented, we don't have to do the opening or
> loading things.
> 

Ok, will do it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
