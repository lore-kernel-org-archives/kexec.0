Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XAE94-0006At-G8
 for kexec@lists.infradead.org; Thu, 24 Jul 2014 08:13:01 +0000
Date: Thu, 24 Jul 2014 17:12:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: align the extended size of dtb
Message-ID: <20140724081208.GA30538@verge.net.au>
References: <1406114434-77987-1-git-send-email-sdu.liu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406114434-77987-1-git-send-email-sdu.liu@huawei.com>
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
To: Liu Hua <sdu.liu@huawei.com>
Cc: wangnan0@huawei.com, kexec@lists.infradead.org, peifeiyue@huawei.com

On Wed, Jul 23, 2014 at 07:20:34PM +0800, Liu Hua wrote:
> When loading dtb on arm platform, we may need change strings in dtb
> in function setup_dtb_prop. If length of new string is larger than that
> of the old one. We should extend the dtb by "FDT_TAGALIGN"ed size.
> If not, kexec may fail to load the capture kernel.
> 
> Signed-off-by: Liu Hua <sdu.liu@huawei.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
