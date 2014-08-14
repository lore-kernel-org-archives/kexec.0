Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHqCV-0004U8-GE
 for kexec@lists.infradead.org; Thu, 14 Aug 2014 08:16:00 +0000
Date: Thu, 14 Aug 2014 16:15:32 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 3/7] preparation functions for parsing vmcoreinfo
Message-ID: <20140814081532.GA19452@dhcp-16-116.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-4-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246615@BPXM01GP.gisp.nec.co.jp>
 <20140812094623.GB4887@dhcp-16-105.nay.redhat.com>
 <20140812100156.GC4887@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9724CA25@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9724CA25@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/14/14 at 07:37am, Atsushi Kumagai wrote:
> >On 08/12/14 at 05:46pm, Baoquan He wrote:
 >>
> >
> >I add the static variable "done" just because it always print below
> >warning message twice, this makes me uncomfortable. Otherwise
> >get_kernel_version() can be called any time no matter how many times it
> >has been called if it's only a converting utility function.
> >
> >The kernel version is not supported.
> >The created dumpfile may be incomplete.
> 
> Yeah, I understand the reason.
> I agree with your idea, but I think it's better to check the
> kernel_version directly like:
> 
> 	if (info->kernel_version)
> 		return info->kernel_version;

Well, I got what you meant. I didn't get it when you said at first
time. Yeah, this works and is better. Will change like this. Thanks a
lot.


> 
> 
> Thanks
> Atsushi Kumagai
> 
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
