Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fKnly-0004Mh-13
 for kexec@lists.infradead.org; Mon, 21 May 2018 16:34:59 +0000
Date: Mon, 21 May 2018 12:34:41 -0400 (EDT)
Message-Id: <20180521.123441.1933324667176430245.davem@davemloft.net>
Subject: Re: [PATCH net-next] vmcore: move get_vmcore_size out of __init
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
References: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
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
Date: Mon, 21 May 2018 19:07:50 +0530

> Fix below build warning:
> 
> WARNING: vmlinux.o(.text+0x422bb8): Section mismatch in reference from
> the function vmcore_add_device_dump() to the function
> .init.text:get_vmcore_size.constprop.5()
> 
> The function vmcore_add_device_dump() references
> the function __init get_vmcore_size.constprop.5().
> This is often because vmcore_add_device_dump lacks a __init
> annotation or the annotation of get_vmcore_size.constprop.5 is wrong.
> 
> Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

Applied, thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
