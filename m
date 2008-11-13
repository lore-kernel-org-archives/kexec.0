Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0a7J-0000At-Iu
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 11:12:06 +0000
Message-ID: <491BEE34.6070501@mxs.nes.nec.co.jp>
Date: Thu, 13 Nov 2008 18:07:00 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Claim to support 2.6.27
References: <109842e145d381000c4c.1226482968@hale.suse.de>
In-Reply-To: <109842e145d381000c4c.1226482968@hale.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0562267600=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============0562267600==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> According to the changelog and my tests, 2.6.27 kernel is supported. Express
> that in the LATEST_VERSION check.

Thank your for your tests and your patch.
I also tested makedumpfile on linux-2.6.27 of both i386 and x86_64,
but I have not tested on ia64 yet.
So I want to know the CPU architecture of your machine to fill the
supporting table of makedumpfile's "README" file.


Thanks
Ken'ichi Ohmichi

> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -436,7 +436,7 @@
>  #define KVER_MIN_SHIFT 16
>  #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
>  #define OLDEST_VERSION		(0x0206000f)	/* linux-2.6.15 */
> -#define LATEST_VERSION		(0x0206001a)	/* linux-2.6.26 */
> +#define LATEST_VERSION		(0x0206001b)	/* linux-2.6.27 */
>  #define VERSION_LINUX_2_6_26	(0x0206001a)	/* linux-2.6.26 */
>  #define VERSION_LINUX_2_6_27	(0x0206001b)	/* linux-2.6.27 */
>  
> 




--===============0562267600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0562267600==--
