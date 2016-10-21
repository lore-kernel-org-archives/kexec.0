Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxP2b-0002EJ-Lk
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 01:54:38 +0000
Date: Thu, 20 Oct 2016 21:54:10 -0400 (EDT)
Message-Id: <20161020.215410.650162338407203719.davem@davemloft.net>
Subject: Re: [PATCH] kexec: Export kexec_in_progress to modules
From: David Miller <davem@davemloft.net>
In-Reply-To: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
References: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
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
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, sfr@canb.auug.org.au, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 20 Oct 2016 18:15:16 -0700

> The bcm_sf2 driver uses kexec_in_progress to know whether it can power
> down an integrated PHY during shutdown, and can be built as a module.
> Other modules may be using this in the future, so export it.
> 
> Fixes: 2399d6143f85 ("net: dsa: bcm_sf2: Prevent GPHY shutdown for kexec'd kernels")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Eric, David, Stephen,
> 
> The offending commit is in David's net.git tree, so it would probably make
> sense to route the fix through the same tree.

Ok, I'll apply this, thanks Florian.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
