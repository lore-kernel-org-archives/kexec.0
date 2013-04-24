Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUodS-0006kl-Gr
 for kexec@lists.infradead.org; Wed, 24 Apr 2013 01:36:40 +0000
Date: Wed, 24 Apr 2013 10:33:34 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: Check dump file early
Message-Id: <20130424103334.1919f09a5a2e3ac360cad3dc@mxc.nes.nec.co.jp>
In-Reply-To: <20130422111117.00c1ecef@holzheu>
References: <20130419173644.4c24dead@holzheu> <51747DD3.8000104@jp.fujitsu.com>
 <20130422111117.00c1ecef@holzheu>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Hello Michael,

On Mon, 22 Apr 2013 11:11:17 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Mon, 22 Apr 2013 09:01:23 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > > +	if (info->flag_force) {
> > > +		if (access(path, W_OK) == 0)
> > > +			return TRUE; /* We have write permission */
> > > +		err_str = strerror(errno);
> > > +	} else {
> > > +		err_str = "File exists";
> > 
> > How about strerror(EEXIST)? It's better to avoid hard code to use the 
> > same string as what libc returns.
> 
> Yes, this solution is better.
> 
> Here the updated patch:

Nice work!
I'll merge this patch into v1.5.4.


Thanks
Atsushi Kumagai

> ---
>  makedumpfile.c |   37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -730,6 +730,24 @@ open_dump_file(void)
>  }
>  
>  int
> +check_dump_file(const char *path)
> +{
> +	char *err_str;
> +
> +	if (access(path, F_OK) != 0)
> +		return TRUE; /* File does not exist */
> +	if (info->flag_force) {
> +		if (access(path, W_OK) == 0)
> +			return TRUE; /* We have write permission */
> +		err_str = strerror(errno);
> +	} else {
> +		err_str = strerror(EEXIST);
> +	}
> +	ERRMSG("Can't open the dump file (%s). %s\n", path, err_str);
> +	return FALSE;
> +}
> +
> +int
>  open_dump_bitmap(void)
>  {
>  	int i, fd;
> @@ -8609,6 +8627,9 @@ main(int argc, char *argv[])
>  			MSG("Try `makedumpfile --help' for more information.\n");
>  			goto out;
>  		}
> +		if (!check_dump_file(info->name_dumpfile))
> +			goto out;
> +
>  		if (!open_files_for_rearranging_dumpdata())
>  			goto out;
>  
> @@ -8626,9 +8647,11 @@ main(int argc, char *argv[])
>  			MSG("Try `makedumpfile --help' for more information.\n");
>  			goto out;
>  		}
> -		if (!reassemble_dumpfile())
> +		if (!check_dump_file(info->name_dumpfile))
>  			goto out;
>  
> +		if (!reassemble_dumpfile())
> +			goto out;
>  		MSG("\n");
>  		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
>  	} else if (info->flag_dmesg) {
> @@ -8637,6 +8660,8 @@ main(int argc, char *argv[])
>  			MSG("Try `makedumpfile --help' for more information.\n");
>  			goto out;
>  		}
> +		if (!check_dump_file(info->name_dumpfile))
> +			goto out;
>  		if (!dump_dmesg())
>  			goto out;
>  
> @@ -8648,6 +8673,16 @@ main(int argc, char *argv[])
>  			MSG("Try `makedumpfile --help' for more information.\n");
>  			goto out;
>  		}
> +		if (info->flag_split) {
> +			for (i = 0; i < info->num_dumpfile; i++) {
> +				if (!check_dump_file(SPLITTING_DUMPFILE(i)))
> +					goto out;
> +			}
> +		} else {
> +			if (!check_dump_file(info->name_dumpfile))
> +				goto out;
> +		}
> +
>  		if (!create_dumpfile())
>  			goto out;
>  
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
