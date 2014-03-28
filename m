Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTQA7-0002Cu-4K
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 06:21:07 +0000
Date: Fri, 28 Mar 2014 14:20:43 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [kexec-tools PATCH] x86, kaslr: add alternative way to locate
 kernel text mapping area
Message-ID: <20140328062043.GG2944@dhcp-17-89.nay.redhat.com>
References: <20140327102548.GA15941@dhcp-17-89.nay.redhat.com>
 <20140327215717.GO13816@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140327215717.GO13816@redhat.com>
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
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>

On 03/27/14 at 05:57pm, Vivek Goyal wrote:
> On Thu, Mar 27, 2014 at 06:25:48PM +0800, WANG Chao wrote:
> 
> [..]
> > @@ -169,6 +200,31 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
> >  			}
> >  		}
> >  	}
> > +
> > +	/* Go through /proc/kcore again. This time we find the region
> > +	 * where _stext symbol is located in */
> 
> Hi Chao,
> 
> How about doing it reverse. Using _stext seems to be the right thing to
> do both for kaslr enabled as well as kaslr disabled kernel. Right now
> assuming that kernel text mapping fall in a certain area is a hack
> and will break if kernel addresses are shifted again for whatever reason.
> 
> So we can first look for kernel mapping using _stext. If /proc/kallsyms
> is not present, then we can fall back using hardcoded address range
> between X86_64__START_KERNEL_map and X86_64__START_KERNEL_map +
> X86_64_KERNEL_TEXT_SIZE.

Good point. I'll post V2.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
