Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WT7bj-00018G-LL
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 10:32:25 +0000
Date: Thu, 27 Mar 2014 18:31:54 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v4 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140327103154.GA2944@dhcp-17-89.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <20140320154228.GB29549@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140320154228.GB29549@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, ebiederm@xmission.com

Hi, Vivek

Sorry for my late response.

On 03/20/14 at 11:42am, Vivek Goyal wrote:
> On Wed, Mar 19, 2014 at 04:03:57PM +0800, WANG Chao wrote:
> > Hi, All
> > 
> > When kaslr comes in and kdump is broken, it seems about the right time to use
> > E820 instead of memmap=exactmap to pass memmap for kdump for the default memmap
> > passing mechanism:
> > http://lists.infradead.org/pipermail/kexec/2014-February/011048.html
> 
> What's the connection between kaslr and passing memory mappings in
> bootparams?

kaslr doesn't work with memmap=exactmap. kaslr happens before parsing
user defined memmap and it walks through E820 in boot_params to
determine 2nd kernel text area. And it would override the 1st kernel's
ram.

> 
> To me this is completely independent of kaslr. This is moving towards
> a better design to pass memory map to second kernel which in turn will
> also solve the issue of too many memory ranges on large machines.

Yes. You're right. That's what this patchset is mostly for.
kASLR is just one of the reasons.

> 
> Also, could you get hold of a machine with calgary IOMMU and test that
> --pass-memmap option makes those calgary machines work?

I couldn't find any calgary box. I tried to force calgary iommu on some
IBM-X series, but didn't work out. Those old hardwares are really hard
to find these days.

I think given the fact that the calgary code chage is simple enough and
hpa has committed to tip tree, this patchset won't risk much.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
