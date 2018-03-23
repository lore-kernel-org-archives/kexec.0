Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezM5a-0001xs-Ar
 for kexec@lists.infradead.org; Fri, 23 Mar 2018 12:46:35 +0000
Date: Fri, 23 Mar 2018 13:46:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/2] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180323124615.GB5145@lunn.ch>
References: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

> 4. Crashdd exposes the buffer as a file via
> /sys/kernel/crashdd/<driver>/<dump_file>.

Hi Rahul

You should add something to Documentation/ABI/. All sysfs files need
to be documented.

   Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
