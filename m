Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anNQu-0006Ei-4c
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 09:38:01 +0000
Date: Tue, 5 Apr 2016 11:37:54 +0200
From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
Subject: Re: [PATCH 1/3] arm: properly handle a missing /chosen node in the DT
Message-ID: <20160405093754.GB14598@avionic-0071.adnet.avionic-design.de>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
 <20160405063306.GA19694@verge.net.au>
 <20160405093433.GA14598@avionic-0071.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160405093433.GA14598@avionic-0071.adnet.avionic-design.de>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Alban Bedel <alban.bedel@avionic-design.de>

On Tue, Apr 05, 2016 at 11:34:33AM +0200, Nikolaus Schulz wrote:
> > * If it is inappropriate to pass off to fdt_add_subnode() can
> >   that be resolved by simply passing 0 instead?
> 
> If we know that we're adding a top-level node, then yes.  Basically,
> one can do that either in fdt_add_subnode, or when calling it in
> zImage_arm_load.  My patch does the latter.

s/fdt_add_subnode/setup_dtb_prop/ in the above paragraph

Nikolaus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
