Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zrz2p-0003E1-78
 for kexec@lists.infradead.org; Fri, 30 Oct 2015 02:03:56 +0000
Date: Fri, 30 Oct 2015 10:03:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151030020322.GA18800@dhcp-128-73.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
 <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
 <20151027133520.30653ba3@holzheu>
 <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
 <20151028105721.4ada142d@holzheu>
 <20151029063710.GE21927@dhcp-129-115.nay.redhat.com>
 <20151029162612.14e68bdc@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151029162612.14e68bdc@holzheu>
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

Hi,

On 10/29/15 at 04:26pm, Michael Holzheu wrote:
> On Thu, 29 Oct 2015 14:37:10 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 10/28/15 at 10:57am, Michael Holzheu wrote:
> > > On Wed, 28 Oct 2015 14:46:23 +0800
> > > Dave Young <dyoung@redhat.com> wrote:
> > > 
> > > > Hi, Michael
> > > > 
> > > > > @@ -552,11 +563,18 @@ char *slurp_file(const char *filename, o
> > > > >  		if (err < 0)
> > > > >  			die("Can not seek to the begin of file %s: %s\n",
> > > > >  					filename, strerror(errno));
> > > > > +		buf = slurp_fd(fd, filename, size, &nread, use_mmap);
> > > > >  	} else {
> > > > >  		size = stats.st_size;
> > > > > +		if (use_mmap) {
> > > > > +			buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
> > > > > +				   MAP_PRIVATE, fd, 0);
> > > > > +			nread = stats.st_size;
> > > > > +		} else {
> > > > > +			buf = slurp_fd(fd, filename, size, &nread, 0);
> > > > > +		}
> > > > >  	}
> > > > 
> > > > Drop above changes and replace below lines with an extra use_mmap argument
> > > > should be enough?
> > > > 
> > > > -	buf = slurp_fd(fd, filename, size, &nread);
> > > > [snip]
> > > 
> > > Hmm, I don't think so.
> > > 
> > > In case of non-character devices I either mmap the file directly (use_mmap=true)
> > > or use "slurp_fd()" (use_mmap=false). So I can't unconditionaly use slurp_fd().
> > 
> > How about handle these in slurp_fd only? Directly return mmapped buf in case
> > use_mmap=1 there. I do not understand why use_mmap=1 but you still call read
> > syscall to read data into the mmapped buffer..
> 
> For the character device case (S_ISCHR(stats.st_mode)) we have to use
> the read() syscall path. With my patch I wanted to ensure that when calling
> slurp_file_mmap() we always return mmaped storage.

I understand it now. But it looks odd in code..

> Otherwise slurp_file_mmap() would return mmaped storage for files
> and malloced memory for character devices.
> 
> As already noted this is only to be consistent and is not really required
> for our use case.
> 
> So would you prefer the patch below?

Two nitpicks see the comments inline, otherwise I think it is much better to me.

> 
> Michael
> ---
>  kexec/arch/s390/kexec-image.c |    2 +-
>  kexec/kexec.c                 |   24 +++++++++++++++++++++---
>  kexec/kexec.h                 |    1 +
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -101,7 +101,7 @@ image_s390_load(int argc, char **argv, c
>  	 * we load the ramdisk directly behind the image with 1 MiB alignment.
>  	 */
>  	if (ramdisk) {
> -		rd_buffer = slurp_file(ramdisk, &ramdisk_len);
> +		rd_buffer = slurp_file_mmap(ramdisk, &ramdisk_len);
>  		if (rd_buffer == NULL) {
>  			fprintf(stderr, "Could not read ramdisk.\n");
>  			return -1;
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -29,6 +29,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/reboot.h>
> +#include <sys/mman.h>
>  #include <unistd.h>
>  #include <fcntl.h>
>  #ifndef _O_BINARY
> @@ -514,7 +515,8 @@ static char *slurp_fd(int fd, const char
>  	return buf;
>  }
>  
> -char *slurp_file(const char *filename, off_t *r_size)
> +static char *slurp_file_generic(const char *filename, off_t *r_size,
> +				int use_mmap)

Add a function comment about the argument use_mmap so that one knows
that it will be not used for character devices?

>  {
>  	int fd;
>  	char *buf;
> @@ -552,11 +554,17 @@ char *slurp_file(const char *filename, o
>  		if (err < 0)
>  			die("Can not seek to the begin of file %s: %s\n",
>  					filename, strerror(errno));
> +		buf = slurp_fd(fd, filename, size, &nread);
>  	} else {
>  		size = stats.st_size;
> +		if (use_mmap) {
> +			buf = mmap(NULL, size, PROT_READ|PROT_WRITE,
> +				   MAP_PRIVATE, fd, 0);

Probably map it as readonly is enough.

> +			nread = size;
> +		} else {
> +			buf = slurp_fd(fd, filename, size, &nread);
> +		}
>  	}
> -
> -	buf = slurp_fd(fd, filename, size, &nread);
>  	if (!buf)
>  		die("Cannot read %s", filename);
>  
> @@ -567,6 +575,16 @@ char *slurp_file(const char *filename, o
>  	return buf;
>  }
>  
> +char *slurp_file(const char *filename, off_t *r_size)
> +{
> +	return slurp_file_generic(filename, r_size, 0);
> +}
> +
> +char *slurp_file_mmap(const char *filename, off_t *r_size)
> +{
> +	return slurp_file_generic(filename, r_size, 1);
> +}
> +
>  /* This functions reads either specified number of bytes from the file or
>     lesser if EOF is met. */
>  
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -253,6 +253,7 @@ extern void die(const char *fmt, ...)
>  extern void *xmalloc(size_t size);
>  extern void *xrealloc(void *ptr, size_t size);
>  extern char *slurp_file(const char *filename, off_t *r_size);
> +extern char *slurp_file_mmap(const char *filename, off_t *r_size);
>  extern char *slurp_file_len(const char *filename, off_t size, off_t *nread);
>  extern char *slurp_decompress_file(const char *filename, off_t *r_size);
>  extern unsigned long virt_to_phys(unsigned long addr);
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
