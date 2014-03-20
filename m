Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQf7L-0005iF-RZ
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 15:42:52 +0000
Date: Thu, 20 Mar 2014 11:42:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140320154228.GB29549@redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, ebiederm@xmission.com

On Wed, Mar 19, 2014 at 04:03:57PM +0800, WANG Chao wrote:
> Hi, All
> 
> When kaslr comes in and kdump is broken, it seems about the right time to use
> E820 instead of memmap=exactmap to pass memmap for kdump for the default memmap
> passing mechanism:
> http://lists.infradead.org/pipermail/kexec/2014-February/011048.html

What's the connection between kaslr and passing memory mappings in
bootparams?

To me this is completely independent of kaslr. This is moving towards
a better design to pass memory map to second kernel which in turn will
also solve the issue of too many memory ranges on large machines.

Also, could you get hold of a machine with calgary IOMMU and test that
--pass-memmap option makes those calgary machines work?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
