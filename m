Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W69c8-00034w-6n
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 02:01:52 +0000
Date: Thu, 23 Jan 2014 10:02:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] kexec-tools: fix bugs and pass initrd position for arm
Message-ID: <20140123020205.GD3768@dhcp-16-126.nay.redhat.com>
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 01/22/14 at 06:52pm, Wang Nan wrote:
> Hi,
> 
> This patch series contains following bug fixes and cleanups for
> kexec-tools on arm platform:
> 
> Wang Nan (3):
>   kexec: align initrd when no --image-size
>   kexec: pass initrd position in dtb
>   kexec: increase zImage compress ratio from 4 to 5
> 
>  kexec/arch/arm/kexec-zImage-arm.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)

Previously I tested arm kexec on virtual machine, there's some breakage.
But due to lack of time I did not get chance to continue on it. I will have a
test with your patches and review the patches.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
