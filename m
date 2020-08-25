Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAXl8-0000jG-Ue
 for kexec@lists.infradead.org; Tue, 25 Aug 2020 12:09:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1598343262-30874-1-git-send-email-tangyouling@loongson.cn>
Date: Tue, 25 Aug 2020 07:04:57 -0500
In-Reply-To: <1598343262-30874-1-git-send-email-tangyouling@loongson.cn>
 (Youling Tang's message of "Tue, 25 Aug 2020 16:14:22 +0800")
Message-ID: <87blizq6c6.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/kexec.c: Add missing fclose()/close() call
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: Khalid Aziz <khalid.aziz@hp.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Hariprasad Nellitheertha <hari@in.ibm.com>, Tim Deegan <tjd21@cl.cam.ac.uk>

Youling Tang <tangyouling@loongson.cn> writes:

> Add missing fclose()/close() call.

The program exits immediately and that exit closes all of the files.
What is the point of adding an explicit close?

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
>  
>  	*r_size = size;
> +	close(fd);
>  	return buf;
>  }
>  
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
