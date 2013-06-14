Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnZ8q-0006bq-Iw
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 18:54:33 +0000
Date: Fri, 14 Jun 2013 14:54:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 1/5] vmcore: Introduce ELF header in new memory feature
Message-ID: <20130614185401.GL12023@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Jun 07, 2013 at 06:55:57PM +0200, Michael Holzheu wrote:

[..]
> @@ -935,10 +967,17 @@ static int __init vmcore_init(void)
>  {
>  	int rc = 0;
>  
> -	/* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
> -	if (!(is_vmcore_usable()))
> -		return rc;
> +	/*
> +	 * If elfcorehdr= has not been passed in cmdline, try to get the
> +	 * header from 2nd kernel, then capture the dump.
> +	 */
> +	if (!(is_vmcore_usable())) {
> +		rc = elfcorehdr_alloc();
> +		if (rc)
> +			return rc;
> +	}

Hi Michael,

Patch description says that elfcorehdr_alloc() returns the addr and 
size of elf headers. But that does not seem to be the case here. Has
it been modified in later patches.

Also will it be better if we call elfcorehdr_alloc() always and then
check for is_vmcore_usable().

Something like.

elfcorehdr_addr = elfcorehdr_alloc()
if (elfcorehdr_addr < )
	return elfcorehdr_addr

if (!(is_vmcore_usable()))
	return error

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
