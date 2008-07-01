Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDkY7-0005wM-F1
	for kexec@lists.infradead.org; Tue, 01 Jul 2008 18:25:55 +0000
Message-ID: <486A76AF.9080109@wpkg.org>
Date: Tue, 01 Jul 2008 20:25:51 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200807011542.29274.nschichan@freebox.fr>
	<486A6F0D.4070802@wpkg.org>
	<200807012000.40421.nschichan@freebox.fr>
In-Reply-To: <200807012000.40421.nschichan@freebox.fr>
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
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org

Nicolas Schichan schrieb:

(...)

> +	printk("image->start = %lx", image->start);
> +

And this is what happens if I use your "util.c for kexec-userland" - why 
does it use a different address?


# /root/kexec-test/kexec -r
Starting new kernel
image->start = 802520d0Will call new kernel at 802520d0
Bye ...


-- 
Tomasz Chmielewski
http://wpkg.org


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
