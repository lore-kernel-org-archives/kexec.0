Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLvY4-00027m-DP
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 14:14:53 +0000
Date: Fri, 7 Mar 2014 09:14:13 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, calgary: use 8M TCE table size by default
Message-ID: <20140307141413.GF1326@redhat.com>
References: <1394179816-15435-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394179816-15435-1-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Muli Ben-Yehuda <muli@cs.technion.ac.il>, "Jon D. Mason" <jdmason@kudzu.us>

On Fri, Mar 07, 2014 at 04:10:16PM +0800, WANG Chao wrote:

[..]
>  	}
>  
> -	specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
> -					saved_max_pfn : max_pfn) * PAGE_SIZE);
> +	specified_table_size = determine_tce_table_size();

I don't think you can get rid of saved_max_pfn right away. What if
somebody is using old first kernel and new second kernel. Then old kernel
will still be using a table size which is smaller than 8M.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
