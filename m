Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W6AUV-00040b-2G
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 02:58:04 +0000
Message-ID: <52E084DA.1000507@huawei.com>
Date: Thu, 23 Jan 2014 10:56:26 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] kexec-tools: fix bugs and pass initrd position for arm
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
 <20140123024716.GF3768@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20140123024716.GF3768@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 2014/1/23 10:47, Dave Young wrote:
> On 01/22/14 at 06:52pm, Wang Nan wrote:
>> Hi,
>>
>> This patch series contains following bug fixes and cleanups for
>> kexec-tools on arm platform:
>>
>> Wang Nan (3):
>>   kexec: align initrd when no --image-size
>>   kexec: pass initrd position in dtb
>>   kexec: increase zImage compress ratio from 4 to 5
> 
> One question:
> Is these kexec-tools patches enough for kexec work or still need the
> kernel patches you sent?
> 
> Thanks
> Dave
> 

kexec will work without the kernel side patches, but the atag, kernel
cmdline, dtb information and kernel configuration must be carefully
adjusted.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
