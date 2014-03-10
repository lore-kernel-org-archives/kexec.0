Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMzUJ-0004lM-4l
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 12:39:24 +0000
Date: Mon, 10 Mar 2014 08:38:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, calgary: use 8M TCE table size by default
Message-ID: <20140310123848.GA31879@redhat.com>
References: <1394179816-15435-1-git-send-email-chaowang@redhat.com>
 <20140307141413.GF1326@redhat.com>
 <20140307155204.GC30641@dhcp-17-89.nay.redhat.com>
 <20140307160906.GH1326@redhat.com>
 <20140310083834.GA32547@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140310083834.GA32547@dhcp-17-89.nay.redhat.com>
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

On Mon, Mar 10, 2014 at 04:38:34PM +0800, WANG Chao wrote:

[..]
> > So we have two scenarios.
> > 
> > - Old first kernel and new second kernel.
> > - New first kernel and old second kernel.
> > 
> > If we want to make these two scenarios work with calgary, we need to
> > use kexec-tools with --pass-memmap option. And also in new kernel we
> > need to retain saved_max_pfn. Only difference will be, that we will
> > set saved_max_pfn only if it is kdump kernel and if user passed a 
> > memory map on kernel command line.
> 
> Old first kernel and new second kernel is easy to handle. Like you said,
> we can use exactmap and set saved_max_pfn in kdump kernel, just as the
> old way.
> 
> But it's still not clear to me how we can handle the case of new first
> kernel and old second kernel.
> 
> Let's say, a calgary system has 2G memory. The new first kernel TCE
> table size are hard coded to 8M. When the old kdump kernel is booting,
> memmap=exactmap is parsed and saved_max_pfn is set to 2G/PAGE_SIZE. TCE
> table size is determined by 2G ram size. So the size is 4M. We run into
> the situation that TCE table is 8M in first kernel and 4M in second
> kernel. This inconsistency of TCE table size would cause kdump kernel
> fails somehow, that's why we brought in saved_max_pfn in the first place
> as you know.
> 
> The problem is how to keep TCE table size being consistent between new
> first kernel and old second kernel.

You are right. I did not think through it. So we can't handle the case
of new first kernel and second old kernel without exporting size of
tables to user space. Given the fact that calgary is old hardware,
exporting table size to user space is not very prudent.

I would say let us handle the case of old first kernel and second new
kernel to maintain backward compatibility.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
