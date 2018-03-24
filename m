Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezkwo-0001U2-CD
 for kexec@lists.infradead.org; Sat, 24 Mar 2018 15:19:35 +0000
Date: Sat, 24 Mar 2018 16:18:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second
 kernel
Message-ID: <20180324151852.GE31941@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
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

On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
> Register callback to collect hardware/firmware dumps in second kernel
> before hardware/firmware is initialized.  The dumps for each device
> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
> kernel.
> 
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

Thanks for adding generic documentation about the files in sysfs.

However, you don't add any specific documentation here about the cxgb4
crash dump. How am i supposed to interpret it? Does it follow any of
the standard core dump formats? How do i use gdb with it? Are there
some specific tools i should use to analyse it?

Thanks
	Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
