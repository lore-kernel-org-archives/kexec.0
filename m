Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEsRv-00077n-6n
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 02:59:09 +0000
Date: Thu, 29 Aug 2013 10:58:37 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] makedumpfile: reverse -c and -p if using snappy
 compression
Message-ID: <20130829025837.GA2298@dhcp12-158.nay.redhat.com>
References: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

Hi, Cliff

On 08/28/13 at 05:08pm, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> Reverse the meanings of -c (compression) and -p (snappy compression) if
> USESNAPPY is defined.
> 
> The distro kdump scripts seem to only support -c for compression.
> So make -c mean snappy compression if it is supported.

It looks like more a distro issue to me. I'm wondering if that script
only support -c, why do that distro compile makedumpfile with USESNAPPY?

I don't think other distros would like to see this change. IMHO, the
right thing to do is fix that kdump script on that particular distro,
not reverse -c and -p.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
