Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f2vWA-0007Bw-JW
 for kexec@lists.infradead.org; Mon, 02 Apr 2018 09:12:48 +0000
Received: by mail-wr0-x231.google.com with SMTP id p53so12847674wrc.10
 for <kexec@lists.infradead.org>; Mon, 02 Apr 2018 02:12:36 -0700 (PDT)
Date: Mon, 2 Apr 2018 11:12:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180402091232.GE3313@nanopsycho>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho> <20180330151129.GG28244@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180330151129.GG28244@lunn.ch>
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, viro@zeniv.linux.org.uk, valex@mellanox.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
>> Please see:
>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>> 
>> I bevieve that the solution in the patchset could be used for
>> your usecase too.
>
>Hi Jiri
>
>https://lkml.org/lkml/2018/3/20/436
>
>How well does this API work for a 2Gbyte snapshot?

Ccing Alex who did the tests.

>
>    Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
