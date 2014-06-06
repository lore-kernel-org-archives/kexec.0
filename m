Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsoPf-0001y5-09
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 07:18:08 +0000
Date: Fri, 6 Jun 2014 16:17:41 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] kexec: add LPAE support for ARM32 platform
Message-ID: <20140606071741.GB13049@verge.net.au>
References: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Liu Hua <sdu.liu@huawei.com>
Cc: wangnan0@huawei.com, liusdu@126.com, kexec@lists.infradead.org, genghui@huawei.com

On Thu, Jun 05, 2014 at 07:20:06PM +0800, Liu Hua wrote:
> 
> This patch series introduces LPAE support for 32-bit ARM
> platform.
> 
> I have test them on LPAE enabled kernel(command: kexec ... -d):
> 
> With this patch series:
> 
> crashkernel: [0x20000000 - 0x280fffff] (129M)
> memory range: [0 - 0x1fffffff] (512M)
> memory range: [0x28100000 - 0x3fffffff] (383M)
> memory range: [0x1e0000000 - 0x1fcbfffff] (460M)
> 
> Without:
> 
> crashkernel: [0x20000000 - 0x280fffff] (129M)
> memory range: [0 - 0x1fffffff] (512M)
> memory range: [0x28100000 - 0x3fffffff] (383M)
> memory range: [0xe0000000 - 0xfcbfffff] (460M)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
