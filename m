Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i0ioK-0002M4-0r
 for kexec@lists.infradead.org; Thu, 22 Aug 2019 08:51:15 +0000
Date: Thu, 22 Aug 2019 10:51:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] cleanup: move it back from util_lib/elf_info.c
Message-ID: <20190822085105.yta4wozkfupvp2y3@verge.net.au>
References: <20190815033756.15587-1-lijiang@redhat.com>
 <20190815033756.15587-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190815033756.15587-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: kasong@redhat.com, piliu@redhat.com, bhsharma@redhat.com, kexec@lists.infradead.org, junw99@yahoo.com, bhe@redhat.com, dyoung@redhat.com

Hi Lianbo,

I like where this patch is going but I would like to request a few changes.
Please see comments inline.

On Thu, Aug 15, 2019 at 11:37:55AM +0800, Lianbo Jiang wrote:
> Some code related to vmcore-dmesg.c is put into the util_lib, which
> is not very reasonable, so lets move it back and tidy up those code.
> 
> In addition, that will also help to limit the size of vmcore-dmesg.txt.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kexec/arch/arm64/kexec-arm64.c |  2 +-
>  util_lib/elf_info.c            | 73 ++++++++--------------------------
>  util_lib/include/elf_info.h    |  8 +++-
>  vmcore-dmesg/vmcore-dmesg.c    | 44 +++++++++++++++++---
>  4 files changed, 61 insertions(+), 66 deletions(-)
> 
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index eb3a3a37307c..6ad3b0a134b3 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -889,7 +889,7 @@ int get_phys_base_from_pt_load(unsigned long *phys_offset)
>  		return EFAILED;
>  	}
>  
> -	read_elf_kcore(fd);
> +	read_elf(fd);
>  
>  	for (i = 0; get_pt_load(i,
>  		    &phys_start, NULL, &virt_start, NULL);
> diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
> index 90a3b21662e7..2f254e972721 100644
> --- a/util_lib/elf_info.c
> +++ b/util_lib/elf_info.c
> @@ -20,7 +20,6 @@
>  /* The 32bit and 64bit note headers make it clear we don't care */
>  typedef Elf32_Nhdr Elf_Nhdr;
>  
> -static const char *fname;
>  static Elf64_Ehdr ehdr;
>  static Elf64_Phdr *phdr;
>  static int num_pt_loads;
> @@ -120,8 +119,8 @@ void read_elf32(int fd)
>  
>  	ret = pread(fd, &ehdr32, sizeof(ehdr32), 0);
>  	if (ret != sizeof(ehdr32)) {
> -		fprintf(stderr, "Read of Elf header from %s failed: %s\n",
> -			fname, strerror(errno));
> +		fprintf(stderr, "Read of Elf header failed in %s: %s\n",
> +				__func__, strerror(errno));

I'm not sure of the merit of changing the loging output.
And moreover I don't think it belongs in this patch
as it doesn't seem related to the other changes.

>  		exit(10);
>  	}
>  
> @@ -193,8 +192,8 @@ void read_elf64(int fd)
>  
>  	ret = pread(fd, &ehdr64, sizeof(ehdr64), 0);
>  	if (ret < 0 || (size_t)ret != sizeof(ehdr)) {
> -		fprintf(stderr, "Read of Elf header from %s failed: %s\n",
> -			fname, strerror(errno));
> +		fprintf(stderr, "Read of Elf header failed in %s: %s\n",
> +				__func__, strerror(errno));
>  		exit(10);
>  	}
>  
> @@ -531,19 +530,7 @@ static int32_t read_file_s32(int fd, uint64_t addr)
>  	return read_file_u32(fd, addr);
>  }
>  
> -static void write_to_stdout(char *buf, unsigned int nr)
> -{
> -	ssize_t ret;
> -
> -	ret = write(STDOUT_FILENO, buf, nr);
> -	if (ret != nr) {
> -		fprintf(stderr, "Failed to write out the dmesg log buffer!:"
> -			" %s\n", strerror(errno));
> -		exit(54);
> -	}
> -}
> -
> -static void dump_dmesg_legacy(int fd)
> +void dump_dmesg_legacy(int fd, handler_t handler)
>  {
>  	uint64_t log_buf, log_buf_offset;
>  	unsigned log_end, logged_chars, log_end_wrapped;
> @@ -604,7 +591,7 @@ static void dump_dmesg_legacy(int fd)
>  	 */
>  	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
>  
> -	write_to_stdout(buf + (log_buf_len - logged_chars), logged_chars);
> +	handler(buf + (log_buf_len - logged_chars), logged_chars);
>  }
>  
>  static inline uint16_t struct_val_u16(char *ptr, unsigned int offset)
> @@ -623,7 +610,7 @@ static inline uint64_t struct_val_u64(char *ptr, unsigned int offset)
>  }
>  
>  /* Read headers of log records and dump accordingly */
> -static void dump_dmesg_structured(int fd)
> +void dump_dmesg_structured(int fd, handler_t handler)
>  {
>  #define OUT_BUF_SIZE	4096
>  	uint64_t log_buf, log_buf_offset, ts_nsec;
> @@ -733,7 +720,7 @@ static void dump_dmesg_structured(int fd)
>  				out_buf[len++] = c;
>  
>  			if (len >= OUT_BUF_SIZE - 64) {
> -				write_to_stdout(out_buf, len);
> +				handler(out_buf, len);
>  				len = 0;
>  			}
>  		}
> @@ -753,25 +740,24 @@ static void dump_dmesg_structured(int fd)
>  	}
>  	free(buf);
>  	if (len)
> -		write_to_stdout(out_buf, len);
> +		handler(out_buf, len);
>  }
>  
> -static void dump_dmesg(int fd)
> +int check_log_first_idx_vaddr(void)
>  {
>  	if (log_first_idx_vaddr)
> -		dump_dmesg_structured(fd);
> -	else
> -		dump_dmesg_legacy(fd);
> +		return 1;
> +
> +	return 0;
>  }
>  
> -static int read_elf(int fd)
> +int read_elf(int fd)
>  {
>  	int ret;
>  
>  	ret = pread(fd, ehdr.e_ident, EI_NIDENT, 0);
>  	if (ret != EI_NIDENT) {
> -		fprintf(stderr, "Read of e_ident from %s failed: %s\n",
> -			fname, strerror(errno));
> +		fprintf(stderr, "Read of e_ident failed: %s\n", strerror(errno));
>  		return 3;
>  	}
>  	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0) {
> @@ -808,40 +794,13 @@ static int read_elf(int fd)
>  	return 0;
>  }
>  
> -int read_elf_vmcore(int fd)
> -{
> -	int ret;
> -
> -	ret = read_elf(fd);
> -	if (ret > 0) {
> -		fprintf(stderr, "Unable to read ELF information"
> -			" from vmcore\n");
> -		return ret;
> -	}
> -
> -	dump_dmesg(fd);
> -
> -	return 0;
> -}
> -
> -int read_elf_kcore(int fd)
> -{
> -	int ret;
> -
> -	ret = read_elf(fd);
> -	if (ret != 0)
> -		return ret;
> -
> -	return 0;
> -}

I think that removing read_elf_kcore is not related to the rest of this
patch and should be in a separate patch - it is a nice cleanup.

> -
>  int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
>  {
>  	int ret;
>  
>  	*phys_off = UINT64_MAX;
>  
> -	ret = read_elf_kcore(fd);
> +	ret = read_elf(fd);
>  	if (!ret) {
>  		/* If we have a valid 'PHYS_OFFSET' by now,
>  		 * return it to the caller now.
> diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
> index 1a4debd2d4ba..8ee7d3e2763f 100644
> --- a/util_lib/include/elf_info.h
> +++ b/util_lib/include/elf_info.h
> @@ -23,13 +23,17 @@
>  #include <inttypes.h>
>  #include <ctype.h>
>  
> +typedef void (*handler_t)(char *msg, unsigned int bytes);

I would prefer it if we did not add new typedefs.

> +
>  int get_pt_load(int idx,
>  	unsigned long long *phys_start,
>  	unsigned long long *phys_end,
>  	unsigned long long *virt_start,
>  	unsigned long long *virt_end);
>  int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off);
> -int read_elf_kcore(int fd);
> -int read_elf_vmcore(int fd);
> +int check_log_first_idx_vaddr(void);
> +void dump_dmesg_structured(int fd, handler_t handler);
> +void dump_dmesg_legacy(int fd, handler_t handler);
> +int read_elf(int fd);
>  
>  #endif /* ELF_INFO_H */
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index 7a386b380291..ff0d540c9130 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -1,21 +1,53 @@
>  #include <elf_info.h>
>  
> -/* The 32bit and 64bit note headers make it clear we don't care */
> -typedef Elf32_Nhdr Elf_Nhdr;
> +static void write_to_stdout(char *buf, unsigned int nr)
> +{
> +	ssize_t ret;
> +
> +	ret = write(STDOUT_FILENO, buf, nr);
> +	if (ret != nr) {
> +		fprintf(stderr, "Failed to write out the dmesg log buffer!:"
> +				" %s\n", strerror(errno));
> +		exit(54);
> +	}
> +}
> +
> +static void dump_dmesg(int fd, handler_t handler)
> +{
> +	if (check_log_first_idx_vaddr())
> +		dump_dmesg_structured(fd, handler);
> +	else
> +		dump_dmesg_legacy(fd, handler);
> +}

I think that dump_dmesg() could stay in kexec-arm64.c,
it does not seem specific to vmcore handling.

> -static const char *fname;
> +static int read_vmcore_dmesg(int fd)
> +{
> +        int ret;
> +
> +        ret = read_elf(fd);
> +        if (ret > 0) {
> +                fprintf(stderr, "Unable to read ELF information"
> +                        " from vmcore\n");
> +                return ret;
> +        }
> +
> +        dump_dmesg(fd, write_to_stdout);
> +
> +        return 0;
> +}
>  
>  int main(int argc, char **argv)
>  {
>  	ssize_t ret;
>  	int fd;
> +	const char *fname;
>  
>  	if (argc != 2) {
>  		fprintf(stderr, "usage: %s <kernel core file>\n", argv[0]);
>  		return 1;
>  	}
> -	fname = argv[1];
>  
> +	fname = argv[1];
>  	fd = open(fname, O_RDONLY);
>  	if (fd < 0) {
>  		fprintf(stderr, "Cannot open %s: %s\n",
> @@ -23,8 +55,8 @@ int main(int argc, char **argv)
>  		return 2;
>  	}
>  
> -	ret = read_elf_vmcore(fd);
> -	
> +	ret = read_vmcore_dmesg(fd);
> +
>  	close(fd);
>  
>  	return ret;
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
