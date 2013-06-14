Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnZUt-00073F-C7
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 19:17:20 +0000
Date: Fri, 14 Jun 2013 15:16:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 2/5] s390/vmcore: Use ELF header in new memory feature
Message-ID: <20130614191649.GN12023@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-3-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1370624161-2298-3-git-send-email-holzheu@linux.vnet.ibm.com>
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

On Fri, Jun 07, 2013 at 06:55:58PM +0200, Michael Holzheu wrote:

[..]
>  /*
> - * Create kdump ELF core header in new kernel, if it has not been passed via
> - * the "elfcorehdr" kernel parameter
> + * Free ELF core header (new kernel)
>   */
> -static int setup_kdump_elfcorehdr(void)
> +void elfcorehdr_free(void)
>  {

I was hoping that we will pass the value returned by elfcorehdr_alloc()
here. Something along the lines of kmalloc() and kfree().

elfcorehdr_addr = elfcorhdr_alloc();
...
...
elfcorhdr_free(elfcorhdr_addr);

Only odd part here is that arch will not set elfcorehdr_addr=NULL as there
are functions like is_kdump_kernel() which depend on it being set.

That might be a separate cleanup thought and we can put a comment after
elfcorhdr_free() and explain that oddity.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
