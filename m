Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KpCGH-00060d-CV
	for kexec@lists.infradead.org; Mon, 13 Oct 2008 01:30:17 +0000
MIME-Version: 1.0
Message-ID: <18674.42140.69339.584403@drongo.ozlabs.ibm.com>
Date: Mon, 13 Oct 2008 12:30:04 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Support for relocatable kdump kernel
In-Reply-To: <20081012233420.GA6240@in.ibm.com>
References: <20081012233420.GA6240@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

Mohan Kumar M writes:

> Support for relocatable kdump kernel

> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
>  	beq	9f			/* have already put us at zero */
>  	li	r6,0x100		/* Start offset, the first 0x100 */
>  					/* bytes were copied earlier.	 */
> -#ifdef CONFIG_RELOCATABLE
> +
> +#ifdef CONFIG_CRASH_DUMP

What tree is this patch against?  No tree that I can find has a line
saying "#ifdef CONFIG_RELOCATABLE" at that point.  Or is there a
prerequisite patch that I haven't seen yet?

Paul.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
