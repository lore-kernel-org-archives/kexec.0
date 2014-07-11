Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5bFP-0005Lj-Di
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 13:52:23 +0000
Date: Fri, 11 Jul 2014 09:51:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140711135155.GE15611@redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140611135701.GA1592@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9722440E@BPXM01GP.gisp.nec.co.jp>
 <20140623125723.GB29112@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
 <20140626123118.GB11136@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723B033@BPXM01GP.gisp.nec.co.jp>
 <20140702081349.GA20309@dhcp-16-105.nay.redhat.com>
 <53B6091F.4010707@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B6091F.4010707@jp.fujitsu.com>
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
To: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "bhe@redhat.com" <bhe@redhat.com>

On Fri, Jul 04, 2014 at 10:53:35AM +0900, HATAYAMA, Daisuke wrote:

[..]
> For fail safe, it should address ENOSPC case more. Sadly, preparing too small disks for vmcores is human error. In general, we cannot avoid this in real world. It's important to make vmcore valid even in case of ENOSPC in the sense that at least generated part of vmcore can correctly be analized by crash.

I agree. Dealing with ENOSPC makes sense. Save as much as possible and
display a warning message that dump got truncated. Still dump file should
be readable by "crash". That way we will not lose the whole dump and 
whatever has been saved, might be sufficient to analyze the dump.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
