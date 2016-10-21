Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxaaE-0000jP-0Q
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 14:14:09 +0000
Date: Fri, 21 Oct 2016 10:13:43 -0400 (EDT)
Message-Id: <20161021.101343.1389577512803674816.davem@davemloft.net>
Subject: Re: [PATCH] kexec: Export kexec_in_progress to modules
From: David Miller <davem@davemloft.net>
In-Reply-To: <871szagtls.fsf@xmission.com>
References: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
 <20161020.215410.650162338407203719.davem@davemloft.net>
 <871szagtls.fsf@xmission.com>
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
To: ebiederm@xmission.com
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 21 Oct 2016 00:26:55 -0500

> So as far as I can tell you are advocating for a change to support a
> driver doing something that is completely pointless.  So no let's not
> export this symbol.  Please fix the driver to do something less
> pointless instead.

FLorian explained his reasoning for doing what he is doing in this
specific driver and it made sense to me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
