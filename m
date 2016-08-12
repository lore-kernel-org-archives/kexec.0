Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bYKG4-0001dH-NL
 for kexec@lists.infradead.org; Fri, 12 Aug 2016 21:44:53 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7CLfjH7020796
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 17:44:29 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj8xj5c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 17:44:29 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 18:44:26 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] kexec: extend kexec_file_load system call
Date: Fri, 12 Aug 2016 18:44:16 -0300
In-Reply-To: <20160812081739.GB22218@350D>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160812081739.GB22218@350D>
MIME-Version: 1.0
Message-Id: <1606244.4vNzhVNUBR@hactar>
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
To: bsingharora@gmail.com
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, AKASHI Takahiro <takahiro.akashi@linaro.org>, David Laight <David.Laight@aculab.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Hello Balbir,

Thank you for the review!

Am Freitag, 12 August 2016, 18:17:39 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:03:58PM -0300, Thiago Jung Bauermann wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3523bf62f328..847d9c31f428 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2656,6 +2656,7 @@ extern int do_pipe_flags(int *, int);
> > 
> >  	id(MODULE, kernel-module)		\
> >  	id(KEXEC_IMAGE, kexec-image)		\
> >  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> > 
> > +	id(KEXEC_PARTIAL_DTB, kexec-partial-dtb)		\
> 
> The backspace is over-indented?

Indeed, I'll fix that. But to keep it aligned with the other backslashes, 
there would be no spaces between it and the final closing parenthesis. 
Either that, or reindent the other backslashes one more level. I think I 
prefer the former.
 
> > @@ -160,6 +180,55 @@ kimage_file_prepare_segments(struct kimage *image,
> > int kernel_fd, int initrd_fd,> 
> >  		image->initrd_buf_len = size;
> >  	
> >  	}
> > 
> > +	if (flags & KEXEC_FILE_EXTRA_FDS) {
> > +		int nr_fds, i;
> > +		size_t fdset_size;
> > +		char fdset_buf[MAX_FDSET_SIZE];
> 
> Do we really want this on the stack?  I presume the size is not large

It has 132 bytes. Would it be better to use kmalloc instead?

> > +		struct kexec_fdset *fdset = (struct kexec_fdset *) 
fdset_buf;
> > +
> > +		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
> > +		if (ret) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +
> > +		if (nr_fds > KEXEC_SEGMENT_MAX) {
> 
> We need an nr_fds < 0 check as well

Indeed, I forgot to do that. I will add the check.

> > +			ret = -E2BIG;
> > +			goto out;
> > +		}
> > +
> > +		fdset_size = sizeof(struct kexec_fdset)
> > +				+ nr_fds * sizeof(struct kexec_file_fd);
> > +
> > +		ret = copy_from_user(fdset, ufdset, fdset_size);
> 
> Can the user change nr_fds between the two copy_from_users, ideally not,
> but we should validate it.

Good catch. I'll check if nr_fds == fdset->nr_fds and return with an error 
if they're different.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
