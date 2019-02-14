Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guODM-0005aZ-32
 for kexec@lists.infradead.org; Thu, 14 Feb 2019 21:06:37 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: fix a typo for checking the file pointer
 for null.
Date: Thu, 14 Feb 2019 21:05:39 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0356872C@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC0356869A@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0356869A@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: "Nisha.Parrakat@kpit.com" <Nisha.Parrakat@kpit.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

-----Original Message-----
> From: Nisha Parrakat <nisha.parrakat@kpit.com>
> 
> Description:
> Static code analysis of makedumpfile code shows a mistake in checking
> the validity of a file descripter just attempted to open.
> 
> arch/ppc64.c: fixed the typo that missed checking fpb that was last attempted to open.
> 
> Found during cppcheck on the code.
> 
> Signed-off-by: Nisha Parrakat <Nisha.Parrakat@kpit.com>
> 
> --- a/arch/ppc64.c	2019-01-29 23:08:27.099027763 +0100
> +++ b/arch/ppc64.c	2019-01-29 23:08:58.567379337 +0100
> @@ -623,7 +623,7 @@
>  		return FALSE;
>  	}
>  	fpb = fopen(f_crashbase, "r");
> -	if (!fp) {
> +	if (!fpb) {
>  		ERRMSG("Cannot open %s\n", f_crashbase);
>  		fclose(fp);
>  		return FALSE;
> 

Thanks, applied to the devel branch.

Kazu




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
