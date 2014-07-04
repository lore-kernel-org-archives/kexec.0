Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X303r-0003DS-5L
 for kexec@lists.infradead.org; Fri, 04 Jul 2014 09:45:44 +0000
Date: Fri, 4 Jul 2014 17:44:06 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140704094406.GF20309@dhcp-16-105.nay.redhat.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 07/04/14 at 10:53am, HATAYAMA, Daisuke wrote:
> 
> There are things that make users to guess actual vmcore size; not only compression but also additional meta-data, note data, header, bitmaps, of vmcores. I think it important to stress that the actual dump size should be larger than the number of pages displayed there so you (users) should care about that enough.
> 

Yes, if dump is kdump compression user need know actual vmcore includes
more. If only show number of dumpable page, the size should be very
close to the elf vmcore size. But I think it's a good idea to tell user
the difference.

> For fail safe, it should address ENOSPC case more. Sadly, preparing too small disks for vmcores is human error. In general, we cannot avoid this in real world. It's important to make vmcore valid even in case of ENOSPC in the sense that at least generated part of vmcore can correctly be analized by crash. In this direction, I previously sent the patch to create 1st bitmap first but this patch alone is still unsatisfactory to deal with the issue. It's necessary to flush the 2nd bitmap and the data left in caches too.
> 

Yes, it makes sense to me that generate part of vmcore even in case of
ENOSPC, maybe later further attempt can be taken in this direction. 


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
