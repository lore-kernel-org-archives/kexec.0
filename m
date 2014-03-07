Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLx4d-00052d-Q7
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 15:52:36 +0000
Date: Fri, 7 Mar 2014 23:52:04 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] x86, calgary: use 8M TCE table size by default
Message-ID: <20140307155204.GC30641@dhcp-17-89.nay.redhat.com>
References: <1394179816-15435-1-git-send-email-chaowang@redhat.com>
 <20140307141413.GF1326@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140307141413.GF1326@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Muli Ben-Yehuda <muli@cs.technion.ac.il>, "Jon D. Mason" <jdmason@kudzu.us>

Hi, Vivek

On 03/07/14 at 09:14am, Vivek Goyal wrote:
> On Fri, Mar 07, 2014 at 04:10:16PM +0800, WANG Chao wrote:
> 
> [..]
> >  	}
> >  
> > -	specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
> > -					saved_max_pfn : max_pfn) * PAGE_SIZE);
> > +	specified_table_size = determine_tce_table_size();
> 
> I don't think you can get rid of saved_max_pfn right away. What if
> somebody is using old first kernel and new second kernel. Then old kernel
> will still be using a table size which is smaller than 8M.

If TCE table size is hard coded to 8M, the new 1st kernel can never be
compatible with the old 2nd kernel. Because old kernel's TCE table size
is depending on saved_max_pfn, which could be from 64K to 8M, not
necessarily the hard coded value 8M.

If we want to drop saved_max_pfn once and for all, that's a trade-off
which is worth doing. Because as Muli pointed out last time, there are
very few people likely running upstream kernel on calgary machine.  And
most of them would use the same kernel as 1st and 2nd kernel. For the
very very few people who suffers from it, we can always encourage them
to use the same kernel for 1st and 2nd kernel or other solutions we
have.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
