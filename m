Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnP7M-0006iV-St
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 08:44:37 +0000
Date: Mon, 2 Dec 2013 16:43:23 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Message-ID: <20131202084323.GA2462@dhcp-16-105.nay.redhat.com>
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C60A8@BPXM01GP.gisp.nec.co.jp>
 <20131127053731.GA4318@dhcp-16-252.nay.redhat.com>
 <5295A153.8080400@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5295A153.8080400@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "chaowang@redhat.com" <chaowang@redhat.com>

On 11/27/13 at 04:37pm, HATAYAMA Daisuke wrote:
> (2013/11/27 14:37), Baoquan He wrote:
> >On 11/26/13 at 03:12am, Atsushi Kumagai wrote:
> >>Hello Baoquan,
> >>

> >>I also prefer v1 because the usage of update_cyclic_region_without_exclude() is
> >>definite and understandable while v2's update_cyclic_region() is complicated.
> >>
> >>On the other hand, I agree with your opinion, so could you post a cleanup patch
> >>separately from v1 patch ?
> >
> >Hi Atsushi,
> >
> >Yeah, you are right, v1 is better. Then we can wait for HATAYAMA's cleanup
> >patch. I know you are goint to release v1.5.5.
> >
> 
> I don't have a time to make a clean-up patch now, at least within this year.

OK, I will try to post a clean-up patch based on your cycle loop method.
But I can not guarantee the completion date.

> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
