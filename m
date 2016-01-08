Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHSfg-0001ON-6C
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 08:45:20 +0000
Date: Fri, 8 Jan 2016 16:47:41 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v3 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160108084741.GB6295@dhcp-128-25.nay.redhat.com>
References: <1452220423-4733-1-git-send-email-xlpang@redhat.com>
 <1452220423-4733-2-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452220423-4733-2-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/08/16 at 10:33am, Xunlei Pang wrote:
> +
> +static int
> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
> +{
> +	struct page *page;
> +	unsigned int nr_pages;
> +
> +	/* For physical range: [start, end] */
> +	if (!end || start > end)
> +		return 0;

This test !end is hard to be understood without the annotation. It is
better to add the comment about it.

Otherwise it looks good for me.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
