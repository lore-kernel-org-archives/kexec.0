Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1as3Mf-0006je-NP
 for kexec@lists.infradead.org; Mon, 18 Apr 2016 07:12:58 +0000
Date: Mon, 18 Apr 2016 15:17:29 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH V8] Improve the performance of --num-threads -d 31
Message-ID: <20160418071729.GA5169@dhcp-128-25.nay.redhat.com>
References: <1460941546-2569-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <57143724.5020100@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E3B53A@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E3B53A@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 04/18/16 at 06:47am, Atsushi Kumagai wrote:
> >Hi Atsushi,
> >
> >I have done a simple test on a machine with 32G memory.
> >And the following is the result.
> >
> >threads num                       :  1     2     3
> >patch v4                          :  8.04  6.10  6.18     (sec)
> >patch v8(PAGE_DATA_NUM:5)         :  8.21  6.36  6.19     (sec)
> >
> >patch v8 modified(PAGE_DATA_NUM:3):  8.22  6.42  6.05     (sec)
> >
> >
> >I only run one time each test, so some values may be strange.
> >I think the performance is acceptable.
> 
> Sure, I'll accept this version.
> 
> Minfei, could you test this patch when you get a chance to use
> your machine ? If there is no ENOMEM, I'll merge this into v1.6.0.

Hi, Atsushi.

Sure. I will have this test as soon as possible, once I get an
available machine.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
