Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fB41s-0001df-TB
 for kexec@lists.infradead.org; Tue, 24 Apr 2018 19:55:10 +0000
Date: Tue, 24 Apr 2018 15:54:52 -0400 (EDT)
Message-Id: <20180424.155452.825338057383489874.davem@davemloft.net>
Subject: Re: [PATCH net-next v5 0/3] kernel: add support to collect
 hardware logs in crash recovery kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
References: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
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
Date: Sat, 21 Apr 2018 22:35:52 +0530

> Patch 1 adds API to vmcore module to allow drivers to register callback
> to collect the device specific hardware/firmware logs.  The logs will
> be added to /proc/vmcore as elf notes.
> 
> Patch 2 updates read and mmap logic to append device specific hardware/
> firmware logs as elf notes.
> 
> Patch 3 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs in crash recovery kernel, before hardware is
> initialized.

Are there any serious remaining objections to this series?  I'm going to
integrate this into net-next soon if not.

Thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
