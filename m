Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f3LAe-0005IE-SM
 for kexec@lists.infradead.org; Tue, 03 Apr 2018 12:36:19 +0000
Date: Tue, 3 Apr 2018 14:35:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180403123556.GA31740@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho> <20180330151129.GG28244@lunn.ch>
 <20180402091232.GE3313@nanopsycho>
 <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
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
To: Alex Vesker <valex@mellanox.com>
Cc: Jiri Pirko <jiri@resnulli.us>, indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

On Tue, Apr 03, 2018 at 08:43:27AM +0300, Alex Vesker wrote:
> 
> 
> On 4/2/2018 12:12 PM, Jiri Pirko wrote:
> >Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
> >>>Please see:
> >>>http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> >>>
> >>>I bevieve that the solution in the patchset could be used for
> >>>your usecase too.
> >>Hi Jiri
> >>
> >>https://lkml.org/lkml/2018/3/20/436
> >>
> >>How well does this API work for a 2Gbyte snapshot?
> >Ccing Alex who did the tests.
> 
> I didn't check the performance for such a large snapshot.
> From my measurement it takes 0.09s for 1 MB of data this means
> about ~3m.

I was not really thinking about performance. More about how well does
the system work when you ask the kernel for 2GB of RAM to put a
snapshot into? And given your current design, you need another 2GB
buffer for the driver to use before calling this new API.

So i'm asking, how well does this API scale?

I think you need to remove the need for a second buffer in the
driver. Either the driver allocates the buffer and hands it over, or
your core code allocates the buffer and gives it to the driver to
fill. Maybe look at what makes most sense for the crash dump code?

      Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
