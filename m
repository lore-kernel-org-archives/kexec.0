Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbgEI-0003Hc-EY
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 00:35:19 +0000
Received: by mail-oa0-f49.google.com with SMTP id j10so2301428oah.22
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 17:34:55 -0700 (PDT)
Message-ID: <5271A5AA.3050904@linaro.org>
Date: Wed, 30 Oct 2013 17:34:50 -0700
From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20131030031253.GD20932@dhcp16-109.nay.redhat.com>
 <1383152798.31813.2.camel@odvarok>
In-Reply-To: <1383152798.31813.2.camel@odvarok>
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
To: Lubomir Rintel <lkundrak@v3.sk>, WANG Chao <chaowang@redhat.com>
Cc: Joe Perches <joe@perches.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 10/30/2013 10:06 AM, Lubomir Rintel wrote:
> Hi,
> 
> On Wed, 2013-10-30 at 11:12 +0800, WANG Chao wrote:
>> On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
>>> Symbol name changed with the following commit:
>>> 62e32ac printk: rename struct log to struct printk_log
> ...
>> vmcore-dmesg is really broken here since 3.11 kernel is released. Are
>> you going to send an update v3 to address the comments to v2 from Vivek,
>> Joe and Dave
> 
> I'm not really sure. I thought the suggestions were concerning the Linux
> kernel tree, not kexec-tools tree. I might be wrong though, but I'd need
> the suggestions to be a bit more specific for me to understand.
> 

Hi

I've posted a bit different version of fix [1].
Could you please check out that approach?

[1] http://permalink.gmane.org/gmane.linux.kernel.kexec/9522

-- 
Taras Kondratiuk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
