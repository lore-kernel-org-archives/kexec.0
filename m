Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1vgx-0005yK-0I
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 15:11:48 +0000
Date: Fri, 30 Mar 2018 17:11:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180330151129.GG28244@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180330103907.GC3313@nanopsycho>
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

> Please see:
> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> 
> I bevieve that the solution in the patchset could be used for
> your usecase too.

Hi Jiri

https://lkml.org/lkml/2018/3/20/436

How well does this API work for a 2Gbyte snapshot?

    Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
