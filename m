Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaTgz-0007xJ-VJ
 for kexec@lists.infradead.org; Mon, 29 Feb 2016 19:41:18 +0000
Date: Mon, 29 Feb 2016 20:40:51 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: When reading partial ELF pages, check
 final pointer against buffer end
Message-ID: <20160229204051.2f4d238d@hananiah.suse.cz>
In-Reply-To: <20160229195952.47c1738b@hananiah.suse.cz>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210085009.4df4d14d@hananiah.suse.cz>
 <20160229195514.335108c9@hananiah.suse.cz>
 <20160229195952.47c1738b@hananiah.suse.cz>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Ivan Delalande <colona@arista.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi again,

On Mon, 29 Feb 2016 19:59:52 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> If the last part of a page is not present in the ELF file, it should
> be replaced with zeroes. However, the check is incorrect.

While this fix is correct, it seems there are a few more errors in the
logic. I found this issues while adapting the code for libkdumpfile
(https://github.com/ptesarik/libkdumpfile). This project includes a
test suite, so let's postpone fixing the code in makedumpfile until I'm
done with writing a good set of tests for this other project and making
sure that all of them pass.

Stay tuned,
Petr Tesarik

> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 867b953..138ddec 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -691,7 +691,7 @@ readpage_elf(unsigned long long paddr, void
> *bufptr) ERRMSG("Attempt to read non-existent page at 0x%llx.\n",
>  		       paddr);
>  		return FALSE;
> -	} else if (p < bufptr)
> +	} else if (p < endp)
>  		memset(p, 0, endp - p);
>  
>  	return TRUE;
> @@ -744,7 +744,7 @@ readpage_elf_parallel(int fd_memory, unsigned
> long long paddr, void *bufptr) ERRMSG("Attempt to read non-existent
> page at 0x%llx.\n", paddr);
>  		return FALSE;
> -	} else if (p < bufptr)
> +	} else if (p < endp)
>  		memset(p, 0, endp - p);
>  
>  	return TRUE;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
