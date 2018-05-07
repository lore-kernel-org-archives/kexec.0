Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFmM6-0002WK-72
 for kexec@lists.infradead.org; Mon, 07 May 2018 20:03:31 +0000
Date: Mon, 07 May 2018 16:03:10 -0400 (EDT)
Message-Id: <20180507.160310.1980287981944658521.davem@davemloft.net>
Subject: Re: [PATCH net-next v8 0/3] kernel: add support to collect
 hardware logs in crash recovery kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
References: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
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
To: rahul.lakkireddy@chelsio.com
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Date: Wed,  2 May 2018 15:17:16 +0530

> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device in the crash recovery kernel. In crash
> recovery kernel, the collected logs are added as elf notes to
> /proc/vmcore, which is copied by user space scripts for post-analysis.

Eric B., since you've been giving very useful and active feedback on
this series could you please give it a review?

Thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
