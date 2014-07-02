Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2Fty-0004QE-IE
 for kexec@lists.infradead.org; Wed, 02 Jul 2014 08:28:27 +0000
Date: Wed, 2 Jul 2014 16:26:54 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140702082654.GB20309@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 06/17/14 at 02:32am, Atsushi Kumagai wrote:
 
> +static void
> +setup_page_is_hugepage(void)
> +{
> +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
> +		if (NUMBER(PG_tail) == NOT_FOUND_NUMBER) {
> +			/*
> +			 * If PG_tail is not explicitly saved, then assume
> +			 * that it immediately follows PG_head.
> +			 */
> +			NUMBER(PG_tail) = NUMBER(PG_head) + 1;
> +		}
> +	} else if ((NUMBER(PG_compound) != NOT_FOUND_NUMBER)
> +		   && (info->dump_level & DL_EXCLUDE_USER_DATA)) {

Hi,

I may not understand hugepage well. I am wondering why hugepage
filtering can't be done if PG_compound is available.

> +		MSG("Compound page bit could not be determined: ");
> +		MSG("huge pages will NOT be filtered.\n");
> +	}
> +}
> +

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
