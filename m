Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTIIv-00038I-1m
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 21:57:42 +0000
Date: Thu, 27 Mar 2014 17:57:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [kexec-tools PATCH] x86, kaslr: add alternative way to locate
 kernel text mapping area
Message-ID: <20140327215717.GO13816@redhat.com>
References: <20140327102548.GA15941@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140327102548.GA15941@dhcp-17-89.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>

On Thu, Mar 27, 2014 at 06:25:48PM +0800, WANG Chao wrote:

[..]
> @@ -169,6 +200,31 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  			}
>  		}
>  	}
> +
> +	/* Go through /proc/kcore again. This time we find the region
> +	 * where _stext symbol is located in */

Hi Chao,

How about doing it reverse. Using _stext seems to be the right thing to
do both for kaslr enabled as well as kaslr disabled kernel. Right now
assuming that kernel text mapping fall in a certain area is a hack
and will break if kernel addresses are shifted again for whatever reason.

So we can first look for kernel mapping using _stext. If /proc/kallsyms
is not present, then we can fall back using hardcoded address range
between X86_64__START_KERNEL_map and X86_64__START_KERNEL_map +
X86_64_KERNEL_TEXT_SIZE.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
