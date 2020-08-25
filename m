Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout.easymail.ca ([64.68.200.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAaHt-0001w3-VO
 for kexec@lists.infradead.org; Tue, 25 Aug 2020 14:51:02 +0000
Subject: Re: [PATCH] kexec/kexec.c: Add missing fclose()/close() call
References: <1598343262-30874-1-git-send-email-tangyouling@loongson.cn>
From: Khalid Aziz and Shuah Khan <azizkhan@gonehiking.org>
Message-ID: <e00de2f7-1e2d-65b9-c198-7a94c2f10f2b@gonehiking.org>
Date: Tue, 25 Aug 2020 08:50:50 -0600
MIME-Version: 1.0
In-Reply-To: <1598343262-30874-1-git-send-email-tangyouling@loongson.cn>
Content-Language: en-US
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
To: Youling Tang <tangyouling@loongson.cn>, Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@hp.com>, Hariprasad Nellitheertha <hari@in.ibm.com>, Tim Deegan <tjd21@cl.cam.ac.uk>
Cc: kexec@lists.infradead.org

As Eric pointed out, not all of these make sense. I have flagged the
ones that makes sense below.

On 8/25/20 2:14 AM, Youling Tang wrote:
> Add missing fclose()/close() call.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kexec/kexec.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index a62b362..f970b13 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -542,6 +542,7 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
>  	}
>  	result = fstat(fd, &stats);
>  	if (result < 0) {
> +		close(fd);
>  		die("Cannot stat: %s: %s\n",
>  			filename, strerror(errno));
>  	}
> @@ -553,20 +554,26 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
>  	if (S_ISCHR(stats.st_mode)) {
>  
>  		size = lseek(fd, 0, SEEK_END);
> -		if (size < 0)
> +		if (size < 0) {
> +			close(fd);
>  			die("Can not seek file %s: %s\n", filename,
>  					strerror(errno));
> +		}
>  
>  		err = lseek(fd, 0, SEEK_SET);
> -		if (err < 0)
> +		if (err < 0) {
> +			close(fd);
>  			die("Can not seek to the begin of file %s: %s\n",
>  					filename, strerror(errno));
> +		}
>  		buf = slurp_fd(fd, filename, size, &nread);
>  	} else if (S_ISBLK(stats.st_mode)) {
>  		err = ioctl(fd, BLKGETSIZE64, &size);
> -		if (err < 0)
> +		if (err < 0) {
> +			close(fd);
>  			die("Can't retrieve size of block device %s: %s\n",
>  				filename, strerror(errno));
> +		}
>  		buf = slurp_fd(fd, filename, size, &nread);
>  	} else {
>  		size = stats.st_size;
> @@ -578,13 +585,18 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
>  			buf = slurp_fd(fd, filename, size, &nread);
>  		}
>  	}
> -	if ((use_mmap && (buf == MAP_FAILED)) || (!use_mmap && (buf == NULL)))
> +	if ((use_mmap && (buf == MAP_FAILED)) || (!use_mmap && (buf == NULL))) {
> +		close(fd);
>  		die("Cannot read %s", filename);
> +	}
>  
> -	if (nread != size)
> +	if (nread != size) {
> +		close(fd);
>  		die("Read on %s ended before stat said it should\n", filename);
> +	}

Above changes do not serve any purpose.

>  
>  	*r_size = size;
> +	close(fd);
>  	return buf;
>  }
>  

This one is good.

> @@ -1131,8 +1143,10 @@ char *get_command_line(void)
>  	if (!fp)
>  		die("Could not open /proc/cmdline.");
>  
> -	if (fgets(line, sizeof_line, fp) == NULL)
> +	if (fgets(line, sizeof_line, fp) == NULL) {
> +		fclose(fp);
>  		die("Can't read /proc/cmdline.");
> +	}
>  
>  	fclose(fp);
>  

This is unnecessary.

> @@ -1257,12 +1271,14 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  	if (i == file_types) {
>  		fprintf(stderr, "Cannot determine the file type " "of %s\n",
>  				kernel);
> +		close(kernel_fd);
>  		return EFAILED;
>  	}
>  
>  	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
>  	if (ret < 0) {
>  		fprintf(stderr, "Cannot load %s\n", kernel);
> +		close(kernel_fd);
>  		return ret;
>  	}
>  
> 

These are good.

--
Khalid


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
