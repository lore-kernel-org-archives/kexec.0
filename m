Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W68LB-0001pW-LD
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 00:40:18 +0000
Date: Thu, 23 Jan 2014 08:39:51 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] makedumpfile: introduce struct cycle to store the
 cyclic region
Message-ID: <20140123003951.GA1517@dhcp-17-102.nay.redhat.com>
References: <1390399051-8732-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390399051-8732-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

  
> +static void first_cycle(unsigned long long start, unsigned long long max, struct cycle *cycle)
> +{
> +	cycle->start_pfn = start;

recheck code, the start_pfn may need be aligned to info->pfn_cyclic,
Though I don't know what will happen if not doing this.
	cycle->start_pfn = round(start, info->pfn_cyclic);

> +	cycle->end_pfn = cycle->start_pfn + info->pfn_cyclic;
> +
> +	if (cycle->end_pfn > max)
> +		cycle->end_pfn = max;
> +}
> +
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
