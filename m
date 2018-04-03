Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f3Ek3-0006Jh-5x
 for kexec@lists.infradead.org; Tue, 03 Apr 2018 05:44:25 +0000
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho> <20180330151129.GG28244@lunn.ch>
 <20180402091232.GE3313@nanopsycho>
From: Alex Vesker <valex@mellanox.com>
Message-ID: <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
Date: Tue, 3 Apr 2018 08:43:27 +0300
MIME-Version: 1.0
In-Reply-To: <20180402091232.GE3313@nanopsycho>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com



On 4/2/2018 12:12 PM, Jiri Pirko wrote:
> Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
>>> Please see:
>>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>>>
>>> I bevieve that the solution in the patchset could be used for
>>> your usecase too.
>> Hi Jiri
>>
>> https://lkml.org/lkml/2018/3/20/436
>>
>> How well does this API work for a 2Gbyte snapshot?
> Ccing Alex who did the tests.

I didn't check the performance for such a large snapshot.
 From my measurement it takes 0.09s for 1 MB of data this means
about ~3m.
This can be tuned and improved since this is a socket application.

>>     Andrew


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
